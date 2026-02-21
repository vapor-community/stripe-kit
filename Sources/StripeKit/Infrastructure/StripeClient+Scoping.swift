//
//  StripeClient+Scoping.swift
//  StripeKit
//
//  Hand-written convenience extensions for StripeClient.
//  These don't depend on the spec and are never regenerated.
//

import Foundation
import AsyncHTTPClient

extension StripeClient {
    /// Returns a scoped client that sends all requests on behalf of a connected account.
    /// Uses the `Stripe-Account` header per Stripe Connect docs.
    ///
    /// ```swift
    /// let payout = try await stripe.onBehalfOf("acct_xxx").payouts.create(params)
    /// ```
    public func onBehalfOf(_ accountId: String) -> StripeClient {
        return .live(
            httpClient: handler.httpClient,
            apiKey: handler.apiKey,
            stripeAccount: accountId
        )
    }

    /// Returns a scoped client that sends all requests with the given idempotency key.
    /// Stripe guarantees that requests with the same key produce the same result.
    ///
    /// ```swift
    /// let customer = try await stripe.idempotent("unique-key").customers.create(params)
    /// ```
    public func idempotent(_ key: String) -> StripeClient {
        return .live(
            httpClient: handler.httpClient,
            apiKey: handler.apiKey,
            stripeAccount: handler.stripeAccount,
            idempotencyKey: key
        )
    }
}
