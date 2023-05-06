//
//  TaxRateRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/12/19.
//

import NIO
import NIOHTTP1
import Foundation

public protocol TaxRateRoutes: StripeAPIRoute {
    /// Creates a new tax rate.
    ///
    /// - Parameters:
    ///   - displayName: The display name of the tax rate, which will be shown to users.
    ///   - inclusive: This specifies if the tax rate is inclusive or exclusive.
    ///   - percentage: This represents the tax rate percent out of 100.
    ///   - active: Flag determining whether the tax rate is active or inactive. Inactive tax rates continue to work where they are currently applied however they cannot be used for new applications.
    ///   - country: Two-letter country code.
    ///   - description: An arbitrary string attached to the tax rate for your internal use only. It will not be visible to your customers.
    ///   - jurisdiction: The jurisdiction for the tax rate.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - state: ISO 3166-2 subdivision code, without country prefix. For example, “NY” for New York, United States.
    ///   - taxType: The high-level tax type, such as `vat` or `sales_tax`.
    /// - Returns: The created tax rate object.
    func create(displayName: String,
                inclusive: Bool,
                percentage: String,
                active: Bool?,
                country: String?,
                description: String?,
                jurisdiction: String?,
                metadata: [String: String]?,
                state: String?,
                taxType: TaxRateTaxType?) async throws -> TaxRate
    
    /// Retrieves a tax rate with the given ID
    ///
    /// - Parameter taxRate: The ID of the desired tax rate.
    /// - Returns: Returns an tax rate if a valid tax rate ID was provided. Returns an error otherwise.
    func retrieve(taxRate: String) async throws -> TaxRate
    
    /// Updates an existing tax rate.
    ///
    /// - Parameters:
    ///   - taxRate: ID of the tax rate to update.
    ///   - active: Flag determining whether the tax rate is active or inactive. Inactive tax rates continue to work where they are currently applied however they cannot be used for new applications.
    ///   - country: Two-letter country code.
    ///   - description: An arbitrary string attached to the tax rate for your internal use only. It will not be visible to your customers. This will be unset if you POST an empty value.
    ///   - desplayName: The display name of the tax rate, which will be shown to users.
    ///   - jurisdiction: The jurisdiction for the tax rate. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - state: ISO 3166-2 subdivision code, without country prefix. For example, “NY” for New York, United States.
    ///   - taxType: The high-level tax type, such as `vat` or `sales_tax`.
    /// - Returns: The updated tax rate.
    func update(taxRate: String,
                active: Bool?,
                country: String?,
                description: String?,
                displayName: String?,
                jurisdiction: String?,
                metadata: [String: String]?,
                state: String?,
                taxType: TaxRateTaxType?) async throws -> TaxRate
    
    /// Returns a list of your tax rates. Tax rates are returned sorted by creation date, with the most recently created tax rates appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/tax_rates/list)
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` tax rates, starting after tax rate `starting_after`. Each entry in the array is a separate tax rate object. If no more tax rates are available, the resulting array will be empty. This request should never return an error.
    func listAll(filter: [String: Any]?) async throws -> TaxRateList
}

public struct StripeTaxRateRoutes: TaxRateRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let taxrates = APIBase + APIVersion + "tax_rates"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(displayName: String,
                       inclusive: Bool,
                       percentage: String,
                       active: Bool? = nil,
                       country: String? = nil,
                       description: String? = nil,
                       jurisdiction: String? = nil,
                       metadata: [String: String]? = nil,
                       state: String? = nil,
                       taxType: TaxRateTaxType? = nil) async throws -> TaxRate {
        var body: [String: Any] = ["display_name": displayName,
                                   "inclusive": inclusive,
                                   "percentage": percentage]
        
        if let active {
            body["active"] = active
        }
        
        if let country {
            body["country"] = country
        }
        
        if let description {
            body["description"] = description
        }
        
        if let jurisdiction {
            body["jurisdiction"] = jurisdiction
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let state {
            body["state"] = state
        }
        
        if let taxType {
            body["tax_type"] = taxType.rawValue
        }
        
        return try await apiHandler.send(method: .POST, path: taxrates, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(taxRate: String) async throws -> TaxRate {
        try await apiHandler.send(method: .GET, path: "\(taxrates)/\(taxRate)", headers: headers)
    }
    
    public func update(taxRate: String,
                       active: Bool? = nil,
                       country: String? = nil,
                       description: String? = nil,
                       displayName: String? = nil,
                       jurisdiction: String? = nil,
                       metadata: [String: String]? = nil,
                       state: String? = nil,
                       taxType: TaxRateTaxType? = nil) async throws -> TaxRate {
        var body: [String: Any] = [:]
        
        if let active {
            body["active"] = active
        }
        
        if let country {
            body["country"] = country
        }
        
        if let description {
            body["description"] = description
        }
        
        if let displayName {
            body["display_name"] = displayName
        }
        
        if let jurisdiction {
            body["jurisdiction"] = jurisdiction
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let state {
            body["state"] = state
        }
        
        if let taxType {
            body["tax_type"] = taxType.rawValue
        }
        
        return try await apiHandler.send(method: .POST, path: "\(taxrates)/\(taxRate)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> TaxRateList {
        var queryParams = ""
        if let filter {
            queryParams += filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: taxrates, query: queryParams, headers: headers)
    }
}
