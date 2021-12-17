//
//  ShippingRateRoutes.swift
//  
//
//  Created by Andrew Edwards on 12/17/21.
//

import NIO
import NIOHTTP1
import Foundation

public protocol ShippingRateRoutes {
    /// Updates an existing shipping rate object.
    /// - Parameters:
    /// - displayName: The name of the shipping rate, meant to be displayable to the customer. This will appear on CheckoutSessions.
    /// - type: The type of calculation to use on the shipping rate. Can only be f`ixed_amount` for now.
    /// - fixedAmount: Describes a fixed amount to charge for shipping. Must be present if type is `fixed_amount`.
    /// - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    /// - deliveryEstimate: The estimated range for how long shipping will take, meant to be displayable to the customer. This will appear on CheckoutSessions.
    /// - taxBehavior: Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of inclusive, exclusive, or unspecified.
    /// - taxCode: A tax code ID. The Shipping tax code is `txcd_92010001`.
    /// - Returns: A `StripeShippingRate`
    func create(displayName: String,
                type: StripeShippingRateType,
                fixedAmount: [String: Any]?,
                metadata: [String: String]?,
                deliveryEstimate: [String: Any]?,
                taxBehavior: StripeShippingRateTaxBehavior?,
                taxCode: String?) -> EventLoopFuture<StripeShippingRate>
    
    /// Returns the shipping rate object with the given ID.
    /// - Parameter id: The ID of the shipping rate.
    /// - Returns: A `StripeShippingRate`
    func retrieve(id: String) -> EventLoopFuture<StripeShippingRate>
    
    /// Updates an existing shipping rate object.
    /// - Parameters:
    /// - id: The id of the shipping rate.
    /// - active: Whether the shipping rate can be used for new purchases. Defaults to true.
    /// - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    /// - Returns: A `StripeShippingRate`
    func update(id: String, active: Bool?, metadata: [String: String]?) -> EventLoopFuture<StripeShippingRate>
    
    /// Returns a list of your shipping rates.
    /// - Parameter filter: A dictionary that will be used for the query parameters.
    /// - Returns: A `StripeShippingRateList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeShippingRateList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension ShippingRateRoutes {
    public func create(displayName: String,
                       type: StripeShippingRateType,
                       fixedAmount: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       deliveryEstimate: [String: Any]? = nil,
                       taxBehavior: StripeShippingRateTaxBehavior? = nil,
                       taxCode: String? = nil) -> EventLoopFuture<StripeShippingRate> {
        create(displayName: displayName,
               type: type,
               fixedAmount: fixedAmount,
               metadata: metadata,
               deliveryEstimate: deliveryEstimate,
               taxBehavior: taxBehavior,
               taxCode: taxCode)
    }
    
    public func retrieve(id: String) -> EventLoopFuture<StripeShippingRate> {
        retrieve(id: id)
    }
    
    func update(id: String, active: Bool? = nil, metadata: [String: String]? = nil) -> EventLoopFuture<StripeShippingRate> {
        update(id: id, active: active, metadata: metadata)
    }
    
    func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeShippingRateList> {
        listAll(filter: filter)
    }
}

public struct StripeShippingRateRoutes: ShippingRateRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let shippingrates = APIBase + APIVersion + "shipping_rates"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(displayName: String,
                       type: StripeShippingRateType,
                       fixedAmount: [String: Any]?,
                       metadata: [String: String]?,
                       deliveryEstimate: [String: Any]?,
                       taxBehavior: StripeShippingRateTaxBehavior?,
                       taxCode: String?) -> EventLoopFuture<StripeShippingRate> {
        var body: [String: Any] = ["display_name": displayName,
                                   "type": type.rawValue]
        
        if let fixedAmount = fixedAmount {
            fixedAmount.forEach { body["fixed_amount[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let deliveryEstimate = deliveryEstimate {
            deliveryEstimate.forEach { body["delivery_estimate[\($0)]"] = $1 }
        }
        
        if let taxBehavior = taxBehavior {
            body["tax_behavior"] = taxBehavior.rawValue
        }
        
        if let taxCode = taxCode {
            body["tax_code"] = taxCode
        }
        
        return apiHandler.send(method: .POST, path: shippingrates, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(id: String) -> EventLoopFuture<StripeShippingRate> {
        apiHandler.send(method: .GET, path: "\(shippingrates)/\(id)", headers: headers)
    }
    
    public func update(id: String, active: Bool?, metadata: [String: String]?) -> EventLoopFuture<StripeShippingRate> {
        var body: [String: Any] = [:]
        
        if let active = active {
            body["active"] = active
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: "\(shippingrates)/\(id)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeShippingRateList> {
        var queryParams = ""
        if let filter = filter {
            queryParams += filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: shippingrates, query: queryParams, headers: headers)
    }
}
