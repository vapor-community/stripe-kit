//
//  TopUpRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/24/19.
//

import NIO
import NIOHTTP1

public protocol TopUpRoutes {
    /// Top up the balance of an account
    ///
    /// - Parameters:
    ///   - amount: A positive integer representing how much to transfer.
    ///   - currency: Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    ///   - description: An arbitrary string attached to the object. Often useful for displaying to users. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - source: The ID of a source to transfer funds from. For most users, this should be left unspecified which will use the bank account that was set up in the dashboard for the specified currency. In test mode, this can be a test bank token (see [Testing Top-ups](https://stripe.com/docs/connect/testing#testing-top-ups)).
    ///   - statementDescriptor: Extra information about a top-up for the source’s bank statement. Limited to 15 ASCII characters.
    ///   - transferGroup: A string that identifies this top-up as part of a group.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeTopUp`.
    func create(amount: Int,
                currency: Currency,
                description: String?,
                metadata: [String: String]?,
                source: String?,
                statementDescriptor: String?,
                transferGroup: String?,
                expand: [String]?) -> EventLoopFuture<StripeTopUp>
    
    /// Retrieves the details of a top-up that has previously been created. Supply the unique top-up ID that was returned from your previous request, and Stripe will return the corresponding top-up information.
    ///
    /// - Parameter topup: The ID of the top-up to retrieve.
    /// - Parameter expand: An array of properties to expand.
    /// - Returns: A `StripeTopUp`.
    func retrieve(topup: String, expand: [String]?) -> EventLoopFuture<StripeTopUp>
    
    /// Updates the metadata of a top-up. Other top-up details are not editable by design.
    ///
    /// - Parameters:
    ///   - topup: The ID of the top-up to retrieve.
    ///   - description: An arbitrary string attached to the object. Often useful for displaying to users. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeTopUp`.
    func update(topup: String,
                description: String?,
                metadata: [String: String]?,
                expand: [String]?) -> EventLoopFuture<StripeTopUp>
    
    /// Returns a list of top-ups.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/topups/list).
    /// - Returns: A `StripeTopUpList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeTopUpList>
    
    /// Cancels a top-up. Only pending top-ups can be canceled.
    ///
    /// - Parameter topup: The ID of the top-up to cancel.
    /// - Parameter expand: An array of properties to expand.
    /// - Returns: A canceled `StripeTopUp`.
    func cancel(topup: String, expand: [String]?) -> EventLoopFuture<StripeTopUp>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension TopUpRoutes {
    public func create(amount: Int,
                       currency: Currency,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       source: String? = nil,
                       statementDescriptor: String? = nil,
                       transferGroup: String? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeTopUp> {
        return create(amount: amount,
                      currency: currency,
                      description: description,
                      metadata: metadata,
                      source: source,
                      statementDescriptor: statementDescriptor,
                      transferGroup: transferGroup,
                      expand: expand)
    }
    
    public func retrieve(topup: String, expand: [String]? = nil) -> EventLoopFuture<StripeTopUp> {
        return retrieve(topup: topup, expand: expand)
    }
    
    public func update(topup: String,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeTopUp> {
        return update(topup: topup,
                      description: description,
                      metadata: metadata,
                      expand: expand)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeTopUpList> {
        return listAll(filter: filter)
    }
    
    public func cancel(topup: String, expand: [String]? = nil) -> EventLoopFuture<StripeTopUp> {
        return cancel(topup: topup, expand: expand)
    }
}

public struct StripeTopUpRoutes: TopUpRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let topups = APIBase + APIVersion + "topups"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(amount: Int,
                       currency: Currency,
                       description: String?,
                       metadata: [String: String]?,
                       source: String?,
                       statementDescriptor: String?,
                       transferGroup: String?,
                       expand: [String]?) -> EventLoopFuture<StripeTopUp> {
        var body: [String: Any] = ["amount": amount,
                                   "currency": currency.rawValue]
        
        if let description = description {
            body["description"] = description
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let source = source {
            body["source"] = source
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let transferGroup = transferGroup {
            body["transfer_group"] = transferGroup
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: topups, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(topup: String, expand: [String]?) -> EventLoopFuture<StripeTopUp> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(topups)/\(topup)", query: queryParams)
    }
    
    public func update(topup: String,
                       description: String?,
                       metadata: [String: String]?,
                       expand: [String]?) -> EventLoopFuture<StripeTopUp> {
        var body: [String: Any] = [:]
        
        if let description = description {
            body["description"] = description
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(topups)/\(topup)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeTopUpList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return apiHandler.send(method: .GET, path: topups, query: queryParams, headers: headers)
    }
    
    public func cancel(topup: String, expand: [String]?) -> EventLoopFuture<StripeTopUp> {
        var body: [String: Any] = [:]
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(topups)/\(topup)/cancel", body: .string(body.queryParameters), headers: headers)
    }
}
