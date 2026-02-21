import XCTest
@testable import StripeKit

class ExpandableTests: XCTestCase {
    
    func testDynamicExpandable_decodesProperly() throws {
        
        // Self-contained test: DynamicExpandable works independently of generated models
        struct TypeA: Codable { var id: String; var name: String }
        struct TypeB: Codable { var id: String; var code: Int }
        struct TestFee: Codable {
            @DynamicExpandable<TypeA, TypeB> var item: String?
        }
        
        let expandedJSON = """
        {
            "item": {
              "id": "item_123",
              "name": "Test Item"
            }
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let fee = try decoder.decode(TestFee.self, from: expandedJSON)
        
        XCTAssertNotNil(fee.$item(as: TypeA.self))
        XCTAssertNil(fee.$item(as: TypeB.self))
        XCTAssertEqual(fee.$item(as: TypeA.self)?.name, "Test Item")
    }
    
    func testExpandable_decodesProperly_whenTopLevelField_isMissing() throws {
        
        let objectMissingExpandableTransferFieldOnCharge = """
        {
          "object": {
            "id": "pi_1GdgW1IEV8X7ehfSpCasicNz",
            "object": "payment_intent",
            "amount": 2000,
            "amount_capturable": 0,
            "amount_received": 2000,
            "application": null,
            "application_fee_amount": null,
            "canceled_at": null,
            "cancellation_reason": null,
            "capture_method": "automatic",
            "charges": {
              "object": "list",
              "data": [
                {
                  "id": "ch_1GdgW2IEV8X7ehfSpaWh7SH4",
                  "object": "charge",
                  "amount": 2000,
                  "amount_refunded": 0,
                  "application": null,
                  "application_fee": null,
                  "application_fee_amount": null,
                  "balance_transaction": "txn_1GdgW2IEV8X7ehfS6VWplXVL",
                  "billing_details": {
                    "address": {
                      "city": null,
                      "country": null,
                      "line1": null,
                      "line2": null,
                      "postal_code": null,
                      "state": null
                    },
                    "email": null,
                    "name": null,
                    "phone": null
                  },
                  "calculated_statement_descriptor": "CODANUT",
                  "captured": true,
                  "created": 1588268982,
                  "currency": "usd",
                  "customer": null,
                  "description": "(created by Stripe CLI)",
                  "destination": null,
                  "dispute": null,
                  "disputed": false,
                  "failure_code": null,
                  "failure_message": null,
                  "fraud_details": {
                  },
                  "invoice": null,
                  "livemode": false,
                  "metadata": {
                  },
                  "on_behalf_of": null,
                  "order": null,
                  "outcome": {
                    "network_status": "approved_by_network",
                    "reason": null,
                    "risk_level": "normal",
                    "risk_score": 16,
                    "seller_message": "Payment complete.",
                    "type": "authorized"
                  },
                  "paid": true,
                  "payment_intent": "pi_1GdgW1IEV8X7ehfSpCasicNz",
                  "payment_method": "pm_1GdgW1IEV8X7ehfSHj6NWpKv",
                  "payment_method_details": {
                    "card": {
                      "brand": "visa",
                      "checks": {
                        "address_line1_check": null,
                        "address_postal_code_check": null,
                        "cvc_check": null
                      },
                      "country": "US",
                      "exp_month": 4,
                      "exp_year": 2021,
                      "fingerprint": "Kka7mYRiNKPJTIum",
                      "funding": "credit",
                      "installments": null,
                      "last4": "4242",
                      "network": "visa",
                      "three_d_secure": null,
                      "wallet": null
                    },
                    "type": "card"
                  },
                  "receipt_email": null,
                  "receipt_number": null,
                  "receipt_url": "https://pay.stripe.com/receipts/acct_1GQK3mIEV8X7ehfS/ch_1GdgW2IEV8X7ehfSpaWh7SH4/rcpt_HC4f61HVvgNeCToXazHDcOLU43dhs1u",
                  "refunded": false,
                  "refunds": {
                    "object": "list",
                    "data": [
                    ],
                    "has_more": false,
                    "total_count": 0,
                    "url": "/v1/charges/ch_1GdgW2IEV8X7ehfSpaWh7SH4/refunds"
                  },
                  "review": null,
                  "shipping": {
                    "address": {
                      "city": "San Francisco",
                      "country": "US",
                      "line1": "510 Townsend St",
                      "line2": null,
                      "postal_code": "94103",
                      "state": "CA"
                    },
                    "carrier": null,
                    "name": "Jenny Rosen",
                    "phone": null,
                    "tracking_number": null
                  },
                  "source": null,
                  "source_transfer": null,
                  "statement_descriptor": null,
                  "statement_descriptor_suffix": null,
                  "status": "succeeded",
                  "transfer_data": null,
                  "transfer_group": null
                }
              ],
              "has_more": false,
              "total_count": 1,
              "url": "/v1/charges?payment_intent=pi_1GdgW1IEV8X7ehfSpCasicNz"
            },
            "client_secret": "",
            "confirmation_method": "automatic",
            "created": 1588268981,
            "currency": "usd",
            "customer": null,
            "description": "(created by Stripe CLI)",
            "invoice": null,
            "last_payment_error": null,
            "livemode": false,
            "metadata": {
            },
            "next_action": null,
            "on_behalf_of": null,
            "payment_method": "pm_1GdgW1IEV8X7ehfSHj6NWpKv",
            "payment_method_options": {
              "card": {
                "installments": null,
                "request_three_d_secure": "automatic"
              }
            },
            "payment_method_types": [
              "card"
            ],
            "receipt_email": null,
            "review": null,
            "setup_future_usage": null,
            "shipping": {
              "address": {
                "city": "San Francisco",
                "country": "US",
                "line1": "510 Townsend St",
                "line2": null,
                "postal_code": "94103",
                "state": "CA"
              },
              "carrier": null,
              "name": "Jenny Rosen",
              "phone": null,
              "tracking_number": null
            },
            "source": null,
            "statement_descriptor": null,
            "statement_descriptor_suffix": null,
            "status": "succeeded",
            "transfer_data": null,
            "transfer_group": null
          }
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
       _ = try decoder.decode(EventData.self, from: objectMissingExpandableTransferFieldOnCharge)
    }
    
    func testExpandable_nullEncodingDecoding() throws {
        struct TestSession: Codable {
            var id: String
            @Expandable<TestRef> var customer: String?
        }
        struct TestRef: Codable, Sendable { var id: String }
        
        let json = """
        {
          "id": "cs_test_ffff",
          "customer": null
        }
        """.data(using: .utf8)!
        let sess = try JSONDecoder().decode(TestSession.self, from: json)
        XCTAssertNil(sess.customer)
        XCTAssertNil(sess.$customer)
        _ = try JSONDecoder().decode(TestSession.self, from: JSONEncoder().encode(sess))
    }
    
    func testExpandableCollection_decodesProperly() throws {
        
        struct TestItem: Codable, Sendable {
            var id: String
        }
        struct SimpleType: Codable {
            @ExpandableCollection<TestItem> var items: [String]?
        }
        
        let json = """
        {
            "items": [
                {
                    "id": "item_1234"
                },
                {
                    "id": "item_12345"
                }
            ]
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let simple = try decoder.decode(SimpleType.self, from: json)
        
        XCTAssertEqual(simple.$items?.count, 2)
        XCTAssertEqual(simple.$items?[0].id, "item_1234")
        XCTAssertEqual(simple.$items?[1].id, "item_12345")
    }
}
