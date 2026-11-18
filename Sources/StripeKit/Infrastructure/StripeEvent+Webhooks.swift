//
//  StripeEvent+Webhooks.swift
//  StripeKit
//
//  Hand-written infrastructure (not emitted by stripe-kit-codegen). `StripeEvent` itself is
//  generated from the spec's `event` schema; these are the parts the spec doesn't describe.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import Crypto

/// The `data` of an event: the object it's about, and for `*.updated` events the values its
/// changed fields had before.
public struct EventData: Codable, Sendable {
    /// The object the event is about, as raw JSON. `object(as:)` decodes it.
    public var object: JSONValue
    /// For `*.updated` events, the previous values of the fields that changed, as raw JSON.
    public var previousAttributes: JSONValue?

    public enum CodingKeys: String, CodingKey {
        case object
        case previousAttributes = "previous_attributes"
    }

    /// Decode the event's object as `type`, e.g. `PaymentIntent.self` for a
    /// `payment_intent.succeeded` event.
    public func object<T: Decodable>(as type: T.Type) throws -> T {
        try object.decode(as: type)
    }

    /// Decode the previous values as `type`. Only the changed fields are present, so this fails
    /// for a model with required fields: read `previousAttributes` directly
    /// (`previousAttributes?["email"]`) or decode into a type whose fields are all optional.
    public func previousAttributes<T: Decodable>(as type: T.Type) throws -> T? {
        try previousAttributes?.decode(as: type)
    }
}

/// The API request that caused an event, if any.
public struct EventRequest: Codable, Sendable {
    /// The request's ID, or nil when the event was automatic (e.g. a scheduled renewal).
    public var id: String?
    /// The idempotency key the request was sent with.
    public var idempotencyKey: String?

    public enum CodingKeys: String, CodingKey {
        case id
        case idempotencyKey = "idempotency_key"
    }
}

// MARK: - Signature Verification

extension StripeEvent {
    /// Verify a webhook signature and decode the event.
    /// - Parameters:
    ///   - payload: The raw request body bytes
    ///   - header: The Stripe-Signature header value
    ///   - secret: Your webhook endpoint secret (whsec_...)
    ///   - tolerance: Maximum age in seconds (default: 300)
    /// - Returns: The decoded and verified StripeEvent
    public static func verify(
        payload: Data,
        header: String,
        secret: String,
        tolerance: Double = 300
    ) throws -> StripeEvent {
        try verifySignature(payload: payload, header: header, secret: secret, tolerance: tolerance)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return try decoder.decode(StripeEvent.self, from: payload)
    }

    /// Verify a webhook signature without decoding the event.
    /// Throws if the header is malformed, no signature matches, or the timestamp is more
    /// than `tolerance` seconds from now.
    public static func verifySignature(
        payload: Data,
        header: String,
        secret: String,
        tolerance: Double = 300
    ) throws {
        // Parse header: t=timestamp,v1=sig1,v1=sig2,...
        let pairs = header.split(separator: ",").reduce(into: [String: [String]]()) { result, pair in
            let kv = pair.split(separator: "=", maxSplits: 1)
            guard kv.count == 2 else { return }
            result[String(kv[0]), default: []].append(String(kv[1]))
        }

        guard let timestamp = pairs["t"]?.first, let time = TimeInterval(timestamp),
              let signatures = pairs["v1"], !signatures.isEmpty
        else { throw StripeSignatureError.unableToParseHeader }

        // Stripe signs "{timestamp}.{payload}" with the payload's exact bytes
        var signedPayload = Data("\(timestamp).".utf8)
        signedPayload.append(payload)
        let signature = HMAC<SHA256>.authenticationCode(for: signedPayload, using: SymmetricKey(data: Data(secret.utf8)))
        // Lowercase hex, as ASCII bytes
        let hexDigits = Array("0123456789abcdef".utf8)
        let expected = signature.flatMap { [hexDigits[Int($0 >> 4)], hexDigits[Int($0 & 0x0F)]] }

        guard signatures.contains(where: { constantTimeEquals(Array($0.utf8), expected) }) else {
            throw StripeSignatureError.noMatchingSignatureFound
        }

        guard abs(Date().timeIntervalSince1970 - time) <= tolerance else {
            throw StripeSignatureError.timestampNotTolerated
        }
    }

    /// Whether `a` and `b` are equal, taking the same time wherever they differ, so the
    /// comparison doesn't reveal how much of a forged signature was right.
    private static func constantTimeEquals(_ a: [UInt8], _ b: [UInt8]) -> Bool {
        guard a.count == b.count else { return false }
        var difference: UInt8 = 0
        for index in a.indices {
            difference |= a[index] ^ b[index]
        }
        return difference == 0
    }
}
