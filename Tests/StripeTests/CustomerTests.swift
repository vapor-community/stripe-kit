//
//  CustomerTests.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/20/17.
//
//

import XCTest
@testable import Stripe
@testable import Vapor

class CustomerTests: XCTestCase {
    var decoder: JSONDecoder!
    
    override func setUp() {
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    let customerString = """
{
  "id": "cus_CG7FIUH6U4JTkB",
  "object": "customer",
  "account_balance": 0,
  "created": 1517702745,
  "currency": "usd",
  "default_source": "scr_123456",
  "delinquent": false,
  "description": "A customer",
  "discount": null,
  "email": "abc@xyz.com",
  "invoice_prefix": "20DC7A9",
  "invoice_settings": {
    "custom_fields": [{"name": "SwiftNIO",
                       "value": "Bird"}],
    "footer": "Bye Bye"
  },
  "livemode": false,
  "metadata": {
  },
  "shipping": null,
  "sources": {
        "has_more": false,
        "object": "list",
        "data": [],
        "total_count": 0,
        "url": "/v1/customers/cus_D3t6eeIn7f2nYi/sources"
    },
  "subscriptions": {
        "has_more": false,
        "object": "list",
        "data": [],
        "total_count": 0,
        "url": "/v1/customers/cus_D3t6eeIn7f2nYi/subscriptions"
    },
  "tax_info": {
   "tax_id": "taxme",
   "type": "vat"
   },
  "tax_info_verification": {
   "status": "pending",
   "verified_name": "Tim Apple"
   }
}
"""
    func testCustomerParsesProperly() throws {
        do {
            let body = HTTPBody(string: customerString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let customer = try decoder.decode(StripeCustomer.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop()).wait()

            XCTAssertEqual(customer.id, "cus_CG7FIUH6U4JTkB")
            XCTAssertEqual(customer.object, "customer")
            XCTAssertEqual(customer.accountBalance, 0)
            XCTAssertEqual(customer.created, Date(timeIntervalSince1970: 1517702745))
            XCTAssertEqual(customer.currency, .usd)
            XCTAssertEqual(customer.defaultSource, "scr_123456")
            XCTAssertEqual(customer.delinquent, false)
            XCTAssertEqual(customer.description, "A customer")
            XCTAssertEqual(customer.email, "abc@xyz.com")
            XCTAssertEqual(customer.invoicePrefix, "20DC7A9")
            XCTAssertEqual(customer.invoiceSettings?.footer, "Bye Bye")
            XCTAssertEqual(customer.invoiceSettings?.customFields?[0].name, "SwiftNIO")
            XCTAssertEqual(customer.invoiceSettings?.customFields?[0].value, "Bird")
            XCTAssertEqual(customer.taxInfo?.taxId, "taxme")
            XCTAssertEqual(customer.taxInfo?.type, "vat")
            XCTAssertEqual(customer.taxInfoVerification?.status, .pending)
            XCTAssertEqual(customer.taxInfoVerification?.verifiedName, "Tim Apple")
            XCTAssertEqual(customer.livemode, false)
        } catch {
            XCTFail("\(error)")
        }
    }
}
