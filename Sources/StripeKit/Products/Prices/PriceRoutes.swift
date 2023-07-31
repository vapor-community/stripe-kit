//
//  PriceRoutes.swift
//  
//
//  Created by Andrew Edwards on 7/21/20.
//

import NIO
import NIOHTTP1
import Foundation

public protocol PriceRoutes: StripeAPIRoute {
    /// Creates a new price for an existing product. The price can be recurring or one-time.
    /// - Parameters:
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - product: The ID of the product that this price will belong to.
    ///   - unitAmount: A positive integer in cents (or 0 for a free price) representing how much to charge.
    ///   - active: Whether the price is currently active. Defaults to `true`.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - nickname: A brief description of the price, hidden from customers.
    ///   - recurring: The recurring components of a price such as `interval` and `usage_type`.
    ///   - customUnitAmount: When set, provides configuration for the amount to be adjusted by the customer during Checkout Sessions and Payment Links.
    ///   - productData: These fields can be used to create a new product that this price will belong to.
    ///   - tiers: Each element represents a pricing tier. This parameter requires `billing_scheme` to be set to `tiered`. See also the documentation for `billing_scheme`.
    ///   - tiersMode: Defines if the tiering price should be `graduated` or `volume` based. In `volume`-based tiering, the maximum quantity within a period determines the per unit price, in `graduated` tiering pricing can successively change as the quantity grows.
    ///   - billingScheme: Describes how to compute the price per period. Either `per_unit` or `tiered`. `per_unit` indicates that the fixed amount (specified in `unit_amount` or `unit_amount_decimal`) will be charged per unit in `quantity` (for prices with `usage_type=licensed`), or per unit of total usage (for prices with `usage_type=metered`). `tiered` indicates that the unit pricing will be computed using a tiering strategy as defined using the `tiers` and `tiers_mode` attributes.
    ///   - currencyOptions: Prices defined in each available currency option. Each key must be a three-letter ISO currency code and a supported currency. For example, to define your price in `eur`, pass the fields below in the `eur` key of `currency_options`.
    ///   - lookupKey: A lookup key used to retrieve prices dynamically from a static string.
    ///   - taxBehavior: Only required if a default tax behavior was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of inclusive, exclusive, or unspecified. Once specified as either inclusive or exclusive, it cannot be changed.
    ///   - transferLookupKey: If set to true, will atomically remove the lookup key from the existing price, and assign it to this price.
    ///   - transformQuantity: Apply a transformation to the reported usage or set quantity before computing the billed price. Cannot be combined with `tiers`.
    ///   - unitAmountDecimal: Same as `unit_amount`, but accepts a decimal value with at most 12 decimal places. Only one of `unit_amount` and `unit_amount_decimal` can be set.
    ///  - expand: Specifies which fields in the response should be expanded.
    func create(currency: Currency,
                product: String?,
                unitAmount: Int?,
                active: Bool?,
                metadata: [String: String]?,
                nickname: String?,
                recurring: [String: Any]?,
                customUnitAmount: [String: Any]?,
                productData: [String: Any]?,
                tiers: [[String: Any]]?,
                tiersMode: String?,
                billingScheme: [String: Any]?,
                currencyOptions: [String: [String: Any]]?,
                lookupKey: String?,
                taxBehavior: PriceTaxBehavior?,
                transferLookupKey: String?,
                transformQuantity: [String: Any]?,
                unitAmountDecimal: Decimal?,
                expand: [String]?) async throws -> Price
    
    /// Retrieves the price with the given ID.
    /// - Parameter price: The ID of the price to retrieve.
    /// - Parameter expand: Specifies which fields in the response should be expanded.
    func retrieve(price: String, expand: [String]?) async throws -> Price
    
    /// Updates the specified price by setting the values of the parameters passed. Any parameters not provided are left unchanged.
    /// - Parameters:
    ///   - price: The ID of the price to update.
    ///   - active: Whether the price is currently active. Defaults to `true`.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - nickname: A brief description of the price, hidden from customers.
    ///   - currencyOptions: Prices defined in each available currency option. Each key must be a three-letter ISO currency code and a supported currency. For example, to define your price in `eur`, pass the fields below in the `eur` key of `currency_options`.
    ///   - lookupKey: A lookup key used to retrieve prices dynamically from a static string.
    ///   - transferLookupKey: If set to true, will atomically remove the lookup key from the existing price, and assign it to this price.
    ///   - expand: Specifies which fields in the response should be expanded.
    func update(price: String,
                active: Bool?,
                metadata: [String: String]?,
                nickname: String?,
                currencyOptions: [String: [String: Any]]?,
                lookupKey: String?,
                taxBehavior: PriceTaxBehavior?,
                transferLookupKey: String?,
                expand: [String]?) async throws -> Price
    
