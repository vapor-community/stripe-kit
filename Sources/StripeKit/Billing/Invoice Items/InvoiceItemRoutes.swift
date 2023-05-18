//
//  InvoiceItemRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/5/17.
//
//

import NIO
import NIOHTTP1

public protocol InvoiceItemRoutes: StripeAPIRoute {
    /// Creates an item to be added to a draft invoice. If no invoice is specified, the item will be on the next invoice created for the customer specified.
    ///
    /// - Parameters:
    ///   - customer: The ID of the customer who will be billed when this invoice item is billed.
    ///   - amount: The integer amount in cents of the charge to be applied to the upcoming invoice. If you want to apply a credit to the customer’s account, pass a negative amount.
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - description: An arbitrary string which you can attach to the invoice item. The description is displayed in the invoice for easy tracking. This will be unset if you POST an empty value.
    ///   - metadata: A set of key-value pairs that you can attach to an invoice item object. It can be useful for storing additional information about the invoice item in a structured format.
    ///   - period: The period associated with this invoice item.
    ///   - price: The ID of the price object.
    ///   - discountable: Controls whether discounts apply to this invoice item. Defaults to false for prorations or negative invoice items, and true for all other invoice items.
    ///   - discounts: The coupons to redeem into discounts for the invoice item or invoice line item.
    ///   - invoice: The ID of an existing invoice to add this invoice item to. When left blank, the invoice item will be added to the next upcoming scheduled invoice. This is useful when adding invoice items in response to an invoice.created webhook. You can only add invoice items to draft invoices.
    ///   - priceData: Data used to generate a new price object inline.
    ///   - quantity: Non-negative integer. The quantity of units for the invoice item.
    ///   - subscription: The ID of a subscription to add this invoice item to. When left blank, the invoice item will be be added to the next upcoming scheduled invoice. When set, scheduled invoices for subscriptions other than the specified subscription will ignore the invoice item. Use this when you want to express that an invoice item has been accrued within the context of a particular subscription.
    ///   - taxBehavior: Only required if a default tax behavior was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either inclusive or exclusive, it cannot be changed.
    ///   - taxCode: A tax code ID.
    ///   - taxRates: The tax rates which apply to the invoice item. When set, the `default_tax_rates` on the invoice do not apply to this invoice item.
    ///   - unitAmount: The integer unit amount in cents of the charge to be applied to the upcoming invoice. This `unit_amount` will be multiplied by the quantity to get the full amount. If you want to apply a credit to the customer’s account, pass a negative `unit_amount`.
    ///   - unitAmountDecimal: Same as `unit_amount`, but accepts a decimal value with at most 12 decimal places. Only one of `unit_amount` and `unit_amount_decimal` can be set.
    ///   - expand: An array of properties to expand.
    /// - Returns: The created invoice item object is returned if successful. Otherwise, this call returns an error.
    func create(customer: String,
                amount: Int?,
                currency: Currency?,
                description: String?,
                metadata: [String: String]?,
                period: [String: Any]?,
                price: String?,
                discountable: Bool?,
                discounts: [[String: Any]]?,
                invoice: String?,
                priceData: [String: Any]?,
                quantity: Int?,
                subscription: String?,
                taxBehavior: String?,
                taxCode: String?,
                taxRates: [String]?,
                unitAmount: Int?,
                unitAmountDecimal: String?,
                expand: [String]?) async throws -> InvoiceItem
    
    /// Retrieves the invoice item with the given ID.
    ///
    /// - Parameters:
    ///   - invoiceItem: The ID of the desired invoice item.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns an invoice item if a valid invoice item ID was provided. Returns an error otherwise.
    func retrieve(invoiceItem: String, expand: [String]?) async throws -> InvoiceItem
    
    /// Updates the amount or description of an invoice item on an upcoming invoice. Updating an invoice item is only possible before the invoice it’s attached to is closed.
    ///
    /// - Parameters:
    ///   - invoiceItem: The ID of the invoice item to be updated.
    ///   - amount: The integer amount in cents of the charge to be applied to the upcoming invoice. If you want to apply a credit to the customer’s account, pass a negative amount.
    ///   - description: An arbitrary string which you can attach to the invoice item. The description is displayed in the invoice for easy tracking. This will be unset if you POST an empty value.
    ///   - metadata: A set of key-value pairs that you can attach to an invoice item object. It can be useful for storing additional information about the invoice item in a structured format.
    ///   - period: The period associated with this invoice item.
    ///   - price: The ID of the price object.
    ///   - discountable: Controls whether discounts apply to this invoice item. Defaults to false for prorations or negative invoice items, and true for all other invoice items. Cannot be set to true for prorations.
    ///   - discounts: The coupons & existing discounts which apply to the invoice item or invoice line item. Item discounts are applied before invoice discounts. Pass an empty string to remove previously-defined discounts.
    ///   - priceData: Data used to generate a new price object inline.
    ///   - quantity: Non-negative integer. The quantity of units for the invoice item.
    ///   - taxBehavior: Only required if a default tax behavior was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either inclusive or exclusive, it cannot be changed.
    ///   - taxCode: A tax code ID.
    ///   - taxRates: The tax rates which apply to the invoice item. When set, the `default_tax_rates` on the invoice do not apply to this invoice item.
    ///   - unitAmount: The integer unit amount in cents of the charge to be applied to the upcoming invoice. This `unit_amount` will be multiplied by the quantity to get the full amount. If you want to apply a credit to the customer’s account, pass a negative `unit_amount`.
    ///   - unitAmountDecimal: Same as `unit_amount`, but accepts a decimal value with at most 12 decimal places. Only one of `unit_amount` and `unit_amount_decimal` can be set.
    ///   - expand: An array of properties to expand.
    /// - Returns: The updated invoice item object is returned upon success. Otherwise, this call returns an error.
    func update(invoiceItem: String,
                amount: Int?,
                description: String?,
                metadata: [String: String]?,
                period: [String: Any]?,
                price: String?,
                discountable: Bool?,
                discounts: [[String: Any]]?,
                priceData: [String: Any]?,
                quantity: Int?,
                taxBehavior: String?,
                taxCode: String?,
                taxRates: [String]?,
                unitAmount: Int?,
                unitAmountDecimal: String?,
                expand: [String]?) async throws -> InvoiceItem
    
