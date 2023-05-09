//
//  CustomerBalanceTransactionRoutes.swift
//  
//
//  Created by Andrew Edwards on 11/29/19.
//

import NIO
import NIOHTTP1

public protocol CustomerBalanceTransactionRoutes: StripeAPIRoute {
    /// Creates an immutable transaction that updates the customer’s balance.
    /// - Parameters:
    ///  - amount: The integer amount in cents to apply to the customer’s balance. Pass a negative amount to credit the customer’s balance, and pass in a positive amount to debit the customer’s balance.
    ///  - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency. If the customer’s currency is set, this value must match it. If the customer’s currency is not set, it will be updated to this value.
    ///  - customer: The customer the transaction belongs to.
    ///  - description: An arbitrary string attached to the object. Often useful for displaying to users.
    ///  - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///  - expand: An array of properties to expand.
    func create(amount: Int,
                currency: Currency,
                customer: String,
                description: String?,
                metadata: [String: String]?,
                expand: [String]?) async throws -> CustomerBalanceTransaction
    
    /// Retrieves a specific transaction that updated the customer’s balance.
    /// - Parameters:
    ///  - customer: The customer the transaction belongs to.
    ///  - transaction: The transaction to retrieve.
    ///  - expand: An array of properties to expand.
    func retrieve(customer: String, transaction: String, expand: [String]?) async throws -> CustomerBalanceTransaction
    
    /// Most customer balance transaction fields are immutable, but you may update its `description` and `metadata`.
    /// - Parameters:
    ///  - customer: The customer the transaction belongs to.
    ///  - transaction: The transaction to update.
    ///  - description: An arbitrary string attached to the object. Often useful for displaying to users.
    ///  - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///  - expand: An array of properties to expand.
    func update(customer: String,
                transaction: String,
                description: String?,
                metadata: [String: String]?,
                expand: [String]?) async throws -> CustomerBalanceTransaction
    
    /// Returns a list of transactions that updated the customer’s balance.
    /// - Parameter customer: The customer to retrieve transactions for.
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/customer_balance_transactions/list)
    func listAll(customer: String, filter: [String: Any]?) async throws -> CustomerBalanceTransactionList
}

public struct StripeCustomerBalanceTransactionRoutes: CustomerBalanceTransactionRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let customerbalancetransactions = APIBase + APIVersion + "customers"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(amount: Int,
                       currency: Currency,
                       customer: String,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil) async throws -> CustomerBalanceTransaction {
        var body: [String: Any] = ["amount": amount,
                                   "currency": currency.rawValue]
        
        if let description {
            body["description"] = description
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(customerbalancetransactions)/\(customer)/balance_transactions", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(customer: String, transaction: String, expand: [String]? = nil) async throws -> CustomerBalanceTransaction {
        var queryParams = ""
        if let expand {
            queryParams += ["expand": expand].queryParameters
        }
        return try await apiHandler.send(method: .GET, path: "\(customerbalancetransactions)/\(customer)/balance_transactions/\(transaction)", query: queryParams, headers: headers)
    }
    
    public func update(customer: String,
                       transaction: String,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil) async throws -> CustomerBalanceTransaction {
        var body: [String: Any] = [:]
        
        if let description {
            body["description"] = description
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(customerbalancetransactions)/\(customer)/balance_transactions/\(transaction)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(customer: String, filter: [String: Any]? = nil) async throws -> CustomerBalanceTransactionList {
        var queryParams = ""
        if let filter {
            queryParams += filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(customerbalancetransactions)/\(customer)/balance_transactions", query: queryParams, headers: headers)
    }
}
