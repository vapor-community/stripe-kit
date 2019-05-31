//
//  DisputeRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/12/17.
//
//

import NIO
import NIOHTTP1

public protocol DisputeRoutes {
    /// Retrieves the dispute with the given ID.
    ///
    /// - Parameter dispute: ID of dispute to retrieve.
    /// - Returns: A `StripeDispute`.
    /// - Throws: A `StripeError`.
    func retrieve(dispute: String) throws -> EventLoopFuture<StripeDispute>
    
    /// When you get a dispute, contacting your customer is always the best first step. If that doesn’t work, you can submit evidence to help us resolve the dispute in your favor. You can do this in your [dashboard](https://dashboard.stripe.com/disputes), but if you prefer, you can use the API to submit evidence programmatically. \n Depending on your dispute type, different evidence fields will give you a better chance of winning your dispute. To figure out which evidence fields to provide, see our [guide to dispute types](https://stripe.com/docs/disputes/categories).
    ///
    /// - Parameters:
    ///   - dispute: ID of the dispute to update.
    ///   - evidence: Evidence to upload, to respond to a dispute. Updating any field in the hash will submit all fields in the hash for review. The combined character count of all fields is limited to 150,000.
    ///   - metadata: A set of key-value pairs that you can attach to a dispute object. This can be useful for storing additional information about the dispute in a structured format.
    ///   - submit: Whether to immediately submit evidence to the bank. If `false`, evidence is staged on the dispute. Staged evidence is visible in the API and Dashboard, and can be submitted to the bank by making another request with this attribute set to `true` (the default).
    /// - Returns: A `StripeDispute`.
    /// - Throws: A `StripeError`.
    func update(dispute: String,
                evidence: [String: Any]?,
                metadata: [String: String]?,
                submit: Bool?) throws -> EventLoopFuture<StripeDispute>
    
    /// Closing the dispute for a charge indicates that you do not have any evidence to submit and are essentially dismissing the dispute, acknowledging it as lost. \n The status of the dispute will change from `needs_response` to `lost`. Closing a dispute is irreversible.
    ///
    /// - Parameter dispute: ID of the dispute to close.
    /// - Returns: A `StripeDispute`.
    /// - Throws: A `StripeError`.
    func close(dispute: String) throws -> EventLoopFuture<StripeDispute>
    
    /// Returns a list of your disputes.
    ///
    /// - Parameter filter: A dictionary that contains the filters. More info [here](https://stripe.com/docs/api/disputes/list).
    /// - Returns: A `StripeDisputeList`.
    /// - Throws: A `StripeError`.
    func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeDisputeList>
    
    mutating func addHeaders(_ : HTTPHeaders)
}

extension DisputeRoutes {
    public func retrieve(dispute: String) throws -> EventLoopFuture<StripeDispute> {
        return try retrieve(dispute: dispute)
    }
    
    public func update(dispute: String,
                       evidence: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       submit: Bool? = nil) throws -> EventLoopFuture<StripeDispute> {
        return try update(dispute: dispute, evidence: evidence, metadata: metadata, submit: submit)
    }
    
    public func close(dispute: String) throws -> EventLoopFuture<StripeDispute> {
        return try close(dispute: dispute)
    }
    
    public func listAll(filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeDisputeList> {
        return try listAll(filter: filter)
    }
}

public struct StripeDisputeRoutes: DisputeRoutes {
    private let apiHandler: StripeAPIHandler
    private var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public mutating func addHeaders(_ _headers: HTTPHeaders) {
        _headers.forEach { self.headers.replaceOrAdd(name: $0.name, value: $0.value) }
    }
    
    public func retrieve(dispute: String) throws -> EventLoopFuture<StripeDispute> {
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.disputes(dispute).endpoint, headers: headers)
    }
    
    public func update(dispute: String, evidence: [String: Any]?, metadata: [String: String]?, submit: Bool?) throws -> EventLoopFuture<StripeDispute> {
        var body: [String: Any] = [:]
        
        if let evidence = evidence {
            evidence.forEach { body["evidence[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let submit = submit {
            body["submit"] = submit
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.disputes(dispute).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func close(dispute: String) throws -> EventLoopFuture<StripeDispute> {
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.closeDispute(dispute).endpoint, headers: headers)
    }
    
    public func listAll(filter: [String : Any]?) throws -> EventLoopFuture<StripeDisputeList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.dispute.endpoint, query: queryParams, headers: headers)
    }
}
