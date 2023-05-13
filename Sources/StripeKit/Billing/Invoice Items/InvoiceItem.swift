//
//  InvoiceItem.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/5/17.
//
//

import Foundation

/// The [InvoiceItem Object](https://stripe.com/docs/api/invoiceitems/object)
public struct InvoiceItem: Codable {
    /// Unique identifier for the object.
    public var id: String?
    /// Amount (in the currency specified) of the invoice item. This should always be equal to unit_amount * quantity.
    public var amount: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// The ID of the customer who will be billed when this invoice item is billed.
    @Expandable<Customer> public var customer: String?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The period associated with this invoice item. When set to different values, the period will be rendered on the invoice. If you have Stripe Revenue Recognition enabled, the period will be used to recognize and defer revenue. See the Revenue Recognition documentation for details.
    public var period: InvoiceItemPeriod?
    /// The price of the invoice item.
    public var price: Price?
    /// Whether the invoice item was created automatically as a proration adjustment when the customer switched plans.
    public var proration: Bool?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var date: Date?
    /// If true, discounts will apply to this invoice item. Always false for prorations.
    public var discountable: Bool?
    /// The discounts which apply to the invoice item. Item discounts are applied before invoice discounts. Use expand[]=discounts to expand each discount.
    @ExpandableCollection<Discount> public var discounts: [String]?
    /// The ID of the invoice this invoice item belongs to.
    @Expandable<Invoice> public var invoice: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Quantity of units for the invoice item. If the invoice item is a proration, the quantity of the subscription that the proration was computed for.
    public var quantity: Int?
    /// The subscription that this invoice item has been created for, if any.
    @Expandable<Subscription> public var subscription: String?
    /// The subscription item that this invoice item has been created for, if any.
    public var subscriptionItem: String?
    /// The tax rates which apply to the invoice item. When set, the default_tax_rates on the invoice do not apply to this invoice item.
    public var taxRates: [TaxRate]?
    /// ID of the test clock this invoice item belongs to.
    public var testClock: String? // TODO: - Make Expandable
    /// Unit Amount (in the currency specified) of the invoice item.
    public var unitAmount: Int?
    /// Same as `unit_amount`, but contains a decimal value with at most 12 decimal places.
    public var unitAmountDecimal: String?
    
    public init(id: String? = nil,
                amount: Int? = nil,
                currency: Currency? = nil,
                customer: String? = nil,
                description: String? = nil,
                metadata: [String : String]? = nil,
                period: InvoiceItemPeriod? = nil,
                price: Price? = nil,
                proration: Bool? = nil,
                object: String,
                date: Date? = nil,
                discountable: Bool? = nil,
                discounts: [String]? = nil,
                invoice: String? = nil,
                livemode: Bool? = nil,
                quantity: Int? = nil,
                subscription: String? = nil,
                subscriptionItem: String? = nil,
                taxRates: [TaxRate]? = nil,
                testClock: String? = nil,
                unitAmount: Int? = nil,
                unitAmountDecimal: String? = nil) {
        self.id = id
        self.amount = amount
        self.currency = currency
        self._customer = Expandable(id: customer)
        self.description = description
        self.metadata = metadata
        self.period = period
        self.price = price
        self.proration = proration
        self.object = object
        self.date = date
        self.discountable = discountable
        self._discounts = ExpandableCollection(ids: discounts)
        self._invoice = Expandable(id: invoice)
        self.livemode = livemode
        self.quantity = quantity
        self._subscription = Expandable(id: subscription)
        self.subscriptionItem = subscriptionItem
        self.taxRates = taxRates
        self.testClock = testClock
        self.unitAmount = unitAmount
        self.unitAmountDecimal = unitAmountDecimal
    }
}

public struct InvoiceItemPeriod: Codable {
    /// The start of the period. This value is inclusive.
    public var start: Date?
    /// The end of the period, which must be greater than or equal to the start. This value is inclusive.
    public var end: Date?
    
    public init(start: Date? = nil, end: Date? = nil) {
        self.start = start
        self.end = end
    }
}

public struct InvoiceItemList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [InvoiceItem]?
}
