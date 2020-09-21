//
//  SourceRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/1/17.
//
//

import NIO
import NIOHTTP1

public protocol SourceRoutes {
    /// Creates a new source object.
    ///
    /// - Parameters:
    ///   - type: The `type` of the source to create. Required unless `customer` and `original_source` are specified (see the Shared card Sources guide)
    ///   - amount: Amount associated with the source. This is the amount for which the source will be chargeable once ready. Required for `single_use` sources.
    ///   - currency: Three-letter ISO code for the currency associated with the source. This is the currency for which the source will be chargeable once ready.
    ///   - flow: The authentication `flow` of the source to create. `flow` is one of `redirect`, `receiver`, `code_verification`, `none`. It is generally inferred unless a type supports multiple flows.
    ///   - mandate: Information about a mandate possibility attached to a source object (generally for bank debits) as well as its acceptance status.
    ///   - metadata: A set of key-value pairs that you can attach to a source object. It can be useful for storing additional information about the source in a structured format.
    ///   - owner: Information about the owner of the payment instrument that may be used or required by particular source types.
    ///   - receiver: Optional parameters for the receiver flow. Can be set only if the source is a receiver (`flow` is `receiver`).
    ///   - redirect: Parameters required for the redirect flow. Required if the source is authenticated by a redirect (`flow` is `redirect`).
    ///   - sourceOrder: Information about the items and shipping associated with the source. Required for transactional credit (for example Klarna) sources before you can charge it.
    ///   - statementDescriptor: An arbitrary string to be displayed on your customer’s statement. As an example, if your website is `RunClub` and the item you’re charging for is a race ticket, you may want to specify a `statement_descriptor` of `RunClub 5K race ticket.` While many payment types will display this information, some may not display it at all.
    ///   - token: An optional token used to create the source. When passed, token properties will override source parameters.
    ///   - usage: Either `reusable` or `single_use`. Whether this source should be reusable or not. Some source types may or may not be reusable by construction, while others may leave the option at creation. If an incompatible value is passed, an error will be returned.
    ///   - sources: Optional parameters used for creating the source. Will be overridden if a token is passed instead.
    /// - Returns: A `StripeSource`.
    func create(type: StripeSourceType,
                amount: Int?,
                currency: StripeCurrency?,
                flow: StripeSourceFlow?,
                mandate: [String: Any]?,
                metadata: [String: String]?,
                owner: [String: Any]?,
                receiver: [String: Any]?,
                redirect: [String: Any]?,
                sourceOrder: [String: Any]?,
                statementDescriptor: String?,
                token: String?,
                usage: StripeSourceUsage?,
                sources: [String: Any]?) -> EventLoopFuture<StripeSource>
    
    /// Retrieves an existing source object. Supply the unique source ID from a source creation request and Stripe will return the corresponding up-to-date source object information.
    ///
    /// - Parameters:
    /// - source: The identifier of the source to be retrieved.
    /// - clientSecret: The client secret of the source. Required if a publishable key is used to retrieve the source.
    /// - Returns: A `StripeSource`.
    func retrieve(source: String, clientSecret: String?) -> EventLoopFuture<StripeSource>
    
    /// Updates the specified source by setting the values of the parameters passed. Any parameters not provided will be left unchanged. /n This request accepts the `metadata` and `owner` as arguments. It is also possible to update type specific information for selected payment methods. Please refer to our payment method guides for more detail.
    ///
    /// - Parameters:
    ///   - source: The identifier of the source to be updated.
    ///   - amount: Amount associated with the source.
    ///   - mandate: Information about a mandate possibility attached to a source object (generally for bank debits) as well as its acceptance status.
    ///   - metadata: A set of key-value pairs that you can attach to a source object. It can be useful for storing additional information about the source in a structured format.
    ///   - owner: Information about the owner of the payment instrument that may be used or required by particular source types.
    ///   - sourceOrder: Information about the items and shipping associated with the source. Required for transactional credit (for example Klarna) sources before you can charge it.
    /// - Returns: A `StripeSource`.
    func update(source: String,
                amount: Int?,
                mandate: [String: Any]?,
                metadata: [String: String]?,
                owner: [String: Any]?,
                sourceOrder: [String: Any]?) -> EventLoopFuture<StripeSource>
    
    /// Attaches a Source object to a Customer. The source must be in a chargeable or pending state.
    ///
    /// - Parameters:
    ///   - source: The identifier of the source to be attached.
    ///   - customer: The identifier of the customer who the source will be attached to.
    /// - Returns: A `StripeSource`.
    func attach(source: String, customer: String) -> EventLoopFuture<StripeSource>
    
