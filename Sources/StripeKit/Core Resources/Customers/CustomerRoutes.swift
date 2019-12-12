//
//  CustomerRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/20/17.
//
//

import NIO
import NIOHTTP1

public protocol CustomerRoutes {
    /// Creates a new customer object.
    ///
    /// - Parameters:
    ///   - address: The customer’s address.
    ///   - balance: An integer amount that represents the account balance for your customer. Account balances only affect invoices. A negative amount represents a credit that decreases the amount due on an invoice; a positive amount increases the amount due on an invoice.
    ///   - coupon: The code of the coupon to apply to this subscription. A coupon applied to a subscription will only affect invoices created for that particular subscription. This will be unset if you POST an empty value.
    ///   - description: An arbitrary string that you can attach to a customer object. It is displayed alongside the customer in the dashboard. This will be unset if you POST an empty value.
    ///   - email: Customer’s email address. It’s displayed alongside the customer in your dashboard and can be useful for searching and tracking. This may be up to 512 characters. This will be unset if you POST an empty value.
    ///   - invoicePrefix: The prefix for the customer used to generate unique invoice numbers. Must be 3–12 uppercase letters or numbers.
    ///   - invoiceSettings: Default invoice settings for this customer.
    ///   - metadata: A set of key-value pairs that you can attach to a customer object. It can be useful for storing additional information about the customer in a structured format.
    ///   - name: The customer’s full name or business name.
    ///   - paymentMethod: ID of the PaymentMethod to attach to the customer
    ///   - phone: The customer’s phone number.
    ///   - preferredLocales: Customer’s preferred languages, ordered by preference.
    ///   - shipping: The customer’s shipping information. Appears on invoices emailed to this customer.
    ///   - source: The source can be a Token or a Source, as returned by Elements. You must provide a source if the customer does not already have a valid source attached, and you are subscribing the customer to be charged automatically for a plan that is not free. \n Passing source will create a new source object, make it the customer default source, and delete the old customer default if one exists. If you want to add an additional source, instead use the card creation API to add the card and then the customer update API to set it as the default. \n Whenever you attach a card to a customer, Stripe will automatically validate the card.
    ///   - taxExempt: The customer’s tax exemption. One of none, exempt, or reverse.
    ///   - taxIdData: The customer’s tax IDs.
    /// - Returns: A `StripeCustomer`.
    func create(address: [String: Any]?,
                balance: Int?,
                coupon: String?,
                description: String?,
                email: String?,
                invoicePrefix: String?,
                invoiceSettings: [String: Any]?,
                metadata: [String: String]?,
                name: String?,
                paymentMethod: String?,
                phone: String?,
                preferredLocales: [String]?,
                shipping: [String: Any]?,
                source: Any?,
                taxExempt: StripeCustomerTaxExempt?,
                taxIdData: [[String: Any]]?) -> EventLoopFuture<StripeCustomer>
    
    
    /// Retrieves the details of an existing customer. You need only supply the unique customer identifier that was returned upon customer creation.
    ///
    /// - Parameter customer: The identifier of the customer to be retrieved.
    /// - Returns: A `StripeCustomer`.
    func retrieve(customer: String,
                  expand: [String]?) -> EventLoopFuture<StripeCustomer>
    
