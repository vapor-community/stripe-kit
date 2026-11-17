//
//  RequestOptions.swift
//  StripeKit
//
//  Hand-written infrastructure (not emitted by stripe-kit-codegen).
//

import Foundation

/// Options for a single request, like the request options Stripe's other SDKs take:
///
/// ```swift
/// let customer = try await stripe.customers.create(params, options: .init(idempotencyKey: key))
/// let payout = try await stripe.payouts.create(params, options: .init(stripeAccount: "acct_123"))
/// ```
public struct RequestOptions: Sendable, Hashable {
    /// Make the request as this connected account (the `Stripe-Account` header). Overrides a
    /// client scoped with `onBehalfOf(_:)`.
    public var stripeAccount: String?

    /// A unique key for this request (the `Idempotency-Key` header), so retrying it after a
    /// network error can't perform it twice: Stripe returns the first result instead. Use a
    /// new key for every distinct request, e.g. a UUID.
    public var idempotencyKey: String?

    public init(stripeAccount: String? = nil, idempotencyKey: String? = nil) {
        self.stripeAccount = stripeAccount
        self.idempotencyKey = idempotencyKey
    }
}
