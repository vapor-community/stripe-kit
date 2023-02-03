//
//  InvoiceLineItem.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/5/17.
//
//

import Foundation

/// The [Invoice Line Item Object](https://stripe.com/docs/api/invoices/line_item).
public struct StripeInvoiceLineItem: Codable {
    /// Unique identifier for the object.
    public var id: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The amount, in cents.
    public var amount: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// If true, discounts will apply to this line item. Always false for prorations.
    public var discountable: Bool?
    /// The ID of the invoice item associated with this line item if any.
    public var invoiceItem: String?
    /// Whether this is a test line item.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Note that for line items with `type=subscription` this will reflect the metadata of the subscription that caused the line item to be created.
    public var metadata: [String: String]?
    /// The timespan covered by this invoice item.
    public var period: StripeInvoiceLineItemPeriod?
    /// The plan of the subscription, if the line item is a subscription or a proration.
    public var plan: StripePlan?
    /// The price of the line item.
    public var price: StripePrice?
    /// Whether this is a proration.
    public var proration: Bool?
    /// The quantity of the subscription, if the line item is a subscription or a proration.
    public var quantity: Int?
    /// The subscription that the invoice item pertains to, if any.
    public var subscription: String?
    /// The subscription item that generated this invoice item. Left empty if the line item is not an explicit result of a subscription.
    public var subscriptionItem: String?
    /// The amount of tax calculated per tax rate for this line item
    public var taxAmounts: [StripeInvoiceTotalTaxAmount]?
    /// The tax rates which apply to the line item.
    public var taxRates: [StripeTaxRate]?
    /// A string identifying the type of the source of this line item, either an `invoiceitem` or a `subscription`.
    public var type: StripeInvoiceLineItemType?
}

public struct StripeInvoiceLineItemPeriod: Codable {
    /// Start of the line item’s billing period
    public var start: Date?
    /// End of the line item’s billing period
    public var end: Date?
}

public enum StripeInvoiceLineItemType: String, Codable {
    case invoiceitem
    case subscription
}

public struct StripeInvoiceLineItemList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeInvoiceLineItem]?
}
