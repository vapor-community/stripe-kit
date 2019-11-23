//
//  CardholderRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/19.
//

import NIO
import NIOHTTP1

public protocol CardholderRoutes {
    /// Creates a new Issuing Cardholder object that can be issued cards.
    ///
    /// - Parameters:
    ///   - billing: The cardholder’s billing address.
    ///   - name: The cardholder’s name. This will be printed on cards issued to them.
    ///   - type: The type of cardholder. Possible values are `individual` or `business_entity`.
    ///   - authorizationControls: Spending rules that give you control over how your cardholders can make charges. Refer to our [authorizations](https://stripe.com/docs/issuing/authorizations) documentation for more details. This will be unset if you POST an empty value.
    ///   - email: The cardholder’s email address.
    ///   - isDefault: Specifies whether to set this as the default cardholder.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - phoneNumber: The cardholder’s phone number. This will be transformed to E.164 if it is not provided in that format already.
    ///   - status: Specifies whether to permit authorizations on this cardholder’s cards. Possible values are `active` or `inactive`.
    /// - Returns: A `StripeCardholder`.
    func create(billing: [String: Any],
                name: String,
                type: StripeCardholderType,
                authorizationControls: [String: Any]?,
                email: String?,
                isDefault: Bool?,
                metadata: [String: String]?,
                phoneNumber: String?,
                status: StripeCardholderStatus?) -> EventLoopFuture<StripeCardholder>
    
    /// Retrieves an Issuing Cardholder object.
    ///
    /// - Parameter cardholder: The identifier of the cardholder to be retrieved.
    /// - Returns: A `StripeCardholder`.
    func retrieve(cardholder: String) -> EventLoopFuture<StripeCardholder>
    
    /// Updates the specified Issuing Cardholder object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    ///
    /// - Parameters:
    ///   - cardholder: The ID of the cardholder to update.
    ///   - authorizationControls: Spending rules that give you control over how your cardholders can make charges. Refer to our [authorizations](https://stripe.com/docs/issuing/authorizations) documentation for more details. This will be unset if you POST an empty value.
    ///   - billing: The cardholder’s billing address.
    ///   - email: The cardholder’s email address.
    ///   - isDefault: Specifies whether to set this as the default cardholder.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - phoneNumber: The cardholder’s phone number. This will be transformed to E.164 if it is not provided in that format already.
    ///   - status: Specifies whether to permit authorizations on this cardholder’s cards. Possible values are `active` or `inactive`.
    /// - Returns: A `StripeCardholder`.
    func update(cardholder: String,
                authorizationControls: [String: Any]?,
                billing: [String: Any]?,
                email: String?,
                isDefault: Bool?,
                metadata: [String: String]?,
                phoneNumber: String?,
                status: StripeCardholderStatus?) -> EventLoopFuture<StripeCardholder>
    
    /// Returns a list of Issuing Cardholder objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter:  A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/issuing/cardholders/list).
    /// - Returns: A `StripeAuthorizationList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeAuthorizationList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension CardholderRoutes {
    func create(billing: [String: Any],
                name: String,
                type: StripeCardholderType,
                authorizationControls: [String: Any]? = nil,
                email: String? = nil,
                isDefault: Bool? = nil,
                metadata: [String: String]? = nil,
                phoneNumber: String? = nil,
                status: StripeCardholderStatus? = nil) -> EventLoopFuture<StripeCardholder> {
        return create(billing: billing,
                          name: name,
                          type: type,
                          authorizationControls: authorizationControls,
                          email: email,
                          isDefault: isDefault,
                          metadata: metadata,
                          phoneNumber: phoneNumber,
                          status: status)
    }
    
    func retrieve(cardholder: String) -> EventLoopFuture<StripeCardholder> {
        return retrieve(cardholder: cardholder)
    }
    
    func update(cardholder: String,
                authorizationControls: [String: Any]? = nil,
                billing: [String: Any]? = nil,
                email: String? = nil,
                isDefault: Bool? = nil,
                metadata: [String: String]? = nil,
                phoneNumber: String? = nil,
                status: StripeCardholderStatus? = nil) -> EventLoopFuture<StripeCardholder> {
        return update(cardholder: cardholder,
                          authorizationControls: authorizationControls,
                          billing: billing,
                          email: email,
                          isDefault: isDefault,
                          metadata: metadata,
                          phoneNumber: phoneNumber,
                          status: status)
    }
    
    func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeAuthorizationList> {
        return listAll(filter: filter)
    }
}

public struct StripeCardholderRoutes: CardholderRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(billing: [String: Any],
                       name: String,
                       type: StripeCardholderType,
                       authorizationControls: [String: Any]?,
                       email: String?,
                       isDefault: Bool?,
                       metadata: [String: String]?,
                       phoneNumber: String?,
                       status: StripeCardholderStatus?) -> EventLoopFuture<StripeCardholder> {
        var body: [String: Any] = ["name": name,
                                   "type": type.rawValue]
        billing.forEach { body["billing[\($0)]"] = $1 }
        
        if let authorizationControls = authorizationControls {
            authorizationControls.forEach { body["authorization_controls[\($0)]"] = $1 }
        }
        
        if let email = email {
            body["email"] = email
        }
        
        if let isDefault = isDefault {
            body["is_default"] = isDefault
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let phoneNumber = phoneNumber {
            body["phone_number"] = phoneNumber
        }
        
        if let status = status {
            body["status"] = status.rawValue
        }
        
        return apiHandler.send(method: .POST, path: StripeAPIEndpoint.cardholder.endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(cardholder: String) -> EventLoopFuture<StripeCardholder> {
        return apiHandler.send(method: .GET, path: StripeAPIEndpoint.cardholders(cardholder).endpoint, headers: headers)
    }
    
    public func update(cardholder: String,
                       authorizationControls: [String: Any]?,
                       billing: [String: Any]?,
                       email: String?,
                       isDefault: Bool?,
                       metadata: [String: String]?,
                       phoneNumber: String?,
                       status: StripeCardholderStatus?) -> EventLoopFuture<StripeCardholder> {
        var body: [String: Any] = [:]
        
        if let authorizationControls = authorizationControls {
            authorizationControls.forEach { body["authorization_controls[\($0)]"] = $1 }
        }
        
        if let billing = billing {
            billing.forEach { body["billing[\($0)]"] = $1 }
        }
        
        if let email = email {
            body["email"] = email
        }
        
        if let isDefault = isDefault {
            body["is_default"] = isDefault
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let phoneNumber = phoneNumber {
            body["phone_number"] = phoneNumber
        }
        
        if let status = status {
            body["status"] = status.rawValue
        }
        
        return apiHandler.send(method: .POST, path: StripeAPIEndpoint.cardholders(cardholder).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String : Any]?) -> EventLoopFuture<StripeAuthorizationList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: StripeAPIEndpoint.cardholder.endpoint, query: queryParams, headers: headers)
    }
}
