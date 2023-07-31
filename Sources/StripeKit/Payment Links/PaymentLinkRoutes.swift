//
//  PaymentLinkRoutes.swift
//  
//
//  Created by Andrew Edwards on 5/7/23.
//

import NIO
import NIOHTTP1
import Foundation

public protocol PaymentLinkRoutes: StripeAPIRoute {
    /// Creates a Session object.
    /// - Parameters:
    ///   - lineItems: The line items representing what is being sold. Each line item represents an item being sold. Up to 20 line items are supported.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - afterCompletion: Behavior after the purchase is complete.
    ///   - allowPromotionCodes: Enables user redeemable promotion codes
    ///   - applicationFeeAmount: The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the application owner’s Stripe account. Can only be applied when there are no line items with recurring prices.
    ///   - applicationFeePercent: A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the application owner’s Stripe account. There must be at least 1 line item with a recurring price to use this field.
    ///   - automaticTax: Settings for automatic tax lookup for this session and resulting payments, invoices, and subscriptions.
    ///   - billingAddressCollection: Specify whether Checkout should collect the customer’s billing address.
    ///   - consentCollection: Configure fields for the Checkout Session to gather active consent from customers.
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - customFields: Collect additional information from your customer using custom fields. Up to 2 fields are supported.
    ///   - customText: Display additional text for your customers using custom text.
    ///   - customerCreation: Configure whether a Checkout Session creates a Customer during Session confirmation. When a Customer is not created, you can still retrieve email, address, and other customer data entered in Checkout with `customer_details`. Sessions that don’t create Customers instead are grouped by guest customers in the Dashboard. Promotion codes limited to first time customers will return invalid for these Sessions. Can only be set in `payment` and `setup` mode.
    ///   - invoiceCreation: Generate a post-purchase Invoice for one-time payments.
    ///   - onBehalfOf: The account on behalf of which to charge.
    ///   - paymentIntentData: A subset of parameters to be passed to PaymentIntent creation for Checkout Sessions in `payment` mode.
    ///   - paymentMethodCollection: Specify whether Checkout should collect a payment method. When set to `if_required`, Checkout will not collect a payment method when the total due for the session is 0. This may occur if the Checkout Session includes a free trial or a discount. Can only be set in `subscription` mode. If you’d like information on how to collect a payment method outside of Checkout, read the guide on configuring subscriptions with a free trial.
    ///   - paymentMethodTypes: A list of the types of payment methods (e.g., card) this Checkout Session can accept. In payment and subscription mode, you can omit this attribute to manage your payment methods from the Stripe Dashboard. It is required in setup mode. Read more about the supported payment methods and their requirements in our payment method details guide. If multiple payment methods are passed, Checkout will dynamically reorder them to prioritize the most relevant payment methods based on the customer’s location and other characteristics.
    ///   - phoneNumberCollection: Controls phone number collection settings for the session. We recommend that you review your privacy policy and check with your legal contacts before using this feature. Learn more about collecting phone numbers with Checkout.
    ///   - shippingAddressCollection: When set, provides configuration for Checkout to collect a shipping address from a customer.
    ///   - shippingOptions: The shipping rate options to apply to this Session.
    ///   - submitType: Describes the type of transaction being performed by Checkout in order to customize relevant text on the page, such as the submit button. `submit_type` can only be specified on Checkout Sessions in `payment` mode, but not Checkout Sessions in `subscription` or `setup` mode.
    ///   - subscriptionData: A subset of parameters to be passed to subscription creation for Checkout Sessions in subscription mode.
    ///   - taxIdCollection: Controls tax ID collection settings for the session.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns a Session object.
    func create(lineItems: [[String: Any]]?,
                metadata: [String: String]?,
                afterCompletion: [String: Any]?,
                allowPromotionCodes: Bool?,
                applicationFeeAmount: Int?,
                applicationFeePercent: Decimal?,
                automaticTax: [String: Any]?,
                billingAddressCollection: PaymentLinkBillingAddressCollection?,
                consentCollection: [String: Any]?,
                currency: Currency?,
                customFields: [[String: Any]]?,
                customText: [String: Any]?,
                customerCreation: PaymentLinkCustomerCreation?,                
                invoiceCreation: [String: Any]?,
                onBehalfOf: String?,
                paymentIntentData: [String: Any]?,
                paymentMethodCollection: PaymentLinkPaymentMethodCollection?,
                paymentMethodTypes: [String]?,
                phoneNumberCollection: [String: Any]?,
                shippingAddressCollection: [String: Any]?,
                shippingOptions: [[String: Any]]?,
                submitType: PaymentLinkSubmitType?,
                subscriptionData: [String: Any]?,
                taxIdCollection: [String: Any]?,
                expand: [String]?) async throws -> PaymentLink
    
