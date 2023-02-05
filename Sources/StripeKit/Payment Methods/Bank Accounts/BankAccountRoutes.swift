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
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeBankAccount`.
    func create(customer: String,
                source: Any,
                metadata: [String: String]?,
                expand: [String]?) -> EventLoopFuture<StripeBankAccount>
    
    /// By default, you can see the 10 most recent sources stored on a Customer directly on the object, but you can also retrieve details about a specific bank account stored on the Stripe account.
    ///
    /// - Parameters:
    ///   - id: ID of bank account to retrieve.
    ///   - customer: The ID of the customer this source belongs to.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeBankAccount`.
    func retrieve(id: String, customer: String, expand: [String]?) -> EventLoopFuture<StripeBankAccount>
    
    /// Updates the `account_holder_name`, `account_holder_type`, and `metadata` of a bank account belonging to a customer. Other bank account details are not editable, by design.
    ///
    /// - Parameters:
    ///   - id: The ID of the bank account to be updated.
    ///   - customer: The ID of the customer this source belongs to.
    ///   - accountHolderName: The name of the person or business that owns the bank account.
    ///   - accountHolderType: The type of entity that holds the account. This can be either `individual` or `company`.
    ///   - metadata: A set of key-value pairs that you can attach to a card object. It can be useful for storing additional information about the bank account in a structured format.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeBankAccount`.
    func update(id: String,
                customer: String,
                accountHolderName: String?,
                accountHolderType: StripeBankAccountHolderType?,
                metadata: [String: String]?,
                expand: [String]?) -> EventLoopFuture<StripeBankAccount>
    
    /// A customer's bank account must first be verified before it can be charged. Stripe supports instant verification using Plaid for many of the most popular banks. If your customer's bank is not supported or you do not wish to integrate with Plaid, you must manually verify the customer's bank account using the API.
    ///
    /// - Parameters:
    ///   - id: The ID of the source to be verified.
    ///   - customer: The ID of the customer this source belongs to.
    ///   - amounts: Two positive integers, in cents, equal to the values of the microdeposits sent to the bank account.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeBankAccount`.
    func verify(id: String, customer: String, amounts: [Int]?, expand: [String]?) -> EventLoopFuture<StripeBankAccount>
    
    /// You can delete bank accounts from a Customer.
    ///
    /// - Parameters:
    ///   - id: The ID of the source to be deleted.
    ///   - customer: The ID of the customer this source belongs to.
    /// - Returns: A `StripeDeletedObject`.
    func delete(id: String, customer: String) -> EventLoopFuture<DeletedObject>
    
    /// You can see a list of the bank accounts belonging to a Customer. Note that the 10 most recent sources are always available by default on the Customer. If you need more than those 10, you can use this API method and the limit and starting_after parameters to page through additional bank accounts.
    ///
    /// - Parameters:
    ///   - customer: The ID of the customer whose bank accounts will be retrieved.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/customer_bank_accounts/list).
    /// - Returns: A `StripeBankAccountList`.
    func listAll(customer: String, filter: [String: Any]?) -> EventLoopFuture<StripeBankAccountList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension BankAccountRoutes {
    public func create(customer: String,
                       source: Any,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeBankAccount> {
        return create(customer: customer, source: source, metadata: metadata, expand: expand)
    }
    
    public func retrieve(id: String, customer: String, expand: [String]? = nil) -> EventLoopFuture<StripeBankAccount> {
        return retrieve(id: id, customer: customer, expand: expand)
    }
    
    public func update(id: String,
                       customer: String,
                       accountHolderName: String? = nil,
                       accountHolderType: StripeBankAccountHolderType? = nil,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeBankAccount> {
        return update(id: id,
                      customer: customer,
                      accountHolderName: accountHolderName,
                      accountHolderType: accountHolderType,
                      metadata: metadata,
                      expand: expand)
    }
    
    public func verify(id: String,
                       customer: String,
                       amounts: [Int]? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeBankAccount> {
        return verify(id: id, customer: customer, amounts: amounts, expand: expand)
    }
    
    public func delete(id: String, customer: String) -> EventLoopFuture<DeletedObject> {
        return delete(id: id, customer: customer)
    }
    
    public func listAll(customer: String, filter: [String: Any]? = nil) -> EventLoopFuture<StripeBankAccountList> {
        return listAll(customer: customer, filter: filter)
    }
}

public struct StripeBankAccountRoutes: BankAccountRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let bankaccounts = APIBase + APIVersion + "customers"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(customer: String, source: Any, metadata: [String: String]?, expand: [String]?) -> EventLoopFuture<StripeBankAccount> {
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
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(bankaccounts)/\(customer)/sources", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(id: String, customer: String, expand: [String]?) -> EventLoopFuture<StripeBankAccount> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        return apiHandler.send(method: .GET, path: "\(bankaccounts)/\(customer)/sources/\(id)", query: queryParams, headers: headers)
    }
    
    public func update(id: String,
                       customer: String,
                       accountHolderName: String?,
                       accountHolderType: StripeBankAccountHolderType?,
                       metadata: [String: String]?,
                       expand: [String]?) -> EventLoopFuture<StripeBankAccount> {
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
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(bankaccounts)/\(customer)/sources/\(id)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func verify(id: String, customer: String, amounts: [Int]?, expand: [String]?) -> EventLoopFuture<StripeBankAccount> {
        var body: [String: Any] = [:]
        
        if let amounts = amounts {
            body["amounts"] = amounts
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(bankaccounts)/\(customer)/sources/\(id)/verify", body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(id: String, customer: String) -> EventLoopFuture<DeletedObject> {
        return apiHandler.send(method: .DELETE, path: "\(bankaccounts)/\(customer)/sources/\(id)", headers: headers)
    }
    
    public func listAll(customer: String, filter: [String: Any]?) -> EventLoopFuture<StripeBankAccountList> {
        var queryParams = "object=bank_account"
        if let filter = filter {
            queryParams += "&" + filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(bankaccounts)/\(customer)/sources", query: queryParams, headers: headers)
    }
}
