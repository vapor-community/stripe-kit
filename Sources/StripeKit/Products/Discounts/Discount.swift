//
//  Discount.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/7/17.
//
//

import Foundation

/// The [Discount Object](https://stripe.com/docs/api/discounts/object)
public struct StripeDiscount: StripeModel {
    /// The ID of the discount object. Discounts cannot be fetched by ID. Use expand[]=discounts in API calls to expand discount IDs in an array.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Hash describing the coupon applied to create this discount.
    public var coupon: StripeCoupon?
    /// The id of the customer this discount is associated with.
    @Expandable<StripeCustomer> public var customer: String?
    /// If the coupon has a duration of repeating, the date that this discount will end. If the coupon has a duration of once or forever, this attribute will be null.
    public var end: Date?
    /// Date that the coupon was applied.
    public var start: Date?
    /// The subscription that this coupon is applied to, if it is applied to a particular subscription.
    public var subscription: String?
    /// The Checkout session that this coupon is applied to, if it is applied to a particular session in payment mode. Will not be present for subscription mode.
    public var checkoutSession: String?
    /// The invoice that the discount’s coupon was applied to, if it was applied directly to a particular invoice.
    public var invoice: String?
    /// The invoice item id (or invoice line item id for invoice line items of type=‘subscription’) that the discount’s coupon was applied to, if it was applied directly to a particular invoice item or invoice line item.
    public var invoiceItem: String?
    /// The promotion code applied to create this discount.
    @Expandable<StripePromotionCode> public var promotionCode: String?
}
