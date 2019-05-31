//
//  PaymentMethodRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/1/19.
//

import NIO
import NIOHTTP1

public protocol PaymentMethodRoutes {
    /// Creates a PaymentMethod object. Read the Stripe.js reference to learn how to create PaymentMethods via Stripe.js.
    ///
    /// - Parameters:
    ///   - type: The type of the PaymentMethod. An additional hash is included on the PaymentMethod with a name matching this value. It contains additional information specific to the PaymentMethod type. Required unless `payment_method` is specified (see the Shared PaymentMethods guide)
    ///   - billingDetails: Billing information associated with the PaymentMethod that may be used or required by particular types of payment methods.
    ///   - card: If this is a `card` PaymentMethod, this hash contains the user’s card details. For backwards compatibility, you can alternatively provide a Stripe token (e.g., for Apple Pay, Amex Express Checkout, or legacy Checkout) into the card hash with format `card: {token: "tok_visa"}`. When creating with a card number, you must meet the requirements for PCI compliance. We strongly recommend using Stripe.js instead of interacting with this API directly.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    /// - Returns: A `StripePaymentMethod`.
    /// - Throws: A `StripeError`.
    func create(type: StripePaymentMethodType,
                billingDetails: [String: Any]?,
                card: [String: Any]?,
                metadata: [String: String]?) throws -> EventLoopFuture<StripePaymentMethod>
    
    /// Retrieves a PaymentMethod object.
    ///
    /// - Parameter paymentMethod: The ID of the PaymentMethod.
    /// - Returns: A `StripePaymentMethod`.
    /// - Throws: A `StripeError`.
    func retrieve(paymentMethod: String) throws -> EventLoopFuture<StripePaymentMethod>
    
    /// Updates a PaymentMethod object. A PaymentMethod must be attached a customer to be updated.
    ///
    /// - Parameters:
    ///   - paymentMethod: The ID of the PaymentMethod to be updated.
    ///   - billingDetails: Billing information associated with the PaymentMethod that may be used or required by particular types of payment methods.
    ///   - card: If this is a `card` PaymentMethod, this hash contains the user’s card details. For backwards compatibility, you can alternatively provide a Stripe token (e.g., for Apple Pay, Amex Express Checkout, or legacy Checkout) into the card hash with format `card: {token: "tok_visa"}`. When creating with a card number, you must meet the requirements for PCI compliance. We strongly recommend using Stripe.js instead of interacting with this API directly.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    /// - Returns: A `StripePaymentMethod`.
    /// - Throws: A `StripeError`.
    func update(paymentMethod: String,
                billingDetails: [String: Any]?,
                card: [String: Any]?,
                metadata: [String: String]?) throws -> EventLoopFuture<StripePaymentMethod>
    
    /// Returns a list of PaymentMethods for a given Customer
    ///
    /// - Parameters:
    ///   - customer: The ID of the customer whose PaymentMethods will be retrieved.
    ///   - type: A required filter on the list, based on the object type field.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/payment_methods/list)
    /// - Returns: A `StripePaymentMethodList`.
    /// - Throws: A `StripeError`.
    func listAll(customer: String,
                 type: StripePaymentMethodType,
                 filter: [String: Any]?) throws -> EventLoopFuture<StripePaymentMethodList>
    
    /// Attaches a PaymentMethod object to a Customer.
    ///
    /// - Parameters:
    ///   - paymentMethod: The PaymentMethod to attach to the customer.
    ///   - customer: The ID of the customer to which to attach the PaymentMethod.
    /// - Returns: A `StripePaymentMethod`.
    /// - Throws: A `StripeError`.
    func attach(paymentMethod: String, customer: String) throws -> EventLoopFuture<StripePaymentMethod>
    
    /// Detaches a PaymentMethod object from a Customer.
    ///
    /// - Parameter paymentMethod: The PaymentMethod to detach from the customer.
    /// - Returns: A `StripePaymentMethod`.
    /// - Throws: A `StripeError`.
    func detach(paymentMethod: String) throws -> EventLoopFuture<StripePaymentMethod>
    
