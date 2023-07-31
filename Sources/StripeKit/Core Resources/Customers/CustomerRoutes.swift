//
//  CustomerRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/20/17.
//
//

import NIO
import NIOHTTP1

public protocol CustomerRoutes: StripeAPIRoute {
    /// Creates a Customer
    /// - Parameters:
    ///   - address: The customer’s address.
    ///   - description: An arbitrary string that you can attach to a customer object. It is displayed alongside the customer in the dashboard.
    ///   - email: Customer’s email address. It’s displayed alongside the customer in your dashboard and can be useful for searching and tracking. This may be up to 512 characters.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - name: The customer’s full name or business name.
    ///   - paymentMethod: The ID of the PaymentMethod to attach to the customer.
    ///   - phone: The customer’s phone number.
    ///   - shipping: The customer’s shipping information. Appears on invoices emailed to this customer.
    ///   - balance: An integer amount in cents that represents the customer’s current balance, which affect the customer’s future invoices. A negative amount represents a credit that decreases the amount due on an invoice; a positive amount increases the amount due on an invoice.
    ///   - cashBalance: Balance information and default balance settings for this customer.
    ///   - coupon: If you provide a coupon code, the customer will have a discount applied on all recurring charges. Charges you create through the API will not have the discount.
    ///   - invoicePrefix: The prefix for the customer used to generate unique invoice numbers. Must be 3–12 uppercase letters or numbers.
    ///   - invoiceSettings: Default invoice settings for this customer.
    ///   - nextInvoiceSequence: The sequence to be used on the customer’s next invoice. Defaults to 1.
    ///   - preferredLocales: Customer’s preferred languages, ordered by preference.
    ///   - promotionCode: The API ID of a promotion code to apply to the customer. The customer will have a discount applied on all recurring payments. Charges you create through the API will not have the discount.
    ///   - source: When using payment sources created via the Token or Sources APIs, passing source will create a new source object, make it the new customer default source, and delete the old customer default if one exists. If you want to add additional sources instead of replacing the existing default, use the card creation API. Whenever you attach a card to a customer, Stripe will automatically validate the card.
    ///   - tax: Tax details about the customer.
    ///   - taxExempt: The customer’s tax exemption. One of none, exempt, or reverse.
    ///   - taxIdData: The customer’s tax IDs.
    ///   - testClock: ID of the test clock to attach to the customer.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns the customer object if the update succeeded. Returns an error if create parameters are invalid (e.g. specifying an invalid coupon or an invalid source).
    func create(address: [String: Any]?,
                description: String?,
                email: String?,
                metadata: [String: String]?,
                name: String?,
                paymentMethod: String?,
                phone: String?,
                shipping: [String: Any]?,
                balance: Int?,
                cashBalance: [String: Any]?,
                coupon: String?,
                invoicePrefix: String?,
                invoiceSettings: [String: Any]?,
                nextInvoiceSequence: Int?,
                preferredLocales: [String]?,
                promotionCode: String?,
                source: Any?,
                tax: [String: Any]?,
                taxExempt: CustomerTaxExempt?,
                taxIdData: [[String: Any]]?,
                testClock: String?,
                expand: [String]?) async throws -> Customer
    
    // TODO: - Investigate a deleted field on customer.
    /// Retrieves a Customer object.
    /// - Parameters:
    ///   - customer: The id of the customer
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns the Customer object for a valid identifier. If it’s for a deleted Customer, a subset of the customer’s information is returned, including a deleted property that’s set to true.
    func retrieve(customer: String, expand: [String]?) async throws -> Customer
    
