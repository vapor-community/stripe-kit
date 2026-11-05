//
//  TaxIDTests.swift
//
//

import XCTest
@testable import StripeKit

final class TaxIDTests: XCTestCase {
    private func decodeType(_ type: String) throws -> TaxIDType? {
        let json = #"{"id": "txi_123", "object": "tax_id", "type": "\#(type)", "value": "RSSMRA80A01H501U", "customer": "cus_123", "created": 1789318994}"#
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(TaxID.self, from: Data(json.utf8)).type
    }

    func testDecodesItalianCodiceFiscale() throws {
        XCTAssertEqual(try decodeType("it_cf"), .itCf)
    }

    func testDecodesAnUnknownTypeAsUnknown() throws {
        XCTAssertEqual(try decodeType("xx_new_type"), .unknown)
    }
}
