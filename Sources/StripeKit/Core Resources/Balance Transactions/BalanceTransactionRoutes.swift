//
//  BalanceTransactionRoutes.swift
//  
//
//  Created by Andrew Edwards on 11/22/19.
//

import NIO
import NIOHTTP1
import Baggage

public protocol BalanceTransactionRoutes {
    /// Retrieves the balance transaction with the given ID.
    ///
    /// - Parameter id: The ID of the desired balance transaction, as found on any API object that affects the balance (e.g., a charge or transfer).
    /// - Returns: A `StripeBalanceTransaction`.
    func retrieve(id: String, context: LoggingContext) -> EventLoopFuture<StripeBalanceTransaction>
    
    /// Returns a list of transactions that have contributed to the Stripe account balance (e.g., charges, transfers, and so forth). The transactions are returned in sorted order, with the most recent transactions appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/balance/balance_history).
    /// - Returns: A `StripeBalanceTransactionList`.
    func listAll(filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeBalanceTransactionList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension BalanceTransactionRoutes {
    public func retrieve(id: String, context: LoggingContext) -> EventLoopFuture<StripeBalanceTransaction> {
        return retrieve(id: id)
    }
    
    public func listAll(filter: [String: Any]? = nil, context: LoggingContext) -> EventLoopFuture<StripeBalanceTransactionList> {
        return listAll(filter: filter)
    }
}

public struct StripeBalanceTransactionRoutes: BalanceTransactionRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let balanceTransaction = APIBase + APIVersion + "balance_transactions/"
    private let balanceTransactions = APIBase + APIVersion + "balance_transactions"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(id: String, context: LoggingContext) -> EventLoopFuture<StripeBalanceTransaction> {
        return apiHandler.send(method: .GET, path: balanceTransaction + id, headers: headers)
    }
    
    public func listAll(filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeBalanceTransactionList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return apiHandler.send(method: .GET, path: balanceTransactions, query: queryParams, headers: headers)
    }
}
