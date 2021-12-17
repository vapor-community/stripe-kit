//
//  Coupon.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/28/17.
//
//

import Foundation

/// The [Coupon Object](https://stripe.com/docs/api/coupons/object).
public struct StripeCoupon: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Amount (in the `currency` specified) that will be taken off the subtotal of any invoices for this customer.
    public var amountOff: Int?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// If amount_off has been set, the three-letter ISO code for the currency of the amount to take off.
    public var currency: StripeCurrency?
    /// One of `forever`, `once`, and `repeating`. Describes how long a customer who applies this coupon will get the discount.
    public var duration: StripeCouponDuration?
    /// If `duration` is `repeating`, the number of months the coupon applies. Null if coupon `duration` is `forever` or `once`.
    public var durationInMonths: Int?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// Maximum number of times this coupon can be redeemed, in total, across all customers, before it is no longer valid.
    public var maxRedemptions: Int?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Name of the coupon displayed to customers on for instance invoices or receipts.
    public var name: String?
    /// Percent that will be taken off the subtotal of any invoices for this customer for the duration of the coupon. For example, a coupon with percent_off of 50 will make a $100 invoice $50 instead.
    public var percentOff: Int?
    /// Date after which the coupon can no longer be redeemed.
    public var redeemBy: Date?
    /// Number of times this coupon has been applied to a customer.
    public var timesRedeemed: Int?
    /// Taking account of the above properties, whether this coupon can still be applied to a customer.
    public var valid: Bool?
}

public enum StripeCouponDuration: String, StripeModel {
    case forever
    case once
    case repeating
}

public struct StripeCouponList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeCoupon]?
}
