import XCTest
@testable import StripeKit

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

    // MARK: Generated params

    func testEnumEncodesRawValueNotCaseName() throws {
        let params = PaymentIntentCreateParams(
            amount: 100,
            currency: "cad",
            automaticPaymentMethods: .init(enabled: true),
            setupFutureUsage: .offSession
        )
        let body = params.toFormBody()
        XCTAssertTrue(body.contains("setup_future_usage=off_session"), "got: \(body)")
        XCTAssertTrue(body.contains("automatic_payment_methods[enabled]=true"), "got: \(body)")
        XCTAssertTrue(body.contains("amount=100"), "got: \(body)")
        XCTAssertTrue(body.contains("currency=cad"), "got: \(body)")
        XCTAssertFalse(body.contains("offSession"), "got: \(body)")
    }

    func testServerStylePaymentIntentParams() throws {
        let params = PaymentIntentCreateParams(
            amount: 2500,
            currency: "cad",
            automaticPaymentMethods: .init(enabled: true),
            confirm: true,
            metadata: ["order_id": "ord 1&2"],
            offSession: true,
            setupFutureUsage: .offSession
        )
        let pairs = Set(params.toFormBody().split(separator: "&").map(String.init))
        XCTAssertEqual(pairs, [
            "amount=2500",
            "automatic_payment_methods[enabled]=true",
            "confirm=true",
            "currency=cad",
            "metadata[order_id]=ord%201%262",
            "off_session=true",
            "setup_future_usage=off_session",
        ])
    }

    func testArrayOfEnumsUsesEmptyBrackets() throws {
        let params = PaymentIntentCreateParams(
            amount: 100,
            currency: "usd",
            allowedPaymentMethodTypes: [.card, .acssDebit],
            expand: ["customer", "latest_charge"]
        )
        let body = params.toFormBody()
        XCTAssertTrue(body.contains("allowed_payment_method_types[]=card&allowed_payment_method_types[]=acss_debit"), "got: \(body)")
        XCTAssertTrue(body.contains("expand[]=customer&expand[]=latest_charge"), "got: \(body)")
    }

    func testArrayOfNestedParamsUsesIndexedBrackets() throws {
        let params = SubscriptionCreateParams(
            customer: "cus_123",
            items: [
                .init(metadata: ["k": "v"], price: "price_a", quantity: 2),
                .init(price: "price_b", taxRates: ["txr_1"]),
            ]
        )
        let pairs = Set(params.toFormBody().split(separator: "&").map(String.init))
        XCTAssertEqual(pairs, [
            "customer=cus_123",
            "items[0][metadata][k]=v",
            "items[0][price]=price_a",
            "items[0][quantity]=2",
            "items[1][price]=price_b",
            "items[1][tax_rates][]=txr_1",
        ])
    }

    func testNumbersAndBoolsStayDistinct() throws {
        let params = SubscriptionCreateParams(applicationFeePercent: 1.5, cancelAtPeriodEnd: true, daysUntilDue: 1)
        let pairs = Set(params.toFormBody().split(separator: "&").map(String.init))
        XCTAssertEqual(pairs, ["application_fee_percent=1.5", "cancel_at_period_end=true", "days_until_due=1"])
    }

    func testCodingKeysDecideWireNames() throws {
        // camelCase → snake_case conversion alone would give `ssn_last4`.
        let params = TokenAccountIndividual(ssnLast4: "1234")
        XCTAssertEqual(params.toFormBody(), "ssn_last_4=1234")
    }

    func testFormBodyEscapesReservedCharacters() throws {
        // `+`, `&` and `=` would otherwise be read as a space and as separators.
        let params = TestParams(amount: 1, currency: "usd", customer: "Hamlin, Hamlin & McGill+a=b")
        XCTAssertTrue(params.toFormBody().contains("customer=Hamlin%2C%20Hamlin%20%26%20McGill%2Ba%3Db"), params.toFormBody())
    }
}
