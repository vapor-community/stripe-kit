import Foundation
import AsyncHTTPClient
import Crypto
import NIO
import NIOFoundationCompat
import NIOHTTP1

extension StripeClient {
    /// Verify a signature from Stripe
    /// - Parameters:
    ///   - payload: The JSON payload as `Data`
    ///   - header: The `Stripe-Signature` HTTP-Header value
    ///   - secret: The secret associated with the webhook
    ///   - tolerance: In seconds the time difference tolerance to prevent replay attacks: Default 300 seconds
    static public func verifySignature(payload: Data, header: String, secret: String, tolerance: Double = 300) throws {
        let signaturePairs = header.components(separatedBy: ",")
        
        let signatures = signaturePairs.reduce(into: [String]()) { result, component in
            let kvPair = component.components(separatedBy: "=")
            
            guard kvPair.count == 2 else { return }
            
            if kvPair.first == "v1" { result.append(kvPair.last!) }
        }
        
        guard let timestamp = signaturePairs
            .first(where: { $0.starts(with: "t=")})?
            .components(separatedBy: "=")
            .last
            else {
                throw StripeSignatureError.unableToParseHeader
        }
        
        let payloadString = String(data: payload, encoding: .utf8)!
        let combinedPayload = [timestamp, payloadString].joined(separator: ".").data(using: .utf8)!
        
        let secretKey = SymmetricKey(data: secret.data(using: .utf8)!)
        
        let result = signatures.map { signature -> Bool in
            guard let data = signature.data(using: .hexadecimal) else {
                return false
            }
            
            return HMAC<SHA256>.isValidAuthenticationCode(data, authenticating: combinedPayload, using: secretKey)
        }
        
        guard result.contains(true) else {
            throw StripeSignatureError.noMatchingSignatureFound
        }
        
        guard let time = Double(timestamp) else {
                throw StripeSignatureError.unableToParseHeader
        }
        
        let timeDifference = Date().timeIntervalSince(Date(timeIntervalSince1970: time))
        
        if tolerance > 0 && timeDifference > tolerance || timeDifference < 0 {
            throw StripeSignatureError.timestampNotTolerated
        }
    }
}
