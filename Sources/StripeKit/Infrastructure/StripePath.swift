//
//  StripePath.swift
//  StripeKit
//
//  Hand-written infrastructure (not emitted by stripe-kit-codegen).
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// A request path whose interpolated values are each escaped as one path segment.
///
/// ```swift
/// let path: StripePath = "/v1/products/\(productID)"  // "prod/a b" → /v1/products/prod%2Fa%20b
/// ```
///
/// The literal parts are used as written; every interpolated value has all but RFC 3986's
/// unreserved characters (letters, digits, `-._~`) percent-encoded. Some IDs are chosen by
/// you (products, prices, features) and may hold `/`, `?`, `#` or spaces, which would
/// otherwise change the path or start a query string. stripe-go and stripe-node escape path
/// parameters the same way. IDs that Stripe generates (`cus_…`) are unchanged.
///
/// `StripeAPIHandler` takes paths as this type, so a path parameter can't reach a request
/// unescaped.
public struct StripePath: ExpressibleByStringInterpolation, Sendable, Hashable, CustomStringConvertible {
    /// The escaped path, e.g. `/v1/products/prod%2Fa%20b`
    public let description: String

    public init(stringLiteral path: String) {
        description = path
    }

    public init(stringInterpolation: Interpolation) {
        description = stringInterpolation.path
    }

    /// A path that's already escaped, used exactly as given.
    public init(unescaped path: String) {
        description = path
    }

    public struct Interpolation: StringInterpolationProtocol {
        var path = ""

        public init(literalCapacity: Int, interpolationCount: Int) {
            path.reserveCapacity(literalCapacity + 16 * interpolationCount)
        }

        public mutating func appendLiteral(_ literal: String) {
            path += literal
        }

        /// Appends `value` escaped as one path segment.
        public mutating func appendInterpolation(_ value: String) {
            path += value.percentEncoded()
        }
    }
}
