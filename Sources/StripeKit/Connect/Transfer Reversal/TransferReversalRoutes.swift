//
//  TransferReversalRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/3/18.
//

import NIO
import NIOHTTP1

public protocol TransferReversalRoutes {
    /// When you create a new reversal, you must specify a transfer to create it on.
    /// When reversing transfers, you can optionally reverse part of the transfer. You can do so as many times as you wish until the entire transfer has been reversed.
    /// Once entirely reversed, a transfer can’t be reversed again. This method will return an error when called on an already-reversed transfer, or whening to reverse more money than is left on a transfer.
    ///
    /// - Parameters:
    ///   - id: The ID of the transfer to be reversed.
    ///   - amount: A positive integer in cents representing how much of this transfer to reverse. Can only reverse up to the unreversed amount remaining of the transfer. Partial transfer reversals are only allowed for transfers to Stripe Accounts. Defaults to the entire transfer amount.
    ///   - description: An arbitrary string which you can attach to a reversal object. It is displayed alongside the reversal in the Dashboard. This will be unset if you POST an empty value. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - refundApplicationFee: Boolean indicating whether the application fee should be refunded when reversing this transfer. If a full transfer reversal is given, the full application fee will be refunded. Otherwise, the application fee will be refunded with an amount proportional to the amount of the transfer reversed.
    /// - Returns: A `StripeTransferReversal`.
    func create(id: String,
                amount: Int?,
                description: String?,
                metadata: [String: String]?,
                refundApplicationFee: Bool?) -> EventLoopFuture<StripeTransferReversal>
    
    /// By default, you can see the 10 most recent reversals stored directly on the transfer object, but you can also retrieve details about a specific reversal stored on the transfer.
    ///
    /// - Parameters:
    ///   - id: ID of reversal to retrieve.
    ///   - reversal: ID of the transfer reversed.
    /// - Returns: A `StripeTransferReversal`.
    func retrieve(id: String, transfer: String) -> EventLoopFuture<StripeTransferReversal>
    
    /// Updates the specified reversal by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    /// This request only accepts metadata and description as arguments.
    ///
    /// - Parameters:
    ///   - id: ID of reversal to retrieve.
    ///   - transfer: ID of the transfer reversed.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    /// - Returns: A `StripeTransferReversal`.
    func update(id: String, transfer: String, metadata: [String: String]?) -> EventLoopFuture<StripeTransferReversal>
    
    /// You can see a list of the reversals belonging to a specific transfer. Note that the 10 most recent reversals are always available by default on the transfer object. If you need more than those 10, you can use this API method and the limit and starting_after parameters to page through additional reversals.
    ///
    /// - Parameters:
    ///   - id: The ID of the transfer whose reversals will be retrieved.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/transfer_reversals/list)
    /// - Returns: A `StripeTransferReversalList`.
    func listAll(id: String, filter: [String: Any]?) -> EventLoopFuture<StripeTransferReversalList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension TransferReversalRoutes {
    public func create(id: String,
                       amount: Int? = nil,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       refundApplicationFee: Bool? = nil) -> EventLoopFuture<StripeTransferReversal> {
        return create(id: id,
                      amount: amount,
                      description: description,
                      metadata: metadata,
                      refundApplicationFee: refundApplicationFee)
    }
    
    public func retrieve(id: String, transfer: String) -> EventLoopFuture<StripeTransferReversal> {
        return retrieve(id: id, transfer: transfer)
    }
    
    public func update(id: String,
                       transfer: String,
                       metadata: [String: String]? = nil) -> EventLoopFuture<StripeTransferReversal> {
        return update(id: id,
                          transfer: transfer,
                          metadata: metadata)
    }
    
    public func listAll(id: String, filter: [String: Any]? = nil) -> EventLoopFuture<StripeTransferReversalList> {
        return listAll(id: id, filter: filter)
    }
}

public struct StripeTransferReversalRoutes: TransferReversalRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let transferreversals = APIBase + APIVersion + "transfers"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(id: String,
                       amount: Int?,
                       description: String?,
                       metadata: [String: String]?,
                       refundApplicationFee: Bool?) -> EventLoopFuture<StripeTransferReversal> {
        var body: [String: Any] = [:]
        
        if let amount = amount {
            body["amount"] = amount
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let refundApplicationFee = refundApplicationFee {
            body["refund_application_fee"] = refundApplicationFee
        }
        
        return apiHandler.send(method: .POST, path: "\(transferreversals)/\(id)/reversals", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(id: String, transfer: String) -> EventLoopFuture<StripeTransferReversal> {
        return apiHandler.send(method: .GET, path: "\(transferreversals)/\(id)/reversals/\(id)", headers: headers)
    }
    
    public func update(id: String,
                       transfer: String,
                       metadata: [String: String]?) -> EventLoopFuture<StripeTransferReversal> {
        var body: [String: Any] = [:]
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: "\(transferreversals)/\(id)/reversals/\(id)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(id: String, filter: [String: Any]?) -> EventLoopFuture<StripeTransferReversalList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return apiHandler.send(method: .GET, path: "\(transferreversals)/\(id)/reversals", query: queryParams, headers: headers)
    }
}