    /// Updates the specified customer by setting the values of the parameters passed. Any parameters not provided will be left unchanged. For example, if you pass the source parameter, that becomes the customer’s active source (e.g., a card) to be used for all charges in the future. When you update a customer to a new valid card source by passing the source parameter: for each of the customer’s current subscriptions, if the subscription bills automatically and is in the `past_due` state, then the latest open invoice for the subscription with automatic collection enabled will be retried. This retry will not count as an automatic retry, and will not affect the next regularly scheduled payment for the invoice. Changing the default_source for a customer will not trigger this behavior. \n This request accepts mostly the same arguments as the customer creation call.
    ///
    /// - Parameters:
    ///   - customer: The identifier of the customer to be updated.
    ///   - address: The customer’s address.
    ///   - balance: An integer amount that represents the account balance for your customer. Account balances only affect invoices. A negative amount represents a credit that decreases the amount due on an invoice; a positive amount increases the amount due on an invoice.
    ///   - coupon: The code of the coupon to apply to this subscription. A coupon applied to a subscription will only affect invoices created for that particular subscription. This will be unset if you POST an empty value.
    ///   - defaultSource: ID of the default payment source for the customer.
    ///   - description: An arbitrary string that you can attach to a customer object. It is displayed alongside the customer in the dashboard. This will be unset if you POST an empty value.
    ///   - email: Customer’s email address. It’s displayed alongside the customer in your dashboard and can be useful for searching and tracking. This may be up to 512 characters. This will be unset if you POST an empty value.
    ///   - invoicePrefix: The prefix for the customer used to generate unique invoice numbers. Must be 3–12 uppercase letters or numbers.
    ///   - invoiceSettings: Default invoice settings for this customer.
    ///   - metadata: A set of key-value pairs that you can attach to a customer object. It can be useful for storing additional information about the customer in a structured format.
    ///   - name: The customer’s full name or business name.
    ///   - phone: The customer’s phone number.
    ///   - preferredLocales: Customer’s preferred languages, ordered by preference.
    ///   - shipping: The customer’s shipping information. Appears on invoices emailed to this customer.
    ///   - source: The source can be a Token or a Source, as returned by Elements. You must provide a source if the customer does not already have a valid source attached, and you are subscribing the customer to be charged automatically for a plan that is not free. \n Passing source will create a new source object, make it the customer default source, and delete the old customer default if one exists. If you want to add an additional source, instead use the card creation API to add the card and then the customer update API to set it as the default. \n Whenever you attach a card to a customer, Stripe will automatically validate the card.
    ///   - taxExempt: The customer’s tax exemption. One of none, exempt, or reverse.
    /// - Returns: A `StripeCustomer`.
    func update(customer: String,
                address: [String: Any]?,
                balance: Int?,
                coupon: String?,
                defaultSource: String?,
                description: String?,
                email: String?,
                invoicePrefix: String?,
                invoiceSettings: [String: Any]?,
                metadata: [String: String]?,
                name: String?,
                phone: String?,
                preferredLocales: [String]?,
                shipping: [String: Any]?,
                source: Any?,
                taxExempt: StripeCustomerTaxExempt?) -> EventLoopFuture<StripeCustomer>
    
    
    /// Permanently deletes a customer. It cannot be undone. Also immediately cancels any active subscriptions on the customer.
    ///
    /// - Parameter customer: The identifier of the customer to be deleted.
    /// - Returns: A `StripeDeletedObject`.
    func delete(customer: String) -> EventLoopFuture<StripeDeletedObject>
    
    /// Returns a list of your customers. The customers are returned sorted by creation date, with the most recent customers appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/customers/list).
    /// - Returns: A `StripeCustomerList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeCustomerList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension CustomerRoutes {
    public func create(address: [String: Any]? = nil,
                       balance: Int? = nil,
                       coupon: String? = nil,
                       description: String? = nil,
                       email: String? = nil,
                       invoicePrefix: String? = nil,
                       invoiceSettings: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       name: String? = nil,
                       paymentMethod: String? = nil,
                       phone: String? = nil,
                       preferredLocales: [String]? = nil,
                       shipping: [String: Any]? = nil,
                       source: Any? = nil,
                       taxExempt: StripeCustomerTaxExempt? = nil,
                       taxIdData: [[String: Any]]? = nil) -> EventLoopFuture<StripeCustomer> {
        return create(address: address,
                      balance: balance,
                      coupon: coupon,
                      description: description,
                      email: email,
                      invoicePrefix: invoicePrefix,
                      invoiceSettings: invoiceSettings,
                      metadata: metadata,
                      name: name,
                      paymentMethod: paymentMethod,
                      phone: phone,
                      preferredLocales: preferredLocales,
                      shipping: shipping,
                      source: source,
                      taxExempt: taxExempt,
                      taxIdData: taxIdData)
    }
    
    public func retrieve(customer: String,
                         expand: [String]? = nil) -> EventLoopFuture<StripeCustomer> {
        return retrieve(customer: customer,
                        expand: expand)
    }
    
    public func update(customer: String,
                       address: [String: Any]? = nil,
                       balance: Int? = nil,
                       coupon: String? = nil,
                       defaultSource: String? = nil,
                       description: String? = nil,
                       email: String? = nil,
                       invoicePrefix: String? = nil,
                       invoiceSettings: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       name: String? = nil,
                       phone: String? = nil,
                       preferredLocales: [String]? = nil,
                       shipping: [String: Any]? = nil,
                       source: Any? = nil,
                       taxExempt: StripeCustomerTaxExempt? = nil) -> EventLoopFuture<StripeCustomer> {
        return update(customer: customer,
                      address: address,
                      balance: balance,
                      coupon: coupon,
                      defaultSource: defaultSource,
                      description: description,
                      email: email,
                      invoicePrefix: invoicePrefix,
                      invoiceSettings: invoiceSettings,
                      metadata: metadata,
                      name: name,
                      phone: phone,
                      preferredLocales: preferredLocales,
                      shipping: shipping,
                      source: source,
                      taxExempt: taxExempt)
    }
    
