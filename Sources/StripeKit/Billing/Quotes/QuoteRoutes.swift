//
//  QuoteRoutes.swift
//  File
//
//  Created by Andrew Edwards on 7/31/21.
//

import NIO
import NIOHTTP1
import Foundation

public protocol QuoteRoutes: StripeAPIRoute {
    /// A quote models prices and services for a customer. Default options for `header`, `description`, `footer`, and `expires_at` can be set in the dashboard via the quote template.
    /// - Parameters:
    ///    - lineItems: A list of line items the customer is being quoted for. Each line item includes information about the product, the quantity, and the resulting cost.
    ///    - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///    - applicationFeeAmount: The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the application owner’s Stripe account. There cannot be any line items with recurring prices when using this field.
    ///    - applicationFeePercent: A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the application owner’s Stripe account. There must be at least 1 line item with a recurring price to use this field.
    ///    - automaticTax: Settings for automatic tax lookup for this quote and resulting invoices and subscriptions.
    ///    - collectionMethod: Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay invoices at the end of the subscription cycle or at invoice finalization using the default payment method attached to the subscription or customer. When sending an invoice, Stripe will email your customer an invoice with payment instructions. Defaults to `charge_automatically`.
    ///    - customer: The customer for which this quote belongs to. A customer is required before finalizing the quote. Once specified, it   cannot be changed.
    ///    - defaultTaxRates: The tax rates that will apply to any line item that does not have `tax_rates` set.
    ///    - description: A description that will be displayed on the quote PDF. If no value is passed, the default description configured in your quote template settings will be used.
    ///    - discounts: The discounts applied to the quote. You can only set up to one discount.
    ///    - expiresAt: A future timestamp on which the quote will be canceled if in `open` or `draft` status. Measured in seconds since the  Unix epoch. If no value is passed, the default expiration date configured in your quote template settings will be used.
    ///    - footer: A footer that will be displayed on the quote PDF. If no value is passed, the default footer configured in your quote template settings will be used.
    ///    - fromQuote: Clone an existing quote. The new quote will be created in `status=draft`. When using this parameter, you cannot   specify any other parameters except for `expires_at`.
    ///    - header: A header that will be displayed on the quote PDF. If no value is passed, the default header configured in your quote template settings will be used.
    ///    - invoiceSettings: All invoices will be billed using the specified settings.
    ///    - onBehalfOf: The account on behalf of which to charge.
    ///    - subscriptionData: When creating a subscription or subscription schedule, the specified configuration data will be used. There    must be at least one line item with a recurring price for a subscription or subscription schedule to be created. A subscription schedule is created if `subscription_data[effective_date]` is present and in the future, otherwise a subscription is created.
    ///    - testClock: ID of the test clock to attach to the quote.
    ///    - transferData: The data with which to automatically create a Transfer for each of the invoices.
    ///    - expand: Specifies which fields in the response should be expanded.
    ///    - Returns: Returns the quote object.
    func create(lineItems: [[String: Any]]?,
                metadata: [String: String]?,
                applicationFeeAmount: Int?,
                applicationFeePercent: String?,
                automaticTax: [String: Any]?,
                collectionMethod: QuoteCollectionMethod?,
                customer: String?,
                defaultTaxRates: [String]?,
                description: String?,
                discounts: [[String: Any]]?,
                expiresAt: Date?,
                footer: String?,
                fromQuote: [String: Any]?,
                header: String?,
                invoiceSettings: [String: Any]?,
                onBehalfOf: String?,
                subscriptionData: [String: Any]?,
                testClock: String?,
                transferData: [String: Any]?,
                expand: [String]?) async throws -> Quote
    
    /// Retrieves the quote with the given ID.
    /// - Parameter quote: The id of the quote.
    /// - Parameter expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns a quote if a valid quote ID was provided. Returns an error otherwise.
    func retrieve(quote: String, expand: [String]?) async throws -> Quote
    
