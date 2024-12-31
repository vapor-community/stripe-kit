//
//  SessionRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/4/19.
//

import NIO
import NIOHTTP1
import Foundation

public protocol SessionRoutes: Sendable {
    /// Creates a Session object.
    /// - Parameters:
    ///   - lineItems: A list of items the customer is purchasing. Use this parameter to pass one-time or recurring Prices. For payment mode, there is a maximum of 100 line items, however it is recommended to consolidate line items if there are more than a few dozen. For subscription mode, there is a maximum of 20 line items with recurring Prices and 20 line items with one-time Prices. Line items with one-time Prices will be on the initial invoice only.
    ///   - mode: The mode of the Checkout Session. Pass `subscription` if the Checkout Session includes at least one recurring item.
    ///   - successUrl: The URL to which Stripe should send customers when payment or setup is complete. If you’d like to use information from the successful Checkout Session on your page, read the guide on customizing your success page.
    ///   - cancelUrl: If set, Checkout displays a back button and customers will be directed to this URL if they decide to cancel payment and return to your website.
    ///   - clientReferenceId: A unique string to reference the Checkout Session. This can be a customer ID, a cart ID, or similar, and can be used to reconcile the session with your internal systems.
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - customer: ID of an existing Customer, if one exists. In `payment` mode, the customer’s most recent card payment method will be used to prefill the email, name, card details, and billing address on the Checkout page. In `subscription` mode, the customer’s default payment method will be used if it’s a card, and otherwise the most recent card will be used. A valid billing address, billing name and billing email are required on the payment method for Checkout to prefill the customer’s card details. If the Customer already has a valid email set, the email will be prefilled and not editable in Checkout. If the Customer does not have a valid `email`, Checkout will set the email entered during the session on the Customer. If blank for Checkout Sessions in `payment` or `subscription` mode, Checkout will create a new Customer object based on information provided during the payment flow. You can set `payment_intent_data.setup_future_usage` to have Checkout automatically attach the payment method to the Customer you pass in for future reuse.
    ///   - customerEmail: If provided, this value will be used when the Customer object is created. If not provided, customers will be asked to enter their email address. Use this parameter to prefill customer data if you already have an email on file. To access information about the customer once a session is complete, use the `customer` field.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - afterExpiration: Configure actions after a Checkout Session has expired.
    ///   - allowPromotionCodes: Enables user redeemable promotion codes.
    ///   - automaticTax: Settings for automatic tax lookup for this session and resulting payments, invoices, and subscriptions.
    ///   - billingAddressCollection: Specify whether Checkout should collect the customer’s billing address.
    ///   - consentCollection: Configure fields for the Checkout Session to gather active consent from customers.
    ///   - customFields: Collect additional information from your customer using custom fields. Up to 2 fields are supported.
    ///   - customText: Display additional text for your customers using custom text.
    ///   - customerCreation: Configure whether a Checkout Session creates a Customer during Session confirmation. When a Customer is not created, you can still retrieve email, address, and other customer data entered in Checkout with `customer_details`. Sessions that don’t create Customers instead are grouped by guest customers in the Dashboard. Promotion codes limited to first time customers will return invalid for these Sessions. Can only be set in `payment` and `setup` mode.
    ///   - customerUpdate: Controls what fields on Customer can be updated by the Checkout Session. Can only be provided when customer is provided.
    ///   - discounts: The coupon or promotion code to apply to this Session. Currently, only up to one may be specified.
    ///   - expiresAt: The Epoch time in seconds at which the Checkout Session will expire. It can be anywhere from 30 minutes to 24 hours after Checkout Session creation. By default, this value is 24 hours from creation.
    ///   - invoiceCreation: Generate a post-purchase Invoice for one-time payments.
    ///   - locale: The IETF language tag of the locale Checkout is displayed in. If blank or auto, the browser’s locale is used.
    ///   - paymentIntentData: A subset of parameters to be passed to PaymentIntent creation for Checkout Sessions in `payment` mode.
    ///   - paymentMethodCollection: Specify whether Checkout should collect a payment method. When set to `if_required`, Checkout will not collect a payment method when the total due for the session is 0. This may occur if the Checkout Session includes a free trial or a discount. Can only be set in `subscription` mode. If you’d like information on how to collect a payment method outside of Checkout, read the guide on configuring subscriptions with a free trial.
    ///   - paymentMethodOptions: Payment-method-specific configuration.
    ///   - paymentMethodTypes: A list of the types of payment methods (e.g., card) this Checkout Session can accept. In payment and subscription mode, you can omit this attribute to manage your payment methods from the Stripe Dashboard. It is required in setup mode. Read more about the supported payment methods and their requirements in our payment method details guide. If multiple payment methods are passed, Checkout will dynamically reorder them to prioritize the most relevant payment methods based on the customer’s location and other characteristics.
    ///   - phoneNumberCollection: Controls phone number collection settings for the session. We recommend that you review your privacy policy and check with your legal contacts before using this feature. Learn more about collecting phone numbers with Checkout.
    ///   - setupIntentData: A subset of parameters to be passed to SetupIntent creation for Checkout Sessions in setup mode.
    ///   - shippingAddressCollection: When set, provides configuration for Checkout to collect a shipping address from a customer.
    ///   - shippingOptions: The shipping rate options to apply to this Session.
    ///   - submitType: Describes the type of transaction being performed by Checkout in order to customize relevant text on the page, such as the submit button. `submit_type` can only be specified on Checkout Sessions in `payment` mode, but not Checkout Sessions in `subscription` or `setup` mode.
    ///   - subscriptionData: A subset of parameters to be passed to subscription creation for Checkout Sessions in subscription mode.
    ///   - taxIdCollection: Controls tax ID collection settings for the session.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns a Session object.
    func create(lineItems: [[String: Any]]?,
                mode: SessionMode,
                successUrl: String,
                cancelUrl: String?,
                clientReferenceId: String?,
                currency: Currency?,
                customer: String?,
                customerEmail: String?,
                metadata: [String: String]?,
                afterExpiration: [String: Any]?,
                allowPromotionCodes: Bool?,
                automaticTax: [String: Any]?,
                billingAddressCollection: SessionBillingAddressCollection?,
                consentCollection: [String: Any]?,
                customFields: [[String: Any]]?,
                customText: [String: Any]?,
                customerCreation: SessionCustomerCreation?,
                customerUpdate: [String: Any]?,
                discounts: [[String: Any]]?,
                expiresAt: Date?,
                invoiceCreation: [String: Any]?,
                locale: SessionLocale?,
                paymentIntentData: [String: Any]?,
                paymentMethodCollection: SessionPaymentMethodCollection?,
                paymentMethodOptions: [String: Any]?,
                paymentMethodTypes: [String]?,
                phoneNumberCollection: [String: Any]?,
                setupIntentData: [String: Any]?,
                shippingAddressCollection: [String: Any]?,
                shippingOptions: [[String: Any]]?,
                submitType: SessionSubmitType?,
                subscriptionData: [String: Any]?,
                taxIdCollection: [String: Any]?,
                expand: [String]?) async throws -> Session
    
