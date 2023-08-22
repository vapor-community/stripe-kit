//
//  Coupon.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/28/17.
//
//

import Foundation

/// The [Coupon Object](https://stripe.com/docs/api/coupons/object) .
public struct Coupon: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// Amount (in the `currency` specified) that will be taken off the subtotal of any invoices for this customer.
    public var amountOff: Int?
    /// If `amount_off` has been set, the three-letter ISO code for the currency of the amount to take off.
    public var currency: Currency?
    /// One of `forever`, `once`, and `repeating`. Describes how long a customer who applies this coupon will get the discount.
    public var duration: CouponDuration?
    /// If `duration` is `repeating`, the number of months the coupon applies. Null if coupon `duration` is `forever` or `once`.
    public var durationInMonths: Int?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Name of the coupon displayed to customers on for instance invoices or receipts.
    public var name: String?
    /// Percent that will be taken off the subtotal of any invoices for this customer for the duration of the coupon. For example, a coupon with `percent_off` of 50 will make a $100 invoice $50 instead.
    public var percentOff: Int?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Contains information about what this coupon applies to. This field is not included by default. To include it in the response, expand the `applies_to` field.
    public var appliesTo: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Coupons defined in each available currency option. Each key must be a three-letter ISO currency code and a supported currency. For example, to get your coupon in `eur`, fetch the value of the `eur` key in `currency_options`. This field is not included by default. To include it in the response, expand the `currency_options` field.
    public var currencyOptions: [Currency: CouponCurrencyOptions]?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// Maximum number of times this coupon can be redeemed, in total, across all customers, before it is no longer valid.
    public var maxRedemptions: Int?
    /// Date after which the coupon can no longer be redeemed.
    public var redeemBy: Date?
    /// Number of times this coupon has been applied to a customer.
    public var timesRedeemed: Int?
    /// Taking account of the above properties, whether this coupon can still be applied to a customer.
    public var valid: Bool?
    
    public init(id: String,
                amountOff: Int? = nil,
                currency: Currency? = nil,
                duration: CouponDuration? = nil,
                durationInMonths: Int? = nil,
                metadata: [String : String]? = nil,
                name: String? = nil,
                percentOff: Int? = nil,
                object: String,
                appliesTo: String? = nil,
                created: Date,
                currencyOptions: [Currency : CouponCurrencyOptions]? = nil,
                livemode: Bool? = nil,
                maxRedemptions: Int? = nil,
                redeemBy: Date? = nil,
                timesRedeemed: Int? = nil,
                valid: Bool? = nil) {
        self.id = id
        self.amountOff = amountOff
        self.currency = currency
        self.duration = duration
        self.durationInMonths = durationInMonths
        self.metadata = metadata
        self.name = name
        self.percentOff = percentOff
        self.object = object
        self.appliesTo = appliesTo
        self.created = created
        self.currencyOptions = currencyOptions
        self.livemode = livemode
        self.maxRedemptions = maxRedemptions
        self.redeemBy = redeemBy
        self.timesRedeemed = timesRedeemed
        self.valid = valid
    }
}

public struct CouponAppliesTo: Codable {
    /// A list of product IDs this coupon applies to
    public var products: [String]?
    
    public init(products: [String]? = nil) {
        self.products = products
    }
}

public struct CouponCurrencyOptions: Codable {
    /// Amount (in the currency specified) that will be taken off the subtotal of any invoices for this customer.
    public var amountOff: Int?
    
    public init(amountOff: Int? = nil) {
        self.amountOff = amountOff
    }
}

public enum CouponDuration: String, Codable {
    /// Applies to the first charge from a subscription with this coupon applied.
    case once
    /// Applies to charges in the first `duration_in_months` months from a subscription with this coupon applied.
    case repeating
    /// Applies to all charges from a subscription with this coupon applied.
    case forever
}

public struct CouponList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [Coupon]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [Coupon]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
