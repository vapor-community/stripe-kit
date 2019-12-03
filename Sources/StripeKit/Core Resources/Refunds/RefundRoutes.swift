//
//  RefundRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 5/13/17.
//
//

import NIO
import NIOHTTP1

public protocol RefundRoutes {
    /// When you create a new refund, you must specify a charge on which to create it. /n Creating a new refund will refund a charge that has previously been created but not yet refunded. Funds will be refunded to the credit or debit card that was originally charged. /n You can optionally refund only part of a charge. You can do so multiple times, until the entire charge has been refunded. /n Once entirely refunded, a charge can’t be refunded again. This method will return an error when called on an already-refunded charge, or whening to refund more money than is left on a charge.
    ///
    /// - Parameters:
    ///   - charge: The identifier of the charge to refund.
    ///   - amount: A positive integer in cents representing how much of this charge to refund. Can refund only up to the remaining, unrefunded amount of the charge.
    ///   - metadata: A set of key-value pairs that you can attach to a `Refund` object. This can be useful for storing additional information about the refund in a structured format. You can unset individual keys if you POST an empty value for that key. You can clear all keys if you POST an empty value for `metadata`
    ///   - paymentIntent: ID of the PaymentIntent to refund.
    ///   - reason: String indicating the reason for the refund. If set, possible values are `duplicate`, `fraudulent`, and `requested_by_customer`. If you believe the charge to be fraudulent, specifying `fraudulent` as the reason will add the associated card and email to your blocklists, and will also help us improve our fraud detection algorithms.
    ///   - refundApplicationFee: Boolean indicating whether the application fee should be refunded when refunding this charge. If a full charge refund is given, the full application fee will be refunded. Otherwise, the application fee will be refunded in an amount proportional to the amount of the charge refunded. /n An application fee can be refunded only by the application that created the charge.
    ///   - reverseTransfer: Boolean indicating whether the transfer should be reversed when refunding this charge. The transfer will be reversed proportionally to the amount being refunded (either the entire or partial amount). /n A transfer can be reversed only by the application that created the charge.
    /// - Returns: A `StripeRefund`.
    func create(charge: String,
                amount: Int?,
                metadata: [String: String]?,
                paymentIntent: String?,
                reason: StripeRefundReason?,
                refundApplicationFee: Bool?,
                reverseTransfer: Bool?) -> EventLoopFuture<StripeRefund>
    
    /// Retrieves the details of an existing refund.
    ///
    /// - Parameter refund: ID of refund to retrieve.
    /// - Returns: A `StripeRefund`.
    func retrieve(refund: String) -> EventLoopFuture<StripeRefund>
    
    /// Updates the specified refund by setting the values of the parameters passed. Any parameters not provided will be left unchanged. /n This request only accepts metadata as an argument.
    ///
    /// - Parameters:
    ///   - refund: ID of refund to update.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    /// - Returns: A `StripeRefund`.
    func update(refund: String, metadata: [String: String]?) -> EventLoopFuture<StripeRefund>
    
    /// Returns a list of all refunds you’ve previously created. The refunds are returned in sorted order, with the most recent refunds appearing first. For convenience, the 10 most recent refunds are always available by default on the charge object.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/refunds/list)
    /// - Returns: A `StripeRefundsList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeRefundsList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension RefundRoutes {
    public func create(charge: String,
                       amount: Int? = nil,
                       metadata: [String: String]? = nil,
                       paymentIntent: String? = nil,
                       reason: StripeRefundReason? = nil,
                       refundApplicationFee: Bool? = nil,
                       reverseTransfer: Bool? = nil) -> EventLoopFuture<StripeRefund> {
        return create(charge: charge,
                      amount: amount,
                      metadata: metadata,
                      paymentIntent: paymentIntent,
                      reason: reason,
                      refundApplicationFee: refundApplicationFee,
                      reverseTransfer: reverseTransfer)
    }
    
    public func retrieve(refund: String) -> EventLoopFuture<StripeRefund> {
        return retrieve(refund: refund)
    }
    
    public func update(refund: String, metadata: [String: String]? = nil) -> EventLoopFuture<StripeRefund> {
        return update(refund: refund, metadata: metadata)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeRefundsList> {
        return listAll(filter: filter)
    }
}

public struct StripeRefundRoutes: RefundRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let refunds = APIBase + APIVersion + "refunds"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(charge: String,
                       amount: Int?,
                       metadata: [String: String]?,
                       paymentIntent: String?,
                       reason: StripeRefundReason?,
                       refundApplicationFee: Bool?,
                       reverseTransfer: Bool?) -> EventLoopFuture<StripeRefund> {
        var body: [String: Any] = [:]
        
        body["charge"] = charge
        
        if let amount = amount {
            body["amount"] = amount
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let paymentIntent = paymentIntent {
            body["payment_intent"] = paymentIntent
        }

        if let refundReason = reason {
            body["reason"] = refundReason.rawValue
        }
        
        if let refundApplicationFee = refundApplicationFee {
            body["refund_application_fee"] = refundApplicationFee
        }
        
        if let reverseTransfer = reverseTransfer {
            body["reverse_transfer"] = reverseTransfer
        }
        
        return apiHandler.send(method: .POST, path: refunds, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(refund: String) -> EventLoopFuture<StripeRefund> {
        return apiHandler.send(method: .GET, path: "\(refunds)/\(refund)", headers: headers)
    }
    
    public func update(refund: String, metadata: [String: String]?) -> EventLoopFuture<StripeRefund> {
        var body: [String: Any] = [:]
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: "\(refunds)/\(refund)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeRefundsList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: refunds, query: queryParams, headers: headers)
    }
}
