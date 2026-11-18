import XCTest
@testable import StripeKit

/// Query params for GET list/search routes, generated from the spec's `in: query` parameters.
class ListParamsTests: XCTestCase {

    /// Decoded `key=value` pairs, order ignored.
    private func pairs(_ query: String) -> Set<String> {
        Set(query.split(separator: "&").map { $0.removingPercentEncoding ?? String($0) })
    }

    func testCustomerListEncodesFiltersAsQuery() throws {
        let params = CustomerListParams(
            created: .range(gte: 1_700_000_000, lt: 1_800_000_000),
            email: "jane@example.com",
            expand: ["data.default_source"],
            limit: 10,
            startingAfter: "cus_123"
        )
        XCTAssertEqual(pairs(params.toFormBody()), [
            "created[gte]=1700000000",
            "created[lt]=1800000000",
            "email=jane@example.com",
            "expand[]=data.default_source",
            "limit=10",
            "starting_after=cus_123",
        ])
    }

    func testRangeQueryEqualsEncodesAsScalar() throws {
        XCTAssertEqual(CustomerListParams(created: .equals(1_700_000_000)).toFormBody(), "created=1700000000")
    }

    func testEmptyListParamsEncodeToEmptyQuery() throws {
        XCTAssertEqual(CustomerListParams().toFormBody(), "")
    }

    func testPaymentMethodListEnumsUseRawValues() throws {
        let params = PaymentMethodListParams(allowRedisplay: .always, customer: "cus_123", type: .card)
        XCTAssertEqual(pairs(params.toFormBody()), ["allow_redisplay=always", "customer=cus_123", "type=card"])
    }

    func testSearchQueryIsRequiredAndPercentEncoded() throws {
        let params = CustomerSearchParams(query: "email:'jane+1@example.com' AND metadata['a']:'b'", limit: 5)
        let body = params.toFormBody()
        XCTAssertFalse(body.contains(" "), "spaces must be encoded, got: \(body)")
        XCTAssertFalse(body.contains("jane+1"), "+ must be encoded, got: \(body)")
        XCTAssertEqual(pairs(body), ["limit=5", "query=email:'jane+1@example.com' AND metadata['a']:'b'"])
    }

    func testRangeQueryRoundTrips() throws {
        for value in [StripeRangeQuery.equals(5), .range(gt: 1, lte: 9)] {
            let data = try JSONEncoder().encode(value)
            XCTAssertEqual(try JSONDecoder().decode(StripeRangeQuery.self, from: data), value)
        }
    }

    func testSearchResultDecodes() throws {
        let json = """
        {
          "object": "search_result",
          "url": "/v1/customers/search",
          "has_more": true,
          "next_page": "page_abc",
          "data": []
        }
        """
        let result = try JSONDecoder().decode(StripeSearchResult<Customer>.self, from: Data(json.utf8))
        XCTAssertEqual(result.object, "search_result")
        XCTAssertTrue(result.hasMore)
        XCTAssertEqual(result.nextPage, "page_abc")
        XCTAssertNil(result.totalCount)
        XCTAssertTrue(result.data.isEmpty)
    }
}
