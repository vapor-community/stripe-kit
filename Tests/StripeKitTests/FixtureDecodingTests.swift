import Foundation
import Testing
import StripeKit

/// Decodes every object in Stripe's published fixtures (`fixtures3.json`, from the same
/// stripe/openapi commit as `spec3.sdk.json`) into the matching generated type.
///
/// The type map (`Generated/FixtureTypes.swift`) is produced by stripe-kit-codegen,
/// so these tests follow the generator when the spec is updated.
@Suite("Stripe fixture decoding")
struct FixtureDecodingTests {

    /// Fixtures with no generated type. Each entry needs a reason.
    static let knownUnmapped: Set<String> = [
        "issuing.settlement",     // fixture only; no schema in this spec version
        "sigma.sigma_api_query",  // fixture only; no schema in this spec version
        "terminal.refund",        // fixture only; no schema in this spec version
    ]

    @Test("Resource fixture decodes", arguments: Fixtures.keys(in: resourceTypes))
    func resourceFixtureDecodes(_ key: String) throws {
        try Fixtures.assertDecodes(key, as: resourceTypes[key]!)
    }

    @Test("Resource fixture survives an encode/decode round trip", arguments: Fixtures.keys(in: resourceTypes))
    func resourceFixtureRoundTrips(_ key: String) throws {
        let type = try #require(resourceTypes[key] as? any Codable.Type)
        let decoded = try Fixtures.decode(key, as: type)
        let reencoded = try Fixtures.encoder.encode(decoded)
        #expect(throws: Never.self) { try Fixtures.decoder.decode(type, from: reencoded) }
    }

    /// Delete endpoints return a deleted stub (`{id, object, deleted}`), not the full object.
    /// The key paths only compile if the routes are typed to return the deleted types.
    @Test("Delete routes return deleted objects")
    func deleteRoutesReturnDeletedObjects() throws {
        let _: KeyPath<CustomerRoutes, @Sendable (String, [String]?, RequestOptions) async throws -> DeletedCustomer> = \.delete
        let _: KeyPath<TerminalLocationRoutes, @Sendable (String, [String]?, RequestOptions) async throws -> DeletedTerminalLocation> = \.delete
        let _: KeyPath<PaymentSourceRoutes, @Sendable (String, String, [String]?, RequestOptions) async throws -> ObjectOrDeleted<PaymentSource, DeletedPaymentSource>> = \.delete

        let card = try Fixtures.decode("deleted_card", as: ObjectOrDeleted<PaymentSource, DeletedPaymentSource>.self)
        #expect(card.deleted?.deletedCard != nil)

        let source = try Fixtures.decode("source", as: ObjectOrDeleted<PaymentSource, DeletedPaymentSource>.self)
        #expect(source.object?.source != nil)
    }

    /// Where the spec says a retrieve or update can return either the object or a deleted stub,
    /// the route returns `ObjectOrDeleted` (as async-stripe does), and both shapes decode.
    @Test("Retrieve routes return the object or a deleted object")
    func retrieveRoutesReturnObjectOrDeleted() throws {
        let _: KeyPath<CustomerRoutes, @Sendable (String, [String]?, RequestOptions) async throws -> ObjectOrDeleted<Customer, DeletedCustomer>> = \.retrieve
        let _: KeyPath<TerminalLocationRoutes, @Sendable (String, [String]?, RequestOptions) async throws -> ObjectOrDeleted<TerminalLocation, DeletedTerminalLocation>> = \.retrieve
        let _: KeyPath<TerminalReaderRoutes, @Sendable (String, TerminalReaderUpdateParams, RequestOptions) async throws -> ObjectOrDeleted<TerminalReader, DeletedTerminalReader>> = \.update

        let live = try Fixtures.decode("customer", as: ObjectOrDeleted<Customer, DeletedCustomer>.self)
        #expect(live.object?.id == "cus_QXg1o8vcGmoR32")

        let deleted = try Fixtures.decode("deleted_customer", as: ObjectOrDeleted<Customer, DeletedCustomer>.self)
        #expect(deleted.deleted?.deleted == true)
        #expect(deleted.object == nil)
    }

    /// The webhook path: `StripeEvent.verify` decodes with this same decoder configuration,
    /// then callers pull the typed object out with `object(as:)`.
    @Test("Event fixture decodes as a webhook StripeEvent with a typed object")
    func webhookEventDecodes() throws {
        let event = try Fixtures.decode("event", as: StripeEvent.self)
        #expect(event.type == .planCreated)

        let plan = try event.data.object(as: Plan.self)
        let fixturePlan = try Fixtures.decode("plan", as: Plan.self)
        #expect(plan.id == fixturePlan.id)
        // Dates survive the trip through the raw JSON
        #expect(plan.created == Date(timeIntervalSince1970: 1_721_948_530))
        #expect(event.data.object["id"]?.stringValue == fixturePlan.id)
    }

