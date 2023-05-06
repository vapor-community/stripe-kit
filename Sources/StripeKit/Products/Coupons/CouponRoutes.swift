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

public protocol CouponRoutes: StripeAPIRoute {
    /// You can create coupons easily via the [coupon management page](https://dashboard.stripe.com/coupons) of the Stripe dashboard. Coupon creation is also accessible via the API if you need to create coupons on the fly.
    ///
    /// A coupon has either a `percent_off` or an `amount_off` and `currency`. If you set an `amount_off`, that amount will be subtracted from any invoice’s subtotal. For example, an invoice with a subtotal of $100 will have a final total of $0 if a coupon with an `amount_off` of 20000 is applied to it and an invoice with a subtotal of $300 will have a final total of $100 if a coupon with an `amount_off` of 20000 is applied to it.
    ///
    /// - Parameters:
    ///   - amountOff: A positive integer representing the amount to subtract from an invoice total (required if `percent_off` is not passed).
    ///   - duration: Specifies how long the discount will be in effect. Can be `forever`, `once`, or `repeating`.
    ///   - currency: Three-letter ISO code for the currency of the `amount_off` parameter (required if `amount_off` is passed).
    ///   - durationInMonths: Required only if `duration` is `repeating`, in which case it must be a positive integer that specifies the number of months the discount will be in effect.
    ///   - maxRedemptions: A positive integer specifying the number of times the coupon can be redeemed before it’s no longer valid. For example, you might have a 50% off coupon that the first 20 readers of your blog can use.
    ///   - metadata: A set of key-value pairs that you can attach to a coupon object. It can be useful for storing additional information about the coupon in a structured format.
    ///   - name: Name of the coupon displayed to customers on, for instance invoices, or receipts. By default the id is shown if name is not set.
    ///   - percentOff: A positive float larger than 0, and smaller or equal to 100, that represents the discount the coupon will apply (required if `amount_off` is not passed).
    ///   - id: Unique string of your choice that will be used to identify this coupon when applying it to a customer. If you don’t want to specify a particular code, you can leave the ID blank and we’ll generate a random code for you.
    ///   - appliesTo: A hash containing directions for what this Coupon will apply discounts to.
    ///   - currencyOptions: Coupons defined in each available currency option (only supported if `amount_off` is passed). Each key must be a three-letter ISO currency code and a supported currency. For example, to define your coupon in eur, pass the fields below in the eur key of `currency_options`.
    ///   - maxRedemptions: A positive integer specifying the number of times the coupon can be redeemed before it’s no longer valid. For example, you might have a 50% off coupon that the first 20 readers of your blog can use.
    ///   - redeemBy: Unix timestamp specifying the last time at which the coupon can be redeemed. After the `redeem_by` date, the coupon can no longer be applied to new customers.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns the coupon object.
    func create(amountOff: Int?,
                currency: Currency?,
                duration: CouponDuration?,
                durationInMonths: Int?,
                metadata: [String: String]?,
                name: String?,
                percentOff: Int?,
                id: String?,
                appliesTo: CouponAppliesTo?,
                currencyOptions: [Currency: CouponCurrencyOptions]?,
                maxRedemptions: Int?,
                redeemBy: Date?,
                expand: [String]?) async throws -> Coupon
    
    /// Retrieves the coupon with the given ID.
    ///
    /// - Parameter coupon: The ID of the desired coupon.
    /// - Returns: Returns a coupon if a valid coupon ID was provided. Returns an error otherwise.
    func retrieve(coupon: String, expand: [String]?) async throws -> Coupon
    