    /// A quote models prices and services for a customer.
    /// - Parameters:
    ///    - quote: The id of the quote.
    ///    - lineItems: A list of line items the customer is being quoted for. Each line item includes information about the product, the quantity, and the resulting cost.
    ///    - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///    - applicationFeeAmount: The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the application owner’s Stripe account. There cannot be any line items with recurring prices when using this field.
    ///    - applicationFeePercent: A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the application owner’s Stripe account. There must be at least 1 line item with a recurring price to use this field.
    ///    - automaticTax: Settings for automatic tax lookup for this quote and resulting invoices and subscriptions.
    ///    - collectionMethod: Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay invoices at the end of the subscription cycle or at invoice finalization using the default payment method attached to the subscription or customer. When sending an invoice, Stripe will email your customer an invoice with payment instructions. Defaults to `charge_automatically`.
    ///    - customer: The customer for which this quote belongs to. A customer is required before finalizing the quote. Once specified, it   cannot be changed.
    ///    - defaultTaxRates: The tax rates that will apply to any line item that does not have `tax_rates` set.
    ///    - description: A description that will be displayed on the quote PDF. If no value is passed, the default description configured in your quote template settings will be used.
    ///    - discounts: The discounts applied to the quote. You can only set up to one discount.
    ///    - expiresAt: A future timestamp on which the quote will be canceled if in `open` or `draft` status. Measured in seconds since the  Unix epoch. If no value is passed, the default expiration date configured in your quote template settings will be used.
    ///    - footer: A footer that will be displayed on the quote PDF. If no value is passed, the default footer configured in your quote template settings will be used.
    ///    - header: A header that will be displayed on the quote PDF. If no value is passed, the default header configured in your quote template settings will be used.
    ///    - invoiceSettings: All invoices will be billed using the specified settings.
    ///    - onBehalfOf: The account on behalf of which to charge.
    ///    - subscriptionData: When creating a subscription or subscription schedule, the specified configuration data will be used. There    must be at least one line item with a recurring price for a subscription or subscription schedule to be created. A subscription schedule is created if `subscription_data[effective_date]` is present and in the future, otherwise a subscription is created.
    ///    - transferData: The data with which to automatically create a Transfer for each of the invoices.
    ///    - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns the updated quote object.
    func update(quote: String,
                lineItems: [[String: Any]]?,
                metadata: [String: String]?,
                applicationFeeAmount: Int?,
                applicationFeePercent: String?,
                automaticTax: [String: Any]?,
                collectionMethod: QuoteCollectionMethod?,
                customer: String?,
                defaultTaxRates: [String]?,
                description: String?,
                discounts: [[String: Any]]?,
                expiresAt: Date?,
                footer: String?,
                header: String?,
                invoiceSettings: [String: Any]?,
                onBehalfOf: String?,
                subscriptionData: [String: Any]?,
                transferData: [String: Any]?,
                expand: [String]?) async throws -> Quote
    
    /// Finalizes the quote.
    /// - Parameter quote: The id of the quote
    /// - Parameter expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns an open quote. Returns an error otherwise.
    func finalize(quote: String,
                  expiresAt: Date?,
                  expand: [String]?) async throws -> Quote
    
    /// Accepts the specified quote.
    /// - Parameter quote: The id of the quote
    /// - Parameter expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns an accepted quote and creates an invoice, subscription or subscription schedule. Returns an error otherwise
    func accept(quote: String, expand: [String]?) async throws -> Quote
    
    /// Cancels the quote.
    /// - Parameter quote: The id of the quote
    /// - Parameter expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns a canceled quote. Returns an error otherwise.
    func cancel(quote: String, expand: [String]?) async throws -> Quote
    
    /// Download the PDF for a finalized quote
    /// - Parameter quote: The id of the quote
    /// - Returns: The PDF file for the quote.
    func downloadPDF(quote: String) async throws -> Data
    
    /// When retrieving a quote, there is an includable **line_items** property containing the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.
    /// - Parameters:
    ///   - quote: The id of the quote.
    ///   - filter: A dictionary that will be used for the query parameters.
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` quote line items, starting after Line Item `starting_after`. Each entry in the array is a separate Line Item object. If no more line items are available, the resulting array will be empty.
    func retrieveLineItems(quote: String, filter: [String: Any]?) async throws -> QuoteLineItemList
    
    /// When retrieving a quote, there is an includable **[computed.upfront.line_items property](https://stripe.com/docs/api/quotes/object#quote_object-computed-upfront-line_items)** containing the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of upfront line items.
    /// - Parameters:
    ///   - quote: The id of the quote.
    ///   - filter: A dictionary that will be used for the query parameters.
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` upfront line items, starting after Line Item `starting_after`. Each entry in the array is a separate Line Item object. If no more upfront line items are available, the resulting array will be empty.
    func retrieveUpfrontLineItems(quote: String, filter: [String: Any]?) async throws -> QuoteLineItemList
    
