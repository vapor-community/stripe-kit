//
//  PromotionCodesRoutes.swift
//  
//
//  Created by Andrew Edwards on 11/10/20.
//

import NIO
import NIOHTTP1
import Foundation

public protocol PromotionCodesRoutes {
    
    /// A promotion code points to a coupon. You can optionally restrict the code to a specific customer, redemption limit, and expiration date.
    /// - Parameters:
    ///   - coupon: The coupon for this promotion code.
    ///   - code: The customer-facing code. Regardless of case, this code must be unique across all active promotion codes for a specific customer. If left blank, we will generate one automatically.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - active: Whether the promotion code is currently active.
    ///   - customer: The customer that this promotion code can be used by. If not set, the promotion code can be used by all customers.
    ///   - expiresAt: The timestamp at which this promotion code will expire. If the coupon has specified a `redeems_by`, then this value cannot be after the coupon’s `redeems_by`.
    ///   - maxRedemptions: A positive integer specifying the number of times the promotion code can be redeemed. If the coupon has specified a `max_redemptions`, then this value cannot be greater than the coupon’s `max_redemptions`.
    ///   - restrictions: Settings that restrict the redemption of the promotion code.
    func create(coupon: String,
                code: String?,
                metadata: [String: String]?,
                active: Bool?,
                customer: String?,
                expiresAt: Date?,
                maxRedemptions: Int?,
                restrictions: [String: Any]?) -> EventLoopFuture<StripePromotionCode>
    
    /// Updates the specified promotion code by setting the values of the parameters passed. Most fields are, by design, not editable.
    /// - Parameters:
    ///   - promotionCode: The identifier of the promotion code to update.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - active: Whether the promotion code is currently active. A promotion code can only be reactivated when the coupon is still valid and the promotion code is otherwise redeemable.
    func update(promotionCode: String,
                metadata: [String: String]?,
                active: Bool?) -> EventLoopFuture<StripePromotionCode>
    
    /// Retrieves the promotion code with the given ID.
    /// - Parameter promotionCode: The identifier of the promotion code to retrieve.
    func retrieve(promotionCode: String) -> EventLoopFuture<StripePromotionCode>
    
    /// Returns a list of your promotion codes.
    /// - Parameter filter: A dictionary that will be used for the query parameters.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripePromotionCodeList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension PromotionCodesRoutes {
    public func create(coupon: String,
                       code: String? = nil,
                       metadata: [String: String]? = nil,
                       active: Bool? = nil,
                       customer: String? = nil,
                       expiresAt: Date? = nil,
                       maxRedemptions: Int? = nil,
                       restrictions: [String: Any]? = nil) -> EventLoopFuture<StripePromotionCode> {
        create(coupon: coupon,
               code: code,
               metadata: metadata,
               active: active,
               customer: customer,
               expiresAt: expiresAt,
               maxRedemptions: maxRedemptions,
               restrictions: restrictions)
    }
    
    public func update(promotionCode: String,
                       metadata: [String: String]? = nil,
                       active: Bool? = nil) -> EventLoopFuture<StripePromotionCode> {
        update(promotionCode: promotionCode, metadata: metadata, active: active)
    }
    
    public func retrieve(promotionCode: String) -> EventLoopFuture<StripePromotionCode> {
        retrieve(promotionCode: promotionCode)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripePromotionCodeList> {
        listAll(filter: filter)
    }
}

public struct StripePromotionCodesRoutes: PromotionCodesRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let promotionCodes = APIBase + APIVersion + "promotion_codes"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(coupon: String,
                       code: String?,
                       metadata: [String: String]?,
                       active: Bool?,
                       customer: String?,
                       expiresAt: Date?,
                       maxRedemptions: Int?,
                       restrictions: [String: Any]?) -> EventLoopFuture<StripePromotionCode> {
        var body: [String: Any] = ["coupon": coupon]
        
        if let code = code {
            body["code"] = code
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let active = active {
            body["active"] = active
        }
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let expiresAt = expiresAt {
            body["expiresAt"] = Int(expiresAt.timeIntervalSince1970)
        }
        
        if let maxRedemptions = maxRedemptions {
            body["max_redemptions"] = maxRedemptions
        }
        
        if let restrictions = restrictions {
            restrictions.forEach { body["restrictions[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: promotionCodes, body: .string(body.queryParameters), headers: headers)
    }
    
    public func update(promotionCode: String,
                       metadata: [String: String]?,
                       active: Bool?) -> EventLoopFuture<StripePromotionCode> {
        var body: [String: Any] = [:]
        
        if let active = active {
            body["active"] = active
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: "\(promotionCodes)/\(promotionCode)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(promotionCode: String) -> EventLoopFuture<StripePromotionCode> {
        apiHandler.send(method: .GET, path: "\(promotionCodes)/\(promotionCode)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripePlanList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: promotionCodes, query: queryParams, headers: headers)
    }
}
