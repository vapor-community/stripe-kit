import Foundation
import Testing
import StripeKit

/// Stripe clears a field sent empty (`field=`) where its spec allows "", including objects,
/// arrays and numbers that have no empty value of their own.
@Suite("Clearing fields")
struct ClearFieldTests {
    @Test("A cleared field is sent empty")
    func clearsTopLevelFields() {
        var params = CustomerUpdateParams()
        params.clear(.metadata)
        params.clear(.shipping)    // an object
        #expect(params.toFormBody() == "metadata=&shipping=")
    }

    @Test("A nested field is cleared under its parent's key")
    func clearsNestedFields() {
        var settings = CustomerInvoiceSettings(footer: "Thanks!")
        settings.clear(.customFields)
        settings.clear(.renderingOptions)
        let params = CustomerUpdateParams(invoiceSettings: settings)
        #expect(params.toFormBody() == "invoice_settings[custom_fields]=&invoice_settings[footer]=Thanks%21&invoice_settings[rendering_options]=")
    }

    @Test("Clearing a field replaces a value set on it")
    func clearingWins() {
        var params = CustomerUpdateParams(metadata: ["order": "1"], name: "Jane")
        params.clear(.metadata)
        #expect(params.toFormBody() == "metadata=&name=Jane")
    }

    @Test("Params without cleared fields encode as before, and decode without the key")
    func noClearedFields() throws {
        let params = CustomerUpdateParams(name: "Jane")
        #expect(params.toFormBody() == "name=Jane")

        let decoded = try JSONDecoder().decode(CustomerUpdateParams.self, from: Data(#"{"name": "Jane"}"#.utf8))
        #expect(decoded.fieldsToClear.isEmpty)
        #expect(decoded.name == "Jane")

        var cleared = params
        cleared.clear(.metadata)
        let roundTripped = try JSONDecoder().decode(CustomerUpdateParams.self, from: JSONEncoder().encode(cleared))
        #expect(roundTripped.fieldsToClear == [.metadata])
    }
}
