import Foundation
import Testing
import StripeKit

/// Stripe adds enum values (payment method types, error codes, event types, …) without a new
/// API version. Spec enums are extensible structs, so a value this version of StripeKit
/// doesn't list still decodes instead of failing the whole response.
@Suite("Unknown values")
struct UnknownValueTests {
    @Test("A new enum value decodes and round-trips; known values read like enum cases")
    func extensibleValues() throws {
        var json = try #require(JSONSerialization.jsonObject(with: Fixtures.all["payment_method"]!) as? [String: Any])
        json["type"] = "a_payment_method_from_the_future"
        let method = try Fixtures.decoder.decode(PaymentMethod.self, from: JSONSerialization.data(withJSONObject: json))
        #expect(method.type.rawValue == "a_payment_method_from_the_future")
        #expect(method.type != .card)

        let roundTripped = try Fixtures.decoder.decode(PaymentMethod.self, from: Fixtures.encoder.encode(method))
        #expect(roundTripped.type == method.type)

        // Known values compare and switch like enum cases
        let card = PaymentMethodType(rawValue: "card")
        #expect(card == .card)
        switch card {
        case .sepaDebit: Issue.record("matched the wrong value")
        case .card: break
        default: Issue.record("didn't match .card")
        }
    }

    @Test("A new error code still decodes the error, keeping its message")
    func errorCodes() throws {
        let json = Data(#"{"error": {"type": "card_error", "code": "a_new_code", "decline_code": "a_new_decline", "message": "Your card was declined."}}"#.utf8)
        let error = try JSONDecoder().decode(StripeError.self, from: json)
        #expect(error.error?.code?.rawValue == "a_new_code")
        #expect(error.error?.type == .cardError)
        #expect(error.error?.message == "Your card was declined.")
        #expect(StripeErrorCode(rawValue: "card_declined") == .cardDeclined)
    }

    @Test("A new event type still decodes")
    func eventTypes() throws {
        var json = try #require(JSONSerialization.jsonObject(with: Fixtures.all["event"]!) as? [String: Any])
        json["type"] = "a_resource.something_happened"
        let event = try Fixtures.decoder.decode(StripeEvent.self, from: JSONSerialization.data(withJSONObject: json))
        #expect(event.type.rawValue == "a_resource.something_happened")
    }

    @Test("Params can send a value this version doesn't list")
    func paramsSendUnknownValues() {
        let params = PaymentIntentCreateParams(amount: 100, currency: "usd", setupFutureUsage: .init(rawValue: "a_new_usage"))
        #expect(params.toFormBody().contains("setup_future_usage=a_new_usage"))
    }

}
