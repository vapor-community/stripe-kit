//
//  ShippingRateRoutes.swift
//  
//
//  Created by Andrew Edwards on 12/17/21.
//

import NIO
import NIOHTTP1
import Foundation

public protocol ShippingRateRoutes: StripeAPIRoute {
    /// Updates an existing shipping rate object.
    /// - Parameters:
    ///  - displayName: The name of the shipping rate, meant to be displayable to the customer. This will appear on CheckoutSessions.
    ///  - type: The type of calculation to use on the shipping rate. Can only be `fixed_amount` for now.
    ///  - fixedAmount: Describes a fixed amount to charge for shipping. Must be present if type is `fixed_amount`.
    ///  - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///  - deliveryEstimate: The estimated range for how long shipping will take, meant to be displayable to the customer. This will appear on CheckoutSessions.
    ///  - taxBehavior: Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`.
    ///  - taxCode: A tax code ID. The Shipping tax code is `txcd_92010001`.
    ///  - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns a shipping rate object if the call succeeded.
    func create(displayName: String,
                type: ShippingRateType,
                fixedAmount: [String: Any]?,
                metadata: [String: String]?,
                deliveryEstimate: [String: Any]?,
                taxBehavior: ShippingRateTaxBehavior?,
                taxCode: String?,
                expand: [String]?) async throws -> ShippingRate
    
    /// Returns the shipping rate object with the given ID.
    /// - Parameter id: The ID of the shipping rate.
    /// - Parameter array: Specifies which fields in the response should be expanded.
    /// - Returns: Returns a shipping rate object if a valid identifier was provided.
    func retrieve(id: String, expand: [String]?) async throws -> ShippingRate
    
    /// Updates an existing shipping rate object.
    /// - Parameters:
    ///   - id: The id of the shipping rate.
    ///   - active: Whether the shipping rate can be used for new purchases. Defaults to true.
    ///   - fixedAmount: Describes a fixed amount to charge for shipping. Must be present if type is `fixed_amount`.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - taxBehavior: Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns the modified shipping rate object if the call succeeded.
    func update(id: String,
                active: Bool?,
                fixedAmount: [String: Any]?,
                metadata: [String: String]?,
                taxBehavior: ShippingRateTaxBehavior?,
                expand: [String]?) async throws -> ShippingRate
    
    /// Returns a list of your shipping rates.
    /// - Parameter filter: A dictionary that will be used for the query parameters.
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` shipping rates, starting after shipping rate `starting_after`. Each entry in the array is a separate shipping rate object. If no more shipping rates are available, the resulting array will be empty. This require should never return an error.
    func listAll(filter: [String: Any]?) async throws -> ShippingRateList
}

public struct StripeShippingRateRoutes: ShippingRateRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let shippingrates = APIBase + APIVersion + "shipping_rates"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(displayName: String,
                       type: ShippingRateType,
                       fixedAmount: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       deliveryEstimate: [String: Any]? = nil,
                       taxBehavior: ShippingRateTaxBehavior? = nil,
                       taxCode: String? = nil,
                       expand: [String]? = nil) async throws -> ShippingRate {
        var body: [String: Any] = ["display_name": displayName,
                                   "type": type.rawValue]
        
        if let fixedAmount {
            fixedAmount.forEach { body["fixed_amount[\($0)]"] = $1 }
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let deliveryEstimate {
            deliveryEstimate.forEach { body["delivery_estimate[\($0)]"] = $1 }
        }
        
        if let taxBehavior {
            body["tax_behavior"] = taxBehavior.rawValue
        }
        
        if let taxCode {
            body["tax_code"] = taxCode
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: shippingrates, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(id: String, expand: [String]? = nil) async throws -> ShippingRate {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .GET, path: "\(shippingrates)/\(id)", query: body.queryParameters, headers: headers)
    }
    
    public func update(id: String,
                       active: Bool? = nil,
                       fixedAmount: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       taxBehavior: ShippingRateTaxBehavior? = nil,
                       expand: [String]? = nil) async throws -> ShippingRate {
        var body: [String: Any] = [:]
        
        if let active {
            body["active"] = active
        }
        
        if let fixedAmount {
            fixedAmount.forEach { body["fixed_amount[\($0)]"] = $1 }
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let taxBehavior {
            body["tax_behavior"] = taxBehavior.rawValue
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(shippingrates)/\(id)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> ShippingRateList {
        var queryParams = ""
        if let filter {
            queryParams += filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: shippingrates, query: queryParams, headers: headers)
    }
}
