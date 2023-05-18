//
//  TransactionRoutes.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import NIO
import NIOHTTP1

public protocol TransactionRoutes: StripeAPIRoute {
    /// Retrieves an Issuing Transaction object.
    ///
    /// - Parameter transaction: The ID of the transaction to retrieve.
    /// - Parameter expand: An array of properties to expand.
    /// - Returns: Returns an Issuing Transaction object if a valid identifier was provided.
    func retrieve(transaction: String, expand: [String]?) async throws -> Transaction
    
    /// Updates the specified Issuing Transaction object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    ///
    /// - Parameters:
    ///   - transaction: The identifier of the transaction to update.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns an updated Issuing Transaction object if a valid identifier was provided.
    func update(transaction: String, metadata: [String: String]?, expand: [String]?) async throws -> Transaction
    
    /// Returns a list of Issuing Transaction objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/issuing/transactions/list)
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` transactions, starting after transaction `starting_after`. Each entry in the array is a separate Issuing `Transaction` object. If no more transactions are available, the resulting array will be empty.
    func listAll(filter: [String: Any]?) async throws -> TransactionList
}


public struct StripeTransactionRoutes: TransactionRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let issuingtransactions = APIBase + APIVersion + "issuing/transactions"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(transaction: String, expand: [String]? = nil) async throws -> Transaction {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        return try await apiHandler.send(method: .GET, path: "\(issuingtransactions)/\(transaction)", query: queryParams, headers: headers)
    }
    
    public func update(transaction: String,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil) async throws -> Transaction {
        var body: [String: Any] = [:]
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(issuingtransactions)/\(transaction)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> TransactionList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: issuingtransactions, query: queryParams, headers: headers)
    }
}