    /// Returns a list of your quotes.
    /// - Parameter filter: A dictionary that will be used for the query parameters.
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` quotes, starting after quote `starting_after`. Each entry in the array is a separate quote object. If no more quotes are available, the resulting array will be empty. This request should never return an error.
    func listAll(filter: [String: Any]?) async throws -> QuoteList
}

public struct StripeQuoteRoutes: QuoteRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let quotes = APIBase + APIVersion + "quotes"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(lineItems: [[String: Any]]? = nil,
                       metadata: [String: String]? = nil,
                       applicationFeeAmount: Int? = nil,
                       applicationFeePercent: String? = nil,
                       automaticTax: [String: Any]? = nil,
                       collectionMethod: QuoteCollectionMethod? = nil,
                       customer: String? = nil,
                       defaultTaxRates: [String]? = nil,
                       description: String? = nil,
                       discounts: [[String: Any]]? = nil,
                       expiresAt: Date? = nil,
                       footer: String? = nil,
                       fromQuote: [String: Any]? = nil,
                       header: String? = nil,
                       invoiceSettings: [String: Any]? = nil,
                       onBehalfOf: String? = nil,
                       subscriptionData: [String: Any]? = nil,
                       testClock: String? = nil,
                       transferData: [String: Any]? = nil,
                       expand: [String]? = nil) async throws -> Quote {
        var body: [String: Any] = [:]
        
        if let lineItems {
            body["line_items"] = lineItems
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
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
        
        if let collectionMethod {
            body["collection_method"] = collectionMethod.rawValue
        }
        
        if let customer {
            body["customer"] = customer
        }
        
        if let defaultTaxRates {
            body["default_tax_rates"] = defaultTaxRates
        }
        
        if let description {
            body["description"] = description
        }
        
        if let discounts {
            body["discounts"] = discounts
        }
        
        if let expiresAt {
            body["expires_at"] = Int(expiresAt.timeIntervalSince1970)
        }
        
        if let footer {
            body["footer"] = footer
        }
        
        if let fromQuote {
            fromQuote.forEach { body["from_quote[\($0)]"] = $1 }
        }
        
        if let header {
            body["header"] = header
        }
        
        if let invoiceSettings {
            invoiceSettings.forEach { body["invoice_settings[\($0)]"] = $1 }
        }
        
        if let onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }
        
        if let subscriptionData {
            subscriptionData.forEach { body["subscription_data[\($0)]"] = $1 }
        }
        
        if let testClock {
            body["test_clock"] = testClock
        }
        
        if let transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: quotes, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(quote: String, expand: [String]? = nil) async throws -> Quote {
        var queryParams = ""
        if let expand {
            queryParams += ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(quotes)/\(quote)", query: queryParams, headers: headers)
    }
    
    public func update(quote: String,
                       lineItems: [[String: Any]]? = nil,
                       metadata: [String: String]? = nil,
                       applicationFeeAmount: Int? = nil,
                       applicationFeePercent: String? = nil,
                       automaticTax: [String: Any]? = nil,
                       collectionMethod: QuoteCollectionMethod? = nil,
                       customer: String? = nil,
                       defaultTaxRates: [String]? = nil,
                       description: String? = nil,
                       discounts: [[String: Any]]? = nil,
                       expiresAt: Date? = nil,
                       footer: String? = nil,
                       header: String? = nil,
                       invoiceSettings: [String: Any]? = nil,
                       onBehalfOf: String? = nil,
                       subscriptionData: [String: Any]? = nil,
                       transferData: [String: Any]? = nil,
                       expand: [String]? = nil) async throws -> Quote {
        var body: [String: Any] = [:]
        
        if let lineItems {
            body["line_items"] = lineItems
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
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
        
        if let collectionMethod {
            body["collection_method"] = collectionMethod.rawValue
        }
        
        if let customer {
            body["customer"] = customer
        }
        
        if let defaultTaxRates {
            body["default_tax_rates"] = defaultTaxRates
        }
        
        if let description {
            body["description"] = description
        }
        
        if let discounts {
            body["discounts"] = discounts
        }
        
        if let expiresAt {
            body["expires_at"] = Int(expiresAt.timeIntervalSince1970)
        }
        
        if let footer {
            body["footer"] = footer
        }
        
        if let header {
            body["header"] = header
        }
        
        if let invoiceSettings {
            invoiceSettings.forEach { body["invoice_settings[\($0)]"] = $1 }
        }
        
        if let onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }
        
        if let subscriptionData {
            subscriptionData.forEach { body["subscription_data[\($0)]"] = $1 }
        }
        
        if let transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(quotes)/\(quote)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func finalize(quote: String,
                         expiresAt: Date? = nil,
                         expand: [String]? = nil) async throws -> Quote {
        var body: [String: Any] = [:]
        
        if let expiresAt {
            body["expires_at"] = Int(expiresAt.timeIntervalSince1970)
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(quotes)/\(quote)/finalize", body: .string(body.queryParameters), headers: headers)
    }
    
    public func accept(quote: String, expand: [String]? = nil) async throws -> Quote {
        var queryParams = ""
        if let expand {
            queryParams += ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .POST, path: "\(quotes)/\(quote)/accept", query: queryParams, headers: headers)
    }
    
    public func cancel(quote: String, expand: [String]? = nil) async throws -> Quote {
        var queryParams = ""
        if let expand {
            queryParams += ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .POST, path: "\(quotes)/\(quote)/cancel", query: queryParams, headers: headers)
    }
    
    public func downloadPDF(quote: String) async throws -> Data {
        try await apiHandler.send(method: .GET, path: "\(quotes)/\(quote)", headers: headers)
    }
    
    public func retrieveLineItems(quote: String, filter: [String: Any]? = nil) async throws -> QuoteLineItemList {
        var queryParams = ""
        if let filter {
            queryParams += filter.queryParameters
        }
        
        return try await apiHandler.send(method: .POST, path: "\(quotes)/\(quote)/line_items", query: queryParams, headers: headers)
    }
    
    public func retrieveUpfrontLineItems(quote: String, filter: [String: Any]? = nil) async throws -> QuoteLineItemList {
        var queryParams = ""
        if let filter {
            queryParams += filter.queryParameters
        }
        
        return try await apiHandler.send(method: .POST, path: "\(quotes)/\(quote)/computed_upfront_line_items", query: queryParams, headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> QuoteList {
        var queryParams = ""
        if let filter {
            queryParams += filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: quotes, query: queryParams, headers: headers)
    }
}
