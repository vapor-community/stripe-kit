//
//  AuthorizationRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/19.
//

import NIO
import NIOHTTP1
import Baggage

public protocol AuthorizationRoutes {
    /// Retrieves an Issuing Authorization object.
    ///
    /// - Parameter authorization: The ID of the authorization to retrieve.
    /// - Parameter expand: An array of properties to expand.
    /// - Returns: A `StripeAuthorization`.
    func retrieve(authorization: String, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeAuthorization>
    
    /// Updates the specified Issuing `Authorization` object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    ///
    /// - Parameters:
    ///   - authorization: The identifier of the authorization to update.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeAuthorization`.
    func update(authorization: String, metadata: [String: String]?, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeAuthorization>
    
    /// Approves a pending Issuing Authorization object.
    ///
    /// - Parameters:
    ///   - authorization: The identifier of the authorization to approve.
    ///   - heldAmount: If the authorization’s `is_held_amount_controllable` property is `true`, you may provide this value to control how much to hold for the authorization. Must be positive (use `decline` to decline an authorization request).
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeAuthorization`.
    func approve(authorization: String,
                 heldAmount: Int?,
                 metadata: [String: String]?,
                 expand: [String]?,
                 context: LoggingContext) -> EventLoopFuture<StripeAuthorization>
    
    /// Declines a pending Issuing Authorization object.
    ///
    /// - Parameter authorization: The identifier of the issuing authorization to decline.
    /// - Parameter metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    /// - Parameter expand: An array of properties to expand.
    /// - Returns: A `StripeAuthorization`
    func decline(authorization: String, metadata: [String: String]?, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeAuthorization>
    
    /// Returns a list of Issuing Authorization objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter:  A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/issuing/authorizations/list).
    /// - Returns: A `StripeAuthorizationList`.
    func listAll(filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeAuthorizationList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension AuthorizationRoutes {
    func retrieve(authorization: String, expand: [String]? = nil, context: LoggingContext) -> EventLoopFuture<StripeAuthorization> {
        return retrieve(authorization: authorization, expand: expand, context: context)
    }
    
    func update(authorization: String, metadata: [String: String]? = nil, expand: [String]? = nil, context: LoggingContext) -> EventLoopFuture<StripeAuthorization> {
        return update(authorization: authorization, metadata: metadata, expand: expand, context: context)
    }
    
    func approve(authorization: String,
                 heldAmount: Int? = nil,
                 metadata: [String: String]? = nil,
                 expand: [String]? = nil,
                 context: LoggingContext) -> EventLoopFuture<StripeAuthorization> {
        return approve(authorization: authorization,
                       heldAmount: heldAmount,
                       metadata: metadata,
                       expand: expand, context: context)
    }
    
    func decline(authorization: String, metadata: [String: String]? = nil, expand: [String]? = nil, context: LoggingContext) -> EventLoopFuture<StripeAuthorization> {
        return decline(authorization: authorization, metadata: metadata, expand: expand, context: context)
    }
    
    func listAll(filter: [String: Any]? = nil, context: LoggingContext) -> EventLoopFuture<StripeAuthorizationList> {
        return listAll(filter: filter, context: context)
    }
}

public struct StripeAuthorizationRoutes: AuthorizationRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let authorizations = APIBase + APIVersion + "issuing/authorizations"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(authorization: String, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeAuthorization> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(authorizations)/\(authorization)", query: queryParams, headers: headers, context: context)
    }
    
    public func update(authorization: String, metadata: [String: String]?, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeAuthorization> {
        var body: [String: Any] = [:]
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(authorizations)/\(authorization)", body: .string(body.queryParameters), headers: headers, context: context)
    }
    
    public func approve(authorization: String, heldAmount: Int?, metadata: [String: String]?, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeAuthorization> {
        var body: [String: Any] = [:]
        
        if let heldAmount = heldAmount {
            body["held_amount"] = heldAmount
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(authorizations)/\(authorization)/approve", body: .string(body.queryParameters), headers: headers, context: context)
    }
    
    public func decline(authorization: String, metadata: [String: String]?, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeAuthorization> {
        var body: [String: Any] = [:]
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(authorizations)/\(authorization)/decline", body: .string(body.queryParameters), headers: headers, context: context)
    }
    
    public func listAll(filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeAuthorizationList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: authorizations, query: queryParams, headers: headers, context: context)
    }
}