    /// Only fields with `x-expansionResources` (an ID, or the object when expanded) get an
    /// expandable wrapper. Plain nested objects that `x-expandableFields` also lists, so their
    /// own fields can be expanded through them, keep their own type.
    @Test("Nested objects are typed; only ID-or-object fields are expandable")
    func onlyIDOrObjectFieldsAreExpandable() throws {
        let _: KeyPath<Account, AccountBusinessProfile?> = \.businessProfile
        let _: KeyPath<AccountBusinessProfile, Address?> = \.supportAddress
        let account = try Fixtures.decode("account", as: Account.self)
        #expect(account.businessProfile != nil)
        #expect(account.capabilities != nil)

        // Unexpanded: IDs
        var invoiceJSON = try #require(JSONSerialization.jsonObject(with: Fixtures.all["invoice"]!) as? [String: Any])
        invoiceJSON["customer"] = "cus_123"
        invoiceJSON["discounts"] = ["di_123"]
        let unexpanded = try Fixtures.decoder.decode(Invoice.self, from: JSONSerialization.data(withJSONObject: invoiceJSON))
        #expect(unexpanded.customer == "cus_123")
        #expect(unexpanded.discounts == ["di_123"])
        #expect(unexpanded.$discounts == nil)

        // Expanded: the objects, including an array of them (`discounts` also lists
        // deleted_discount, which the wrapper leaves out)
        invoiceJSON["customer"] = try JSONSerialization.jsonObject(with: Fixtures.all["customer"]!)
        invoiceJSON["discounts"] = [try JSONSerialization.jsonObject(with: Fixtures.all["discount"]!)]
        let expanded = try Fixtures.decoder.decode(Invoice.self, from: JSONSerialization.data(withJSONObject: invoiceJSON))
        #expect(expanded.$customer?.object?.id == "cus_QXg1o8vcGmoR32")
        #expect(expanded.$discounts?.count == 1)
        #expect(expanded.$discounts?.first?.object != nil)
    }

    /// When the spec says an expandable field can expand to a deleted object (charge.customer →
    /// customer | deleted_customer), it expands to `ObjectOrDeleted`, so expanding a deleted
    /// customer decodes as `.deleted` instead of failing as an incomplete `Customer`.
    @Test("Expandable fields decode an expanded deleted object")
    func expandedDeletedObjectsDecode() throws {
        let _: KeyPath<Charge, ObjectOrDeleted<Customer, DeletedCustomer>?> = \.$customer
        let _: KeyPath<Invoice, [ObjectOrDeleted<Discount, DeletedDiscount>]?> = \.$discounts

        var invoiceJSON = try #require(JSONSerialization.jsonObject(with: Fixtures.all["invoice"]!) as? [String: Any])
        invoiceJSON["customer"] = try JSONSerialization.jsonObject(with: Fixtures.all["deleted_customer"]!)
        invoiceJSON["discounts"] = [
            try JSONSerialization.jsonObject(with: Fixtures.all["discount"]!),
            try JSONSerialization.jsonObject(with: Fixtures.all["deleted_discount"]!),
        ]
        let invoice = try Fixtures.decoder.decode(Invoice.self, from: JSONSerialization.data(withJSONObject: invoiceJSON))
        #expect(invoice.$customer?.deleted?.id == "cus_QXg1o8vcGmoR32")
        #expect(invoice.$customer?.object == nil)
        #expect(invoice.$discounts?.map { $0.deleted != nil } == [false, true])

        // Still survives an encode/decode round trip
        let roundTripped = try Fixtures.decoder.decode(Invoice.self, from: Fixtures.encoder.encode(invoice))
        #expect(roundTripped.$customer?.deleted?.id == "cus_QXg1o8vcGmoR32")
        #expect(roundTripped.$discounts?.count == 2)
    }

    /// PaymentIntent → ApiErrors → PaymentIntent is a cycle of plain objects. The generator
    /// stores embedded resources (`ApiErrors.paymentIntent`) `@Indirect`, so the structs have a
    /// finite, small size, and the boxed property still reads, decodes (present, null or
    /// missing) and encodes as a plain optional. Decoding this nests ApiErrors inside a
    /// PaymentIntent inside a test task; it overflowed the task's stack while ApiErrors
    /// embedded its resources inline.
    @Test("Recursive models decode through @Indirect")
    func recursiveModelsDecode() throws {
        let _: KeyPath<PaymentIntent, ApiErrors?> = \.lastPaymentError

        var json = try #require(JSONSerialization.jsonObject(with: Fixtures.all["payment_intent"]!) as? [String: Any])
        let nested = json
        json["last_payment_error"] = ["type": "card_error", "code": "card_declined", "payment_intent": nested]
        let intent = try Fixtures.decoder.decode(PaymentIntent.self, from: JSONSerialization.data(withJSONObject: json))
        #expect(intent.lastPaymentError?.code == .cardDeclined)
        #expect(intent.lastPaymentError?.paymentIntent?.id == intent.id)

        let roundTripped = try Fixtures.decoder.decode(PaymentIntent.self, from: Fixtures.encoder.encode(intent))
        #expect(roundTripped.lastPaymentError?.paymentIntent?.id == intent.id)

        json.removeValue(forKey: "last_payment_error")
        let missing = try Fixtures.decoder.decode(PaymentIntent.self, from: JSONSerialization.data(withJSONObject: json))
        #expect(missing.lastPaymentError == nil)
    }

