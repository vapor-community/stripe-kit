//
//  BalanceRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import NIO

public protocol BalanceRoutes {
    /// Retrieves the current account balance, based on the authentication that was used to make the request. For a sample request, see [Accounting for negative balances](https://stripe.com/docs/connect/account-balances#accounting-for-negative-balances).
    ///
    /// - Returns: A `StripeBalance`.
    /// - Throws: A `StripeError`.
    func retrieve() throws -> EventLoopFuture<StripeBalance>
    
    /// Retrieves the balance transaction with the given ID.
    ///
    /// - Parameter id: The ID of the desired balance transaction, as found on any API object that affects the balance (e.g., a charge or transfer).
    /// - Returns: A `StripeBalanceTransaction`.
    /// - Throws: A `StripeError`.
    func retrieve(id: String) throws -> EventLoopFuture<StripeBalanceTransaction>
    
    /// Returns a list of transactions that have contributed to the Stripe account balance (e.g., charges, transfers, and so forth). The transactions are returned in sorted order, with the most recent transactions appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/balance/balance_history).
    /// - Returns: A `StripeBalanceTransactionList`.
    /// - Throws: A `StripeError`.
    func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeBalanceTransactionList>
}

extension BalanceRoutes {
    public func retrieve() throws -> EventLoopFuture<StripeBalance> {
        return try retrieve()
    }
    
    public func retrieve(id: String) throws -> EventLoopFuture<StripeBalanceTransaction> {
        return try retrieve(id: id)
    }
    
    public func listAll(filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeBalanceTransactionList> {
        return try listAll(filter: filter)
    }
}

public struct StripeBalanceRoutes: BalanceRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    public func retrieve() throws -> EventLoopFuture<StripeBalance> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.balance.endpoint)
    }
    
    public func retrieve(id: String) throws -> EventLoopFuture<StripeBalanceTransaction> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.balanceHistoryTransaction(id).endpoint)
    }
    
    public func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeBalanceTransactionList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return try request.send(method: .GET, path: StripeAPIEndpoint.balanceHistory.endpoint, query: queryParams)
    }
}
