import Foundation
import Testing
import StripeKit

@Suite("JSONValue")
struct JSONValueTests {
    static let json = Data(#"{"bool": true, "int": 1, "double": 1.5, "null": null, "array": [1, "two"], "object": {"key": "value"}}"#.utf8)

    @Test("Decodes each kind of JSON value, keeping booleans and numbers apart")
    func decodesEveryKind() throws {
        let value = try JSONDecoder().decode(JSONValue.self, from: Self.json)
        #expect(value == .object([
            "bool": .bool(true),
            "int": .int(1),
            "double": .double(1.5),
            "null": .null,
            "array": .array([.int(1), .string("two")]),
            "object": .object(["key": .string("value")]),
        ]))
        #expect(value["array"]?[1]?.stringValue == "two")
        #expect(value["object"]?["key"]?.stringValue == "value")
        #expect(value["int"]?.doubleValue == 1)
        #expect(value["bool"]?.intValue == nil)
        #expect(value["null"]?.isNull == true)
        #expect(value["missing"] == nil)
    }

    @Test("Survives an encode/decode round trip")
    func roundTrips() throws {
        let value = try JSONDecoder().decode(JSONValue.self, from: Self.json)
        #expect(try JSONDecoder().decode(JSONValue.self, from: JSONEncoder().encode(value)) == value)
    }

    @Test("Free-form model fields decode as JSONValue")
    func freeFormFields() throws {
        let _: KeyPath<PaymentIntentNextAction, [String: JSONValue]?> = \.useStripeSdk
        let action = try JSONDecoder().decode(
            PaymentIntentNextAction.self,
            from: Data(#"{"type": "use_stripe_sdk", "use_stripe_sdk": {"type": "three_d_secure_redirect", "version": 2}}"#.utf8)
        )
        #expect(action.useStripeSdk?["version"] == .int(2))
    }
}
