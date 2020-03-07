//
//  SubscriptionItem.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/6/17.
//
//

import Foundation

/// The [Subscription Item Object](https://stripe.com/docs/api/subscription_items/object).
public struct StripeSubscriptionItem: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Define thresholds at which an invoice will be sent, and the related subscription advanced to a new billing period
    public var billingThresholds: StripeSubscriptionItemBillingThresholds?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Hash describing the plan the customer is subscribed to.
    public var plan: StripePlan?
    /// The quantity of the plan to which the customer should be subscribed.
    public var quantity: Int?
    /// The `subscription` this `subscription_item` belongs to.
    public var subscription: String?
    /// The tax rates which apply to this `subscription_item`. When set, the `default_tax_rates` on the subscription do not apply to this `subscription_item`.
    public var taxRates: [StripeTaxRate]?
}

public struct StripeSubscriptionItemBillingThresholds: StripeModel {
    /// Usage threshold that triggers the subscription to create an invoice
    public var usageGte: Int?
}

public enum StripeSubscriptionItemPaymentBehavior: String, StripeModel {
    /// Creating subscriptions with this status allows you to manage scenarios where additional user actions are needed to pay a subscription’s invoice.
    case allowIncomplete = "allow_incomplete"
    /// Use `error_if_incomplete` if you want Stripe to return an HTTP 402 status code if a subscription’s first invoice cannot be paid.
    case errorIfIncomplete = "error_if_incomplete"
}

public enum StripeSubscriptionItemProrationBehavior: String, StripeModel {
    case createProrations = "create_prorations"
    case alwaysInvoice = "always_invoice"
    case none
}

public struct StripeSubscriptionItemList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeSubscriptionItem]?
}
