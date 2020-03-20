import XCTest
@testable import StripeKit
import Crypto

class SignatureVerificationTests: XCTestCase {
    var jsonData: Data = try! JSONEncoder().encode(["key": "value"])
    var secret: String = "SECRET"
    
    func testVerificationWithSingleSignature() throws {
        let timestamp = String(Date().addingTimeInterval(-60).timeIntervalSince1970)
        let secretData = secret.data(using: .utf8)!
        let data = [timestamp, String(data: jsonData, encoding: .utf8)!].joined(separator: ".").data(using: .utf8)!
        let hash = Data(HMAC<SHA256>.authenticationCode(for: data, using: SymmetricKey(data: secretData))).hexString
        let header = "t=\(timestamp),v1=\(hash)"
        XCTAssertNoThrow(try StripeClient.verifySignature(payload: jsonData, header: header, secret:secret))
    }
    
    func testVerificationWithMultipleSignatures() throws {
        let header = "t=123,v1=7b15c7edc2183ad5be71922cc180f70b1ce4c0925c45abb6b1676ad43cb79173,v1=911b8d64f1a89c73cec478d4ace90345a6c268f5f60892060ea1af531b4fe97c"
        
        XCTAssertNoThrow(try StripeClient.verifySignature(payload: jsonData, header: header, secret: secret, tolerance: -1))
    }
    
    func testVerificationWithInvalidHeaderThrows() throws {
        XCTAssertThrowsError(try StripeClient.verifySignature(payload: jsonData, header: "a", secret: secret, tolerance: -1)) { error in
            XCTAssertEqual(error as? StripeSignatureError, StripeSignatureError.unableToParseHeader)
        }
    }
    
    func testVerificationWithWrongSignatureThrows() throws {
        XCTAssertThrowsError(try StripeClient.verifySignature(payload: jsonData, header: "t=123,v1=abc", secret: secret, tolerance: -1)) { error in
            XCTAssertEqual(error as? StripeSignatureError, StripeSignatureError.noMatchingSignatureFound)
        }
    }
    
    func testVerificationWithNonToleratedTimestamp() throws {
        // Subtracting 6 minutes
        let timestamp = String(Date().addingTimeInterval(-360).timeIntervalSince1970)
        let secretData = secret.data(using: .utf8)!
        let data = [timestamp, String(data: jsonData, encoding: .utf8)!].joined(separator: ".").data(using: .utf8)!
        let hash = Data(HMAC<SHA256>.authenticationCode(for: data, using: SymmetricKey(data: secretData))).hexString
        let header = "t=\(timestamp),v1=\(hash)"
        
        XCTAssertThrowsError(try StripeClient.verifySignature(payload: jsonData, header: header, secret: secret)) { error in
            XCTAssertEqual(error as? StripeSignatureError, StripeSignatureError.timestampNotTolerated)
        }
    }
}

extension Data {
    var hexString: String {
        return self.reduce("", { $0 + String(format: "%02x", $1) })
    }
}
