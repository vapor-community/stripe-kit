//
//  BalanceTransactionRoutes.swift
//  
//
//  Created by Andrew Edwards on 11/22/19.
//

import NIO
import NIOHTTP1

public protocol BalanceTransactionRoutes {
    /// Retrieves the balance transaction with the given ID.
    ///
    /// - Parameter id: The ID of the desired balance transaction.
    func retrieve(id: String) async throws -> BalanceTransaction
    
    /// Returns a list of transactions that have contributed to the Stripe account balance (e.g., charges, transfers, and so forth). The transactions are returned in sorted order, with the most recent transactions appearing first.
    ///
    /// - Parameter filter: A [dictionary](https://stripe.com/docs/api/balance/balance_history) that will be used for the query parameters.
    func listAll(filter: [String: Any]?) async throws -> BalanceTransactionList
}

public struct StripeBalanceTransactionRoutes: BalanceTransactionRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let balanceTransaction = APIBase + APIVersion + "balance_transactions/"
    private let balanceTransactions = APIBase + APIVersion + "balance_transactions"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(id: String) async throws -> BalanceTransaction {
        try await apiHandler.send(method: .GET, path: balanceTransaction + id, headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) async throws -> BalanceTransactionList {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return try await apiHandler.send(method: .GET, path: balanceTransactions, query: queryParams, headers: headers)
    }
}
