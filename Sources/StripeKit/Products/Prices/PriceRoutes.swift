//
//  PriceRoutes.swift
//  
//
//  Created by Andrew Edwards on 7/21/20.
//

import NIO
import NIOHTTP1
import Foundation

public protocol PriceRoutes {
    /// Creates a new price for an existing product. The price can be recurring or one-time.
    /// - Parameters:
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - unitAmount: A positive integer in cents (or 0 for a free price) representing how much to charge.
    ///   - active: Whether the price is currently active. Defaults to `true`.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - nickname: A brief description of the price, hidden from customers.
    ///   - product: The ID of the product that this price will belong to.
    ///   - recurring: The recurring components of a price such as `interval` and `usage_type`.
    ///   - tiers: Each element represents a pricing tier. This parameter requires `billing_scheme` to be set to `tiered`. See also the documentation for `billing_scheme`.
    ///   - tiersMode: Defines if the tiering price should be `graduated` or `volume` based. In `volume`-based tiering, the maximum quantity within a period determines the per unit price, in `graduated` tiering pricing can successively change as the quantity grows.
    ///   - billingScheme: Describes how to compute the price per period. Either `per_unit` or `tiered`. `per_unit` indicates that the fixed amount (specified in `unit_amount` or `unit_amount_decimal`) will be charged per unit in `quantity` (for prices with `usage_type=licensed`), or per unit of total usage (for prices with `usage_type=metered`). `tiered` indicates that the unit pricing will be computed using a tiering strategy as defined using the `tiers` and `tiers_mode` attributes.
    ///   - lookupKey: A lookup key used to retrieve prices dynamically from a static string.
    ///   - productData: These fields can be used to create a new product that this price will belong to.
    ///   - transferLookupKey: If set to true, will atomically remove the lookup key from the existing price, and assign it to this price.
    ///   - transformQuantity: Apply a transformation to the reported usage or set quantity before computing the billed price. Cannot be combined with `tiers`.
    ///   - unitAmountDecimal: Same as `unit_amount`, but accepts a decimal value with at most 12 decimal places. Only one of `unit_amount` and `unit_amount_decimal` can be set.
    ///  - expand: An array of properties to expand.
    func create(currency: StripeCurrency,
                unitAmount: Int?,
                active: Bool?,
                metadata: [String: String]?,
                nickname: String?,
                product: String?,
                recurring: [String: Any]?,
                tiers: [[String: Any]]?,
                tiersMode: StripePlanTiersMode?,
                billingScheme: [String: Any]?,
                lookupKey: String?,
                productData: [String: Any]?,
                transferLookupKey: String?,
                transformQuantity: [String: Any]?,
                unitAmountDecimal: Decimal?,
                expand: [String]?) -> EventLoopFuture<StripePrice>
    
    /// Retrieves the price with the given ID.
    /// - Parameter price: The ID of the price to retrieve.
    /// - Parameter expand: An array of properties to expand.
    func retrieve(price: String, expand: [String]?) -> EventLoopFuture<StripePrice>
    
    /// Updates the specified price by setting the values of the parameters passed. Any parameters not provided are left unchanged.
    /// - Parameters:
    ///   - price: The ID of the price to update.
    ///   - active: Whether the price is currently active. Defaults to `true`.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - nickname: A brief description of the price, hidden from customers.
    ///   - lookupKey: A lookup key used to retrieve prices dynamically from a static string.
    ///   - transferLookupKey: If set to true, will atomically remove the lookup key from the existing price, and assign it to this price.
    ///   - expand: An array of properties to expand.
    func update(price: String,
                active: Bool?,
                metadata: [String: String]?,
                nickname: String?,
                lookupKey: String?,
                transferLookupKey: String?,
                expand: [String]?) -> EventLoopFuture<StripePrice>
    
