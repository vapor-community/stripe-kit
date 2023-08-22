//
//  DisputeRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/12/17.
//
//

import NIO
import NIOHTTP1

public protocol DisputeRoutes: StripeAPIRoute {
    /// Retrieves the dispute with the given ID.
    ///
    /// - Parameters:
    ///   - dispute: ID of dispute to retrieve.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns a dispute if a valid dispute ID was provided. Returns an error otherwise.
    func retrieve(dispute: String, expand: [String]?) async throws -> Dispute
    
    /// When you get a dispute, contacting your customer is always the best first step. If that doesn’t work, you can submit evidence to help us resolve the dispute in your favor. You can do this in your [dashboard](https://dashboard.stripe.com/disputes), but if you prefer, you can use the API to submit evidence programmatically. \n Depending on your dispute type, different evidence fields will give you a better chance of winning your dispute. To figure out which evidence fields to provide, see our [guide to dispute types](https://stripe.com/docs/disputes/categories).
    ///
    /// - Parameters:
    ///   - dispute: ID of the dispute to update.
    ///   - evidence: Evidence to upload, to respond to a dispute. Updating any field in the hash will submit all fields in the hash for review. The combined character count of all fields is limited to 150,000.
    ///   - metadata: A set of key-value pairs that you can attach to a dispute object. This can be useful for storing additional information about the dispute in a structured format.
    ///   - submit: Whether to immediately submit evidence to the bank. If `false`, evidence is staged on the dispute. Staged evidence is visible in the API and Dashboard, and can be submitted to the bank by making another request with this attribute set to `true` (the default).
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns the dispute object.
    func update(dispute: String,
                evidence: [String: Any]?,
                metadata: [String: String]?,
                submit: Bool?,
                expand: [String]?) async throws -> Dispute
    
    /// Closing the dispute for a charge indicates that you do not have any evidence to submit and are essentially dismissing the dispute, acknowledging it as lost.
    ///
    /// The status of the dispute will change from `needs_response` to `lost`. _Closing a dispute is irreversible._
    ///
    /// - Parameters:
    ///   - dispute: ID of the dispute to close.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns the dispute object.
    func close(dispute: String, expand: [String]?) async throws -> Dispute
    
    /// Returns a list of your disputes.
    ///
    /// - Parameter filter: A [dictionary](https://stripe.com/docs/api/disputes/list) that contains the filters.
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` disputes, starting after dispute `starting_after`. Each entry in the array is a separate dispute object. If no more disputes are available, the resulting array will be empty. This request should never return an error.
    func listAll(filter: [String: Any]?) async throws -> DisputeList
}

public struct StripeDisputeRoutes: DisputeRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let disputes = APIBase + APIVersion + "disputes"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(dispute: String, expand: [String]?) async throws -> Dispute {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(disputes)/\(dispute)", query: queryParams, headers: headers)
    }
    
    public func update(dispute: String,
                       evidence: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       submit: Bool? = nil,
                       expand: [String]? = nil) async throws -> Dispute {
        var body: [String: Any] = [:]
        
        if let evidence {
            evidence.forEach { body["evidence[\($0)]"] = $1 }
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let submit {
            body["submit"] = submit
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(disputes)/\(dispute)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func close(dispute: String, expand: [String]?) async throws -> Dispute {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(disputes)/\(dispute)/close", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String : Any]?) async throws -> DisputeList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: disputes, query: queryParams, headers: headers)
    }
}
