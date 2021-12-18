import XCTest
@testable import StripeKit

class ExpandableTests: XCTestCase {
    
    func testDynamicExpandable_decodesProperly() throws {
        
        let fee = """
        {
            "id": "fee_1G7XzFEnR8BaFqPrBOEk9R5P",
            "object": "application_fee",
            "account": "acct_1G7UfdEnR8BaFqPr",
            "amount": 110,
            "amount_refunded": 0,
            "application": "ca_Azct53hw5RUQJekiTbu7ScUpfgxZTrQ6",
            "balance_transaction": "txn_1G7XzFAU9AiAmxbB9hgAoDPs",
            "charge": "py_1G7XzFEnR8BaFqPrdwtxZovX",
            "created": 1580609701,
            "currency": "usd",
            "livemode": false,
            "originating_transaction": {
              "id": "ch_1G7XzFAU9AiAmxbBuFTA65QG",
              "object": "charge",
              "livemode": false,
              "payment_intent": "pi_1G7XzEAU9AiAmxbBYdTBI9fz",
              "status": "succeeded",
              "amount": 2500,
              "amount_refunded": 0,
              "application": null,
              "application_fee": "fee_1G7XzFEnR8BaFqPrBOEk9R5P",
              "application_fee_amount": 110,
              "balance_transaction": "txn_1G7XzFAU9AiAmxbBrfsM5Doj",
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
              "captured": true,
              "created": 1580609701,
              "currency": "usd",
              "customer": null,
              "description": null,
              "destination": "acct_1G7UfdEnR8BaFqPr",
              "dispute": null,
              "disputed": false,
              "failure_code": null,
              "failure_message": null,
              "fraud_details": {
              },
              "invoice": null,
              "metadata": {
              },
              "on_behalf_of": null,
              "order": null,
              "outcome": {
                "network_status": "approved_by_network",
                "reason": null,
                "risk_level": "normal",
                "risk_score": 38,
                "seller_message": "Payment complete.",
                "type": "authorized"
              },
              "paid": true,
              "payment_method": "pm_1G7XzEAU9AiAmxbBsEmn60pS",
              "payment_method_details": {
                "card": {
                  "brand": "visa",
                  "checks": {
                    "address_line1_check": null,
                    "address_postal_code_check": null,
                    "cvc_check": null
                  },
                  "country": "US",
                  "exp_month": 2,
                  "exp_year": 2021,
                  "fingerprint": "3ZiXEfr0TJ2bSd62",
                  "funding": "debit",
                  "installments": null,
                  "last4": "5556",
                  "network": "visa",
                  "three_d_secure": null,
                  "wallet": null
                },
                "type": "card"
              },
              "receipt_email": null,
              "receipt_number": null,
              "receipt_url": "https://pay.stripe.com/receipts/acct_16Ds3sAU9AiAmxbB/ch_1G7XzFAU9AiAmxbBuFTA65QG/rcpt_GeriQEf4RhBGA7n5cy3VVWpBHCBBnlF",
              "refunded": false,
              "refunds": {
                "object": "list",
                "data": [
                ],
                "has_more": false,
                "total_count": 0,
                "url": "/v1/charges/ch_1G7XzFAU9AiAmxbBuFTA65QG/refunds"
              },
              "review": null,
              "shipping": null,
              "source": null,
              "source_transfer": null,
              "statement_descriptor": null,
              "statement_descriptor_suffix": null,
              "transfer": "tr_1G7XzFAU9AiAmxbBHBoCr6IG",
              "transfer_data": {
                "amount": null,
                "destination": "acct_1G7UfdEnR8BaFqPr"
              },
              "transfer_group": "group_pi_1G7XzEAU9AiAmxbBYdTBI9fz"
            },
            "refunded": false,
            "refunds": {
              "object": "list",
              "data": [
              ],
              "has_more": false,
              "total_count": 0,
              "url": "/v1/application_fees/fee_1G7XzFEnR8BaFqPrBOEk9R5P/refunds"
            }
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let appFee = try decoder.decode(StripeApplicationFee.self, from: fee)
        
        XCTAssertNotNil(appFee.$originatingTransaction(as: StripeCharge.self))
        XCTAssertNil(appFee.$originatingTransaction(as: StripeTransfer.self))
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
       _ = try decoder.decode(StripeEventData.self, from: objectMissingExpandableTransferFieldOnCharge)
    }
    
    func testExpandable_nullEncodingDecoding() throws {
        let session = """
        {
          "amountTotal": 100,
          "id": "cs_test_ffff",
          "successUrl": "https://example.com",
          "livemode": false,
          "customer": null,
          "metadata": {},
          "totalDetails": {
            "amountShipping": 0,
            "amountTax": 0,
            "amountDiscount": 0
          },
          "setupIntent": null,
          "object": "checkout.session",
          "mode": "payment",
          "amountSubtotal": 100,
          "paymentIntent": "pi_ffff",
          "paymentMethodTypes": [
            "card"
          ],
          "cancelUrl": "https://example.com",
          "subscription": null,
          "currency": "usd",
          "paymentStatus": "unpaid"
        }
        """.data(using: .utf8)!
        let sess = try JSONDecoder().decode(StripeSession.self, from: session)
        _ = try JSONDecoder().decode(StripeSession.self, from: JSONEncoder().encode(sess))
    }
    
    func testExpandableCollection_decodesProperly() throws {
        
        struct SimpleType: StripeModel {
            @ExpandableCollection<StripeDiscount> var discounts: [String]?
        }
        
        let discounts = """
        {
            "discounts": [
                {
                    "id": "di_1234",
                    "object": "discount"
                },
                {
                    "id": "di_12345",
                    "object": "discount"
                },
            ]
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let simple = try decoder.decode(SimpleType.self, from: discounts)
        
        XCTAssertEqual(simple.$discounts?.count, 2)
        XCTAssertEqual(simple.$discounts?[0].id, "di_1234")
        XCTAssertEqual(simple.$discounts?[1].id, "di_12345")
    }
}
