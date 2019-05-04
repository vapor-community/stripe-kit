//
//  CouponRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/28/17.
//
//

import NIO
import NIOHTTP1
import Foundation

public protocol CouponRoutes {
    /// You can create coupons easily via the [coupon management page](https://dashboard.stripe.com/coupons) of the Stripe dashboard. Coupon creation is also accessible via the API if you need to create coupons on the fly. /n A coupon has either a `percent_off` or an `amount_off` and `currency`. If you set an `amount_off`, that amount will be subtracted from any invoice’s subtotal. For example, an invoice with a subtotal of $100 will have a final total of $0 if a coupon with an `amount_off` of 20000 is applied to it and an invoice with a subtotal of $300 will have a final total of $100 if a coupon with an `amount_off` of 20000 is applied to it.
    ///
    /// - Parameters:
    ///   - id: Unique string of your choice that will be used to identify this coupon when applying it to a customer. This is often a specific code you’ll give to your customer to use when signing up (e.g., `FALL25OFF`). If you don’t want to specify a particular code, you can leave the ID blank and we’ll generate a random code for you.
    ///   - duration: Specifies how long the discount will be in effect. Can be `forever`, `once`, or `repeating`.
    ///   - amountOff: A positive integer representing the amount to subtract from an invoice total (required if `percent_off` is not passed).
    ///   - currency: Three-letter ISO code for the currency of the `amount_off` parameter (required if `amount_off` is passed).
    ///   - durationInMonths: Required only if `duration` is `repeating`, in which case it must be a positive integer that specifies the number of months the discount will be in effect.
    ///   - maxRedemptions: A positive integer specifying the number of times the coupon can be redeemed before it’s no longer valid. For example, you might have a 50% off coupon that the first 20 readers of your blog can use.
    ///   - metadata: A set of key-value pairs that you can attach to a coupon object. It can be useful for storing additional information about the coupon in a structured format.
    ///   - name: Name of the coupon displayed to customers on, for instance invoices, or receipts. By default the id is shown if name is not set.
    ///   - percentOff: A positive float larger than 0, and smaller or equal to 100, that represents the discount the coupon will apply (required if amount_off is not passed).
    ///   - redeemBy: Unix timestamp specifying the last time at which the coupon can be redeemed. After the redeem_by date, the coupon can no longer be applied to new customers.
    /// - Returns: A `StripeCoupon`.
    /// - Throws: A `StripeError`.
    func create(id: String?,
                duration: StripeCouponDuration,
                amountOff: Int?,
                currency: StripeCurrency?,
                durationInMonths: Int?,
                maxRedemptions: Int?,
                metadata: [String: String]?,
                name: String?,
                percentOff: Int?,
                redeemBy: Date?) throws -> EventLoopFuture<StripeCoupon>
    
    /// Retrieves the coupon with the given ID.
    ///
    /// - Parameter coupon: The ID of the desired coupon.
    /// - Returns: A `StripeCoupon`.
    /// - Throws: A `StripeError`.
    func retrieve(coupon: String) throws -> EventLoopFuture<StripeCoupon>
    
    /// Updates the metadata of a coupon. Other coupon details (currency, duration, amount_off) are, by design, not editable.
    ///
    /// - Parameters:
    ///   - coupon: The identifier of the coupon to be updated.
    ///   - metadata: A set of key-value pairs that you can attach to a coupon object. It can be useful for storing additional information about the coupon in a structured format.
    ///   - name: Name of the coupon displayed to customers on, for instance invoices, or receipts. By default the id is shown if name is not set.
    /// - Returns: A `StripeCoupon`.
    /// - Throws: A `StripeError`.
    func update(coupon: String, metadata: [String: String]?, name: String?) throws -> EventLoopFuture<StripeCoupon>
    
    /// You can delete coupons via the [coupon management page](https://dashboard.stripe.com/coupons) of the Stripe dashboard. However, deleting a coupon does not affect any customers who have already applied the coupon; it means that new customers can’t redeem the coupon. You can also delete coupons via the API.
    ///
    /// - Parameter coupon: The identifier of the coupon to be deleted.
    /// - Returns: A `StripeDeletedObject`.
    /// - Throws: A `StripeError`.
    func delete(coupon: String) throws -> EventLoopFuture<StripeDeletedObject>
    
