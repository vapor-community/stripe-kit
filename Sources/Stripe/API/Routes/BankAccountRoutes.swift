//
//  BankAccountRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/2/19.
//

import NIO
import NIOHTTP1

public protocol BankAccountRoutes {
    /// When you create a new bank account, you must specify a `Customer` object on which to create it.
    ///
    /// - Parameters:
    ///   - customer: The ID of the customer to attach this source to.
    ///   - source: Either a token, like the ones returned by Stripe.js, or a dictionary containing a user’s bank account details (with the options shown below).
    ///   - metadata: A set of key-value pairs that you can attach to a card object. It can be useful for storing additional information about the bank account in a structured format.
    /// - Returns: A `StripeBankAccount`.
    /// - Throws: A `StripeError`.
    func create(customer: String, source: Any, metadata: [String: String]?) throws -> EventLoopFuture<StripeBankAccount>
    
    /// By default, you can see the 10 most recent sources stored on a Customer directly on the object, but you can also retrieve details about a specific bank account stored on the Stripe account.
    ///
    /// - Parameters:
    ///   - id: ID of bank account to retrieve.
    ///   - customer: The ID of the customer this source belongs to.
    /// - Returns: A `StripeBankAccount`.
    /// - Throws: A `StripeError`.
    func retrieve(id: String, customer: String) throws -> EventLoopFuture<StripeBankAccount>
    
    /// Updates the `account_holder_name`, `account_holder_type`, and `metadata` of a bank account belonging to a customer. Other bank account details are not editable, by design.
    ///
    /// - Parameters:
    ///   - id: The ID of the bank account to be updated.
    ///   - customer: The ID of the customer this source belongs to.
    ///   - accountHolderName: The name of the person or business that owns the bank account.
    ///   - accountHolderType: The type of entity that holds the account. This can be either `individual` or `company`.
    ///   - metadata: A set of key-value pairs that you can attach to a card object. It can be useful for storing additional information about the bank account in a structured format.
    /// - Returns: A `StripeBankAccount`.
    /// - Throws: A `StripeError`.
    func update(id: String,
                customer: String,
                accountHolderName: String?,
                accountHolderType: StripeBankAccountHolderType?,
                metadata: [String: String]?) throws -> EventLoopFuture<StripeBankAccount>
    
    /// A customer's bank account must first be verified before it can be charged. Stripe supports instant verification using Plaid for many of the most popular banks. If your customer's bank is not supported or you do not wish to integrate with Plaid, you must manually verify the customer's bank account using the API.
    ///
    /// - Parameters:
    ///   - id: The ID of the source to be verified.
    ///   - customer: The ID of the customer this source belongs to.
    ///   - amounts: Two positive integers, in cents, equal to the values of the microdeposits sent to the bank account.
    /// - Returns: A `StripeBankAccount`.
    /// - Throws: A `StripeError`.
    func verify(id: String, customer: String, amounts: [Int]?) throws -> EventLoopFuture<StripeBankAccount>
    
    /// You can delete bank accounts from a Customer.
    ///
    /// - Parameters:
    ///   - id: The ID of the source to be deleted.
    ///   - customer: The ID of the customer this source belongs to.
    /// - Returns: A `StripeDeletedObject`.
    /// - Throws: A `StripeError`.
    func delete(id: String, customer: String) throws -> EventLoopFuture<StripeDeletedObject>
    
    /// You can see a list of the bank accounts belonging to a Customer. Note that the 10 most recent sources are always available by default on the Customer. If you need more than those 10, you can use this API method and the limit and starting_after parameters to page through additional bank accounts.
    ///
    /// - Parameters:
    ///   - customer: The ID of the customer whose bank accounts will be retrieved.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/customer_bank_accounts/list).
    /// - Returns: A `StripeBankAccountList`.
    /// - Throws: A `StripeError`.
    func listAll(customer: String, filter: [String: Any]?) throws -> EventLoopFuture<StripeBankAccountList>
    
    mutating func addHeaders(_ : HTTPHeaders)
}

extension BankAccountRoutes {
    public func create(customer: String, source: Any, metadata: [String: String]? = nil) throws -> EventLoopFuture<StripeBankAccount> {
        return try create(customer: customer, source: source, metadata: metadata)
    }
    
    public func retrieve(id: String, customer: String) throws -> EventLoopFuture<StripeBankAccount> {
        return try retrieve(id: id, customer: customer)
    }
    
    public func update(id: String,
                       customer: String,
                       accountHolderName: String? = nil,
                       accountHolderType: StripeBankAccountHolderType? = nil,
                       metadata: [String: String]? = nil) throws -> EventLoopFuture<StripeBankAccount> {
        return try update(id: id,
                          customer: customer,
                          accountHolderName: accountHolderName,
                          accountHolderType: accountHolderType,
                          metadata: metadata)
    }
    
    public func verify(id: String, customer: String, amounts: [Int]? = nil) throws -> EventLoopFuture<StripeBankAccount> {
        return try verify(id: id, customer: customer, amounts: amounts)
    }
    
    public func delete(id: String, customer: String) throws -> EventLoopFuture<StripeDeletedObject> {
        return try delete(id: id, customer: customer)
    }
    
    public func listAll(customer: String, filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeBankAccountList> {
        return try listAll(customer: customer, filter: filter)
    }
}

public struct StripeBankAccountRoutes: BankAccountRoutes {
    private let apiHandler: StripeAPIHandler
    private var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public mutating func addHeaders(_ _headers: HTTPHeaders) {
        _headers.forEach { self.headers.replaceOrAdd(name: $0.name, value: $0.value) }
    }
    
    public func create(customer: String, source: Any, metadata: [String: String]?) throws -> EventLoopFuture<StripeBankAccount> {
        var body: [String: Any] = [:]
        
        if let source = source as? String {
            body["source"] = source
        }
        
        if let source = source as? [String: Any] {
            source.forEach { body["source[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.bankAccount(customer).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(id: String, customer: String) throws -> EventLoopFuture<StripeBankAccount> {
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.bankAccounts(customer, id).endpoint, headers: headers)
    }
    
    public func update(id: String,
                       customer: String,
                       accountHolderName: String?,
                       accountHolderType: StripeBankAccountHolderType?,
                       metadata: [String: String]?) throws -> EventLoopFuture<StripeBankAccount> {
        var body: [String: Any] = [:]
        
        if let accountHolderName = accountHolderName {
            body["account_holder_name"] = accountHolderName
        }
        
        if let accountHolderType = accountHolderType {
            body["account_holder_type"] = accountHolderType.rawValue
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.bankAccounts(customer, id).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func verify(id: String, customer: String, amounts: [Int]?) throws -> EventLoopFuture<StripeBankAccount> {
        var body: [String: Any] = [:]
        
        if let amounts = amounts {
            body["amounts"] = amounts
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.bankAccountVerify(customer, id).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(id: String, customer: String) throws -> EventLoopFuture<StripeDeletedObject> {
        return try apiHandler.send(method: .DELETE, path: StripeAPIEndpoint.bankAccounts(customer, id).endpoint, headers: headers)
    }
    
    public func listAll(customer: String, filter: [String: Any]?) throws -> EventLoopFuture<StripeBankAccountList> {
        var queryParams = "object=bank_account"
        if let filter = filter {
            queryParams = "&" + filter.queryParameters
        }
        
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.bankAccount(customer).endpoint, query: queryParams, headers: headers)
    }
}
