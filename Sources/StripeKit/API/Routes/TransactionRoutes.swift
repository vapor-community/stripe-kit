//
//  TransactionRoutes.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import NIO
import NIOHTTP1

public protocol TransactionRoutes {
    /// Retrieves an Issuing Transaction object.
    ///
    /// - Parameter transaction: The ID of the transaction to retrieve.
    /// - Returns: A `StripeTransaction`.
    /// - Throws: A `StripeError`.
    func retrieve(transaction: String) throws -> EventLoopFuture<StripeTransaction>
    
    /// Updates the specified Issuing Transaction object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    ///
    /// - Parameters:
    ///   - transaction: The identifier of the transaction to update.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    /// - Returns: A `StripeTransaction`.
    /// - Throws: A `StripeError`.
    func update(transaction: String, metadata: [String: String]?) throws -> EventLoopFuture<StripeTransaction>
    
    /// Returns a list of Issuing Transaction objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/issuing/transactions/list).
    /// - Returns: A `StripeTransactionList`.
    /// - Throws: A `StripeError`.
    func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeTransactionList>
    
    var headers: HTTPHeaders { get set }
}

extension TransactionRoutes {
    func retrieve(transaction: String) throws -> EventLoopFuture<StripeTransaction> {
        return try retrieve(transaction: transaction)
    }
    
    func update(transaction: String, metadata: [String: String]? = nil) throws -> EventLoopFuture<StripeTransaction> {
        return try update(transaction: transaction, metadata: metadata)
    }
    
    func listAll(filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeTransactionList> {
        return try listAll(filter: filter)
    }
}

public struct StripeTransactionRoutes: TransactionRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(transaction: String) throws -> EventLoopFuture<StripeTransaction> {
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.transactions(transaction).endpoint, headers: headers)
    }
    
    public func update(transaction: String, metadata: [String: String]?) throws -> EventLoopFuture<StripeTransaction> {
        var body: [String: Any] = [:]
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.transactions(transaction).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeTransactionList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.transaction.endpoint, query: queryParams, headers: headers)
    }
}
