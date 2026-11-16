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
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        let reencoded = try encoder.encode(decoded)
        #expect(throws: Never.self) { try Fixtures.decoder.decode(type, from: reencoded) }
    }

    /// Delete endpoints return a deleted stub (`{id, object, deleted}`), not the full object.
    /// The key paths only compile if the routes are typed to return the deleted types.
    @Test("Delete routes return deleted objects")
    func deleteRoutesReturnDeletedObjects() throws {
        let _: KeyPath<CustomerRoutes, @Sendable (String, [String]?) async throws -> DeletedCustomer> = \.delete
        let _: KeyPath<TerminalLocationRoutes, @Sendable (String, [String]?) async throws -> DeletedTerminalLocation> = \.delete
        let _: KeyPath<PaymentSourceRoutes, @Sendable (String, String, [String]?) async throws -> ObjectOrDeleted<PaymentSource, DeletedPaymentSource>> = \.delete

        let card = try Fixtures.decode("deleted_card", as: ObjectOrDeleted<PaymentSource, DeletedPaymentSource>.self)
        #expect(card.deleted?.deletedCard != nil)

        let source = try Fixtures.decode("source", as: ObjectOrDeleted<PaymentSource, DeletedPaymentSource>.self)
        #expect(source.object?.source != nil)
    }

    /// Where the spec says a retrieve or update can return either the object or a deleted stub,
    /// the route returns `ObjectOrDeleted` (as async-stripe does), and both shapes decode.
    @Test("Retrieve routes return the object or a deleted object")
    func retrieveRoutesReturnObjectOrDeleted() throws {
        let _: KeyPath<CustomerRoutes, @Sendable (String, [String]?) async throws -> ObjectOrDeleted<Customer, DeletedCustomer>> = \.retrieve
        let _: KeyPath<TerminalLocationRoutes, @Sendable (String, [String]?) async throws -> ObjectOrDeleted<TerminalLocation, DeletedTerminalLocation>> = \.retrieve
        let _: KeyPath<ReaderRoutes, @Sendable (String, ReaderUpdateParams?) async throws -> ObjectOrDeleted<Reader, DeletedReader>> = \.update

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