    /// A Session can be expired when it is in one of these statuses: `open`
    ///
    /// After it expires, a customer can’t complete a Session and customers loading the Session see a message saying the Session is expired.
    /// - Parameters:
    ///   - id: The ID of the Checkout Session.
    ///   - expand: An aray of properties to expand.
    /// - Returns: Returns a Session object if the expiration succeeded. Returns an error if the Session has already expired or isn’t in an expireable state.
    func expire(id: String, expand: [String]?) async throws -> Session
    
    /// Retrieves a Session object.
    ///
    /// - Parameters:
    ///   - id: The ID of the Checkout Session.
    ///   - expand: An aray of properties to expand.
    /// - Returns: Returns a Session object
    func retrieve(id: String, expand: [String]?) async throws -> Session
    
    /// Returns a list of Checkout Sessions.
    /// - Parameter filter: A dictionary that will be used for the [query parameters.](https://stripe.com/docs/api/checkout/sessions/list)
    func listAll(filter: [String: Any]?) async throws -> SessionList
    
    /// When retrieving a Checkout Session, there is an includable **line_items** property containing the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.
    /// - Parameters:
    ///   - session: The ID of the checkout session
    ///   - filter: A dictionary that will be used for the [query parameters.](https://stripe.com/docs/api/checkout/sessions/line_items)
    func retrieveLineItems(session: String, filter: [String: Any]?) async throws -> SessionLineItemList
}


