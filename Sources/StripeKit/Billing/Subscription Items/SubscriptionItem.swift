//
//  SubscriptionItem.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/6/17.
//
//

import Foundation

/// The [Subscription Item Object](https://stripe.com/docs/api/subscription_items/object) .
public struct SubscriptionItem: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The price the customer is subscribed to.
    public var price: Price?
    /// The quantity of the plan to which the customer should be subscribed.
    public var quantity: Int?
    /// The `subscription` this `subscription_item` belongs to.
    public var subscription: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Define thresholds at which an invoice will be sent, and the related subscription advanced to a new billing period
    public var billingThresholds: SubscriptionItemBillingThresholds?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The tax rates which apply to this `subscription_item`. When set, the `default_tax_rates` on the subscription do not apply to this `subscription_item`.
    public var taxRates: [TaxRate]?
    
    public init(id: String,
                metadata: [String : String]? = nil,
                price: Price? = nil,
                quantity: Int? = nil,
                subscription: String? = nil,
                object: String,
                billingThresholds: SubscriptionItemBillingThresholds? = nil,
                created: Date,
                taxRates: [TaxRate]? = nil) {
        self.id = id
        self.metadata = metadata
        self.price = price
        self.quantity = quantity
        self.subscription = subscription
        self.object = object
        self.billingThresholds = billingThresholds
        self.created = created
        self.taxRates = taxRates
    }
}

public struct SubscriptionItemBillingThresholds: Codable {
    /// Usage threshold that triggers the subscription to create an invoice
    public var usageGte: Int?
    
    public init(usageGte: Int? = nil) {
        self.usageGte = usageGte
    }
}

public enum SubscriptionItemPaymentBehavior: String, Codable {
    /// Use `allow_incomplete` to transition the subscription to `status=past_due` if a payment is required but cannot be paid.
    case allowIncomplete = "allow_incomplete"
    /// Use `error_if_incomplete` if you want Stripe to return an HTTP 402 status code if a subscription’s first invoice cannot be paid.
    case errorIfIncomplete = "error_if_incomplete"
    /// Use `pending_if_incomplete` to update the subscription using pending updates. When you use `pending_if_incomplete` you can only pass the parameters supported by pending updates.
    case pendingIfIncomplete = "pending_if_incomplete"
    /// Use `default_incomplete` to transition the subscription to `status=past_due` when payment is required and await explicit confirmation of the invoice’s payment intent. This allows simpler management of scenarios where additional user actions are needed to pay a subscription’s invoice. Such as failed payments, SCA regulation, or collecting a mandate for a bank debit payment method.
    case defaultIncomplete = "default_incomplete"
    
}

public enum SubscriptionItemProrationBehavior: String, Codable {
    case createProrations = "create_prorations"
    case alwaysInvoice = "always_invoice"
    case none
}

public struct SubscriptionItemList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [SubscriptionItem]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [SubscriptionItem]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
