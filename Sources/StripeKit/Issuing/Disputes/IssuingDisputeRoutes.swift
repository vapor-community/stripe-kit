//
//  IssuingDisputeRoutes.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import NIO
import NIOHTTP1
import Baggage

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
    func create(disputedTransaction: String,
                reason: StripeIssuingDisputeReason,
                amount: Int?,
                evidence: [String: Any]?,
                metadata: [String: String]?,
                context: LoggingContext) -> EventLoopFuture<StripeIssuingDispute>
    
    /// Retrieves an Issuing Dispute object.
    ///
    /// - Parameter dispute: The ID of the dispute to retrieve.
    /// - Returns: A `StripeIssuingDispute`.
    func retrieve(dispute: String, context: LoggingContext) -> EventLoopFuture<StripeIssuingDispute>
    
    /// Updates the specified Issuing Dispute object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    ///
    /// - Parameters:
    ///   - dispute: The ID of the dispute to update.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    /// - Returns: A `StripeIssuingDispute`.
    func update(dispute: String, metadata: [String: String]?, context: LoggingContext) -> EventLoopFuture<StripeIssuingDispute>
    
    /// Returns a list of Issuing Dispute objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/issuing/disputes/list).
    /// - Returns: A `StripeIssuingDisputeList`.
    func listAll(filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeIssuingDisputeList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension IssuingDisputeRoutes {
    func create(disputedTransaction: String,
                reason: StripeIssuingDisputeReason,
                amount: Int? = nil,
                evidence: [String: Any]? = nil,
                metadata: [String: String]? = nil,
                context: LoggingContext) -> EventLoopFuture<StripeIssuingDispute> {
        return create(disputedTransaction: disputedTransaction,
                          reason: reason,
                          amount: amount,
                          evidence: evidence,
                          metadata: metadata)
    }
    
    func retrieve(dispute: String, context: LoggingContext) -> EventLoopFuture<StripeIssuingDispute> {
        return retrieve(dispute: dispute)
    }
    
    func update(dispute: String, metadata: [String: String]? = nil, context: LoggingContext) -> EventLoopFuture<StripeIssuingDispute> {
        return update(dispute: dispute, metadata: metadata)
    }
    
    func listAll(filter: [String: Any]? = nil, context: LoggingContext) -> EventLoopFuture<StripeIssuingDisputeList> {
        return listAll(filter: filter)
    }
}

public struct StripeIssuingDisputeRoutes: IssuingDisputeRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let issuingdisputes = APIBase + APIVersion + "issuing/disputes"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(disputedTransaction: String,
                       reason: StripeIssuingDisputeReason,
                       amount: Int?,
                       evidence: [String: Any]?,
                       metadata: [String: String]?,
                       context: LoggingContext) -> EventLoopFuture<StripeIssuingDispute> {
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
        
        return apiHandler.send(method: .POST, path: issuingdisputes, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(dispute: String, context: LoggingContext) -> EventLoopFuture<StripeIssuingDispute> {
        return apiHandler.send(method: .GET, path: "\(issuingdisputes)/\(dispute)", headers: headers)
    }
    
    public func update(dispute: String, metadata: [String: String]?, context: LoggingContext) -> EventLoopFuture<StripeIssuingDispute> {
        var body: [String: Any] = [:]
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: "\(issuingdisputes)/\(dispute)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String : Any]? = nil, context: LoggingContext) -> EventLoopFuture<StripeIssuingDisputeList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: issuingdisputes, query: queryParams, headers: headers)
    }
}
