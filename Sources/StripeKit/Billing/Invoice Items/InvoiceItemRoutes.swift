//
//  InvoiceItemRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/5/17.
//
//

import NIO
import NIOHTTP1

public protocol InvoiceItemRoutes {
    /// Creates an item to be added to a draft invoice. If no invoice is specified, the item will be on the next invoice created for the customer specified.
    ///
    /// - Parameters:
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - customer: The ID of the customer who will be billed when this invoice item is billed.
    ///   - amount: The integer amount in cents of the charge to be applied to the upcoming invoice. If you want to apply a credit to the customer’s account, pass a negative amount.
    ///   - description: An arbitrary string which you can attach to the invoice item. The description is displayed in the invoice for easy tracking. This will be unset if you POST an empty value.
    ///   - discountable: Controls whether discounts apply to this invoice item. Defaults to false for prorations or negative invoice items, and true for all other invoice items.
    ///   - invoice: The ID of an existing invoice to add this invoice item to. When left blank, the invoice item will be added to the next upcoming scheduled invoice. This is useful when adding invoice items in response to an invoice.created webhook. You can only add invoice items to draft invoices.
    ///   - metadata: A set of key-value pairs that you can attach to an invoice item object. It can be useful for storing additional information about the invoice item in a structured format.
    ///   - period: The period associated with this invoice item.
    ///   - quantity: Non-negative integer. The quantity of units for the invoice item.
    ///   - subscription: The ID of a subscription to add this invoice item to. When left blank, the invoice item will be be added to the next upcoming scheduled invoice. When set, scheduled invoices for subscriptions other than the specified subscription will ignore the invoice item. Use this when you want to express that an invoice item has been accrued within the context of a particular subscription.
    ///   - taxRates: The tax rates which apply to the invoice item. When set, the default_tax_rates on the invoice do not apply to this invoice item.
    ///   - unitAmount: The integer unit amount in cents of the charge to be applied to the upcoming invoice. This `unit_amount` will be multiplied by the quantity to get the full amount. If you want to apply a credit to the customer’s account, pass a negative `unit_amount`.
    ///   - unitAmountDecimal: Same as `unit_amount`, but accepts a decimal value with at most 12 decimal places. Only one of `unit_amount` and `unit_amount_decimal` can be set.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeInvoiceItem`.
    func create(currency: StripeCurrency,
                customer: String,
                amount: Int?,
                description: String?,
                discountable: Bool?,
                invoice: String?,
                metadata: [String: String]?,
                period: [String: Any]?,
                quantity: Int?,
                subscription: String?,
                taxRates: [String]?,
                unitAmount: Int?,
                unitAmountDecimal: String?,
                expand: [String]?) -> EventLoopFuture<StripeInvoiceItem>
    
    /// Retrieves the invoice item with the given ID.
    ///
    /// - Parameters:
    ///   - invoiceItem: The ID of the desired invoice item.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeInvoiceItem`.
    func retrieve(invoiceItem: String, expand: [String]?) -> EventLoopFuture<StripeInvoiceItem>
    
    /// Updates the amount or description of an invoice item on an upcoming invoice. Updating an invoice item is only possible before the invoice it’s attached to is closed.
    ///
    /// - Parameters:
    ///   - invoiceItem: The ID of the invoice item to be updated.
    ///   - amount: The integer amount in cents of the charge to be applied to the upcoming invoice. If you want to apply a credit to the customer’s account, pass a negative amount.
    ///   - description: An arbitrary string which you can attach to the invoice item. The description is displayed in the invoice for easy tracking. This will be unset if you POST an empty value.
    ///   - discountable: Controls whether discounts apply to this invoice item. Defaults to false for prorations or negative invoice items, and true for all other invoice items. Cannot be set to true for prorations.
    ///   - metadata: A set of key-value pairs that you can attach to an invoice item object. It can be useful for storing additional information about the invoice item in a structured format.
    ///   - period: The period associated with this invoice item.
    ///   - quantity: Non-negative integer. The quantity of units for the invoice item.
    ///   - taxRates: The tax rates which apply to the invoice item. When set, the `default_tax_rates` on the invoice do not apply to this invoice item.
    ///   - unitAmount: The integer unit amount in cents of the charge to be applied to the upcoming invoice. This `unit_amount` will be multiplied by the quantity to get the full amount. If you want to apply a credit to the customer’s account, pass a negative `unit_amount`.
    ///   - unitAmountDecimal: Same as `unit_amount`, but accepts a decimal value with at most 12 decimal places. Only one of `unit_amount` and `unit_amount_decimal` can be set.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeInvoiceItem`.
    func update(invoiceItem: String,
                amount: Int?,
                description: String?,
                discountable: Bool?,
                metadata: [String: String]?,
                period: [String: Any]?,
                quantity: Int?,
                taxRates: [String]?,
                unitAmount: Int?,
                unitAmountDecimal: String?,
                expand: [String]?) -> EventLoopFuture<StripeInvoiceItem>
    
    /// Deletes an invoice item, removing it from an invoice. Deleting invoice items is only possible when they’re not attached to invoices, or if it’s attached to a draft invoice.
    ///
    /// - Parameter invoiceItem: The identifier of the invoice item to be deleted.
    /// - Returns: A `StripeDeletedObject`.
    func delete(invoiceItem: String) -> EventLoopFuture<StripeDeletedObject>
    
