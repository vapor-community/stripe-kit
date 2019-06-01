//
//  AuthorizationRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/19.
//

import NIO
import NIOHTTP1

public protocol AuthorizationRoutes {
    /// Retrieves an Issuing Authorization object.
    ///
    /// - Parameter authorization: The ID of the authorization to retrieve.
    /// - Returns: A `StripeAuthorization`.
    /// - Throws: A `StripeError`.
    func retrieve(authorization: String) throws -> EventLoopFuture<StripeAuthorization>
    
    /// Updates the specified Issuing `Authorization` object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    ///
    /// - Parameters:
    ///   - authorization: The identifier of the authorization to update.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    /// - Returns: A `StripeAuthorization`.
    /// - Throws: A `StripeError`.
    func update(authorization: String, metadata: [String: String]?) throws -> EventLoopFuture<StripeAuthorization>
    
    /// Approves a pending Issuing Authorization object.
    ///
    /// - Parameters:
    ///   - authorization: The identifier of the authorization to approve.
    ///   - heldAmount: If the authorization’s `is_held_amount_controllable` property is `true`, you may provide this value to control how much to hold for the authorization. Must be positive (use `decline` to decline an authorization request).
    /// - Returns: A `StripeAuthorization`.
    /// - Throws: A `StripeError`.
    func approve(authorization: String, heldAmount: Int?) throws -> EventLoopFuture<StripeAuthorization>
    
    /// Declines a pending Issuing Authorization object.
    ///
    /// - Parameter authorization: The identifier of the issuing authorization to decline.
    /// - Returns: A `StripeAuthorization`
    /// - Throws: A `StripeError`.
    func decline(authorization: String) throws -> EventLoopFuture<StripeAuthorization>
    
    /// Returns a list of Issuing Authorization objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter:  A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/issuing/authorizations/list).
    /// - Returns: A `StripeAuthorizationList`.
    /// - Throws: A `StripeError`.
    func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeAuthorizationList>
    
    var headers: HTTPHeaders { get set }
}

extension AuthorizationRoutes {
    func retrieve(authorization: String) throws -> EventLoopFuture<StripeAuthorization> {
        return try retrieve(authorization: authorization)
    }
    
    func update(authorization: String, metadata: [String: String]? = nil) throws -> EventLoopFuture<StripeAuthorization> {
        return try update(authorization: authorization, metadata: metadata)
    }
    
    func approve(authorization: String, heldAmount: Int? = nil) throws -> EventLoopFuture<StripeAuthorization> {
        return try approve(authorization: authorization, heldAmount: heldAmount)
    }
    
    func decline(authorization: String) throws -> EventLoopFuture<StripeAuthorization> {
        return try decline(authorization: authorization)
    }
    
    func listAll(filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeAuthorizationList> {
        return try listAll(filter: filter)
    }
}

public struct StripeAuthorizationRoutes: AuthorizationRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(authorization: String) throws -> EventLoopFuture<StripeAuthorization> {
         return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.authorizations(authorization).endpoint, headers: headers)
    }
    
    public func update(authorization: String, metadata: [String: String]?) throws -> EventLoopFuture<StripeAuthorization> {
        var body: [String: Any] = [:]
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.authorizations(authorization).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func approve(authorization: String, heldAmount: Int?) throws -> EventLoopFuture<StripeAuthorization> {
        var body: [String: Any] = [:]
        
        if let heldAmount = heldAmount {
            body["held_amount"] = heldAmount
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.authorizationsApprove(authorization).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func decline(authorization: String) throws -> EventLoopFuture<StripeAuthorization> {
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.authorizationsDecline(authorization).endpoint, headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeAuthorizationList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.valueList.endpoint, query: queryParams, headers: headers)
    }
}