    /// Retrieve a payment link.
    /// - Parameters:
    ///   - id: The id of the payment link.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns the payment link.
    func retrieve(id: String, expand: [String]?) async throws -> PaymentLink
    
    /// Updates a payment link.
    /// - Parameters:
    ///   - id: The id of the payment link to update.
    ///   - active: Whether the payment link’s `url` is active. If `false`, customers visiting the URL will be shown a page saying that the link has been deactivated.
    ///   - lineItems: The line items representing what is being sold. Each line item represents an item being sold. Up to 20 line items are supported.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata. Metadata associated with this Payment Link will automatically be copied to checkout sessions created by this payment link.
    ///   - afterCompletion: Behavior after the purchase is complete.
    ///   - allowPromotionCodes: Enables user redeemable promotion codes.
    ///   - automaticTax: Configuration for automatic tax collection.
    ///   - billingAddressCollection: Configuration for collecting the customer’s billing address.
    ///   - customFields: Collect additional information from your customer using custom fields. Up to 2 fields are supported.
    ///   - customText: Display additional text for your customers using custom text.
    ///   - customerCreation: Configures whether checkout sessions created by this payment link create a Customer.
    ///   - invoiceCreation: Generate a post-purchase Invoice for one-time payments.
    ///   - paymentMethodCollection: Specify whether Checkout should collect a payment method. When set to `if_required`, Checkout will not collect a payment method when the total due for the session is 0.This may occur if the Checkout Session includes a free trial or a discount. Can only be set in `subscription` mode. If you’d like information on how to collect a payment method outside of Checkout, read the guide on [configuring subscriptions with a free trial](https://stripe.com/docs/payments/checkout/free-trials) .
    ///   - paymentMethodTypes: The list of payment method types that customers can use. Pass an empty string to enable automatic payment methods that use your [payment method settings](https://dashboard.stripe.com/settings/payment_methods) .
    ///   - shippingAddressCollection: Configuration for collecting the customer’s shipping address.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Updated payment link.
    func update(id: String,
                active: Bool?,
                lineItems: [[String: Any]]?,
                metadata: [String: String]?,
                afterCompletion: [String: Any]?,
                allowPromotionCodes: Bool?,
                automaticTax: [String: Any]?,
                billingAddressCollection: PaymentLinkBillingAddressCollection?,
                customFields: [[String: Any]]?,
                customText: [String: Any]?,
                customerCreation: PaymentLinkCustomerCreation?,
                invoiceCreation: [String: Any]?,
                paymentMethodCollection: PaymentLinkPaymentMethodCollection?,
                paymentMethodTypes: [String]?,
                shippingAddressCollection: [String: Any]?,
                expand: [String]?) async throws -> PaymentLink
    
    /// Returns a list of your payment links.
    /// - Parameter filter: A dictionary for filter values.
    /// - Returns: A dictionary with a data property that contains an array of up to limit payment links, starting after payment link `starting_after`. Each entry in the array is a separate payment link object. If no more payment links are available, the resulting array will be empty. This request should never return an error.
    func listAll(filter: [String: Any]?) async throws -> PaymentLinkList
    
