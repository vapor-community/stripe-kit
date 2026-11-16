import XCTest
@testable import StripeKit

/// Params the spec types as `anyOf` of several forms, or as maps of typed values.
/// Each form must encode to what Stripe expects.
class ParamUnionTests: XCTestCase {

    /// Decoded `key=value` pairs, order ignored.
    private func pairs(_ body: String) -> Set<String> {
        Set(body.split(separator: "&").map { $0.removingPercentEncoding ?? String($0) })
    }

    // MARK: Scalar or keyword

    func testBoolOrKeyword() {
        XCTAssertEqual(PaymentIntentCreateParams(amount: 100, currency: "usd", offSession: true).toFormBody(),
                       "amount=100&currency=usd&off_session=true")
        XCTAssertEqual(PaymentIntentCreateParams(amount: 100, currency: "usd", offSession: .oneOff).toFormBody(),
                       "amount=100&currency=usd&off_session=one_off")
    }

    func testTimestampOrKeyword() {
        XCTAssertEqual(SubscriptionCreateParams(trialEnd: .now).toFormBody(), "trial_end=now")
        XCTAssertEqual(SubscriptionCreateParams(trialEnd: 1_700_000_000).toFormBody(), "trial_end=1700000000")
        XCTAssertEqual(SubscriptionCreateParams(cancelAt: .maxPeriodEnd).toFormBody(), "cancel_at=max_period_end")
    }

    // MARK: Object forms

    func testObjectOrID() {
        XCTAssertEqual(pairs(PlanCreateParams(currency: "usd", interval: .month, product: "prod_123").toFormBody()),
                       ["currency=usd", "interval=month", "product=prod_123"])
        let inline = PlanCreateParams(currency: "usd", interval: .month, product: .inlineProduct(.init(name: "Gold")))
        XCTAssertEqual(pairs(inline.toFormBody()), ["currency=usd", "interval=month", "product[name]=Gold"])
    }

    func testOneOfTwoObjectShapes() {
        let params = PaymentIntentConfirmParams(mandateData: .secretKey(.init(customerAcceptance: .init(
            type: .online,
            online: .init(ipAddress: "127.0.0.1", userAgent: "Swift")
        ))))
        XCTAssertEqual(pairs(params.toFormBody()), [
            "mandate_data[customer_acceptance][type]=online",
            "mandate_data[customer_acceptance][online][ip_address]=127.0.0.1",
            "mandate_data[customer_acceptance][online][user_agent]=Swift",
        ])
    }

    // MARK: Maps

    func testMapOfObjects() {
        let params = CouponCreateParams(currencyOptions: ["eur": .init(amountOff: 500), "gbp": .init(amountOff: 400)])
        XCTAssertEqual(pairs(params.toFormBody()), [
            "currency_options[eur][amount_off]=500",
            "currency_options[gbp][amount_off]=400",
        ])
    }

    // MARK: Round trip

    func testUnionsDecodeWhatTheyEncode() throws {
        let params = SubscriptionCreateParams(cancelAt: 1_800_000_000, trialEnd: .now)
        let decoded = try JSONDecoder().decode(SubscriptionCreateParams.self, from: JSONEncoder().encode(params))
        XCTAssertEqual(decoded.toFormBody(), params.toFormBody())
    }
}
