//
//  RefundRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 5/13/17.
//
//

import NIO
import NIOHTTP1

public protocol RefundRoutes: StripeAPIRoute {
    /// When you create a new refund, you must specify a charge on which to create it.
    ///
    /// Creating a new refund will refund a charge that has previously been created but not yet refunded. Funds will be refunded to the credit or debit card that was originally charged.
    ///
    /// You can optionally refund only part of a charge. You can do so multiple times, until the entire charge has been refunded.
    ///
    /// Once entirely refunded, a charge can’t be refunded again. This method will return an error when called on an already-refunded charge, or whening to refund more money than is left on a charge.
    ///
    /// - Parameters:
    ///   - charge: The identifier of the charge to refund.
    ///   - amount: A positive integer in cents representing how much of this charge to refund. Can refund only up to the remaining, unrefunded amount of the charge.
    ///   - metadata: A set of key-value pairs that you can attach to a `Refund` object. This can be useful for storing additional information about the refund in a structured format. You can unset individual keys if you POST an empty value for that key. You can clear all keys if you POST an empty value for `metadata`
    ///   - paymentIntent: ID of the PaymentIntent to refund.
    ///   - reason: String indicating the reason for the refund. If set, possible values are `duplicate`, `fraudulent`, and `requested_by_customer`. If you believe the charge to be fraudulent, specifying `fraudulent` as the reason will add the associated card and email to your blocklists, and will also help us improve our fraud detection algorithms.
    ///   - refundApplicationFee: Boolean indicating whether the application fee should be refunded when refunding this charge. If a full charge refund is given, the full application fee will be refunded. Otherwise, the application fee will be refunded in an amount proportional to the amount of the charge refunded. /n An application fee can be refunded only by the application that created the charge.
    ///   - reverseTransfer: Boolean indicating whether the transfer should be reversed when refunding this charge. The transfer will be reversed proportionally to the amount being refunded (either the entire or partial amount). /n A transfer can be reversed only by the application that created the charge.
    ///   - instructionsEmail: For payment methods without native refund support (e.g., Konbini, PromptPay), use this email from the customer to receive refund instructions.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns the Refund object if the refund succeeded. Returns an error if the Charge/PaymentIntent has already been refunded, or if an invalid identifier was provided.
    func create(charge: String?,
                amount: Int?,
                metadata: [String: String]?,
                paymentIntent: String?,
                reason: RefundReason?,
                refundApplicationFee: Bool?,
                reverseTransfer: Bool?,
                instructionsEmail: String?,
                expand: [String]?) async throws -> Refund
    
    /// Retrieves the details of an existing refund.
    ///
    /// - Parameters:
    ///   - refund: ID of refund to retrieve.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns a refund if a valid ID was provided. Returns an error otherwise.
    func retrieve(refund: String, expand: [String]?) async throws -> Refund
    
    /// Updates the specified refund by setting the values of the parameters passed. Any parameters not provided will be left unchanged. /n This request only accepts metadata as an argument.
    ///
    /// - Parameters:
    ///   - refund: ID of refund to update.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns the refund object if the update succeeded. This call will return an error if update parameters are invalid.
    func update(refund: String, metadata: [String: String]?, expand: [String]?) async throws -> Refund
        
    /// Cancels a refund with a status of `requires_action`
    ///
    /// Refunds in other states cannot be canceled, and only refunds for payment methods that require customer action will enter the `requires_action` state.
    /// - Parameters:
    ///   - refund: The refund to cancel
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns the refund object if the cancelation succeeded. This call will return an error if the refund is unable to be canceled.
    func cancel(refund: String, expand: [String]?) async throws -> Refund
    
    
    /// Returns a list of all refunds you’ve previously created. The refunds are returned in sorted order, with the most recent refunds appearing first. For convenience, the 10 most recent refunds are always available by default on the charge object.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/refunds/list)
    /// - Returns: A dictionary with a data property that contains an array of up to limit refunds, starting after refund `starting_after`. Each entry in the array is a separate refund object. If no more refunds are available, the resulting array will be empty. If you provide a non-existent charge ID, this call returns an error.
    func listAll(filter: [String: Any]?) async throws -> RefundsList
}

public struct StripeRefundRoutes: RefundRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let refunds = APIBase + APIVersion + "refunds"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(charge: String? = nil,
                       amount: Int? = nil,
                       metadata: [String: String]? = nil,
                       paymentIntent: String? = nil,
                       reason: RefundReason? = nil,
                       refundApplicationFee: Bool? = nil,
                       reverseTransfer: Bool? = nil,
                       instructionsEmail: String? = nil,
                       expand: [String]? = nil) async throws -> Refund {
        var body: [String: Any] = [:]
        
        if let charge {
            body["charge"] = charge
        }
        
        if let amount {
            body["amount"] = amount
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let paymentIntent {
            body["payment_intent"] = paymentIntent
        }

        if let reason {
            body["reason"] = reason.rawValue
        }
        
        if let refundApplicationFee {
            body["refund_application_fee"] = refundApplicationFee
        }
        
        if let reverseTransfer {
            body["reverse_transfer"] = reverseTransfer
        }
        
        if let instructionsEmail {
            body["instructions_email"] = instructionsEmail
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: refunds, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(refund: String, expand: [String]? = nil) async throws -> Refund {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(refunds)/\(refund)", query: queryParams, headers: headers)
    }
    
    public func update(refund: String,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil) async throws -> Refund {
        var body: [String: Any] = [:]
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(refunds)/\(refund)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func cancel(refund: String, expand: [String]? = nil) async throws -> Refund {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(refunds)/\(refund)/cancel", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> RefundsList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: refunds, query: queryParams, headers: headers)
    }
}
