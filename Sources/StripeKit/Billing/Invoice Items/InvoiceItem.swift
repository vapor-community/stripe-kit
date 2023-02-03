//
//  InvoiceItem.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/5/17.
//
//

import Foundation

/// The [InvoiceItem Object](https://stripe.com/docs/api/invoiceitems/object)
public struct StripeInvoiceItem: Codable {
    /// Unique identifier for the object.
    public var id: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Amount (in the currency specified) of the invoice item. This should always be equal to unit_amount * quantity.
    public var amount: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// The ID of the customer who will be billed when this invoice item is billed.
    @Expandable<StripeCustomer> public var customer: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var date: Date?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// If true, discounts will apply to this invoice item. Always false for prorations.
    public var discountable: Bool?
    /// The ID of the invoice this invoice item belongs to.
    @Expandable<StripeInvoice> public var invoice: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The period associated with with this invoice item.
    public var period: StripeInvoiceLineItemPeriod?
    /// If the invoice item is a proration, the plan of the subscription that the proration was computed for.
    public var plan: StripePlan?
    /// The price of the invoice item.
    public var price: StripePrice?
    /// Whether the invoice item was created automatically as a proration adjustment when the customer switched plans.
    public var proration: Bool?
    /// Quantity of units for the invoice item. If the invoice item is a proration, the quantity of the subscription that the proration was computed for.
    public var quantity: Int?
    /// The subscription that this invoice item has been created for, if any.
    @Expandable<StripeSubscription> public var subscription: String?
    /// The subscription item that this invoice item has been created for, if any.
    public var subscriptionItem: String?
    /// The tax rates which apply to the invoice item. When set, the default_tax_rates on the invoice do not apply to this invoice item.
    public var taxRates: [StripeTaxRate]?
    /// Unit Amount (in the currency specified) of the invoice item.
    public var unitAmount: Int?
    /// Same as `unit_amount`, but contains a decimal value with at most 12 decimal places.
    public var unitAmountDecimal: String?
}

public struct StripeInvoiceItemList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeInvoiceItem]?
}
