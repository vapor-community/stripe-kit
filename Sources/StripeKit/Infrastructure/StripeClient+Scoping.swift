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
    /// Returns a scoped client that makes every request as the given connected account, by
    /// sending the `Stripe-Account` header (what Stripe's SDKs call `stripeAccount`).
    ///
    /// Not to be confused with the `on_behalf_of` param some endpoints take (`onBehalfOf` on
    /// their params structs), which keeps the request on your platform account but settles
    /// funds for the connected account.
    ///
    /// ```swift
    /// let payout = try await stripe.onBehalfOf("acct_xxx").payouts.create(params)
    /// ```
    ///
    /// For a single request, pass `options: RequestOptions(stripeAccount:)` instead.
    public func onBehalfOf(_ accountId: String) -> StripeClient {
        .live(handler: StripeAPIHandler(
            httpClient: handler.httpClient,
            apiKey: handler.apiKey,
            stripeAccount: accountId,
            idempotencyKey: handler.idempotencyKey
        ))
    }

    /// Returns a scoped client that sends every request with the given idempotency key.
    ///
    /// Every request must have its own key, so a client scoped this way is only safe for a
    /// single request. Pass the key with that request instead:
    ///
    /// ```swift
    /// let customer = try await stripe.customers.create(params, options: .init(idempotencyKey: key))
    /// ```
    @available(*, deprecated, message: "Pass the key per request: options: RequestOptions(idempotencyKey:)")
    public func idempotent(_ key: String) -> StripeClient {
        .live(handler: StripeAPIHandler(
            httpClient: handler.httpClient,
            apiKey: handler.apiKey,
            stripeAccount: handler.stripeAccount,
            idempotencyKey: key
        ))
    }

    /// A test client with a placeholder API key.
    /// Suitable for `swift-dependencies` `testValue` — actual API calls will fail.
    public static var test: StripeClient {
        .live(httpClient: .shared, apiKey: "sk_test_placeholder")
    }
}
