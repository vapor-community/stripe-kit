//
//  IssuingDisputeRoutes.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import NIO
import NIOHTTP1

public protocol IssuingDisputeRoutes {
    /// Creates an Issuing Dispute object.
    ///
    /// - Parameters:
    ///   - disputedTransaction: The ID of the issuing transaction to create a dispute for.
    ///   - reason: The reason for the dispute. One of `other` or `fraudulent`.
    ///   - amount: Amount to dispute, defaults to full value, given in the currency the transaction was made in.
    ///   - evidence: A hash containing all the evidence related to the dispute. This should have a single key, equal to the provided reason, mapping to an appropriate evidence object.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    /// - Returns: A `StripeIssuingDispute`.
    /// - Throws: A `StripeError`.
    func create(disputedTransaction: String,
                reason: StripeIssuingDisputeReason,
                amount: Int?,
                evidence: [String: Any]?,
                metadata: [String: String]?) throws -> EventLoopFuture<StripeIssuingDispute>
    
    /// Retrieves an Issuing Dispute object.
    ///
    /// - Parameter dispute: The ID of the dispute to retrieve.
    /// - Returns: A `StripeIssuingDispute`.
    /// - Throws: A `StripeError`.
    func retrieve(dispute: String) throws -> EventLoopFuture<StripeIssuingDispute>
    
    /// Updates the specified Issuing Dispute object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    ///
    /// - Parameters:
    ///   - dispute: The ID of the dispute to update.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    /// - Returns: A `StripeIssuingDispute`.
    /// - Throws: A `StripeError`.
    func update(dispute: String, metadata: [String: String]?) throws -> EventLoopFuture<StripeIssuingDispute>
    
    /// Returns a list of Issuing Dispute objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/issuing/disputes/list).
    /// - Returns: A `StripeIssuingDisputeList`.
    /// - Throws: A `StripeError`.
    func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeIssuingDisputeList>
    
    var headers: HTTPHeaders { get set }
}

extension IssuingDisputeRoutes {
    func create(disputedTransaction: String,
                reason: StripeIssuingDisputeReason,
                amount: Int? = nil,
                evidence: [String: Any]? = nil,
                metadata: [String: String]? = nil) throws -> EventLoopFuture<StripeIssuingDispute> {
        return try create(disputedTransaction: disputedTransaction,
                          reason: reason,
                          amount: amount,
                          evidence: evidence,
                          metadata: metadata)
    }
    
    func retrieve(dispute: String) throws -> EventLoopFuture<StripeIssuingDispute> {
        return try retrieve(dispute: dispute)
    }
    
    func update(dispute: String, metadata: [String: String]? = nil) throws -> EventLoopFuture<StripeIssuingDispute> {
        return try update(dispute: dispute, metadata: metadata)
    }
    
    func listAll(filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeIssuingDisputeList> {
        return try listAll(filter: filter)
    }
}

public struct StripeIssuingDisputeRoutes: IssuingDisputeRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(disputedTransaction: String,
                       reason: StripeIssuingDisputeReason,
                       amount: Int?,
                       evidence: [String: Any]?,
                       metadata: [String: String]?) throws -> EventLoopFuture<StripeIssuingDispute> {
        var body: [String: Any] = ["disputed_transaction": disputedTransaction,
                                   "reason": reason.rawValue]
        
        if let amount = amount {
            body["amount"] = amount
        }
        
        if let evidence = evidence {
            evidence.forEach { body["evidence[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.issuingDispute.endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(dispute: String) throws -> EventLoopFuture<StripeIssuingDispute> {
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.issuingDisputes(dispute).endpoint, headers: headers)
    }
    
    public func update(dispute: String, metadata: [String: String]?) throws -> EventLoopFuture<StripeIssuingDispute> {
        var body: [String: Any] = [:]
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.issuingDisputes(dispute).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String : Any]? = nil) throws -> EventLoopFuture<StripeIssuingDisputeList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.issuingDispute.endpoint, query: queryParams, headers: headers)
    }
}