    /// Returns a list of your invoice items. Invoice items are returned sorted by creation date, with the most recently created invoice items appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/invoiceitems/list)
    /// - Returns: A `StripeInvoiceItemList`
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeInvoiceItemList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension InvoiceItemRoutes {
    public func create(currency: StripeCurrency,
                       customer: String,
                       amount: Int? = nil,
                       description: String? = nil,
                       discountable: Bool? = nil,
                       invoice: String? = nil,
                       metadata: [String: String]? = nil,
                       period: [String: Any]? = nil,
                       quantity: Int? = nil,
                       subscription: String? = nil,
                       taxRates: [String]? = nil,
                       unitAmount: Int? = nil,
                       unitAmountDecimal: String? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeInvoiceItem> {
        return create(currency: currency,
                          customer: customer,
                          amount: amount,
                          description: description,
                          discountable: discountable,
                          invoice: invoice,
                          metadata: metadata,
                          period: period,
                          quantity: quantity,
                          subscription: subscription,
                          taxRates: taxRates,
                          unitAmount: unitAmount,
                          unitAmountDecimal: unitAmountDecimal,
                          expand: expand)
    }
    
    public func retrieve(invoiceItem: String, expand: [String]? = nil) -> EventLoopFuture<StripeInvoiceItem> {
        return retrieve(invoiceItem: invoiceItem, expand: expand)
    }
    
    public func update(invoiceItem: String,
                       amount: Int? = nil,
                       description: String? = nil,
                       discountable: Bool? = nil,
                       metadata: [String: String]? = nil,
                       period: [String: Any]? = nil,
                       quantity: Int? = nil,
                       taxRates: [String]? = nil,
                       unitAmount: Int? = nil,
                       unitAmountDecimal: String? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeInvoiceItem> {
        return update(invoiceItem: invoiceItem,
                          amount: amount,
                          description: description,
                          discountable: discountable,
                          metadata: metadata,
                          period: period,
                          quantity: quantity,
                          taxRates: taxRates,
                          unitAmount: unitAmount,
                          unitAmountDecimal: unitAmountDecimal,
                          expand: expand)
    }
    
    public func delete(invoiceItem: String) -> EventLoopFuture<StripeDeletedObject> {
        return delete(invoiceItem: invoiceItem)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeInvoiceItemList> {
        return listAll(filter: filter)
    }
}

public struct StripeInvoiceItemRoutes: InvoiceItemRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let invoiceitems = APIBase + APIVersion + "invoiceitems"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(currency: StripeCurrency,
                       customer: String,
                       amount: Int?,
                       description: String?,
                       discountable: Bool?,
                       invoice: String?,
                       metadata: [String: String]?,
                       period: [String: Any]?,
                       quantity: Int?,
                       subscription: String?,
                       taxRates: [String]?,
                       unitAmount: Int?,
                       unitAmountDecimal: String?,
                       expand: [String]?) -> EventLoopFuture<StripeInvoiceItem> {
        var body: [String: Any] = ["currency": currency.rawValue,
                                   "customer": customer]
        
        if let amount = amount {
            body["amount"] = amount
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let discountable = discountable {
            body["discountable"] = discountable
        }
        
        if let invoice = invoice {
            body["invoice"] = invoice
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let period = period {
            period.forEach { body["period[\($0)]"] = $1 }
        }
        
        if let quantity = quantity {
            body["quantity"] = quantity
        }
        
        if let subscription = subscription {
            body["subscription"] = subscription
        }
        
        if let taxRates = taxRates {
            body["tax_rates"] = taxRates
        }
        
        if let unitAmount = unitAmount {
            body["unit_amount"] = unitAmount
        }
        
        if let unitAmountDecimal = unitAmountDecimal {
            body["unit_amount_decimal"] = unitAmountDecimal
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: invoiceitems, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(invoiceItem: String, expand: [String]?) -> EventLoopFuture<StripeInvoiceItem> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(invoiceitems)/\(invoiceItem)", query: queryParams, headers: headers)
    }
    
    public func update(invoiceItem: String,
                       amount: Int?,
                       description: String?,
                       discountable: Bool?,
                       metadata: [String: String]?,
                       period: [String: Any]?,
                       quantity: Int?,
                       taxRates: [String]?,
                       unitAmount: Int?,
                       unitAmountDecimal: String?,
                       expand: [String]?) -> EventLoopFuture<StripeInvoiceItem> {
        var body: [String: Any] = [:]
        
        if let amount = amount {
            body["amount"] = amount
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let discountable = discountable {
            body["discountable"] = discountable
        }

        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let period = period {
            period.forEach { body["period[\($0)]"] = $1 }
        }
        
        if let quantity = quantity {
            body["quantity"] = quantity
        }
        
        if let taxRates = taxRates {
            body["tax_rates"] = taxRates
        }
        
        if let unitAmount = unitAmount {
            body["unit_amount"] = unitAmount
        }
        
        if let unitAmountDecimal = unitAmountDecimal {
            body["unit_amount_decimal"] = unitAmountDecimal
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(invoiceitems)/\(invoiceItem)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(invoiceItem: String) -> EventLoopFuture<StripeDeletedObject> {
        return apiHandler.send(method: .DELETE, path: "\(invoiceitems)/\(invoiceItem)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeInvoiceItemList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: invoiceitems, query: queryParams, headers: headers)
    }
}
