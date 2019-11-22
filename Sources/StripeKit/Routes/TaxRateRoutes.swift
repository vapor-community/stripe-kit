//
//  TaxRateRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/12/19.
//

import NIO
import NIOHTTP1
import Foundation

public protocol TaxRateRoutes {
    /// Creates a new tax rate.
    ///
    /// - Parameters:
    ///   - displayName: The display name of the tax rate, which will be shown to users.
    ///   - inclusive: This specifies if the tax rate is inclusive or exclusive.
    ///   - percentage: This represents the tax rate percent out of 100.
    ///   - active: Flag determining whether the tax rate is active or inactive. Inactive tax rates continue to work where they are currently applied however they cannot be used for new applications.
    ///   - description: An arbitrary string attached to the tax rate for your internal use only. It will not be visible to your customers.
    ///   - jurisdiction: The jurisdiction for the tax rate.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    /// - Returns: A `StripeTaxRate`.
    func create(displayName: String,
                inclusive: Bool,
                percentage: String,
                active: Bool?,
                description: String?,
                jurisdiction: String?,
                metadata: [String: String]?) -> EventLoopFuture<StripeTaxRate>
    
    /// Retrieves a tax rate with the given ID
    ///
    /// - Parameter taxRate: The ID of the desired tax rate.
    /// - Returns: A `StripeTaxRate`.
    func retrieve(taxRate: String) -> EventLoopFuture<StripeTaxRate>
    
    /// Updates an existing tax rate.
    ///
    /// - Parameters:
    ///   - taxRate: ID of the tax rate to update.
    ///   - active: Flag determining whether the tax rate is active or inactive. Inactive tax rates continue to work where they are currently applied however they cannot be used for new applications.
    ///   - description: An arbitrary string attached to the tax rate for your internal use only. It will not be visible to your customers. This will be unset if you POST an empty value.
    ///   - desplayName: The display name of the tax rate, which will be shown to users.
    ///   - jurisdiction: The jurisdiction for the tax rate. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    /// - Returns: A `StripeTaxRate`.
    func update(taxRate: String,
                active: Bool?,
                description: String?,
                displayName: String?,
                jurisdiction: String?,
                metadata: [String: String]?) -> EventLoopFuture<StripeTaxRate>
    
    /// Returns a list of your tax rates. Tax rates are returned sorted by creation date, with the most recently created tax rates appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/tax_rates/list)
    /// - Returns: A `StripeTaxRateList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeTaxRateList>
    
    var headers: HTTPHeaders { get set }
}

extension TaxRateRoutes {
    public func create(displayName: String,
                       inclusive: Bool,
                       percentage: String,
                       active: Bool? = nil,
                       description: String? = nil,
                       jurisdiction: String? = nil,
                       metadata: [String: String]? = nil) -> EventLoopFuture<StripeTaxRate> {
        return create(displayName: displayName,
                          inclusive: inclusive,
                          percentage: percentage,
                          active: active,
                          description: description,
                          jurisdiction: jurisdiction,
                          metadata: metadata)
    }
    
    public func retrieve(taxRate: String) -> EventLoopFuture<StripeTaxRate> {
        return retrieve(taxRate: taxRate)
    }
    
    public func update(taxRate: String,
                       active: Bool? = nil,
                       description: String? = nil,
                       displayName: String? = nil,
                       jurisdiction: String? = nil,
                       metadata: [String: String]? = nil) -> EventLoopFuture<StripeTaxRate> {
        return update(taxRate: taxRate,
                          active: active,
                          description: description,
                          displayName: displayName,
                          jurisdiction: jurisdiction,
                          metadata: metadata)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeTaxRateList> {
        return listAll(filter: filter)
    }
}

public struct StripeTaxRateRoutes: TaxRateRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(displayName: String,
                       inclusive: Bool,
                       percentage: String,
                       active: Bool?,
                       description: String?,
                       jurisdiction: String?,
                       metadata: [String: String]?) -> EventLoopFuture<StripeTaxRate> {
        var body: [String: Any] = ["display_name": displayName,
                                   "inclusive": inclusive,
                                   "percentage": percentage]
        
        if let active = active {
            body["active"] = active
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let jurisdiction = jurisdiction {
            body["jurisdiction"] = jurisdiction
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: StripeAPIEndpoint.taxRate.endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(taxRate: String) -> EventLoopFuture<StripeTaxRate> {
        return apiHandler.send(method: .GET, path: StripeAPIEndpoint.taxRates(taxRate).endpoint, headers: headers)
    }
    
    public func update(taxRate: String,
                       active: Bool?,
                       description: String?,
                       displayName: String?,
                       jurisdiction: String?,
                       metadata: [String: String]?) -> EventLoopFuture<StripeTaxRate> {
        var body: [String: Any] = [:]
        
        if let active = active {
            body["active"] = active
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let displayName = displayName {
            body["display_name"] = displayName
        }
        
        if let jurisdiction = jurisdiction {
            body["jurisdiction"] = jurisdiction
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: StripeAPIEndpoint.taxRates(taxRate).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeTaxRateList> {
        var queryParams = ""
        if let filter = filter {
            queryParams += filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: StripeAPIEndpoint.taxRate.endpoint, query: queryParams, headers: headers)
    }
}
