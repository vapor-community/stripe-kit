//
//  SessionRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/4/19.
//

import NIO
import NIOHTTP1

public protocol SessionRoutes {
    /// Creates a Session object.
    ///
    /// - Parameters:
    ///   - cancelUrl: The URL the customer will be directed to if they decide to cancel payment and return to your website.
    ///   - paymentMethodTypes: A list of the types of payment methods (e.g. card) this Checkout Session is allowed to accept. The only supported value today is `card`.
    ///   - successUrl: The URL the customer will be directed to after the payment or subscription creation is successful.
    ///   - billingAddressCollection: Specify whether Checkout should collect the customer’s billing address. If set to `required`, Checkout will always collect the customer’s billing address. If left blank or set to `auto` Checkout will only collect the billing address when necessary.
    ///   - clientReferenceId: A unique string to reference the Checkout Session. This can be a customer ID, a cart ID, or similar, and can be used to reconcile the session with your internal systems.
    ///   - customer: ID of an existing customer paying for this session, if one exists. May only be used with line_items. Usage with subscription_data is not yet available. If blank, Checkout will create a new customer object based on information provided during the session. The email stored on the customer will be used to prefill the email field on the Checkout page. If the customer changes their email on the Checkout page, the Customer object will be updated with the new email.
    ///   - customerEmail: If provided, this value will be used when the Customer object is created. If not provided, customers will be asked to enter their email address. Use this parameter to prefill customer data if you already have an email on file. To access information about the customer once a session is complete, use the customer field.
    ///   - lineItems: A list of items the customer is purchasing. Use this parameter for one-time payments. To create subscriptions, use subscription_data.items.
    ///   - locale: The IETF language tag of the locale Checkout is displayed in. If blank or auto, the browser’s locale is used. Supported values are auto, da, de, en, es, fi, fr, it, ja, nb, nl, pl, pt, sv, or zh.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - mode: The mode of the Checkout Session, one of `payment`, `setup`, or `subscription`.
    ///   - paymentIntentData: A subset of parameters to be passed to PaymentIntent creation.
    ///   - setupIntentData: A subset of parameters to be passed to SetupIntent creation for Checkout Sessions in `setup` mode.
    ///   - submitType: Describes the type of transaction being performed by Checkout in order to customize relevant text on the page, such as the submit button. submit_type can only be specified on Checkout Sessions in payment mode, but not Checkout Sessions in subscription or setup mode. Supported values are `auto`, `book`, `donate`, or `pay`.
    ///   - subscriptionData: A subset of parameters to be passed to subscription creation.
    /// - Returns: A `StripeSession`.
    func create(cancelUrl: String,
                paymentMethodTypes: [StripePaymentMethodType],
                successUrl: String,
                billingAddressCollection: StripeSessionBillingAddressCollection?,
                clientReferenceId: String?,
                customer: String?,
                customerEmail: String?,
                lineItems: [String: Any]?,
                locale: StripeSessionLocale?,
                metadata: [String: String]?,
                mode: StripeSessionMode?,
                paymentIntentData: [String: Any]?,
                setupIntentData: [String: Any]?,
                submitType: StripeSessionSubmitType?,
                subscriptionData: [String: Any]?) -> EventLoopFuture<StripeSession>
    
    /// Retrieves a Session object.
    ///
    /// - Parameter id: The ID of the Checkout Session.
    /// - Returns: A `StripeSession`.
    func retrieve(id: String) -> EventLoopFuture<StripeSession>
    
    /// Returns a list of Checkout Sessions.
    /// - Parameter filter: A dictionary that will be used for the [query parameters.](https://stripe.com/docs/api/checkout/sessions/list?lang=curl)
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeSessionList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension SessionRoutes {
    public func create(cancelUrl: String,
                       paymentMethodTypes: [StripePaymentMethodType],
                       successUrl: String,
                       billingAddressCollection: StripeSessionBillingAddressCollection? = nil,
                       clientReferenceId: String? = nil,
                       customer: String? = nil,
                       customerEmail: String? = nil,
                       lineItems: [String: Any]? = nil,
                       locale: StripeSessionLocale? = nil,
                       metadata: [String: String]? = nil,
                       mode: StripeSessionMode? = nil,
                       paymentIntentData: [String: Any]? = nil,
                       setupIntentData: [String: Any]? = nil,
                       submitType: StripeSessionSubmitType? = nil,
                       subscriptionData: [String: Any]? = nil) -> EventLoopFuture<StripeSession> {
        return create(cancelUrl: cancelUrl,
                      paymentMethodTypes: paymentMethodTypes,
                      successUrl: successUrl,
                      billingAddressCollection: billingAddressCollection,
                      clientReferenceId: clientReferenceId,
                      customer: customer,
                      customerEmail: customerEmail,
                      lineItems: lineItems,
                      locale: locale,
                      metadata: metadata,
                      mode: mode,
                      paymentIntentData: paymentIntentData,
                      setupIntentData: setupIntentData,
                      submitType: submitType,
                      subscriptionData: subscriptionData)
    }
    
    public func retrieve(id: String) -> EventLoopFuture<StripeSession> {
        return retrieve(id: id)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeSessionList> {
        listAll(filter: filter)
    }
}

public struct StripeSessionRoutes: SessionRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let sessions = APIBase + APIVersion + "checkout/sessions"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(cancelUrl: String,
                       paymentMethodTypes: [StripePaymentMethodType],
                       successUrl: String,
                       billingAddressCollection: StripeSessionBillingAddressCollection?,
                       clientReferenceId: String?,
                       customer: String?,
                       customerEmail: String?,
                       lineItems: [String: Any]?,
                       locale: StripeSessionLocale?,
                       metadata: [String: String]?,
                       mode: StripeSessionMode?,
                       paymentIntentData: [String: Any]?,
                       setupIntentData: [String: Any]?,
                       submitType: StripeSessionSubmitType?,
                       subscriptionData: [String: Any]?) -> EventLoopFuture<StripeSession> {
        var body: [String: Any] = ["cancel_url": cancelUrl,
                                   "payment_method_types": paymentMethodTypes.map { $0.rawValue },
                                   "success_url": successUrl]
        
        if let billingAddressCollection = billingAddressCollection {
            body["billing_address_collection"] = billingAddressCollection.rawValue
        }
        
        if let clientReferenceId = clientReferenceId {
            body["client_reference_id"] = clientReferenceId
        }
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let customerEmail = customerEmail {
            body["customer_email"] = customerEmail
        }
        
        if let lineItems = lineItems {
            lineItems.forEach { body["line_items[\($0)]"] = $1 }
        }
        
        if let locale = locale {
            body["locale"] = locale.rawValue
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let mode = mode {
            body["mode"] = mode
        }
        
        if let paymentIntentData = paymentIntentData {
            paymentIntentData.forEach { body["payment_intent_data[\($0)]"] = $1 }
        }
        
        if let setupIntentData = setupIntentData {
            setupIntentData.forEach { body["setup_intent_data[\($0)]"] = $1 }
        }
        
        if let submitType = submitType {
            body["submit_type"] = submitType
        }
        
        if let subscriptionData = subscriptionData {
            subscriptionData.forEach { body["subscription_data[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: sessions, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(id: String) -> EventLoopFuture<StripeSession> {
        return apiHandler.send(method: .GET, path: "\(sessions)/\(id)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeSessionList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: sessions, query: queryParams, headers: headers)
    }
}