    /// Detaches a Source object from a Customer. The status of a source is changed to `consumed` when it is detached and it can no longer be used to create a charge.
    ///
    /// - Parameters:
    ///   - id: The identifier of the source to be detached.
    ///   - customer: The identifier of the customer the source will be detached from.
    /// - Returns: A `StripeSource`.
    func detach(id: String, customer: String) -> EventLoopFuture<StripeSource>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension SourceRoutes {
    public func create(type: StripeSourceType,
                       amount: Int? = nil,
                       currency: StripeCurrency? = nil,
                       flow: StripeSourceFlow? = nil,
                       mandate: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       owner: [String: Any]? = nil,
                       receiver: [String: Any]? = nil,
                       redirect: [String: Any]? = nil,
                       sourceOrder: [String: Any]? = nil,
                       statementDescriptor: String? = nil,
                       token: String? = nil,
                       usage: StripeSourceUsage? = nil,
                       sources: [String: Any]? = nil) -> EventLoopFuture<StripeSource> {
        return create(type: type,
                          amount: amount,
                          currency: currency,
                          flow: flow,
                          mandate: mandate,
                          metadata: metadata,
                          owner: owner,
                          receiver: receiver,
                          redirect: redirect,
                          sourceOrder: sourceOrder,
                          statementDescriptor: statementDescriptor,
                          token: token,
                          usage: usage,
                          sources: sources)
    }
    
    public func retrieve(source: String, clientSecret: String? = nil) -> EventLoopFuture<StripeSource> {
        return retrieve(source: source, clientSecret: clientSecret)
    }
    
    public func update(source: String,
                       amount: Int? = nil,
                       mandate: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       owner: [String: Any]? = nil,
                       sourceOrder: [String: Any]? = nil) -> EventLoopFuture<StripeSource> {
        return update(source: source,
                      amount: amount,
                      mandate: mandate,
                      metadata: metadata,
                      owner: owner,
                      sourceOrder: sourceOrder)
    }
    
    public func attach(source: String, customer: String) -> EventLoopFuture<StripeSource> {
        return attach(source: source, customer: customer)
    }
    
    public func detach(id: String, customer: String) -> EventLoopFuture<StripeSource> {
        return detach(id: id, customer: customer)
    }
}

public struct StripeSourceRoutes: SourceRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let sources = APIBase + APIVersion + "sources"
    private let customers = APIBase + APIVersion + "customers"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(type: StripeSourceType,
                       amount: Int?,
                       currency: StripeCurrency?,
                       flow: StripeSourceFlow?,
                       mandate: [String: Any]?,
                       metadata: [String: String]?,
                       owner: [String: Any]?,
                       receiver: [String: Any]?,
                       redirect: [String: Any]?,
                       sourceOrder: [String: Any]?,
                       statementDescriptor: String?,
                       token: String?,
                       usage: StripeSourceUsage?,
                       sources: [String: Any]?) -> EventLoopFuture<StripeSource> {
        var body: [String: Any] = ["type": type.rawValue]
        
        if let currency = currency {
            body["currency"] = currency.rawValue
        }
        
        if let flow = flow {
            body["flow"] = flow.rawValue
        }
        
        if let mandate = mandate {
            mandate.forEach { body["mandate[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let owner = owner {
            owner.forEach { body["owner[\($0)]"] = $1 }
        }
        
        if let receiver = receiver {
            receiver.forEach { body["receiver[\($0)]"] = $1 }
        }
        
        if let redirect = redirect {
            redirect.forEach { body["redirect[\($0)]"] = $1 }
        }
        
        if let sourceOrder = sourceOrder {
            sourceOrder.forEach { body["source_order[\($0)]"] = $1 }
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let token = token {
            body["token"] = token
        }
        
        if let usage = usage {
            body["usage"] = usage
        }
        
        if let sources = sources {
            sources.forEach { body["\($0)"] = $1}
        }
        
        return apiHandler.send(method: .POST, path: self.sources, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(source: String, clientSecret: String?) -> EventLoopFuture<StripeSource> {
        var query = ""
        if let clientSecret = clientSecret {
            query += "client_secret=\(clientSecret)"
        }
        return apiHandler.send(method: .GET, path: "\(sources)/\(source)", query: query, headers: headers)
    }
    
    public func update(source: String,
                       amount: Int?,
                       mandate: [String: Any]?,
                       metadata: [String: String]?,
                       owner: [String: Any]?,
                       sourceOrder: [String: Any]?) -> EventLoopFuture<StripeSource> {
        var body: [String: Any] = [:]
        
        if let amount = amount {
            body["amount"] = amount
        }
        
        if let mandate = mandate {
            mandate.forEach { body["mandate[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let owner = owner {
            owner.forEach { body["owner[\($0)]"] = $1 }
        }
        
        if let sourceOrder = sourceOrder {
            sourceOrder.forEach { body["source_order[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: "\(sources)/\(source)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func attach(source: String, customer: String) -> EventLoopFuture<StripeSource> {
        let body: [String: Any] = ["source": source]
        return apiHandler.send(method: .POST, path: "\(customers)/\(customer)/sources", body: .string(body.queryParameters), headers: headers)
    }
    
    public func detach(id: String, customer: String) -> EventLoopFuture<StripeSource> {
        return apiHandler.send(method: .DELETE, path: "\(customers)/\(customer)/sources/\(id)", headers: headers)
    }
}
