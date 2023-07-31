//
//  AuthorizationRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/19.
//

import NIO
import NIOHTTP1

public protocol AuthorizationRoutes: StripeAPIRoute {
    /// Retrieves an Issuing Authorization object.
    ///
    /// - Parameter authorization: The ID of the authorization to retrieve.
    /// - Parameter expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns an Issuing ``Authorization`` object if a valid identifier was provided.
    func retrieve(authorization: String, expand: [String]?) async throws -> Authorization
    
    /// Updates the specified Issuing `Authorization` object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    ///
    /// - Parameters:
    ///   - authorization: The identifier of the authorization to update.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns an updated Issuing ``Authorization`` object if a valid identifier was provided.
    func update(authorization: String, metadata: [String: String]?, expand: [String]?) async throws -> Authorization
    
    /// Approves a pending Issuing ``Authorization`` object. This request should be made within the timeout window of the real-time authorization flow. You can also respond directly to the webhook request to approve an authorization (preferred). More details can be found [here](https://site-admin.stripe.com/docs/issuing/controls/real-time-authorizations#authorization-handling) .
    ///
    /// - Parameters:
    ///   - authorization: The identifier of the authorization to approve.
    ///   - amount: If the authorization’s `pending_request.is_amount_controllable` property is `true`, you may provide this value to control how much to hold for the authorization. Must be positive (use decline to `decline` an authorization request).
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns an approved Issuing ``Authorization`` object.
    func approve(authorization: String,
                 amount: Int?,
                 metadata: [String: String]?,
                 expand: [String]?) async throws -> Authorization
    
    /// Declines a pending Issuing Authorization object. This request should be made within the timeout window of the real time authorization flow. You can also respond directly to the webhook request to decline an authorization (preferred). More details can be found here.
    ///
    /// - Parameter authorization: The identifier of the issuing authorization to decline.
    /// - Parameter metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    /// - Parameter expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns a declined Issuing ``Authorization`` object.
    func decline(authorization: String, metadata: [String: String]?, expand: [String]?) async throws -> Authorization
    
    /// Returns a list of Issuing ``Authorization`` objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter:  A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/issuing/authorizations/list) .
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` authorizations, starting after authorization `starting_after`. Each entry in the array is a separate Issuing Authorization object. If no more authorizations are available, the resulting array will be empty.
    func listAll(filter: [String: Any]?) async throws -> AuthorizationList
}

public struct StripeAuthorizationRoutes: AuthorizationRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let authorizations = APIBase + APIVersion + "issuing/authorizations"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(authorization: String, expand: [String]? = nil) async throws -> Authorization {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(authorizations)/\(authorization)", query: queryParams, headers: headers)
    }
    
    public func update(authorization: String,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil) async throws -> Authorization {
        var body: [String: Any] = [:]
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(authorizations)/\(authorization)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func approve(authorization: String,
                        amount: Int? = nil,
                        metadata: [String: String]? = nil,
                        expand: [String]? = nil) async throws -> Authorization {
        var body: [String: Any] = [:]
        
        if let amount {
            body["amount"] = amount
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(authorizations)/\(authorization)/approve", body: .string(body.queryParameters), headers: headers)
    }
    
    public func decline(authorization: String,
                        metadata: [String: String]? = nil,
                        expand: [String]? = nil) async throws -> Authorization {
        var body: [String: Any] = [:]
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(authorizations)/\(authorization)/decline", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> AuthorizationList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: authorizations, query: queryParams, headers: headers)
    }
}
