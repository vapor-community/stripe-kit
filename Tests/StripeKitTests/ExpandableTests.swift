import XCTest
@testable import StripeKit

class ExpandableTests: XCTestCase {
    
    func testExpandable_decodesMissingIDAndExpandedValues() throws {
        struct TestRef: Codable, Sendable { var id: String }
        struct TestCharge: Codable {
            @Expandable<TestRef> var customer: String?
        }
        let decoder = JSONDecoder()

        // A missing field decodes as neither an ID nor an object
        let missing = try decoder.decode(TestCharge.self, from: Data(#"{}"#.utf8))
        XCTAssertNil(missing.customer)
        XCTAssertNil(missing.$customer)

        // Unexpanded: the ID
        let unexpanded = try decoder.decode(TestCharge.self, from: Data(#"{"customer": "cus_1"}"#.utf8))
        XCTAssertEqual(unexpanded.customer, "cus_1")
        XCTAssertNil(unexpanded.$customer)

        // Expanded: the object
        let expanded = try decoder.decode(TestCharge.self, from: Data(#"{"customer": {"id": "cus_1"}}"#.utf8))
        XCTAssertNil(expanded.customer)
        XCTAssertEqual(expanded.$customer?.id, "cus_1")
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
        
        let simple = try JSONDecoder().decode(SimpleType.self, from: json)
        
        XCTAssertEqual(simple.$items?.count, 2)
        XCTAssertEqual(simple.$items?[0].id, "item_1234")
        XCTAssertEqual(simple.$items?[1].id, "item_12345")
    }
}
