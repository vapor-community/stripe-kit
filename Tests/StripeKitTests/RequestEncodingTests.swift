import Foundation
import Testing
import NIOHTTP1
import AsyncHTTPClient
@testable import StripeKit

/// What `StripeAPIHandler` sends for each shape of route, checked without a network call.
@Suite("Request encoding")
struct RequestEncodingTests {
    let handler = StripeAPIHandler(httpClient: .shared, apiKey: "sk_test_123", stripeAccount: "acct_123", idempotencyKey: "key_123")

    @Test("GET params go in the query string, with no body")
    func getParamsInQuery() {
        let request = handler.request(.GET, "/v1/customers", params: CustomerListParams(email: "a+b@example.com", limit: 3))
        #expect(request.url == "https://api.stripe.com/v1/customers?email=a%2Bb@example.com&limit=3")
        #expect(request.body == nil)
        #expect(request.headers["Content-Type"].isEmpty)
    }

    @Test("POST params go in a form body, not the query string")
    func postParamsInBody() {
        let request = handler.request(.POST, "/v1/customers", params: CustomerCreateParams(email: "a@example.com"))
        #expect(request.url == "https://api.stripe.com/v1/customers")
        #expect(request.body != nil)
        #expect(request.headers["Content-Type"] == ["application/x-www-form-urlencoded"])
    }

    @Test("expand goes in the query string, percent-encoded")
    func expandInQuery() {
        let request = handler.request(.GET, "/v1/charges/ch_1", expand: ["customer", "invoice.subscription"])
        #expect(request.url == "https://api.stripe.com/v1/charges/ch_1?expand[]=customer&expand[]=invoice.subscription")
    }

    @Test("Every request carries Stripe's headers")
    func standardHeaders() {
        let request = handler.request(.DELETE, "/v1/customers/cus_1")
        #expect(request.method == .DELETE)
        #expect(request.headers["Authorization"] == ["Bearer sk_test_123"])
        #expect(request.headers["Stripe-Version"] == [StripeClient.apiVersion])
        #expect(request.headers["Stripe-Account"] == ["acct_123"])
        #expect(request.headers["Idempotency-Key"] == ["key_123"])
    }

    @Test("A route's own host replaces the API host")
    func baseURLOverride() {
        let request = handler.request(.GET, "/v1/quotes/qt_1/pdf", baseURL: "https://files.stripe.com")
        #expect(request.url == "https://files.stripe.com/v1/quotes/qt_1/pdf")
    }
}
