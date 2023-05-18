//
//  IssuingDisputeRoutes.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import NIO
import NIOHTTP1

public protocol IssuingDisputeRoutes: StripeAPIRoute {
    /// Creates an Issuing Dispute object. Individual pieces of evidence within the evidence object are optional at this point. Stripe only validates that required evidence is present during submission. Refer to Dispute reasons and evidence for more details about evidence requirements.
    ///
    /// - Parameters:
    ///   - evidence: A hash containing all the evidence related to the dispute. This should have a single key, equal to the provided reason, mapping to an appropriate evidence object.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - transaction: The ID of the issuing transaction to create a dispute for.
    ///   - amount: Amount to dispute, defaults to full value, given in the currency the transaction was made in.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns an Issuing `Dispute` object in `unsubmitted` status if creation succeeds.
    func create(evidence: [String: Any]?,
                metadata: [String: String]?,
                transaction: String?,
                amount: Int?,
                expand: [String]?) async throws -> IssuingDispute
    
    /// Submits an Issuing Dispute to the card network. Stripe validates that all evidence fields required for the dispute’s reason are present. For more details, see Dispute reasons and evidence.
    /// - Parameters:
    ///   - dispute: The ID of the dispute to submit.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns an Issuing `Dispute` object in `submitted` status if submission succeeds.
    func submit(dispute: String,
                metadata: [String: String]?,
                expand: [String]?) async throws -> IssuingDispute
    
    /// Retrieves an Issuing Dispute object.
    ///
    /// - Parameter dispute: The ID of the dispute to retrieve.
    /// - Parameter expand: An array of properties to expand.
    /// - Returns: Returns an Issuing `Dispute` object if a valid identifier was provided.
    func retrieve(dispute: String, expand: [String]?) async throws -> IssuingDispute
    
    /// Updates the specified Issuing `Dispute` object by setting the values of the parameters passed. Any parameters not provided will be left unchanged. Properties on the `evidence` object can be unset by passing in an empty string.
    ///
    /// - Parameters:
    ///   - dispute: The ID of the dispute to update.
    ///   - evidence: Evidence provided for the dispute.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - amount: The dispute amount in the card’s currency and in the smallest currency unit.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns an updated Issuing `Dispute` object if a valid identifier was provided.
    func update(dispute: String,
                evidence: [String: Any]?,
                metadata: [String: String]?,
                amount: Int?,
                expand: [String]?) async throws -> IssuingDispute
    
    /// Returns a list of Issuing Dispute objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/issuing/disputes/list)
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` disputes, starting after dispute `starting_after`. Each entry in the array is a separate Issuing `Dispute` object. If no more disputes are available, the resulting array will be empty.
    func listAll(filter: [String: Any]?) async throws -> IssuingDisputeList
}

public struct StripeIssuingDisputeRoutes: IssuingDisputeRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let issuingdisputes = APIBase + APIVersion + "issuing/disputes"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(evidence: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       transaction: String? = nil,
                       amount: Int? = nil,
                       expand: [String]? = nil) async throws -> IssuingDispute {
        var body: [String: Any] = [:]
        
        if let evidence {
            evidence.forEach { body["evidence[\($0)]"] = $1 }
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let transaction {
            body["transaction"] = transaction
        }
        
        if let amount {
            body["amount"] = amount
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: issuingdisputes, body: .string(body.queryParameters), headers: headers)
    }
    
    public func submit(dispute: String,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil) async throws -> IssuingDispute {
        var body: [String: Any] = [:]
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(issuingdisputes)/\(dispute)/submit", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(dispute: String, expand: [String]?) async throws -> IssuingDispute {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        return try await apiHandler.send(method: .GET, path: "\(issuingdisputes)/\(dispute)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func update(dispute: String,
                       evidence: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       amount: Int? = nil,
                       expand: [String]? = nil) async throws -> IssuingDispute {
        var body: [String: Any] = [:]
        
        if let evidence {
            evidence.forEach { body["evidence[\($0)]"] = $1 }
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let amount {
            body["amount"] = amount
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(issuingdisputes)/\(dispute)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> IssuingDisputeList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: issuingdisputes, query: queryParams, headers: headers)
    }
}