public struct StripeSessionRoutes: SessionRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let sessions = APIBase + APIVersion + "checkout/sessions"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(lineItems: [[String: Any]]? = nil,
                       mode: SessionMode,
                       successUrl: String,
                       cancelUrl: String? = nil,
                       clientReferenceId: String? = nil,
                       currency: Currency? = nil,
                       customer: String? = nil,
                       customerEmail: String? = nil,
                       metadata: [String: String]? = nil,
                       afterExpiration: [String: Any]? = nil,
                       allowPromotionCodes: Bool? = nil,
                       automaticTax: [String: Any]? = nil,
                       billingAddressCollection: SessionBillingAddressCollection? = nil,
                       consentCollection: [String: Any]? = nil,
                       customFields: [[String: Any]]? = nil,
                       customText: [String: Any]? = nil,
                       customerCreation: SessionCustomerCreation? = nil,
                       customerUpdate: [String: Any]? = nil,
                       discounts: [[String: Any]]? = nil,
                       expiresAt: Date? = nil,
                       invoiceCreation: [String: Any]? = nil,
                       locale: SessionLocale? = nil,
                       paymentIntentData: [String: Any]? = nil,
                       paymentMethodCollection: SessionPaymentMethodCollection? = nil,
                       paymentMethodOptions: [String: Any]? = nil,
                       paymentMethodTypes: [String]? = nil,
                       phoneNumberCollection: [String: Any]? = nil,
                       setupIntentData: [String: Any]? = nil,
                       shippingAddressCollection: [String: Any]? = nil,
                       shippingOptions: [[String: Any]]? = nil,
                       submitType: SessionSubmitType? = nil,
                       subscriptionData: [String: Any]? = nil,
                       taxIdCollection: [String: Any]? = nil,
                       expand: [String]? = nil) async throws -> Session {
        var body: [String: Any] = ["mode": mode.rawValue,
                                   "success_url": successUrl]
        if let lineItems {
            body["line_items"] = lineItems
        }
        
        if let cancelUrl {
            body["cancel_url"] = cancelUrl
        }
        
        if let clientReferenceId {
            body["client_reference_id"] = clientReferenceId
        }
        
        if let currency {
            body["currency"] = currency.rawValue
        }
        
        if let customer {
            body["customer"] = customer
        }
        
        if let customerEmail {
            body["customer_email"] = customerEmail
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let afterExpiration {
            afterExpiration.forEach { body["after_expiration[\($0)]"] = $1 }
        }
        
        if let allowPromotionCodes {
            body["allow_promotion_codes"] = allowPromotionCodes
        }
        
        if let automaticTax {
            automaticTax.forEach { body["automatic_tax[\($0)]"] = $1 }
        }
        
        if let billingAddressCollection {
            body["billing_address_collection"] = billingAddressCollection.rawValue
        }
        
        if let consentCollection {
            consentCollection.forEach { body["consent_collection[\($0)]"] = $1 }
        }
        
        if let customFields {
            body["custom_fields"] = customFields
        }
        
        if let customText {
            customText.forEach { body["custom_text[\($0)]"] = $1 }
        }
        
        if let customerCreation {
            body["customer_creation"] = customerCreation.rawValue
        }
        
        if let customerUpdate {
            customerUpdate.forEach { body["customer_update[\($0)]"] = $1 }
        }
        
        if let discounts {
            body["discounts"] = discounts
        }
        
        if let expiresAt {
            body["expires_at"] = Int(expiresAt.timeIntervalSince1970)
        }
        
        if let invoiceCreation {
            invoiceCreation.forEach { body["invoice_creation[\($0)]"] = $1 }
        }
        
        if let locale {
            body["locale"] = locale.rawValue
        }
        
        if let paymentIntentData {
            paymentIntentData.forEach { body["payment_intent_data[\($0)]"] = $1 }
        }
        
        if let paymentMethodCollection {
            body["payment_method_collection"] = paymentMethodCollection.rawValue
        }
        
        if let paymentMethodOptions {
            paymentMethodOptions.forEach { body["payment_method_options[\($0)]"] = $1 }
        }
        
        if let paymentMethodTypes {
            body["payment_method_types"] = paymentMethodTypes
        }
        
        if let phoneNumberCollection {
            phoneNumberCollection.forEach { body["phone_number_collection[\($0)]"] = $1 }
        }
        
        if let setupIntentData {
            setupIntentData.forEach { body["setup_intent_data[\($0)]"] = $1 }
        }
        
        if let shippingAddressCollection {
            shippingAddressCollection.forEach { body["shipping_address_collection[\($0)]"] = $1 }
        }
        
        if let shippingOptions {
            body["shipping_options"] = shippingOptions
        }
        
        if let submitType {
            body["submit_type"] = submitType.rawValue
        }
        
        if let subscriptionData {
            subscriptionData.forEach { body["subscription_data[\($0)]"] = $1 }
        }
        
        if let taxIdCollection {
            taxIdCollection.forEach { body["tax_id_collection[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: sessions, body: .string(body.queryParameters), headers: headers)
    }
    
    public func expire(id: String, expand: [String]? = nil) async throws -> Session {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .POST, path: "\(sessions)/\(id)/expire", query: queryParams, headers: headers)
    }
    
    public func retrieve(id: String, expand: [String]? = nil) async throws -> Session {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(sessions)/\(id)", query: queryParams, headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> SessionList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: sessions, query: queryParams, headers: headers)
    }
    
    public func retrieveLineItems(session: String, filter: [String: Any]?) async throws -> SessionLineItemList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(sessions)/\(session)/line_items", query: queryParams, headers: headers)
    }
}
