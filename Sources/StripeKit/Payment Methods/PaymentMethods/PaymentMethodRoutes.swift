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
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripePaymentMethod`.
    func create(type: StripePaymentMethodType,
                billingDetails: [String: Any]?,
                card: [String: Any]?,
                ideal: [String: Any]?,
                metadata: [String: String]?,
                sepaDebit: [String: Any]?,
                expand: [String]?) -> EventLoopFuture<StripePaymentMethod>
    
    /// Retrieves a PaymentMethod object.
    ///
    /// - Parameters:
    ///   - paymentMethod: The ID of the PaymentMethod.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripePaymentMethod`.
    func retrieve(paymentMethod: String, expand: [String]?) -> EventLoopFuture<StripePaymentMethod>
    
    /// Updates a PaymentMethod object. A PaymentMethod must be attached a customer to be updated.
    ///
    /// - Parameters:
    ///   - paymentMethod: The ID of the PaymentMethod to be updated.
    ///   - billingDetails: Billing information associated with the PaymentMethod that may be used or required by particular types of payment methods.
    ///   - card: If this is a `card` PaymentMethod, this hash contains the user’s card details. For backwards compatibility, you can alternatively provide a Stripe token (e.g., for Apple Pay, Amex Express Checkout, or legacy Checkout) into the card hash with format `card: {token: "tok_visa"}`. When creating with a card number, you must meet the requirements for PCI compliance. We strongly recommend using Stripe.js instead of interacting with this API directly.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - sepaDebit: If this is a `sepa_debit` PaymentMethod, this hash contains details about the SEPA debit bank account.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripePaymentMethod`.
    func update(paymentMethod: String,
                billingDetails: [String: Any]?,
                card: [String: Any]?,
                metadata: [String: String]?,
                sepaDebit: [String: Any]?,
                expand: [String]?) -> EventLoopFuture<StripePaymentMethod>
    
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
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripePaymentMethod`.
    func attach(paymentMethod: String, customer: String, expand: [String]?) -> EventLoopFuture<StripePaymentMethod>
    
    /// Detaches a PaymentMethod object from a Customer.
    ///
    /// - Parameters:
    ///   - paymentMethod: The PaymentMethod to detach from the customer.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripePaymentMethod`.
    func detach(paymentMethod: String, expand: [String]?) -> EventLoopFuture<StripePaymentMethod>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension PaymentMethodRoutes {
    public func create(type: StripePaymentMethodType,
                       billingDetails: [String: Any]? = nil,
                       card: [String: Any]? = nil,
                       ideal: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       sepaDebit: [String: Any]? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripePaymentMethod> {
        return create(type: type,
                      billingDetails: billingDetails,
                      card: card,
                      ideal: ideal,
                      metadata: metadata,
                      sepaDebit: sepaDebit,
                      expand: expand)
    }
    
    public func retrieve(paymentMethod: String, expand: [String]? = nil) -> EventLoopFuture<StripePaymentMethod> {
        return retrieve(paymentMethod: paymentMethod, expand: expand)
    }
    
    public func update(paymentMethod: String,
                       billingDetails: [String: Any]? = nil,
                       card: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       sepaDebit: [String: Any]? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripePaymentMethod> {
        return update(paymentMethod: paymentMethod,
                      billingDetails: billingDetails,
                      card: card,
                      metadata: metadata,
                      sepaDebit: sepaDebit,
                      expand: expand)
    }
    
    public func listAll(customer: String,
                        type: StripePaymentMethodType,
                        filter: [String: Any]? = nil) -> EventLoopFuture<StripePaymentMethodList> {
        return listAll(customer: customer,
                           type: type,
                           filter: filter)
    }
    
    public func attach(paymentMethod: String, customer: String, expand: [String]? = nil) -> EventLoopFuture<StripePaymentMethod> {
        return attach(paymentMethod: paymentMethod, customer: customer, expand: expand)
    }
    
    public func detach(paymentMethod: String, expand: [String]? = nil) -> EventLoopFuture<StripePaymentMethod> {
        return detach(paymentMethod: paymentMethod, expand: expand)
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
                       sepaDebit: [String: Any]?,
                       expand: [String]?) -> EventLoopFuture<StripePaymentMethod> {
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
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: paymentmethods, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(paymentMethod: String, expand: [String]?) -> EventLoopFuture<StripePaymentMethod> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(paymentmethods)/\(paymentMethod)", query: queryParams, headers: headers)
    }
    
    public func update(paymentMethod: String,
                       billingDetails: [String: Any]?,
                       card: [String: Any]?,
                       metadata: [String: String]?,
                       sepaDebit: [String: Any]?,
                       expand: [String]?) -> EventLoopFuture<StripePaymentMethod> {
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
        
        if let expand = expand {
            body["expand"] = expand
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
    
    public func attach(paymentMethod: String, customer: String, expand: [String]?) -> EventLoopFuture<StripePaymentMethod> {
        var body: [String: Any] = ["customer": customer]
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(paymentmethods)/\(paymentMethod)/attach", body: .string(body.queryParameters), headers: headers)
    }
    
    public func detach(paymentMethod: String, expand: [String]?) -> EventLoopFuture<StripePaymentMethod> {
        var body: [String: Any] = [:]
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(paymentmethods)/\(paymentMethod)/detach", body: .string(body.queryParameters), headers: headers)
    }
}