    /// Fields the spec marks `format: unix-time` are `Date`s, decoded from Unix seconds.
    @Test("Timestamps decode as Dates")
    func timestampsDecodeAsDates() throws {
        let _: KeyPath<Customer, Date> = \.created
        let _: KeyPath<Subscription, Date?> = \.trialEnd
        let customer = try Fixtures.decode("customer", as: Customer.self)
        #expect(customer.created == Date(timeIntervalSince1970: 1_234_567_890))

        let roundTripped = try Fixtures.decoder.decode(Customer.self, from: Fixtures.encoder.encode(customer))
        #expect(roundTripped.created == customer.created)
    }

    /// A list of several object types (a customer's `sources`) keeps its items in order in
    /// `data`, skips items of an unknown type, and encodes everything it decoded.
    @Test("Polymorphic lists decode in order and round-trip")
    func polymorphicListsRoundTrip() throws {
        let card = try JSONSerialization.jsonObject(with: Fixtures.all["card"]!)
        let source = try JSONSerialization.jsonObject(with: Fixtures.all["source"]!)
        let list: [String: Any] = [
            "object": "list", "has_more": false, "url": "/v1/customers/cus_1/sources",
            "data": [source, ["object": "not_a_stripe_kit_type", "id": "x_1"], card],
        ]
        let decoded = try Fixtures.decoder.decode(PaymentSourceList.self, from: JSONSerialization.data(withJSONObject: list))
        #expect(decoded.data.count == 2)
        #expect(decoded.data.first?.source != nil)
        #expect(decoded.data.last?.card != nil)
        #expect(decoded.cards.count == 1)
        #expect(decoded.sources.count == 1)

        let roundTripped = try Fixtures.decoder.decode(PaymentSourceList.self, from: Fixtures.encoder.encode(decoded))
        #expect(roundTripped.data.count == 2)
        #expect(roundTripped.cards.first?.id == decoded.cards.first?.id)
    }

    @Test("Every fixture has a generated type")
    func everyFixtureIsMapped() {
        let unmapped = Set(Fixtures.all.keys).subtracting(resourceTypes.keys).subtracting(Self.knownUnmapped)
        #expect(unmapped.isEmpty, "Fixtures with no generated type: \(unmapped.sorted())")
    }
}

// MARK: - Fixture loading

enum Fixtures {
    /// Raw JSON for each fixture, keyed by schema name.
    static let all: [String: Data] = {
        guard
            let url = Bundle.module.url(forResource: "fixtures3", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let root = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let resources = root["resources"] as? [String: Any]
        else {
            fatalError("Could not load fixtures3.json from the test bundle")
        }
        return resources.compactMapValues { try? JSONSerialization.data(withJSONObject: $0) }
    }()

    /// Same configuration as `StripeAPIHandler` uses for responses.
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }

    /// Encodes models back into Stripe's JSON shape (dates as Unix seconds), for round trips.
    static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        return encoder
    }

    /// Fixture keys that have an entry in `types`, sorted for stable test ordering.
    static func keys(in types: [String: any Decodable.Type]) -> [String] {
        all.keys.filter { types[$0] != nil }.sorted()
    }

    static func decode<T: Decodable>(_ key: String, as type: T.Type) throws -> T {
        try decoder.decode(type, from: try #require(all[key]))
    }

    static func assertDecodes(_ key: String, as type: any Decodable.Type) throws {
        do {
            _ = try decode(key, as: type)
        } catch let error as DecodingError {
            Issue.record("\(key) → \(type): \(error.summary)")
        }
    }
}

extension DecodingError {
    /// One-line description with the coding path, e.g. `keyNotFound "email" at invoice_settings`.
    var summary: String {
        func path(_ context: Context) -> String {
            let path = context.codingPath.map { $0.intValue.map(String.init) ?? $0.stringValue }.joined(separator: ".")
            return path.isEmpty ? "<root>" : path
        }
        switch self {
        case let .keyNotFound(key, context):
            return "keyNotFound \"\(key.stringValue)\" at \(path(context))"
        case let .typeMismatch(type, context):
            return "typeMismatch \(type) at \(path(context)): \(context.debugDescription)"
        case let .valueNotFound(type, context):
            return "valueNotFound \(type) at \(path(context))"
        case let .dataCorrupted(context):
            return "dataCorrupted at \(path(context)): \(context.debugDescription)"
        @unknown default:
            return String(describing: self)
        }
    }
}
