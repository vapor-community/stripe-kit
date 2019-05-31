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
    /// Once entirely reversed, a transfer can’t be reversed again. This method will return an error when called on an already-reversed transfer, or when trying to reverse more money than is left on a transfer.
    ///
    /// - Parameters:
    ///   - id: The ID of the transfer to be reversed.
    ///   - amount: A positive integer in cents representing how much of this transfer to reverse. Can only reverse up to the unreversed amount remaining of the transfer. Partial transfer reversals are only allowed for transfers to Stripe Accounts. Defaults to the entire transfer amount.
    ///   - description: An arbitrary string which you can attach to a reversal object. It is displayed alongside the reversal in the Dashboard. This will be unset if you POST an empty value. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - refundApplicationFee: Boolean indicating whether the application fee should be refunded when reversing this transfer. If a full transfer reversal is given, the full application fee will be refunded. Otherwise, the application fee will be refunded with an amount proportional to the amount of the transfer reversed.
    /// - Returns: A `StripeTransferReversal`.
    /// - Throws: A `StripeError`.
    func create(id: String,
                amount: Int?,
                description: String?,
                metadata: [String: String]?,
                refundApplicationFee: Bool?) throws -> EventLoopFuture<StripeTransferReversal>
    
    /// By default, you can see the 10 most recent reversals stored directly on the transfer object, but you can also retrieve details about a specific reversal stored on the transfer.
    ///
    /// - Parameters:
    ///   - id: ID of reversal to retrieve.
    ///   - reversal: ID of the transfer reversed.
    /// - Returns: A `StripeTransferReversal`.
    /// - Throws: A `StripeError`.
    func retrieve(id: String, transfer: String) throws -> EventLoopFuture<StripeTransferReversal>
    
    /// Updates the specified reversal by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    /// This request only accepts metadata and description as arguments.
    ///
    /// - Parameters:
    ///   - id: ID of reversal to retrieve.
    ///   - transfer: ID of the transfer reversed.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    /// - Returns: A `StripeTransferReversal`.
    /// - Throws: A `StripeError`.
    func update(id: String, transfer: String, metadata: [String: String]?) throws -> EventLoopFuture<StripeTransferReversal>
    
    /// You can see a list of the reversals belonging to a specific transfer. Note that the 10 most recent reversals are always available by default on the transfer object. If you need more than those 10, you can use this API method and the limit and starting_after parameters to page through additional reversals.
    ///
    /// - Parameters:
    ///   - id: The ID of the transfer whose reversals will be retrieved.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/transfer_reversals/list)
    /// - Returns: A `StripeTransferReversalList`.
    /// - Throws: A `StripeError`.
    func listAll(id: String, filter: [String: Any]?) throws -> EventLoopFuture<StripeTransferReversalList>
    
    mutating func addHeaders(_ : HTTPHeaders)
}

extension TransferReversalRoutes {
    public func create(id: String,
                       amount: Int? = nil,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       refundApplicationFee: Bool? = nil) throws -> EventLoopFuture<StripeTransferReversal> {
        return try create(id: id,
                          amount: amount,
                          description: description,
                          metadata: metadata,
                          refundApplicationFee: refundApplicationFee)
    }
    
    public func retrieve(id: String, transfer: String) throws -> EventLoopFuture<StripeTransferReversal> {
        return try retrieve(id: id, transfer: transfer)
    }
    
    public func update(id: String,
                       transfer: String,
                       metadata: [String: String]? = nil) throws -> EventLoopFuture<StripeTransferReversal> {
        return try update(id: id,
                          transfer: transfer,
                          metadata: metadata)
    }
    
    public func listAll(id: String, filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeTransferReversalList> {
        return try listAll(id: id, filter: filter)
    }
}

public struct StripeTransferReversalRoutes: TransferReversalRoutes {
    private let apiHandler: StripeAPIHandler
    private var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public mutating func addHeaders(_ _headers: HTTPHeaders) {
        _headers.forEach { self.headers.replaceOrAdd(name: $0.name, value: $0.value) }
    }

    public func create(id: String,
                       amount: Int?,
                       description: String?,
                       metadata: [String: String]?,
                       refundApplicationFee: Bool?) throws -> EventLoopFuture<StripeTransferReversal> {
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
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.transferReversal(id).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(id: String, transfer: String) throws -> EventLoopFuture<StripeTransferReversal> {
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.transfersReversal(transfer, id).endpoint, headers: headers)
    }
    
    public func update(id: String,
                       transfer: String,
                       metadata: [String: String]?) throws -> EventLoopFuture<StripeTransferReversal> {
        var body: [String: Any] = [:]
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.transfersReversal(transfer, id).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(id: String, filter: [String: Any]?) throws -> EventLoopFuture<StripeTransferReversalList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.transferReversal(id).endpoint, query: queryParams, headers: headers)
    }
}

