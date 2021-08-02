//
//  QuoteRoutes.swift
//  File
//
//  Created by Andrew Edwards on 7/31/21.
//

import NIO
import NIOHTTP1
import Foundation

public protocol QuoteRoutes {
    
    /// A quote models prices and services for a customer. Default options for `header`, `description`, `footer`, and `expires_at` can be set in the dashboard via the quote template.
    /// - Parameters:
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
    ///    - lineItems: A list of line items the customer is being quoted for. Each line item includes information about the product, the quantity, and the resulting cost.
    ///    - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///    - onBehalfOf: The account on behalf of which to charge.
    ///    - subscriptionData: When creating a subscription or subscription schedule, the specified configuration data will be used. There    must be at least one line item with a recurring price for a subscription or subscription schedule to be created. A subscription schedule is created if `subscription_data[effective_date]` is present and in the future, otherwise a subscription is created.
    ///    - transferData: The data with which to automatically create a Transfer for each of the invoices.
    ///    - expand: An array of properties to expand.
    ///    - Returns: A `StripeQuote`.
    func create(applicationFeeAmount: Int?,
                applicationFeePercent: String?,
                automaticTax: [String: Any]?,
                collectionMethod: StripeQuoteCollectionMethod?,
                customer: String?,
                defaultTaxRates: [String]?,
                description: String?,
                discounts: [[String: Any]]?,
                expiresAt: Date?,
                footer: String?,
                fromQuote: [String: Any]?,
                header: String?,
                invoiceSettings: [String: Any]?,
                lineItems: [[String: Any]]?,
                metadata: [String: String]?,
                onBehalfOf: String?,
                subscriptionData: [String: Any]?,
                transferData: [String: Any]?,
                expand: [String]?) -> EventLoopFuture<StripeQuote>
    
    /// Retrieves the quote with the given ID.
    /// - Parameter quote: The id of the quote.
    /// - Parameter expand: An array of properties to expand.
    /// - Returns: A `StripeQuote`.
    func retrieve(quote: String, expand: [String]?) -> EventLoopFuture<StripeQuote>
    
    /// A quote models prices and services for a customer.
    /// - Parameters:
    ///    - quote: The id of the quote.
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
    ///    - lineItems: A list of line items the customer is being quoted for. Each line item includes information about the product, the quantity, and the resulting cost.
    ///    - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///    - onBehalfOf: The account on behalf of which to charge.
    ///    - subscriptionData: When creating a subscription or subscription schedule, the specified configuration data will be used. There    must be at least one line item with a recurring price for a subscription or subscription schedule to be created. A subscription schedule is created if `subscription_data[effective_date]` is present and in the future, otherwise a subscription is created.
    ///    - transferData: The data with which to automatically create a Transfer for each of the invoices.
    ///    - expand: An array of properties to expand.
    /// - Returns: A `StripeQuote`.
    func update(quote: String,
                applicationFeeAmount: Int?,
                applicationFeePercent: String?,
                automaticTax: [String: Any]?,
                collectionMethod: StripeQuoteCollectionMethod?,
                customer: String?,
                defaultTaxRates: [String]?,
                description: String?,
                discounts: [[String: Any]]?,
                expiresAt: Date?,
                footer: String?,
                header: String?,
                invoiceSettings: [String: Any]?,
                lineItems: [[String: Any]]?,
                metadata: [String: String]?,
                onBehalfOf: String?,
                subscriptionData: [String: Any]?,
                transferData: [String: Any]?,
                expand: [String]?) -> EventLoopFuture<StripeQuote>
    
    /// Finalizes the quote.
    /// - Parameter quote: The id of the quote
    /// - Parameter expand: An array of properties to expand.
    /// - Returns: A `StripeQuote`.
    func finalize(quote: String,
                  expiresAt: Date?,
                  expand: [String]?) -> EventLoopFuture<StripeQuote>
    
    /// Accepts the specified quote.
    /// - Parameter quote: The id of the quote
    /// - Parameter expand: An array of properties to expand.
    /// - Returns: A `StripeQuote`.
    func accept(quote: String, expand: [String]?) -> EventLoopFuture<StripeQuote>
    
    /// Cancels the quote.
    /// - Parameter quote: The id of the quote
    /// - Parameter expand: An array of properties to expand.
    /// - Returns: A `StripeQuote`.
    func cancel(quote: String, expand: [String]?) -> EventLoopFuture<StripeQuote>
    
    /// Download the PDF for a finalized quote
    /// - Parameter quote: The id of the quote
    /// - Returns: The pdf data in `Data`.
    func downloadPDF(quote: String) -> EventLoopFuture<Data>
    
