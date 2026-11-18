//
//  StripeClient+Scoping.swift
//  StripeKit
//
//  Hand-written infrastructure (not emitted by stripe-kit-codegen).
//

import AsyncHTTPClient
import StripeKitCore

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
            maxNetworkRetries: handler.maxNetworkRetries
        ))
    }

    /// A test client with a placeholder API key and no retries, so any route you don't replace
    /// fails at once rather than reaching Stripe. Suitable for `swift-dependencies` `testValue`.
    public static var test: StripeClient {
        .live(httpClient: .shared, apiKey: "sk_test_placeholder", maxNetworkRetries: 0)
    }
}
