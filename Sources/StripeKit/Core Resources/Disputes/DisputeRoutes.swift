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
    /// - Parameters:
    ///   - dispute: ID of dispute to retrieve.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeDispute`.
    func retrieve(dispute: String, expand: [String]?) -> EventLoopFuture<StripeDispute>
    
    /// When you get a dispute, contacting your customer is always the best first step. If that doesn’t work, you can submit evidence to help us resolve the dispute in your favor. You can do this in your [dashboard](https://dashboard.stripe.com/disputes), but if you prefer, you can use the API to submit evidence programmatically. \n Depending on your dispute type, different evidence fields will give you a better chance of winning your dispute. To figure out which evidence fields to provide, see our [guide to dispute types](https://stripe.com/docs/disputes/categories).
    ///
    /// - Parameters:
    ///   - dispute: ID of the dispute to update.
    ///   - evidence: Evidence to upload, to respond to a dispute. Updating any field in the hash will submit all fields in the hash for review. The combined character count of all fields is limited to 150,000.
    ///   - metadata: A set of key-value pairs that you can attach to a dispute object. This can be useful for storing additional information about the dispute in a structured format.
    ///   - submit: Whether to immediately submit evidence to the bank. If `false`, evidence is staged on the dispute. Staged evidence is visible in the API and Dashboard, and can be submitted to the bank by making another request with this attribute set to `true` (the default).
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeDispute`.
    func update(dispute: String,
                evidence: [String: Any]?,
                metadata: [String: String]?,
                submit: Bool?,
                expand: [String]?) -> EventLoopFuture<StripeDispute>
    
    /// Closing the dispute for a charge indicates that you do not have any evidence to submit and are essentially dismissing the dispute, acknowledging it as lost. \n The status of the dispute will change from `needs_response` to `lost`. Closing a dispute is irreversible.
    ///
    /// - Parameters:
    ///   - dispute: ID of the dispute to close.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeDispute`.
    func close(dispute: String, expand: [String]?) -> EventLoopFuture<StripeDispute>
    
    /// Returns a list of your disputes.
    ///
    /// - Parameter filter: A dictionary that contains the filters. More info [here](https://stripe.com/docs/api/disputes/list).
    /// - Returns: A `StripeDisputeList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeDisputeList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension DisputeRoutes {
    public func retrieve(dispute: String, expand: [String]? = nil) -> EventLoopFuture<StripeDispute> {
        return retrieve(dispute: dispute, expand: expand)
    }
    
    public func update(dispute: String,
                       evidence: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       submit: Bool? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeDispute> {
        return update(dispute: dispute,
                      evidence: evidence,
                      metadata: metadata,
                      submit: submit,
                      expand: expand)
    }
    
    public func close(dispute: String, expand: [String]? = nil) -> EventLoopFuture<StripeDispute> {
        return close(dispute: dispute, expand: expand)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeDisputeList> {
        return listAll(filter: filter)
    }
}

public struct StripeDisputeRoutes: DisputeRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let disputes = APIBase + APIVersion + "disputes"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(dispute: String, expand: [String]?) -> EventLoopFuture<StripeDispute> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(disputes)/\(dispute)", query: queryParams, headers: headers)
    }
    
    public func update(dispute: String,
                       evidence: [String: Any]?,
                       metadata: [String: String]?,
                       submit: Bool?,
                       expand: [String]?) -> EventLoopFuture<StripeDispute> {
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
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(disputes)/\(dispute)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func close(dispute: String, expand: [String]?) -> EventLoopFuture<StripeDispute> {
        var body: [String: Any] = [:]
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(disputes)/\(dispute)/close", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String : Any]?) -> EventLoopFuture<StripeDisputeList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: disputes, query: queryParams, headers: headers)
    }
}
