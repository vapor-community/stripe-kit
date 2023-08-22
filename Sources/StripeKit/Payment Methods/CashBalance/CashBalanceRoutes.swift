//
//  CashBalanceRoutes.swift
//  
//
//  Created by Andrew Edwards on 5/1/23.
//

import NIO
import NIOHTTP1

public protocol CashBalanceRoutes: StripeAPIRoute {
    /// Retrieves a customer’s cash balance.
    /// - Parameter customer: Id of the customer.
    /// - Returns: The Cash Balance object for a given customer.
    func retrieve(customer: String) async throws -> CashBalance
    
    /// Retrieves a specific cash balance transaction, which updated the customer’s cash balance.
    /// - Parameter customer: Id of the customer.
    /// - Parameter transaction: Id of the transaction.
    /// - Returns: Returns a cash balance transaction object if a valid identifier was provided.
    func retrieveTransaction(customer: String, transaction: String) async throws -> CashBalanceTransaction
    
    /// Changes the settings on a customer’s cash balance.
    /// - Parameters:
    ///   - customer: Id of the customer
    ///   - settings: A hash of settings for this cash balance.
    /// - Returns: The customer’s cash balance, with the updated settings.
    func update(customer: String, settings: [String: Any]?) async throws -> CashBalance
    
    /// Returns a list of transactions that modified the customer’s cash balance.
    /// - Parameters:
    ///   - customer: Id of the customer.
    ///   - filter: A dictionary containing filters.
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` cash balance transactions, starting after item `starting_after`. Each entry in the array is a separate cash balance transaction object. If no more items are available, the resulting array will be empty. This request should never return an error.
    func listAll(customer: String, filter: [String: Any]?) async throws -> CashBalanceTransactionList
    
    /// Create an incoming testmode bank transfer
    /// - Parameters:
    ///   - customer: The id of the customer.
    ///   - amount: Amount to be used for this test cash balance transaction. A positive integer representing how much to fund in the smallest currency unit (e.g., 100 cents to fund $1.00 or 100 to fund ¥100, a zero-decimal currency).
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - reference: A description of the test funding. This simulates free-text references supplied by customers when making bank transfers to their cash balance. You can use this to test how Stripe’s reconciliation algorithm applies to different user inputs.
    /// - Returns: Returns a specific cash balance transaction, which funded the customer’s cash balance.
    func fundCashBalance(customer: String,
                         amount: Int,
                         currency: Currency,
                         reference: String?) async throws -> CashBalanceTransaction
}

public struct StripeCashBalanceRoutes: CashBalanceRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let cashbalance = APIBase + APIVersion + "customers"
    private let testhelper = APIBase + APIVersion + "test_helpers/customers"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(customer: String) async throws -> CashBalance {
        try await apiHandler.send(method: .GET, path: "\(cashbalance)/\(customer)/cash_balance", headers: headers)
    }
    
    
    public func retrieveTransaction(customer: String, transaction: String) async throws -> CashBalanceTransaction {
        try await apiHandler.send(method: .GET, path: "\(cashbalance)/\(customer)/cash_balance_transactions/\(transaction)", headers: headers)
    }
    
    public func update(customer: String, settings: [String: Any]? = nil) async throws -> CashBalance {
        var body: [String: Any] = [:]
        
        if let settings {
            settings.forEach { body["settings[\($0)]"] = $1 }
        }
        
        return try await apiHandler.send(method: .POST, path: "\(cashbalance)/\(customer)/cash_balance", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(customer: String, filter: [String: Any]? = nil) async throws -> CashBalanceTransactionList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(cashbalance)/\(customer)/cash_balance_transactions", query: queryParams, headers: headers)
    }
    
    public func fundCashBalance(customer: String,
                                amount: Int,
                                currency: Currency,
                                reference: String? = nil) async throws -> CashBalanceTransaction {
        var body: [String: Any] = ["amount": amount,
                                   "currency": currency.rawValue]
        
        if let reference {
            body["reference"] = reference
        }
        
        return try await apiHandler.send(method: .POST, path: "\(testhelper)/\(customer)/fund_cash_balance", headers: headers)
    }
}