    /// Updates the specified customer by setting the values of the parameters passed. Any parameters not provided will be left unchanged. For example, if you pass the `source` parameter, that becomes the customer’s active source (e.g., a card) to be used for all charges in the future. When you update a customer to a new valid card source by passing the `source` parameter: for each of the customer’s current subscriptions, if the subscription bills automatically and is in the `past_due` state, then the latest open invoice for the subscription with automatic collection enabled will be retried. This retry will not count as an automatic retry, and will not affect the next regularly scheduled payment for the invoice. Changing the `default_source` for a customer will not trigger this behavior.
    ///
    /// This request accepts mostly the same arguments as the customer creation call.
    ///
    /// - Parameters:
    ///   - customer: The id of the customer
    ///   - address: The customer’s address.
    ///   - description: An arbitrary string that you can attach to a customer object. It is displayed alongside the customer in the dashboard.
    ///   - email: Customer’s email address. It’s displayed alongside the customer in your dashboard and can be useful for searching and tracking. This may be up to 512 characters.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - name: The customer’s full name or business name.
    ///   - phone: The customer’s phone number.
    ///   - shipping: The customer’s shipping information. Appears on invoices emailed to this customer.
    ///   - balance: An integer amount in cents that represents the customer’s current balance, which affect the customer’s future invoices. A negative amount represents a credit that decreases the amount due on an invoice; a positive amount increases the amount due on an invoice.
    ///   - cashBalance: Balance information and default balance settings for this customer.
    ///   - coupon: If you provide a coupon code, the customer will have a discount applied on all recurring charges. Charges you create through the API will not have the discount.
    ///   - defaultSource: If you are using payment methods created via the PaymentMethods API, see the `invoice_settings.default_payment_method` parameter. Provide the ID of a payment source already attached to this customer to make it this customer’s default payment source. If you want to add a new payment source and make it the default, see the source property.
    ///   - invoicePrefix: The prefix for the customer used to generate unique invoice numbers. Must be 3–12 uppercase letters or numbers.
    ///   - invoiceSettings: Default invoice settings for this customer.
    ///   - nextInvoiceSequence: The sequence to be used on the customer’s next invoice. Defaults to 1.
    ///   - preferredLocales: Customer’s preferred languages, ordered by preference.
    ///   - promotionCode: The API ID of a promotion code to apply to the customer. The customer will have a discount applied on all recurring payments. Charges you create through the API will not have the discount.
    ///   - source: When using payment sources created via the Token or Sources APIs, passing source will create a new source object, make it the new customer default source, and delete the old customer default if one exists. If you want to add additional sources instead of replacing the existing default, use the card creation API. Whenever you attach a card to a customer, Stripe will automatically validate the card.
    ///   - tax: Tax details about the customer.
    ///   - taxExempt: The customer’s tax exemption. One of none, exempt, or reverse.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns the customer object if the update succeeded. Returns an error if create parameters are invalid (e.g. specifying an invalid coupon or an invalid source).
    func update(customer: String,
                address: [String: Any]?,
                description: String?,
                email: String?,
                metadata: [String: String]?,
                name: String?,
                phone: String?,
                shipping: [String: Any]?,
                balance: Int?,
                cashBalance: [String: Any]?,
                coupon: String?,
                defaultSource: String?,
                invoicePrefix: String?,
                invoiceSettings: [String: Any]?,
                nextInvoiceSequence: Int?,
                preferredLocales: [String]?,
                promotionCode: String?,
                source: Any?,
                tax: [String: Any]?,
                taxExempt: CustomerTaxExempt?,
                expand: [String]?) async throws -> Customer
    
    /// Permanently deletes a customer. It cannot be undone. Also immediately cancels any active subscriptions on the customer.
    /// - Parameter customer: The id of the customer to delete.
    /// - Returns: Returns an object with a deleted parameter on success. If the customer ID does not exist, this call returns an error.
    /// Unlike other objects, deleted customers can still be retrieved through the API, in order to be able to track the history of customers while still removing their credit card details and preventing any further operations to be performed (such as adding a new subscription).
    func delete(customer: String) async throws -> DeletedObject
    
    /// Returns a list of your customers. The customers are returned sorted by creation date, with the most recent customers appearing first.
    ///
    /// - Parameter filter: A [dictionary](https://stripe.com/docs/api/customers/list) that will be used for the query parameters.
    /// - Returns: A dictionary with a data property that contains an array of up to `limit` customers, starting after customer `starting_after`. Passing an optional `email` will result in filtering to customers with only that exact email address. Each entry in the array is a separate customer object. If no more customers are available, the resulting array will be empty. This request should never return an error.
    func listAll(filter: [String: Any]?) async throws -> CustomerList
    
    /// Search for customers you’ve previously created using Stripe’s Search Query Language. Don’t use search in read-after-write flows where strict consistency is necessary. Under normal operating conditions, data is searchable in less than a minute. Occasionally, propagation of new or updated data can be up to an hour behind during outages. Search functionality is not available to merchants in India.
    /// - Parameters:
    ///   - query: The search query string. See search query language and the list of supported query fields for customers.
    ///   - limit: A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
    ///   - page: A cursor for pagination across multiple pages of results. Don’t include this parameter on the first call. Use the `next_page` value returned in a previous response to request subsequent results.
    ///   - expand: An array of properties to expand.
    /// - Returns: A dictionary with a data property that contains an array of up to limit customers. If no objects match the query, the resulting array will be empty. See the related guide on expanding properties in lists.
    func search(query: String, limit: Int?, page: String?, expand: [String]?) async throws -> CustomerSearchResult
}

