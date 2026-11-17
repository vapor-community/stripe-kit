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
        .live(handler: StripeAPIHandler(httpClient: handler.httpClient, apiKey: handler.apiKey, stripeAccount: accountId))
    }

    /// A test client with a placeholder API key.
    /// Suitable for `swift-dependencies` `testValue` — actual API calls will fail.
    public static var test: StripeClient {
        .live(httpClient: .shared, apiKey: "sk_test_placeholder")
    }
}