    public func delete(customer: String) -> EventLoopFuture<StripeDeletedObject> {
        return delete(customer: customer)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeCustomerList> {
        return listAll(filter: filter)
    }
}

public struct StripeCustomerRoutes: CustomerRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let customers = APIBase + APIVersion + "customers"
    private let customer = APIBase + APIVersion + "customers/"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(address: [String: Any]?,
                       balance: Int?,
                       coupon: String?,
                       description: String?,
                       email: String?,
                       invoicePrefix: String?,
                       invoiceSettings: [String: Any]?,
                       metadata: [String: String]?,
                       name: String?,
                       paymentMethod: String?,
                       phone: String?,
                       preferredLocales: [String]?,
                       shipping: [String: Any]?,
                       source: Any?,
                       taxExempt: StripeCustomerTaxExempt?,
                       taxIdData: [[String: Any]]?) -> EventLoopFuture<StripeCustomer> {
        var body: [String: Any] = [:]
        
        if let address = address {
            address.forEach { body["address[\($0)]"] = $1 }
        }
        
        if let balance = balance {
            body["balance"] = balance
        }
        
        if let coupon = coupon {
            body["coupon"] = coupon
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let email = email {
            body["email"] = email
        }
        
        if let invoicePrefix = invoicePrefix {
            body["invoice_prefix"] = invoicePrefix
        }
        
        if let invoiceSettings = invoiceSettings {
            invoiceSettings.forEach { body["invoice_settings[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let name = name {
            body["name"] = name
        }
        
        if let paymentMethod = paymentMethod {
            body["payment_method"] = paymentMethod
        }
        
        if let phone = phone {
            body["phone"] = phone
        }
        
        if let preferredLocales = preferredLocales {
            body["preferred_locales"] = preferredLocales
        }
        
        if let shipping = shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let stringSource = source as? String {
            body["source"] = stringSource
        }
        
        if let hashSource = source as? [String: Any] {
            hashSource.forEach { body["source[\($0)]"] = $1 }
        }
        
        if let taxExempt = taxExempt {
            body["tax_exempt"] = taxExempt.rawValue
        }
        
        if let taxIdData = taxIdData {
            body["tax_id_data"] = taxIdData
        }
        
        return apiHandler.send(method: .POST, path: customers, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(customer: String,
                         expand: [String]?) -> EventLoopFuture<StripeCustomer> {
        var body: [String: Any] = [:]
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .GET, path: self.customer + customer, body: .string(body.queryParameters), headers: headers)
    }
    
    public func update(customer: String,
                       address: [String: Any]?,
                       balance: Int?,
                       coupon: String?,
                       defaultSource: String?,
                       description: String?,
                       email: String?,
                       invoicePrefix: String?,
                       invoiceSettings: [String: Any]?,
                       metadata: [String: String]?,
                       name: String?,
                       phone: String?,
                       preferredLocales: [String]?,
                       shipping: [String: Any]?,
                       source: Any?,
                       taxExempt: StripeCustomerTaxExempt?) -> EventLoopFuture<StripeCustomer> {
        var body: [String: Any] = [:]
        
        if let address = address {
            address.forEach { body["address[\($0)]"] = $1 }
        }
        
        if let balance = balance {
            body["balance"] = balance
        }
        
        if let coupon = coupon {
            body["coupon"] = coupon
        }
        
        if let defaultSource = defaultSource {
            body["default_source"] = defaultSource
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let email = email {
            body["email"] = email
        }
        
        if let invoicePrefix = invoicePrefix {
            body["invoice_prefix"] = invoicePrefix
        }
        
        if let invoiceSettings = invoiceSettings {
            invoiceSettings.forEach { body["invoice_settings[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let name = name {
            body["name"] = name
        }
        
        if let phone = phone {
            body["phone"] = phone
        }
        
        if let preferredLocales = preferredLocales {
            body["preferred_locales"] = preferredLocales
        }
        
        if let shipping = shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let stringSource = source as? String {
            body["source"] = stringSource
        }
        
        if let hashSource = source as? [String: Any] {
            hashSource.forEach { body["source[\($0)]"] = $1 }
        }
        
        if let taxExempt = taxExempt {
            body["tax_exempt"] = taxExempt.rawValue
        }
        
        return apiHandler.send(method: .POST, path: self.customer + customer, body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(customer: String) -> EventLoopFuture<StripeDeletedObject> {
        return apiHandler.send(method: .DELETE, path: self.customer + customer, headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeCustomerList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }

        return apiHandler.send(method: .GET, path: customers, query: queryParams, headers: headers)
    }
}