    /// Returns a list of your quotes.
    /// - Parameter filter: A dictionary that will be used for the query parameters.
    /// - Returns: A `StripeQuoteList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeQuoteList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension QuoteRoutes {
    public func create(applicationFeeAmount: Int? = nil,
                       applicationFeePercent: String? = nil,
                       automaticTax: [String: Any]? = nil,
                       collectionMethod: StripeQuoteCollectionMethod? = nil,
                       customer: String? = nil,
                       defaultTaxRates: [String]? = nil,
                       description: String? = nil,
                       discounts: [[String: Any]]? = nil,
                       expiresAt: Date? = nil,
                       footer: String? = nil,
                       fromQuote: [String: Any]? = nil,
                       header: String? = nil,
                       invoiceSettings: [String: Any]? = nil,
                       lineItems: [[String: Any]]? = nil,
                       metadata: [String: String]? = nil,
                       onBehalfOf: String? = nil,
                       subscriptionData: [String: Any]? = nil,
                       transferData: [String: Any]? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeQuote> {
        create(applicationFeeAmount: applicationFeeAmount,
               applicationFeePercent: applicationFeePercent,
               automaticTax: automaticTax,
               collectionMethod: collectionMethod,
               customer: customer,
               defaultTaxRates: defaultTaxRates,
               description: description,
               discounts: discounts,
               expiresAt: expiresAt,
               footer: footer,
               fromQuote: fromQuote,
               header: header,
               invoiceSettings: invoiceSettings,
               lineItems: lineItems,
               metadata: metadata,
               onBehalfOf: onBehalfOf,
               subscriptionData: subscriptionData,
               transferData: transferData,
               expand: expand)
    }
    
    public func retrieve(quote: String, expand: [String]? = nil) -> EventLoopFuture<StripeQuote> {
        retrieve(quote: quote, expand: expand)
    }
    
    public func update(quote: String,
                       applicationFeeAmount: Int? = nil,
                       applicationFeePercent: String? = nil,
                       automaticTax: [String: Any]? = nil,
                       collectionMethod: StripeQuoteCollectionMethod? = nil,
                       customer: String? = nil,
                       defaultTaxRates: [String]? = nil,
                       description: String? = nil,
                       discounts: [[String: Any]]? = nil,
                       expiresAt: Date? = nil,
                       footer: String? = nil,
                       header: String? = nil,
                       invoiceSettings: [String: Any]? = nil,
                       lineItems: [[String: Any]]? = nil,
                       metadata: [String: String]? = nil,
                       onBehalfOf: String? = nil,
                       subscriptionData: [String: Any]? = nil,
                       transferData: [String: Any]? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeQuote> {
        update(quote: quote,
               applicationFeeAmount: applicationFeeAmount,
               applicationFeePercent: applicationFeePercent,
               automaticTax: automaticTax,
               collectionMethod: collectionMethod,
               customer: customer,
               defaultTaxRates: defaultTaxRates,
               description: description,
               discounts: discounts,
               expiresAt: expiresAt,
               footer: footer,
               header: header,
               invoiceSettings: invoiceSettings,
               lineItems: lineItems,
               metadata: metadata,
               onBehalfOf: onBehalfOf,
               subscriptionData: subscriptionData,
               transferData: transferData,
               expand: expand)
    }
    
    public func finalize(quote: String,
                         expiresAt: Date? = nil,
                         expand: [String]? = nil) -> EventLoopFuture<StripeQuote> {
        finalize(quote: quote, expiresAt: expiresAt, expand: expand)
    }
    
    public func accept(quote: String, expand: [String]? = nil) -> EventLoopFuture<StripeQuote> {
        accept(quote: quote, expand: expand)
    }
    
    public func cancel(quote: String, expand: [String]? = nil) -> EventLoopFuture<StripeQuote> {
        cancel(quote: quote, expand: expand)
    }
    
    public func downloadPDF(quote: String) -> EventLoopFuture<Data> {
        downloadPDF(quote: quote)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeQuoteList> {
        listAll(filter: filter)
    }
}

public struct StripeQuoteRoutes: QuoteRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let quotes = APIBase + APIVersion + "quotes"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(applicationFeeAmount: Int?,
                       applicationFeePercent: String?,
                       automaticTax: [String: Any]?,
                       collectionMethod: StripeQuoteCollectionMethod?,
                       customer: String?,
                       defaultTaxRates: [String]?,
                       description: String?,
                       discounts: [[String: Any]]?,
                       expiresAt: Date?,
                       footer: String?,
                       fromQuote: [String: Any]?,
                       header: String?,
                       invoiceSettings: [String: Any]?,
                       lineItems: [[String: Any]]?,
                       metadata: [String: String]?,
                       onBehalfOf: String?,
                       subscriptionData: [String: Any]?,
                       transferData: [String: Any]?,
                       expand: [String]?) -> EventLoopFuture<StripeQuote> {
        var body: [String: Any] = [:]
        
        if let applicationFeeAmount = applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }
        
        if let applicationFeePercent = applicationFeePercent {
            body["application_fee_percent"] = applicationFeePercent
        }
        
        if let automaticTax = automaticTax {
            automaticTax.forEach { body["automatic_tax[\($0)]"] = $1 }
        }
        
        if let collectionMethod = collectionMethod {
            body["collection_method"] = collectionMethod.rawValue
        }
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let defaultTaxRates = defaultTaxRates {
            body["default_tax_rates"] = defaultTaxRates
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let discounts = discounts {
            body["discounts"] = discounts
        }
        
        if let expiresAt = expiresAt {
            body["expires_at"] = Int(expiresAt.timeIntervalSince1970)
        }
        
        if let footer = footer {
            body["footer"] = footer
        }
        
        if let fromQuote = fromQuote {
            fromQuote.forEach { body["from_quote[\($0)]"] = $1 }
        }
        
        if let header = header {
            body["header"] = header
        }
        
        if let invoiceSettings = invoiceSettings {
            invoiceSettings.forEach { body["invoice_settings[\($0)]"] = $1 }
        }
        
        if let lineItems = lineItems {
            body["line_items"] = lineItems
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let onBehalfOf = onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }
        
        if let subscriptionData = subscriptionData {
            subscriptionData.forEach { body["subscription_data[\($0)]"] = $1 }
        }
        
        if let transferData = transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: quotes, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(quote: String, expand: [String]?) -> EventLoopFuture<StripeQuote> {
        var queryParams = ""
        if let expand = expand {
            queryParams += ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(quotes)/\(quote)", query: queryParams, headers: headers)
    }
    
    public func update(quote: String,
                       applicationFeeAmount: Int?,
                       applicationFeePercent: String?,
                       automaticTax: [String: Any]?,
                       collectionMethod: StripeQuoteCollectionMethod?,
                       customer: String?,
                       defaultTaxRates: [String]?,
                       description: String?,
                       discounts: [[String: Any]]?,
                       expiresAt: Date?,
                       footer: String?,
                       header: String?,
                       invoiceSettings: [String: Any]?,
                       lineItems: [[String: Any]]?,
                       metadata: [String: String]?,
                       onBehalfOf: String?,
                       subscriptionData: [String: Any]?,
                       transferData: [String: Any]?,
                       expand: [String]?) -> EventLoopFuture<StripeQuote> {
        var body: [String: Any] = [:]
        
        if let applicationFeeAmount = applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }
        
        if let applicationFeePercent = applicationFeePercent {
            body["application_fee_percent"] = applicationFeePercent
        }
        
        if let automaticTax = automaticTax {
            automaticTax.forEach { body["automatic_tax[\($0)]"] = $1 }
        }
        
        if let collectionMethod = collectionMethod {
            body["collection_method"] = collectionMethod.rawValue
        }
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let defaultTaxRates = defaultTaxRates {
            body["default_tax_rates"] = defaultTaxRates
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let discounts = discounts {
            body["discounts"] = discounts
        }
        
        if let expiresAt = expiresAt {
            body["expires_at"] = Int(expiresAt.timeIntervalSince1970)
        }
        
        if let footer = footer {
            body["footer"] = footer
        }
        
        if let header = header {
            body["header"] = header
        }
        
        if let invoiceSettings = invoiceSettings {
            invoiceSettings.forEach { body["invoice_settings[\($0)]"] = $1 }
        }
        
        if let lineItems = lineItems {
            body["line_items"] = lineItems
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let onBehalfOf = onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }
        
        if let subscriptionData = subscriptionData {
            subscriptionData.forEach { body["subscription_data[\($0)]"] = $1 }
        }
        
        if let transferData = transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(quotes)/\(quote)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func finalize(quote: String, expiresAt: Date?, expand: [String]?) -> EventLoopFuture<StripeQuote> {
        var body: [String: Any] = [:]
        
        if let expiresAt = expiresAt {
            body["expires_at"] = Int(expiresAt.timeIntervalSince1970)
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(quotes)/\(quote)/finalize", body: .string(body.queryParameters), headers: headers)
    }
    
    public func accept(quote: String, expand: [String]?) -> EventLoopFuture<StripeQuote> {
        var queryParams = ""
        if let expand = expand {
            queryParams += ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .POST, path: "\(quotes)/\(quote)/accept", query: queryParams, headers: headers)
    }
    
    public func cancel(quote: String, expand: [String]?) -> EventLoopFuture<StripeQuote> {
        var queryParams = ""
        if let expand = expand {
            queryParams += ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .POST, path: "\(quotes)/\(quote)/cancel", query: queryParams, headers: headers)
    }
    
    public func downloadPDF(quote: String) -> EventLoopFuture<Data> {
        apiHandler.send(method: .GET, path: "\(quotes)/\(quote)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeQuoteList> {
        var queryParams = ""
        if let filter = filter {
            queryParams += filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: quotes, query: queryParams, headers: headers)
    }
}
