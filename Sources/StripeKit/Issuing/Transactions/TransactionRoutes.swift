//
//  TransactionRoutes.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import NIO
import NIOHTTP1
import Baggage

public protocol TransactionRoutes {
    /// Retrieves an Issuing Transaction object.
    ///
    /// - Parameter transaction: The ID of the transaction to retrieve.
    /// - Parameter expand: An array of properties to expand.
    /// - Returns: A `StripeTransaction`.
    func retrieve(transaction: String, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeTransaction>
    
    /// Updates the specified Issuing Transaction object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    ///
    /// - Parameters:
    ///   - transaction: The identifier of the transaction to update.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeTransaction`.
    func update(transaction: String, metadata: [String: String]?, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeTransaction>
    
    /// Returns a list of Issuing Transaction objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/issuing/transactions/list).
    /// - Returns: A `StripeTransactionList`.
    func listAll(filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeTransactionList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension TransactionRoutes {
    func retrieve(transaction: String, expand: [String]? = nil, context: LoggingContext) -> EventLoopFuture<StripeTransaction> {
        return retrieve(transaction: transaction, expand: expand, context: context)
    }
    
    func update(transaction: String, metadata: [String: String]? = nil, expand: [String]? = nil, context: LoggingContext) -> EventLoopFuture<StripeTransaction> {
        return update(transaction: transaction, metadata: metadata, expand: expand, context: context)
    }
    
    func listAll(filter: [String: Any]? = nil, context: LoggingContext) -> EventLoopFuture<StripeTransactionList> {
        return listAll(filter: filter, context: context)
    }
}

public struct StripeTransactionRoutes: TransactionRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let issuingtransactions = APIBase + APIVersion + "issuing/transactions"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(transaction: String, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeTransaction> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        return apiHandler.send(method: .GET, path: "\(issuingtransactions)/\(transaction)", query: queryParams, headers: headers, context: context)
    }
    
    public func update(transaction: String, metadata: [String: String]?, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeTransaction> {
        var body: [String: Any] = [:]
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(issuingtransactions)/\(transaction)", body: .string(body.queryParameters), headers: headers, context: context)
    }
    
    public func listAll(filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeTransactionList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: issuingtransactions, query: queryParams, headers: headers, context: context)
    }
}
