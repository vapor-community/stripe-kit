import XCTest
@testable import StripeKit

class QueryEncodingTests: XCTestCase {
    
    func testSimpleQueryEncodedProperly() throws {
        let query: [String: Any] = [
            "email": "accounting+furnitures@hmm.test"
        ]
        XCTAssertEqual(query.queryParameters, "email=accounting%2Bfurnitures@hmm.test")
    }
    
    func testNestedDictionaryQueryEncodedProperly() throws {
        let query: [String: Any] = [
            "shipping": ["name": "Hamlin, Hamlin & McGill"]
        ]
        XCTAssertEqual(query.queryParameters, "shipping[name]=Hamlin,%20Hamlin%20%26%20McGill")
    }
    
    func testNestedArrayQueryEncodedProperly() throws {
        let query: [String: Any] = [
            "items": [["plan": "plan_b"], ["plan": "plan_nine"]]
        ]
        XCTAssertEqual(query.queryParameters, "items[0][plan]=plan_b&items[1][plan]=plan_nine")
    }
    
    func testBoolEncodedAsTrueOrFalse() throws {
        let query: [String: Any] = ["confirm": true]
        XCTAssertEqual(query.queryParameters, "confirm=true")
        
        let query2: [String: Any] = ["confirm": false]
        XCTAssertEqual(query2.queryParameters, "confirm=false")
    }
    
    func testBoolMixedWithOtherTypes() throws {
        let query: [String: Any] = ["amount": 900, "confirm": true, "currency": "usd"]
        let result = query.queryParameters
        XCTAssertTrue(result.contains("confirm=true"), "Expected confirm=true but got: \(result)")
        XCTAssertTrue(result.contains("amount=900"), "Expected amount=900 but got: \(result)")
        XCTAssertTrue(result.contains("currency=usd"), "Expected currency=usd but got: \(result)")
    }
}

// MARK: - StripeParams toFormBody tests

struct TestParams: StripeParams {
    var amount: Int
    var currency: String
    var confirm: Bool?
    var customer: String?
}

class StripeParamsTests: XCTestCase {
    
    func testToFormBodyEncodesBoolAsTrue() throws {
        var params = TestParams(amount: 900, currency: "usd")
        params.confirm = true
        let body = params.toFormBody()
        XCTAssertTrue(body.contains("confirm=true"), "Expected confirm=true but got: \(body)")
    }
    
    func testToFormBodyEncodesBoolAsFalse() throws {
        var params = TestParams(amount: 900, currency: "usd")
        params.confirm = false
        let body = params.toFormBody()
        XCTAssertTrue(body.contains("confirm=false"), "Expected confirm=false but got: \(body)")
    }
    
    func testToFormBodySkipsNilOptionals() throws {
        let params = TestParams(amount: 500, currency: "usd")
        let body = params.toFormBody()
        XCTAssertFalse(body.contains("confirm"), "confirm should be omitted when nil, got: \(body)")
        XCTAssertFalse(body.contains("customer"), "customer should be omitted when nil, got: \(body)")
        XCTAssertTrue(body.contains("amount=500"))
        XCTAssertTrue(body.contains("currency=usd"))
    }
    
    func testToFormBodyEncodesSnakeCaseKeys() throws {
        let params = TestParams(amount: 100, currency: "eur")
        let body = params.toFormBody()
        // All keys should already be snake_case (amount, currency are single-word)
        XCTAssertTrue(body.contains("amount=100"))
        XCTAssertTrue(body.contains("currency=eur"))
    }
}