    /// When retrieving a payment link, there is an includable **line_items** property containing the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.
    /// - Parameters:
    ///   - id: Id of the payment link.
    ///   - filter: A dictionary for filter values.
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` payment link line items, starting after Line Item `starting_after`. Each entry in the array is a separate Line Item object. If no more line items are available, the resulting array will be empty.
    func retrieveLineItems(id: String, filter: [String: Any]?) async throws -> PaymentLinkLineItemList
}

public struct StripePaymentLinkRoutes: PaymentLinkRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let paymentlinks = APIBase + APIVersion + "payment_links"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func create(lineItems: [[String : Any]]? = nil,
                       metadata: [String : String]? = nil,
                       afterCompletion: [String : Any]? = nil,
                       allowPromotionCodes: Bool? = nil,
                       applicationFeeAmount: Int? = nil,
                       applicationFeePercent: Decimal? = nil,
                       automaticTax: [String : Any]? = nil,
                       billingAddressCollection: PaymentLinkBillingAddressCollection? = nil,
                       consentCollection: [String : Any]? = nil,
                       currency: Currency? = nil,
                       customFields: [[String : Any]]? = nil,
                       customText: [String : Any]? = nil,
                       customerCreation: PaymentLinkCustomerCreation? = nil,
                       invoiceCreation: [String : Any]? = nil,
                       onBehalfOf: String? = nil,
                       paymentIntentData: [String : Any]? = nil,
                       paymentMethodCollection: PaymentLinkPaymentMethodCollection? = nil,
                       paymentMethodTypes: [String]? = nil,
                       phoneNumberCollection: [String : Any]? = nil,
                       shippingAddressCollection: [String : Any]? = nil,
                       shippingOptions: [[String : Any]]? = nil,
                       submitType: PaymentLinkSubmitType? = nil,
                       subscriptionData: [String : Any]? = nil,
                       taxIdCollection: [String : Any]? = nil,
                       expand: [String]? = nil) async throws -> PaymentLink {
        var body: [String: Any] = [:]
        
        if let lineItems {
            body["line_items"] = lineItems
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let afterCompletion {
            afterCompletion.forEach { body["after_completion[\($0)]"] = $1 }
        }
        
        if let allowPromotionCodes {
            body["allow_promotion_codes"] = allowPromotionCodes
        }
        
        if let applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }
        
        if let applicationFeePercent {
            body["application_fee_percent"] = applicationFeePercent
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
        
        if let currency {
            body["currency"] = currency.rawValue
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
        
        if let invoiceCreation {
            invoiceCreation.forEach { body["invoice_creation[\($0)]"] = $1 }
        }
        
        if let onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }
        
        if let paymentIntentData {
            paymentIntentData.forEach { body["payment_intent_data[\($0)]"] = $1 }
        }
        
        if let paymentMethodCollection {
            body["payment_method_collection"] = paymentMethodCollection.rawValue
        }
        
        if let paymentMethodTypes {
            body["payment_method_types"] = paymentMethodTypes
        }
        
        if let phoneNumberCollection {
            phoneNumberCollection.forEach { body["phone_number_collection[\($0)]"] = $1 }
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
        
        return try await apiHandler.send(method: .POST, path: paymentlinks, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(id: String, expand: [String]? = nil) async throws -> PaymentLink {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(paymentlinks)/\(id)", query: queryParams, headers: headers)
    }
    
    public func update(id: String,
                       active: Bool? = nil,
                       lineItems: [[String : Any]]? = nil,
                       metadata: [String : String]? = nil,
                       afterCompletion: [String : Any]? = nil,
                       allowPromotionCodes: Bool? = nil,
                       automaticTax: [String : Any]? = nil,
                       billingAddressCollection: PaymentLinkBillingAddressCollection? = nil,
                       customFields: [[String : Any]]? = nil,
                       customText: [String : Any]? = nil,
                       customerCreation: PaymentLinkCustomerCreation? = nil,
                       invoiceCreation: [String : Any]? = nil,
                       paymentMethodCollection: PaymentLinkPaymentMethodCollection? = nil,
                       paymentMethodTypes: [String]? = nil,
                       shippingAddressCollection: [String : Any]? = nil,
                       expand: [String]? = nil) async throws -> PaymentLink {
        var body: [String: Any] = [:]
        
        if let active {
            body["active"] = active
        }
        
        if let lineItems {
            body["line_items"] = lineItems
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let afterCompletion {
            afterCompletion.forEach { body["after_completion[\($0)]"] = $1 }
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
                
        if let customFields {
            body["custom_fields"] = customFields
        }
        
        if let customText {
            customText.forEach { body["custom_text[\($0)]"] = $1 }
        }
        
        if let customerCreation {
            body["customer_creation"] = customerCreation.rawValue
        }
        
        if let invoiceCreation {
            invoiceCreation.forEach { body["invoice_creation[\($0)]"] = $1 }
        }
                
        if let paymentMethodCollection {
            body["payment_method_collection"] = paymentMethodCollection.rawValue
        }
        
        if let paymentMethodTypes {
            body["payment_method_types"] = paymentMethodTypes
        }
                
        if let shippingAddressCollection {
            shippingAddressCollection.forEach { body["shipping_address_collection[\($0)]"] = $1 }
        }
                        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(paymentlinks)/\(id)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String : Any]? = nil) async throws -> PaymentLinkList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: paymentlinks, query: queryParams, headers: headers)
    }
    
    public func retrieveLineItems(id: String, filter: [String: Any]? = nil) async throws -> PaymentLinkLineItemList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(paymentlinks)/\(id)/line_items", query: queryParams, headers: headers)
    }
}