    /// Returns a list of your prices.
    /// - Parameter filter: A dictionary that will be used for the query parameters.
    func listAll(filter: [String: Any]?) async throws -> PriceList
    
    /// Search for prices you’ve previously created using Stripe’s Search Query Language. Don’t use search in read-after-write flows where strict consistency is necessary. Under normal operating conditions, data is searchable in less than a minute. Occasionally, propagation of new or updated data can be up to an hour behind during outages. Search functionality is not available to merchants in India.
    /// - Parameters:
    ///   - query: The search query string. See search query language and the list of supported query fields for prices.
    ///   - limit: A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
    ///   - page: A cursor for pagination across multiple pages of results. Don’t include this parameter on the first call. Use the `next_page` value returned in a previous response to request subsequent results.
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` prices. If no objects match the query, the resulting array will be empty. See the related guide on expanding properties in lists.
    func search(query: String, limit: Int?, page: String?) async throws -> PriceSearchResult
}

public struct StripePriceRoutes: PriceRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let prices = APIBase + APIVersion + "prices"
    private let search = APIBase + APIVersion + "prices/search"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(currency: Currency,
                       product: String? = nil,
                       unitAmount: Int? = nil,
                       active: Bool? = nil,
                       metadata: [String: String]? = nil,
                       nickname: String? = nil,
                       recurring: [String: Any]? = nil,
                       customUnitAmount: [String: Any]? = nil,
                       productData: [String: Any]? = nil,
                       tiers: [[String: Any]]? = nil,
                       tiersMode: String? = nil,
                       billingScheme: [String: Any]? = nil,
                       currencyOptions: [String: [String: Any]]? = nil,
                       lookupKey: String? = nil,
                       taxBehavior: PriceTaxBehavior? = nil,
                       transferLookupKey: String? = nil,
                       transformQuantity: [String: Any]? = nil,
                       unitAmountDecimal: Decimal? = nil,
                       expand: [String]? = nil) async throws -> Price {
        var body: [String: Any] = [:]
        
        body["currency"] = currency.rawValue
        
        if let product {
            body["product"] = product
        }
        
        if let unitAmount {
            body["unit_amount"] = unitAmount
        }
        
        if let active {
            body["active"] = active
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let nickname {
            body["nickname"] = nickname
        }
        
        if let recurring {
            recurring.forEach { body["recurring[\($0)]"] = $1 }
        }
        
        if let customUnitAmount {
            customUnitAmount.forEach { body["custom_unit_amount[\($0)]"] = $1 }
        }
        
        if let productData {
            productData.forEach { body["product_data[\($0)]"] = $1 }
        }
        
        if let tiers {
            body["tiers"] = tiers
        }
        
        if let tiersMode {
            body["tiers_mode"] = tiersMode
        }
        
        if let billingScheme {
            billingScheme.forEach { body["billing_scheme[\($0)]"] = $1 }
        }
        
        if let currencyOptions {
            currencyOptions.forEach { body["currency_options[\($0)]"] = $1 }
        }
        
        if let lookupKey {
            body["lookup_key"] = lookupKey
        }
        
        if let taxBehavior {
            body["tax_behavior"] = taxBehavior.rawValue
        }
        
        if let transferLookupKey {
            body["transfer_lookup_key"] = transferLookupKey
        }
        
        if let transformQuantity {
            transformQuantity.forEach { body["transform_quantity[\($0)]"] = $1 }
        }
        
        if let unitAmountDecimal {
            body["unit_amount_decimal"] = unitAmountDecimal
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: prices, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(price: String, expand: [String]? = nil) async throws -> Price {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(prices)/\(price)", query: queryParams, headers: headers)
    }
    
    public func update(price: String,
                       active: Bool?,
                       metadata: [String: String]?,
                       nickname: String?,
                       currencyOptions: [String: [String: Any]]?,
                       lookupKey: String?,
                       taxBehavior: PriceTaxBehavior?,
                       transferLookupKey: String?,
                       expand: [String]?) async throws -> Price {
        
        var body: [String: Any] = [:]
        
        if let active {
            body["active"] = active
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let nickname {
            body["nickname"] = nickname
        }
        
        if let currencyOptions {
            currencyOptions.forEach { body["currency_options[\($0)]"] = $1 }
        }
        
        if let lookupKey {
            body["lookup_key"] = lookupKey
        }
        
        if let taxBehavior {
            body["tax_behavior"] = taxBehavior.rawValue
        }
        
        if let transferLookupKey {
            body["transfer_lookup_key"] = transferLookupKey
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(prices)/\(price)", body: .string(body.queryParameters), headers: headers)
    }
    
    
    
    public func listAll(filter: [String: Any]? = nil) async throws -> PriceList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: prices, query: queryParams, headers: headers)
    }
    
    public func search(query: String,
                       limit: Int? = nil,
                       page: String? = nil) async throws -> PriceSearchResult {
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