public struct StripeCustomerRoutes: CustomerRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let customers = APIBase + APIVersion + "customers"
    private let customer = APIBase + APIVersion + "customers/"
    private let search = APIBase + APIVersion + "customers/search"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(address: [String: Any]? = nil,
                       description: String? = nil,
                       email: String? = nil,
                       metadata: [String: String]? = nil,
                       name: String? = nil,
                       paymentMethod: String? = nil,
                       phone: String? = nil,
                       shipping: [String: Any]? = nil,
                       balance: Int? = nil,
                       cashBalance: [String: Any]? = nil,
                       coupon: String? = nil,
                       invoicePrefix: String? = nil,
                       invoiceSettings: [String: Any]? = nil,
                       nextInvoiceSequence: Int? = nil,
                       preferredLocales: [String]? = nil,
                       promotionCode: String? = nil,
                       source: Any? = nil,
                       tax: [String: Any]? = nil,
                       taxExempt: CustomerTaxExempt? = nil,
                       taxIdData: [[String: Any]]? = nil,
                       testClock: String? = nil,
                       expand: [String]? = nil) async throws -> Customer {
        var body: [String: Any] = [:]
        
        if let address {
            address.forEach { body["address[\($0)]"] = $1 }
        }
        
        if let description {
            body["description"] = description
        }
        
        if let email {
            body["email"] = email
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let name {
            body["name"] = name
        }
        
        if let paymentMethod {
            body["payment_method"] = paymentMethod
        }
        
        if let phone {
            body["phone"] = phone
        }
        
        if let shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let balance {
            body["balance"] = balance
        }
        
        if let cashBalance {
            cashBalance.forEach { body["cash_balance[\($0)]"] = $1 }
        }
        
        if let coupon {
            body["coupon"] = coupon
        }
        
        if let invoicePrefix {
            body["invoice_prefix"] = invoicePrefix
        }
        
        if let invoiceSettings {
            invoiceSettings.forEach { body["invoice_settings[\($0)]"] = $1 }
        }
        
        if let nextInvoiceSequence {
            body["next_invoice_sequence"] = nextInvoiceSequence
        }
        
        if let preferredLocales {
            body["preferred_locales"] = preferredLocales
        }
        
        if let promotionCode {
            body["promotion_code"] = promotionCode
        }
        
        if let stringSource = source as? String {
            body["source"] = stringSource
        }
        
        if let hashSource = source as? [String: Any] {
            hashSource.forEach { body["source[\($0)]"] = $1 }
        }
        
        if let tax {
            tax.forEach { body["tax[\($0)]"] = $1 }
        }
        
        if let taxExempt {
            body["tax_exempt"] = taxExempt.rawValue
        }
        
        if let taxIdData {
            body["tax_id_data"] = taxIdData
        }
        
        if let testClock {
            body["test_clock"] = testClock
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: customers, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(customer: String, expand: [String]? = nil) async throws -> Customer {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: self.customer + customer, query: queryParams, headers: headers)
    }
    
    public func update(customer: String,
                       address: [String: Any]? = nil,
                       description: String? = nil,
                       email: String? = nil,
                       metadata: [String: String]? = nil,
                       name: String? = nil,
                       phone: String? = nil,
                       shipping: [String: Any]? = nil,
                       balance: Int? = nil,
                       cashBalance: [String: Any]? = nil,
                       coupon: String? = nil,
                       defaultSource: String? = nil,
                       invoicePrefix: String? = nil,
                       invoiceSettings: [String: Any]? = nil,
                       nextInvoiceSequence: Int? = nil,
                       preferredLocales: [String]? = nil,
                       promotionCode: String? = nil,
                       source: Any? = nil,
                       tax: [String: Any]? = nil,
                       taxExempt: CustomerTaxExempt? = nil,
                       expand: [String]? = nil) async throws -> Customer {
        var body: [String: Any] = [:]
        
        if let address {
            address.forEach { body["address[\($0)]"] = $1 }
        }
        
        if let description {
            body["description"] = description
        }
        
        if let email {
            body["email"] = email
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let name {
            body["name"] = name
        }
        
        if let phone {
            body["phone"] = phone
        }
        
        if let shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let balance {
            body["balance"] = balance
        }
        
        if let cashBalance {
            cashBalance.forEach { body["cash_balance[\($0)]"] = $1 }
        }
        
        if let coupon {
            body["coupon"] = coupon
        }
        
        if let defaultSource {
            body["default_source"] = defaultSource
        }
        
        if let invoicePrefix {
            body["invoice_prefix"] = invoicePrefix
        }
        
        if let invoiceSettings {
            invoiceSettings.forEach { body["invoice_settings[\($0)]"] = $1 }
        }
        
        if let nextInvoiceSequence {
            body["next_invoice_sequence"] = nextInvoiceSequence
        }
        
        if let preferredLocales {
            body["preferred_locales"] = preferredLocales
        }
        
        if let promotionCode {
            body["promotion_code"] = promotionCode
        }
        
        if let stringSource = source as? String {
            body["source"] = stringSource
        }
        
        if let hashSource = source as? [String: Any] {
            hashSource.forEach { body["source[\($0)]"] = $1 }
        }
        
        if let tax {
            tax.forEach { body["tax[\($0)]"] = $1 }
        }
        
        if let taxExempt {
            body["tax_exempt"] = taxExempt.rawValue
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: self.customer + customer, body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(customer: String) async throws -> DeletedObject {
        try await apiHandler.send(method: .DELETE, path: self.customer + customer, headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) async throws -> CustomerList {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }

        return try await apiHandler.send(method: .GET, path: customers, query: queryParams, headers: headers)
    }
    
    public func search(query: String,
                       limit: Int? = nil,
                       page: String? = nil,
                       expand: [String]? = nil) async throws -> CustomerSearchResult {
        var queryParams: [String: Any] = ["query": query]
        if let limit {
            queryParams["limit"] = limit
        }
        
        if let page {
            queryParams["page"] = page
        }
        
        return try await apiHandler.send(method: .GET, path: search, query: queryParams.queryParameters, headers: headers)
    }
}
