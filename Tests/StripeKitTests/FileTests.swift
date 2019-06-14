////
////  FileTests.swift
////  StripeTests
////
////  Created by Andrew Edwards on 9/15/18.
////
//
//import XCTest
//@testable import Stripe
//@testable import Vapor
//
//class FileTests: XCTestCase {
//    var decoder: JSONDecoder!
//    
//    override func setUp() {
//        decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .secondsSince1970
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//    }
//    
//    let fileLinkString = """
//{
//  "id": "link_1DAf602eZvKYlo2CwXzohqY4",
//  "object": "file_link",
//  "created": 1537023004,
//  "expired": false,
//  "expires_at": null,
//  "file": "file_1CcHwQ2eZvKYlo2CS8LDX4wK",
//  "livemode": false,
//  "metadata": {
//  },
//  "url": "https://files.stripe.com/links/fl_test_iBHkHOhKU7YuwN7wXjKGOhcw"
//}
//"""
//    
//    func testFileLinkParsedProperly() throws {
//        do {
//            let body = HTTPBody(string: fileLinkString)
//            var headers: HTTPHeaders = [:]
//            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
//            let request = HTTPRequest(headers: headers, body: body)
//            let fileLink = try decoder.decode(StripeFileLink.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop()).wait()
//            
//            XCTAssertEqual(fileLink.id, "link_1DAf602eZvKYlo2CwXzohqY4")
//            XCTAssertEqual(fileLink.object, "file_link")
//            XCTAssertEqual(fileLink.created, Date(timeIntervalSince1970: 1537023004))
//            XCTAssertEqual(fileLink.expired, false)
//            XCTAssertEqual(fileLink.expiresAt, nil)
//            XCTAssertEqual(fileLink.file, "file_1CcHwQ2eZvKYlo2CS8LDX4wK")
//            XCTAssertEqual(fileLink.livemode, false)
//            XCTAssertEqual(fileLink.metadata, [:])
//            XCTAssertEqual(fileLink.url, "https://files.stripe.com/links/fl_test_iBHkHOhKU7YuwN7wXjKGOhcw")
//        } catch {
//            XCTFail("\(error.localizedDescription)")
//        }
//    }
//    
//    let fileUploadString = """
//{
//  "id": "file_1CcHwQ2eZvKYlo2CS8LDX4wK",
//  "object": "file_upload",
//  "created": 1528830846,
//  "filename": "icon1.png",
//  "links": {
//    "object": "list",
//    "data": [
//      {
//        "id": "link_1DAf5z2eZvKYlo2CScuVuZnv",
//        "object": "file_link",
//        "created": 1537023003,
//        "expired": false,
//        "expires_at": null,
//        "file": "file_1CcHwQ2eZvKYlo2CS8LDX4wK",
//        "livemode": false,
//        "metadata": {
//        },
//        "url": "https://files.stripe.com/links/fl_test_980v1485SYKS1DVGCO5SFd7d"
//      }
//    ],
//    "has_more": true,
//    "url": "/v1/file_links?file=file_1CcHwQ2eZvKYlo2CS8LDX4wK"
//  },
//  "purpose": "business_logo",
//  "size": 9676,
//  "type": "png",
//  "url": "https://files.stripe.com/files/f_test_F3TKCoF1vHGS0B5EmdyH1sUn"
//}
//"""
//    
//    func testFileUploadParsedProperly() throws {
//        do {
//            let body = HTTPBody(string: fileUploadString)
//            var headers: HTTPHeaders = [:]
//            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
//            let request = HTTPRequest(headers: headers, body: body)
//            let fileUpload = try decoder.decode(StripeFile.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop()).wait()
//            
//            XCTAssertEqual(fileUpload.id, "file_1CcHwQ2eZvKYlo2CS8LDX4wK")
//            XCTAssertEqual(fileUpload.object, "file_upload")
//            XCTAssertEqual(fileUpload.created, Date(timeIntervalSince1970: 1528830846))
//            XCTAssertEqual(fileUpload.filename, "icon1.png")
//            XCTAssertEqual(fileUpload.purpose, .businessLogo)
//            XCTAssertEqual(fileUpload.size, 9676)
//            XCTAssertEqual(fileUpload.type, .png)
//            XCTAssertEqual(fileUpload.url, "https://files.stripe.com/files/f_test_F3TKCoF1vHGS0B5EmdyH1sUn")
//            
//            XCTAssertEqual(fileUpload.links?.object, "list")
//            XCTAssertEqual(fileUpload.links?.hasMore, true)
//            XCTAssertEqual(fileUpload.links?.url, "/v1/file_links?file=file_1CcHwQ2eZvKYlo2CS8LDX4wK")
//            XCTAssertEqual(fileUpload.links?.data?.count, 1)
//        } catch {
//            XCTFail("\(error.localizedDescription)")
//        }
//    }
//}
