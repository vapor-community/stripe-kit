//
//  StripeError.swift
//  StripeKit
//
//  Hand-written infrastructure (not emitted by stripe-kit-codegen).
//

import Foundation

/// An error response from the Stripe API. Routes throw it for any non-2xx response; network
/// and decoding failures are thrown as the underlying error.
public struct StripeError: Swift.Error, Codable, Sendable {
    public var error: StripeAPIError?
}

/// Detailed error information from the Stripe API.
public struct StripeAPIError: Codable, Sendable {
    /// The type of error returned.
    public var type: StripeErrorType?
    /// For card errors, the ID of the failed charge.
    public var charge: String?
    /// A short string indicating the error code reported.
    public var code: StripeErrorCode?
    /// A short string for the card issuer's decline reason.
    public var declineCode: StripeDeclineCode?
    /// A URL to more information about the error code.
    public var docUrl: String?
    /// A human-readable message providing more details.
    public var message: String?
    /// The parameter related to the error, if applicable.
    public var param: String?

    public enum CodingKeys: String, CodingKey {
        case type, charge, code, message, param
        case declineCode = "decline_code"
        case docUrl = "doc_url"
    }
}

/// The type of an API error (`api_error`, `card_error`, …). The spec's `api_errors.type`.
public typealias StripeErrorType = ApiErrorsType

/// An API error's code (`card_declined`, `resource_missing`, …). The spec's `api_errors.code`, so
/// it stays current with the spec, and a code Stripe added since still decodes (with its
/// `rawValue`) instead of failing the error response.
public typealias StripeErrorCode = ApiErrorsCode

/// A card issuer's reason for declining a payment (`insufficient_funds`, …). A string, since
/// the spec doesn't list the values.
public typealias StripeDeclineCode = String

/// Errors during webhook signature verification.
public enum StripeSignatureError: Swift.Error, Sendable {
    case unableToParseHeader
    case noMatchingSignatureFound
    case timestampNotTolerated
}
