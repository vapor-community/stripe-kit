//
//  Discount.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/7/17.
//
//

import Foundation

/// The [Discount Object](https://stripe.com/docs/api/discounts/object)
public struct Discount: Codable {
    /// The ID of the discount object. Discounts cannot be fetched by ID. Use expand[]=discounts in API calls to expand discount IDs in an array.
    public var id: String
    /// Hash describing the coupon applied to create this discount.
    public var coupon: Coupon?
    /// The id of the customer this discount is associated with.
    @Expandable<Customer> public var customer: String?
    /// If the coupon has a duration of repeating, the date that this discount will end. If the coupon has a duration of once or forever, this attribute will be null.
    public var end: Date?
    /// Date that the coupon was applied.
    public var start: Date?
    /// The subscription that this coupon is applied to, if it is applied to a particular subscription.
    public var subscription: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The Checkout session that this coupon is applied to, if it is applied to a particular session in payment mode. Will not be present for subscription mode.
    public var checkoutSession: String?
    /// The invoice that the discount’s coupon was applied to, if it was applied directly to a particular invoice.
    public var invoice: String?
    /// The invoice item id (or invoice line item id for invoice line items of type=‘subscription’) that the discount’s coupon was applied to, if it was applied directly to a particular invoice item or invoice line item.
    public var invoiceItem: String?
    /// The promotion code applied to create this discount.
    @Expandable<PromotionCode> public var promotionCode: String?
    
    public init(id: String,
                coupon: Coupon? = nil,
                customer: String? = nil,
                end: Date? = nil,
                start: Date? = nil,
                subscription: String? = nil,
                object: String,
                checkoutSession: String? = nil,
                invoice: String? = nil,
                invoiceItem: String? = nil,
                promotionCode: String? = nil) {
        self.id = id
        self.coupon = coupon
        self._customer = Expandable(id: customer)
        self.end = end
        self.start = start
        self.subscription = subscription
        self.object = object
        self.checkoutSession = checkoutSession
        self.invoice = invoice
        self.invoiceItem = invoiceItem
        self._promotionCode = Expandable(id: promotionCode)
    }
}