    /// Deletes an invoice item, removing it from an invoice. Deleting invoice items is only possible when they’re not attached to invoices, or if it’s attached to a draft invoice.
    ///
    /// - Parameter invoiceItem: The identifier of the invoice item to be deleted.
    /// - Returns: An object with the deleted invoice item’s ID and a deleted flag upon success. Otherwise, this call returns an error, such as if the invoice item has already been deleted.
    func delete(invoiceItem: String) async throws -> DeletedObject
    
    /// Returns a list of your invoice items. Invoice items are returned sorted by creation date, with the most recently created invoice items appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/invoiceitems/list)
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` invoice items, starting after invoice item `starting_after`. Each entry in the array is a separate invoice item object. If no more invoice items are available, the resulting array will be empty. This request should never return an error.
    func listAll(filter: [String: Any]?) async throws -> InvoiceItemList
}

public struct StripeInvoiceItemRoutes: InvoiceItemRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let invoiceitems = APIBase + APIVersion + "invoiceitems"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(customer: String,
                       amount: Int? = nil,
                       currency: Currency? = nil,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       period: [String: Any]? = nil,
                       price: String? = nil,
                       discountable: Bool? = nil,
                       discounts: [[String: Any]]? = nil,
                       invoice: String? = nil,
                       priceData: [String: Any]? = nil,
                       quantity: Int? = nil,
                       subscription: String? = nil,
                       taxBehavior: String? = nil,
                       taxCode: String? = nil,
                       taxRates: [String]? = nil,
                       unitAmount: Int? = nil,
                       unitAmountDecimal: String? = nil,
                       expand: [String]? = nil) async throws -> InvoiceItem {
        var body: [String: Any] = ["customer": customer]
        
        if let amount {
            body["amount"] = amount
        }

        if let currency {
            body["currency"] = currency.rawValue
        }
        
        if let description {
            body["description"] = description
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let period {
            period.forEach { body["period[\($0)]"] = $1 }
        }
        
        if let price {
            body["price"] = price
        }
        
        if let discountable {
            body["discountable"] = discountable
        }
        
        if let discounts {
            body["discounts"] = discounts
        }
        
        if let invoice {
            body["invoice"] = invoice
        }
        
        if let priceData {
            priceData.forEach { body["price_data[\($0)]"] = $1 }
        }
        
        if let quantity {
            body["quantity"] = quantity
        }
        
        if let subscription {
            body["subscription"] = subscription
        }
        
        if let taxBehavior {
            body["tax_behavior"] = taxBehavior
        }
        
        if let taxCode {
            body["tax_code"] = taxCode
        }
        
        if let taxRates {
            body["tax_rates"] = taxRates
        }
        
        if let unitAmount {
            body["unit_amount"] = unitAmount
        }
        
        if let unitAmountDecimal {
            body["unit_amount_decimal"] = unitAmountDecimal
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: invoiceitems, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(invoiceItem: String, expand: [String]? = nil) async throws -> InvoiceItem {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(invoiceitems)/\(invoiceItem)", query: queryParams, headers: headers)
    }
    
    public func update(invoiceItem: String,
                       amount: Int? = nil,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       period: [String: Any]? = nil,
                       price: String? = nil,
                       discountable: Bool? = nil,
                       discounts: [[String: Any]]? = nil,
                       priceData: [String: Any]? = nil,
                       quantity: Int? = nil,
                       taxBehavior: String? = nil,
                       taxCode: String? = nil,
                       taxRates: [String]? = nil,
                       unitAmount: Int? = nil,
                       unitAmountDecimal: String? = nil,
                       expand: [String]? = nil) async throws -> InvoiceItem {
        var body: [String: Any] = [:]
        
        if let amount {
            body["amount"] = amount
        }
        
        if let description {
            body["description"] = description
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let period {
            period.forEach { body["period[\($0)]"] = $1 }
        }
        
        if let price {
            body["price"] = price
        }
        
        if let discountable {
            body["discountable"] = discountable
        }
        
        if let discounts {
            body["discounts"] = discounts
        }

        if let priceData {
            priceData.forEach { body["price_data[\($0)]"] = $1 }
        }
        
        if let quantity {
            body["quantity"] = quantity
        }
        
        if let taxBehavior {
            body["tax_behavior"] = taxBehavior
        }
        
        if let taxCode {
            body["tax_code"] = taxCode
        }
        
        if let taxRates {
            body["tax_rates"] = taxRates
        }
        
        if let unitAmount {
            body["unit_amount"] = unitAmount
        }
        
        if let unitAmountDecimal {
            body["unit_amount_decimal"] = unitAmountDecimal
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(invoiceitems)/\(invoiceItem)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(invoiceItem: String) async throws -> DeletedObject {
        try await apiHandler.send(method: .DELETE, path: "\(invoiceitems)/\(invoiceItem)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> InvoiceItemList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: invoiceitems, query: queryParams, headers: headers)
    }
}
