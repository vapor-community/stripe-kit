//
//  ApplicationFeeRefundRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/17/19.
//

import NIO
import NIOHTTP1
import Baggage

public protocol ApplicationFeeRefundRoutes {
    /// Refunds an application fee that has previously been collected but not yet refunded. Funds will be refunded to the Stripe account from which the fee was originally collected.
    /// You can optionally refund only part of an application fee. You can do so multiple times, until the entire fee has been refunded.
    /// Once entirely refunded, an application fee can’t be refunded again. This method will return an error when called on an already-refunded application fee, or when trying to refund more money than is left on an application fee.
    ///
    /// - Parameters:
    ///   - fee: The identifier of the application fee to be refunded.
    ///   - amount: A positive integer, in `cents`, representing how much of this fee to refund. Can refund only up to the remaining unrefunded amount of the fee.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeApplicationFeeRefund`.
    func create(fee: String,
                amount: Int?,
                metadata: [String: String]?,
                expand: [String]?,
                context: LoggingContext) -> EventLoopFuture<StripeApplicationFeeRefund>
    
    /// By default, you can see the 10 most recent refunds stored directly on the application fee object, but you can also retrieve details about a specific refund stored on the application fee.
    ///
    /// - Parameters:
    ///   - refund: ID of refund to retrieve.
    ///   - fee: ID of the application fee refunded.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeApplicationFeeRefund`.
    func retrieve(refund: String, fee: String, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeApplicationFeeRefund>
    
    /// Updates the specified application fee refund by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    /// This request only accepts metadata as an argument.
    ///
    /// - Parameters:
    ///   - refund: ID of refund to retrieve.
    ///   - fee: ID of the application fee refunded.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeApplicationFeeRefund`.
    func update(refund: String,
                fee: String,
                metadata: [String: String]?,
                expand: [String]?,
                context: LoggingContext) -> EventLoopFuture<StripeApplicationFeeRefund>
    
    /// You can see a list of the refunds belonging to a specific application fee. Note that the 10 most recent refunds are always available by default on the application fee object. If you need more than those 10, you can use this API method and the limit and starting_after parameters to page through additional refunds.
    ///
    /// - Parameters:
    ///   - fee: The ID of the application fee whose refunds will be retrieved.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/fee_refunds/list)
    /// - Returns: A `StripeApplicationFeeRefundList`.
    func listAll(fee: String, filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeApplicationFeeRefundList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension ApplicationFeeRefundRoutes {
    public func create(fee: String,
                       amount: Int? = nil,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil,
                       context: LoggingContext) -> EventLoopFuture<StripeApplicationFeeRefund> {
        return create(fee: fee,
                      amount: amount,
                      metadata: metadata,
                      expand: expand)
    }
    
    public func retrieve(refund: String, fee: String, expand: [String]? = nil, context: LoggingContext) -> EventLoopFuture<StripeApplicationFeeRefund> {
        return retrieve(refund: refund, fee: fee, expand: expand)
    }
    
    public func update(refund: String,
                       fee: String,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil,
                       context: LoggingContext) -> EventLoopFuture<StripeApplicationFeeRefund> {
        return update(refund: refund,
                      fee: fee,
                      metadata: metadata,
                      expand: expand)
    }
    
    public func listAll(fee: String, filter: [String: Any]? = nil, context: LoggingContext) -> EventLoopFuture<StripeApplicationFeeRefundList> {
        return listAll(fee: fee, filter: filter)
    }
}

public struct StripeApplicationFeeRefundRoutes: ApplicationFeeRefundRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let applicationfeesrefund = APIBase + APIVersion + "application_fees"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(fee: String,
                       amount: Int?,
                       metadata: [String: String]?,
                       expand: [String]?,
                       context: LoggingContext) -> EventLoopFuture<StripeApplicationFeeRefund> {
        var body: [String: Any] = [:]
        
        if let amount = amount {
            body["amount"] = amount
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(applicationfeesrefund)/\(fee)/refunds", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(refund: String, fee: String, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeApplicationFeeRefund> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        return apiHandler.send(method: .GET, path: "\(applicationfeesrefund)/\(fee)/refunds/\(refund)", query: queryParams, headers: headers)
    }
    
    public func update(refund: String,
                       fee: String,
                       metadata: [String: String]?,
                       expand: [String]?,
                       context: LoggingContext) -> EventLoopFuture<StripeApplicationFeeRefund> {
        var body: [String: Any] = [:]
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(applicationfeesrefund)/\(fee)/refunds/\(refund)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(fee: String, filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeApplicationFeeList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return apiHandler.send(method: .GET, path: "\(applicationfeesrefund)/\(fee)/refunds", query: queryParams, headers: headers)
    }
}