    /// Returns a list of your prices.
    /// - Parameter filter: A dictionary that will be used for the query parameters.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripePriceList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension PriceRoutes {
    public func create(currency: StripeCurrency,
                       unitAmount: Int? = nil,
                       active: Bool? = nil,
                       metadata: [String: String]? = nil,
                       nickname: String? = nil,
                       product: String? = nil,
                       recurring: [String: Any]? = nil,
                       tiers: [[String: Any]]? = nil,
                       tiersMode: StripePlanTiersMode? = nil,
                       billingScheme: [String: Any]? = nil,
                       lookupKey: String? = nil,
                       productData: [String: Any]? = nil,
                       transferLookupKey: String? = nil,
                       transformQuantity: [String: Any]? = nil,
                       unitAmountDecimal: Decimal? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripePrice> {
        create(currency: currency,
               unitAmount: unitAmount,
               active: active,
               metadata: metadata,
               nickname: nickname,
               product: product,
               recurring: recurring,
               tiers: tiers,
               tiersMode: tiersMode,
               billingScheme: billingScheme,
               lookupKey: lookupKey,
               productData: productData,
               transferLookupKey: transferLookupKey,
               transformQuantity: transformQuantity,
               unitAmountDecimal: unitAmountDecimal,
               expand: expand)
    }
    
    public func retrieve(price: String, expand: [String]? = nil) -> EventLoopFuture<StripePrice> {
        retrieve(price: price, expand: expand)
    }
    
    public func update(price: String,
                       active: Bool? = nil,
                       metadata: [String: String]? = nil,
                       nickname: String? = nil,
                       lookupKey: String? = nil,
                       transferLookupKey: String? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripePrice> {
        update(price: price,
               active: active,
               metadata: metadata,
               nickname: nickname,
               lookupKey: lookupKey,
               transferLookupKey: transferLookupKey,
               expand: expand)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripePriceList> {
        listAll(filter: filter)
    }
}

public struct StripePriceRoutes: PriceRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let prices = APIBase + APIVersion + "prices"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(currency: StripeCurrency,
                       unitAmount: Int?,
                       active: Bool?,
                       metadata: [String: String]?,
                       nickname: String?,
                       product: String?,
                       recurring: [String: Any]?,
                       tiers: [[String: Any]]?,
                       tiersMode: StripePlanTiersMode?,
                       billingScheme: [String: Any]?,
                       lookupKey: String?,
                       productData: [String: Any]?,
                       transferLookupKey: String?,
                       transformQuantity: [String: Any]?,
                       unitAmountDecimal: Decimal?,
                       expand: [String]?) -> EventLoopFuture<StripePrice> {
        var body: [String: Any] = [:]
        
        body["currency"] = currency.rawValue
        
        if let unitAmount = unitAmount {
            body["unit_amount"] = unitAmount
        }
        
        if let active = active {
            body["active"] = active
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let nickname = nickname {
            body["nickname"] = nickname
        }
        
        if let product = product {
            body["product"] = product
        }
        
        if let recurring = recurring {
            recurring.forEach { body["recurring[\($0)]"] = $1 }
        }
        
        if let tiers = tiers {
            body["tiers"] = tiers
        }
        
        if let tiersMode = tiersMode {
            body["tiers_mode"] = tiersMode.rawValue
        }
        
        if let billingScheme = billingScheme {
            billingScheme.forEach { body["billing_scheme[\($0)]"] = $1 }
        }
        
        if let lookupKey = lookupKey {
            body["lookup_key"] = lookupKey
        }
        
        if let productData = productData {
            productData.forEach { body["product_data[\($0)]"] = $1 }
        }
        
        if let transferLookupKey = transferLookupKey {
            body["transfer_lookup_key"] = transferLookupKey
        }
        
        if let transformQuantity = transformQuantity {
            transformQuantity.forEach { body["transform_quantity[\($0)]"] = $1 }
        }
        
        if let unitAmountDecimal = unitAmountDecimal {
            body["unit_amount_decimal"] = unitAmountDecimal
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: prices, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(price: String, expand: [String]?) -> EventLoopFuture<StripePrice> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(prices)/\(price)", query: queryParams, headers: headers)
    }
    
    public func update(price: String,
                       active: Bool?,
                       metadata: [String: String]?,
                       nickname: String?,
                       lookupKey: String?,
                       transferLookupKey: String?,
                       expand: [String]?) -> EventLoopFuture<StripePrice> {
        
        var body: [String: Any] = [:]
        
        if let active = active {
            body["active"] = active
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let nickname = nickname {
            body["nickname"] = nickname
        }
        
        if let transferLookupKey = transferLookupKey {
            body["transfer_lookup_key"] = transferLookupKey
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(prices)/\(price)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripePriceList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: prices, query: queryParams, headers: headers)
    }
}