    mutating func addHeaders(_ : HTTPHeaders)
}

extension PaymentMethodRoutes {
    public func create(type: StripePaymentMethodType,
                       billingDetails: [String: Any]? = nil,
                       card: [String: Any]? = nil,
                       metadata: [String: String]? = nil) throws -> EventLoopFuture<StripePaymentMethod> {
        return try create(type: type,
                          billingDetails: billingDetails,
                          card: card,
                          metadata: metadata)
    }
    
    public func retrieve(paymentMethod: String) throws -> EventLoopFuture<StripePaymentMethod> {
        return try retrieve(paymentMethod: paymentMethod)
    }
    
    public func update(paymentMethod: String,
                       billingDetails: [String: Any]? = nil,
                       card: [String: Any]? = nil,
                       metadata: [String: String]? = nil) throws -> EventLoopFuture<StripePaymentMethod> {
        return try update(paymentMethod: paymentMethod,
                          billingDetails: billingDetails,
                          card: card,
                          metadata: metadata)
    }
    
    public func listAll(customer: String,
                        type: StripePaymentMethodType,
                        filter: [String: Any]? = nil) throws -> EventLoopFuture<StripePaymentMethodList> {
        return try listAll(customer: customer,
                           type: type,
                           filter: filter)
    }
    
    public func attach(paymentMethod: String, customer: String) throws -> EventLoopFuture<StripePaymentMethod> {
        return try attach(paymentMethod: paymentMethod, customer: customer)
    }
    
    public func detach(paymentMethod: String) throws -> EventLoopFuture<StripePaymentMethod> {
        return try detach(paymentMethod: paymentMethod)
    }
}

public struct StripePaymentMethodRoutes: PaymentMethodRoutes {
    private let apiHandler: StripeAPIHandler
    private var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public mutating func addHeaders(_ _headers: HTTPHeaders) {
        _headers.forEach { self.headers.replaceOrAdd(name: $0.name, value: $0.value) }
    }
    
    public func create(type: StripePaymentMethodType,
                       billingDetails: [String: Any]?,
                       card: [String: Any]?,
                       metadata: [String: String]?) throws -> EventLoopFuture<StripePaymentMethod> {
        var body: [String: Any] = ["type": type.rawValue]
        
        if let billingDetails = billingDetails {
            billingDetails.forEach { body["billing_details[\($0)]"] = $1 }
        }
        
        if let card = card {
            card.forEach { body["card[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.paymentMethod.endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(paymentMethod: String) throws -> EventLoopFuture<StripePaymentMethod> {
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.paymentMethods(paymentMethod).endpoint, headers: headers)
    }
    
    public func update(paymentMethod: String,
                       billingDetails: [String: Any]?,
                       card: [String: Any]?,
                       metadata: [String: String]?) throws -> EventLoopFuture<StripePaymentMethod> {
        var body: [String: Any] = [:]
        
        if let billingDetails = billingDetails {
            billingDetails.forEach { body["billing_details[\($0)]"] = $1 }
        }
        
        if let card = card {
            card.forEach { body["card[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.paymentMethods(paymentMethod).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(customer: String, type: StripePaymentMethodType, filter: [String: Any]?) throws -> EventLoopFuture<StripePaymentMethodList> {
        var queryParams = "customer=\(customer)&type=\(type.rawValue)"
        if let filter = filter {
            queryParams += "&" + filter.queryParameters
        }
        
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.paymentMethod.endpoint, query: queryParams, headers: headers)
    }
    
    public func attach(paymentMethod: String, customer: String) throws -> EventLoopFuture<StripePaymentMethod> {
        let body: [String: Any] = ["customer": customer]
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.paymentMethodsAttach(paymentMethod).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func detach(paymentMethod: String) throws -> EventLoopFuture<StripePaymentMethod> {
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.paymentMethodsDetach(paymentMethod).endpoint, headers: headers)
    }
}
