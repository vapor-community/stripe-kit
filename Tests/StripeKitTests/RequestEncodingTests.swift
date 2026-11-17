import Foundation
import Testing
import NIOHTTP1
import AsyncHTTPClient
@testable import StripeKit

/// What `StripeAPIHandler` sends for each shape of route, checked without a network call.
@Suite("Request encoding")
struct RequestEncodingTests {
    let handler = StripeAPIHandler(httpClient: .shared, apiKey: "sk_test_123", stripeAccount: "acct_123")

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
        // Idempotency keys are only ever per request
        #expect(request.headers["Idempotency-Key"].isEmpty)
    }

    @Test("Interpolated path values are escaped as a single path segment")
    func pathParametersEscaped() {
        func path(_ id: String) -> String { StripePath("/v1/products/\(id)").description }
        // IDs Stripe generates pass through unchanged
        #expect(path("cus_QXg1o8vcGmoR32") == "/v1/products/cus_QXg1o8vcGmoR32")
        #expect(path("price.v2-test~1") == "/v1/products/price.v2-test~1")
        // A chosen ID can't break out of its segment or into the query string
        #expect(path("prod/../secret?x=1#y") == "/v1/products/prod%2F..%2Fsecret%3Fx%3D1%23y")
        #expect(path("my product+ü") == "/v1/products/my%20product%2B%C3%BC")
        // Literal parts, and an explicitly unescaped path, are used as written
        #expect(StripePath("/v1/a/b").description == "/v1/a/b")
        #expect(StripePath(unescaped: "/v1/a%2Fb").description == "/v1/a%2Fb")

        let id = "a/b c"
        let request = handler.request(.GET, "/v1/products/\(id)")
        #expect(request.url == "https://api.stripe.com/v1/products/a%2Fb%20c")
    }

    @Test("Per-request options set the idempotency key and override the client's account")
    func requestOptionsOverride() {
        let request = handler.request(.POST, "/v1/payouts", options: .init(stripeAccount: "acct_other", idempotencyKey: "key_1"))
        #expect(request.headers["Stripe-Account"] == ["acct_other"])
        #expect(request.headers["Idempotency-Key"] == ["key_1"])
    }

    @Test("A route's own host replaces the API host")
    func baseURLOverride() {
        let request = handler.request(.GET, "/v1/quotes/qt_1/pdf", baseURL: "https://files.stripe.com")
        #expect(request.url == "https://files.stripe.com/v1/quotes/qt_1/pdf")
    }
}
