//
//  Discount.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/7/17.
//
//

import Foundation

/// The [Discount Object](https://stripe.com/docs/api/discounts/object).
public struct StripeDiscount: StripeModel {
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Hash describing the coupon applied to create this discount.
    public var coupon: StripeCoupon?
    /// The id of the customer this discount is associated with.
    public var customer: String?
    /// If the coupon has a duration of repeating, the date that this discount will end. If the coupon has a duration of once or forever, this attribute will be null.
    public var end: Date?
    /// Date that the coupon was applied.
    public var start: Date?
    /// The subscription that this coupon is applied to, if it is applied to a particular subscription.
    public var subscription: String?
}
