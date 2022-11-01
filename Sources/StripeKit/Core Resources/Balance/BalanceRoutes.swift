//
//  BalanceRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import NIO
import NIOHTTP1

public protocol BalanceRoutes: StripeAPIRoute {
    /// Retrieves the current account balance, based on the authentication that was used to make the request. For a sample request, see [Accounting for negative balances](https://stripe.com/docs/connect/account-balances#accounting-for-negative-balances) .
    func retrieve() async throws -> Balance
}

public struct StripeBalanceRoutes: BalanceRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let balance = APIBase + APIVersion + "balance"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve() async throws -> Balance {
        try await apiHandler.send(method: .GET,
                                  path: balance,
                                  headers: headers)
    }
}