    /// Returns a list of your coupons.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/coupons/list?lang=curl).
    /// - Returns: A `StripeCouponList`.
    /// - Throws: A `StripeError`.
    func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeCouponList>
    
    mutating func addHeaders(_ : HTTPHeaders)
}

extension CouponRoutes {
    public func create(id: String? = nil,
                       duration: StripeCouponDuration,
                       amountOff: Int? = nil,
                       currency: StripeCurrency? = nil,
                       durationInMonths: Int? = nil,
                       maxRedemptions: Int? = nil,
                       metadata: [String: String]? = nil,
                       name: String? = nil,
                       percentOff: Int? = nil,
                       redeemBy: Date? = nil) throws -> EventLoopFuture<StripeCoupon> {
        return try create(id: id,
                          duration: duration,
                          amountOff: amountOff,
                          currency: currency,
                          durationInMonths: durationInMonths,
                          maxRedemptions: maxRedemptions,
                          metadata: metadata,
                          name: name,
                          percentOff: percentOff,
                          redeemBy: redeemBy)
    }
    
    public func retrieve(coupon: String) throws -> EventLoopFuture<StripeCoupon> {
        return try retrieve(coupon: coupon)
    }
    
    public func update(coupon: String, metadata: [String: String]? = nil, name: String? = nil) throws -> EventLoopFuture<StripeCoupon> {
        return try update(coupon: coupon, metadata: metadata, name: name)
    }
    
    public func delete(coupon: String) throws -> EventLoopFuture<StripeDeletedObject> {
        return try delete(coupon: coupon)
    }
    
    public func listAll(filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeCouponList> {
        return try listAll(filter: filter)
    }
}

public struct StripeCouponRoutes: CouponRoutes {
    private let apiHandler: StripeAPIHandler
    private var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public mutating func addHeaders(_ _headers: HTTPHeaders) {
        _headers.forEach { self.headers.replaceOrAdd(name: $0.name, value: $0.value) }
    }

    public func create(id: String?,
                       duration: StripeCouponDuration,
                       amountOff: Int?,
                       currency: StripeCurrency?,
                       durationInMonths: Int?,
                       maxRedemptions: Int?,
                       metadata: [String: String]?,
                       name: String?,
                       percentOff: Int?,
                       redeemBy: Date?) throws -> EventLoopFuture<StripeCoupon> {
        var body: [String: Any] = ["duration": duration.rawValue]
        
        if let id = id {
            body["id"] = id
        }

        if let amountOff = amountOff {
            body["amount_off"] = amountOff
        }

        if let currency = currency {
            body["currency"] = currency.rawValue
        }

        if let durationInMonths = durationInMonths {
            body["duration_in_months"] = durationInMonths
        }

        if let maxRedemptions = maxRedemptions {
            body["max_redemptions"] = maxRedemptions
        }

        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let name = name {
            body["name"] = name
        }
        
        if let percentOff = percentOff {
            body["percent_off"] = percentOff
        }

        if let redeemBy = redeemBy {
            body["redeem_by"] = Int(redeemBy.timeIntervalSince1970)
        }

        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.coupons.endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(coupon: String) throws -> EventLoopFuture<StripeCoupon> {
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.coupon(coupon).endpoint, headers: headers)
    }
    
    public func update(coupon: String, metadata: [String: String]?, name: String?) throws -> EventLoopFuture<StripeCoupon> {
        var body: [String: Any] = [:]
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let name = name {
            body["name"] = name
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.coupon(coupon).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(coupon: String) throws -> EventLoopFuture<StripeDeletedObject> {
        return try apiHandler.send(method: .DELETE, path: StripeAPIEndpoint.coupon(coupon).endpoint, headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeCouponList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }

        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.coupons.endpoint, query: queryParams, headers: headers)
    }
}