    /// Updates the metadata of a coupon. Other coupon details (currency, duration, `amount_off`) are, by design, not editable.
    ///
    /// - Parameters:
    ///   - coupon: The identifier of the coupon to be updated.
    ///   - metadata: A set of key-value pairs that you can attach to a coupon object. It can be useful for storing additional information about the coupon in a structured format.
    ///   - name: Name of the coupon displayed to customers on, for instance invoices, or receipts. By default the id is shown if name is not set.
    ///   - currencyOptions: Coupons defined in each available currency option (only supported if the coupon is amount-based). Each key must be a three-letter ISO currency code and a supported currency. For example, to define your coupon in eur, pass the fields below in the eur key of `currency_options`.
    /// - Returns: The newly updated coupon object if the call succeeded. Otherwise, this call returns an error, such as if the coupon has been deleted.
    func update(coupon: String,
                metadata: [String: String]?,
                name: String?,
                currencyOptions: [Currency: CouponCurrencyOptions]?,
                expand: [String]?) async throws -> Coupon
    
    /// You can delete coupons via the [coupon management](https://dashboard.stripe.com/coupons) page of the Stripe dashboard. However, deleting a coupon does not affect any customers who have already applied the coupon; it means that new customers can’t redeem the coupon. You can also delete coupons via the API.
    ///
    /// - Parameter coupon: The identifier of the coupon to be deleted.
    /// - Returns: An object with the deleted coupon’s ID and a deleted flag upon success. Otherwise, this call returns an error, such as if the coupon has already been deleted
    func delete(coupon: String) async throws -> DeletedObject
    
    /// Returns a list of your coupons.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/coupons/list) .
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` coupons, starting after coupon `starting_after`. Each entry in the array is a separate coupon object. If no more coupons are available, the resulting array will be empty. This request should never return an error.
    func listAll(filter: [String: Any]?) async throws -> CouponList
}

public struct StripeCouponRoutes: CouponRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let coupons = APIBase + APIVersion + "coupons"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(amountOff: Int? = nil,
                       currency: Currency? = nil,
                       duration: CouponDuration? = nil,
                       durationInMonths: Int? = nil,
                       metadata: [String: String]? = nil,
                       name: String? = nil,
                       percentOff: Int? = nil,
                       id: String? = nil,
                       appliesTo: CouponAppliesTo? = nil,
                       currencyOptions: [Currency: CouponCurrencyOptions]? = nil,
                       maxRedemptions: Int? = nil,
                       redeemBy: Date? = nil,
                       expand: [String]? = nil) async throws -> Coupon {
        var body: [String: Any] = [:]
        
        if let amountOff {
            body["amount_off"] = amountOff
        }
        
        if let currency {
            body["currency"] = currency.rawValue
        }
        
        if let duration {
            body["duration"] = duration.rawValue
        }
        
        if let durationInMonths {
            body["duration_in_months"] = durationInMonths
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let name {
            body["name"] = name
        }
        
        if let percentOff {
            body["percent_off"] = percentOff
        }
        
        if let id {
            body["id"] = id
        }

        if let appliesTo {
            body["applies_to"] = appliesTo
        }

        if let currencyOptions {
            currencyOptions.forEach { body["currency_options[\($0.rawValue)]"] = $1 }
        }

        if let maxRedemptions {
            body["max_redemptions"] = maxRedemptions
        }

        if let redeemBy {
            body["redeem_by"] = Int(redeemBy.timeIntervalSince1970)
        }

        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: coupons, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(coupon: String, expand: [String]? = nil) async throws -> Coupon {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(coupons)/\(coupon)", query: queryParams, headers: headers)
    }
    
    public func update(coupon: String,
                       metadata: [String: String]? = nil,
                       name: String? = nil,
                       currencyOptions: [Currency: CouponCurrencyOptions]? = nil,
                       expand: [String]? = nil) async throws -> Coupon {
        var body: [String: Any] = [:]
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let name {
            body["name"] = name
        }
        
        if let currencyOptions {
            currencyOptions.forEach { body["currency_options[\($0.rawValue)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(coupons)/\(coupon)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(coupon: String) async throws -> DeletedObject {
        try await apiHandler.send(method: .DELETE, path: "\(coupons)/\(coupon)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> CouponList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }

        return try await apiHandler.send(method: .GET, path: coupons, query: queryParams, headers: headers)
    }
}
