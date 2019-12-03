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
    ///   - ideal: If this is an ideal PaymentMethod, this hash contains details about the iDEAL payment method.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - sepaDebit: If this is a `sepa_debit` PaymentMethod, this hash contains details about the SEPA debit bank account.
    /// - Returns: A `StripePaymentMethod`.
    func create(type: StripePaymentMethodType,
                billingDetails: [String: Any]?,
                card: [String: Any]?,
                ideal: [String: Any]?,
                metadata: [String: String]?,
                sepaDebit: [String: Any]?) -> EventLoopFuture<StripePaymentMethod>
    
    /// Retrieves a PaymentMethod object.
    ///
    /// - Parameter paymentMethod: The ID of the PaymentMethod.
    /// - Returns: A `StripePaymentMethod`.
    func retrieve(paymentMethod: String) -> EventLoopFuture<StripePaymentMethod>
    
    /// Updates a PaymentMethod object. A PaymentMethod must be attached a customer to be updated.
    ///
    /// - Parameters:
    ///   - paymentMethod: The ID of the PaymentMethod to be updated.
    ///   - billingDetails: Billing information associated with the PaymentMethod that may be used or required by particular types of payment methods.
    ///   - card: If this is a `card` PaymentMethod, this hash contains the user’s card details. For backwards compatibility, you can alternatively provide a Stripe token (e.g., for Apple Pay, Amex Express Checkout, or legacy Checkout) into the card hash with format `card: {token: "tok_visa"}`. When creating with a card number, you must meet the requirements for PCI compliance. We strongly recommend using Stripe.js instead of interacting with this API directly.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - sepaDebit: If this is a `sepa_debit` PaymentMethod, this hash contains details about the SEPA debit bank account.
    /// - Returns: A `StripePaymentMethod`.
    func update(paymentMethod: String,
                billingDetails: [String: Any]?,
                card: [String: Any]?,
                metadata: [String: String]?,
                sepaDebit: [String: Any]?) -> EventLoopFuture<StripePaymentMethod>
    
    /// Returns a list of PaymentMethods for a given Customer
    ///
    /// - Parameters:
    ///   - customer: The ID of the customer whose PaymentMethods will be retrieved.
    ///   - type: A required filter on the list, based on the object type field.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/payment_methods/list)
    /// - Returns: A `StripePaymentMethodList`.
    func listAll(customer: String,
                 type: StripePaymentMethodType,
                 filter: [String: Any]?) -> EventLoopFuture<StripePaymentMethodList>
    
    /// Attaches a PaymentMethod object to a Customer.
    ///
    /// - Parameters:
    ///   - paymentMethod: The PaymentMethod to attach to the customer.
    ///   - customer: The ID of the customer to which to attach the PaymentMethod.
    /// - Returns: A `StripePaymentMethod`.
    func attach(paymentMethod: String, customer: String) -> EventLoopFuture<StripePaymentMethod>
    
    /// Detaches a PaymentMethod object from a Customer.
    ///
    /// - Parameter paymentMethod: The PaymentMethod to detach from the customer.
    /// - Returns: A `StripePaymentMethod`.
    func detach(paymentMethod: String) -> EventLoopFuture<StripePaymentMethod>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension PaymentMethodRoutes {
    public func create(type: StripePaymentMethodType,
                       billingDetails: [String: Any]? = nil,
                       card: [String: Any]? = nil,
                       ideal: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       sepaDebit: [String: Any]? = nil) -> EventLoopFuture<StripePaymentMethod> {
        return create(type: type,
                      billingDetails: billingDetails,
                      card: card,
                      ideal: ideal,
                      metadata: metadata,
                      sepaDebit: sepaDebit)
    }
    
    public func retrieve(paymentMethod: String) -> EventLoopFuture<StripePaymentMethod> {
        return retrieve(paymentMethod: paymentMethod)
    }
    
    public func update(paymentMethod: String,
                       billingDetails: [String: Any]? = nil,
                       card: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       sepaDebit: [String: Any]? = nil) -> EventLoopFuture<StripePaymentMethod> {
        return update(paymentMethod: paymentMethod,
                      billingDetails: billingDetails,
                      card: card,
                      metadata: metadata,
                      sepaDebit: sepaDebit)
    }
    
    public func listAll(customer: String,
                        type: StripePaymentMethodType,
                        filter: [String: Any]? = nil) -> EventLoopFuture<StripePaymentMethodList> {
        return listAll(customer: customer,
                           type: type,
                           filter: filter)
    }
    
    public func attach(paymentMethod: String, customer: String) -> EventLoopFuture<StripePaymentMethod> {
        return attach(paymentMethod: paymentMethod, customer: customer)
    }
    
    public func detach(paymentMethod: String) -> EventLoopFuture<StripePaymentMethod> {
        return detach(paymentMethod: paymentMethod)
    }
}

public struct StripePaymentMethodRoutes: PaymentMethodRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let paymentmethods = APIBase + APIVersion + "payment_methods"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(type: StripePaymentMethodType,
                       billingDetails: [String: Any]?,
                       card: [String: Any]?,
                       ideal: [String: Any]?,
                       metadata: [String: String]?,
                       sepaDebit: [String: Any]?) -> EventLoopFuture<StripePaymentMethod> {
        var body: [String: Any] = ["type": type.rawValue]
        
        if let billingDetails = billingDetails {
            billingDetails.forEach { body["billing_details[\($0)]"] = $1 }
        }
        
        if let card = card {
            card.forEach { body["card[\($0)]"] = $1 }
        }
        
        if let ideal = ideal {
            ideal.forEach { body["ideal[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        if let sepaDebit = sepaDebit {
            sepaDebit.forEach { body["sepa_debit[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: paymentmethods, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(paymentMethod: String) -> EventLoopFuture<StripePaymentMethod> {
        return apiHandler.send(method: .GET, path: "\(paymentmethods)/\(paymentMethod)", headers: headers)
    }
    
    public func update(paymentMethod: String,
                       billingDetails: [String: Any]?,
                       card: [String: Any]?,
                       metadata: [String: String]?,
                       sepaDebit: [String: Any]?) -> EventLoopFuture<StripePaymentMethod> {
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
        
        if let sepaDebit = sepaDebit {
            sepaDebit.forEach { body["sepa_debit[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: "\(paymentmethods)/\(paymentMethod)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(customer: String, type: StripePaymentMethodType, filter: [String: Any]?) -> EventLoopFuture<StripePaymentMethodList> {
        var queryParams = "customer=\(customer)&type=\(type.rawValue)"
        if let filter = filter {
            queryParams += "&" + filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: paymentmethods, query: queryParams, headers: headers)
    }
    
    public func attach(paymentMethod: String, customer: String) -> EventLoopFuture<StripePaymentMethod> {
        let body: [String: Any] = ["customer": customer]
        return apiHandler.send(method: .POST, path: "\(paymentmethods)/\(paymentMethod)/attach", body: .string(body.queryParameters), headers: headers)
    }
    
    public func detach(paymentMethod: String) -> EventLoopFuture<StripePaymentMethod> {
        return apiHandler.send(method: .POST, path: "\(paymentmethods)/\(paymentMethod)/detach", headers: headers)
    }
}
