//
//  CreditNote.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/13/19.
//

import Foundation

/// The [Credit Note Object](https://stripe.com/docs/api/credit_notes/object) .
public struct CreditNote: Codable {
    /// Unique identifier for the object.
    public var id: String?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// ID of the invoice.
    @Expandable<StripeInvoice> public var invoice: String?
    /// Line items that make up the credit note
    public var lines: CreditNoteLineItemList?
    /// Customer-facing text that appears on the credit note PDF.
    public var memo: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Reason for issuing this credit note, one of `duplicate`, `fraudulent`, `order_change`, or `product_unsatisfactory`
    public var reason: CreditNoteReason?
    /// Status of this credit note, one of issued or void. Learn more about [voiding credit notes](https://stripe.com/docs/billing/invoices/credit-notes#voiding).
    public var status: CreditNoteStatus?
    /// The integer amount in `cents` representing the amount of the credit note, excluding tax and discount.
    public var subtotal: Int?
    /// The integer amount in `cents` representing the total amount of the credit note, including tax and discount.
    public var total: Int?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The integer amount in cents representing the total amount of the credit note.
    public var amount: Int?
    /// This is the sum of all the shipping amounts.
    public var amountShipping: Int?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// ID of the customer.
    @Expandable<Customer> public var customer: String?
    /// Customer balance transaction related to this credit note.
    @Expandable<CustomerBalanceTransaction> public var customerBalanceTransaction: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// A unique number that identifies this particular credit note and appears on the PDF of the credit note and its associated invoice.
    public var number: String?
    /// Amount that was credited outside of Stripe.
    public var outOfBandAmount: Int?
    /// The link to download the PDF of the credit note.
    public var pdf: String?
    /// Refund related to this credit note.
    @Expandable<Refund> public var refund: String?
    /// The details of the cost of shipping, including the ShippingRate applied to the invoice.
    public var shippingCost: CreditNoteShippingCost?
    /// The integer amount in cents representing the amount of the credit note, excluding all tax and invoice level discounts.
    public var subtotalExcludingTax: Int?
    /// The aggregate amounts calculated per tax rate for all line items.
    public var taxAmounts: [CreditNoteTaxAmount]?
    /// The integer amount in cents representing the total amount of the credit note, excluding tax, but including discounts.
    public var totalExcludingTax: Int?
    /// Type of this credit note, one of `post_payment` or `pre_payment`. A `pre_payment` credit note means it was issued when the invoice was open. A `post_payment` credit note means it was issued when the invoice was paid.
    public var type: CreditNoteType?
    /// The time that the credit note was voided.
    public var voidedAt: Date?
    
    public init(id: String? = nil,
                currency: Currency? = nil,
                invoice: String? = nil,
                lines: CreditNoteLineItemList? = nil,
                memo: String? = nil,
                metadata: [String : String]? = nil,
                reason: CreditNoteReason? = nil,
                status: CreditNoteStatus? = nil,
                subtotal: Int? = nil,
                total: Int? = nil,
                object: String,
                amount: Int? = nil,
                amountShipping: Int? = nil,
                created: Date,
                customer: String? = nil,
                customerBalanceTransaction: String? = nil,
                livemode: Bool? = nil,
                number: String? = nil,
                outOfBandAmount: Int? = nil,
                pdf: String? = nil,
                refund: String? = nil,
                shippingCost: CreditNoteShippingCost? = nil,
                subtotalExcludingTax: Int? = nil,
                taxAmounts: [CreditNoteTaxAmount]? = nil,
                totalExcludingTax: Int? = nil,
                type: CreditNoteType? = nil,
                voidedAt: Date? = nil) {
        self.id = id
        self.currency = currency
        self._invoice = Expandable(id: invoice)
        self.lines = lines
        self.memo = memo
        self.metadata = metadata
        self.reason = reason
        self.status = status
        self.subtotal = subtotal
        self.total = total
        self.object = object
        self.amount = amount
        self.amountShipping = amountShipping
        self.created = created
        self._customer = Expandable(id: customer)
        self._customerBalanceTransaction = Expandable(id: customerBalanceTransaction)
        self.livemode = livemode
        self.number = number
        self.outOfBandAmount = outOfBandAmount
        self.pdf = pdf
        self._refund = Expandable(id: refund)
        self.shippingCost = shippingCost
        self.subtotalExcludingTax = subtotalExcludingTax
        self.taxAmounts = taxAmounts
        self.totalExcludingTax = totalExcludingTax
        self.type = type
        self.voidedAt = voidedAt
    }
}

public enum CreditNoteReason: String, Codable {
    case duplicate
    case fraudulent
    case orderChange = "order_change"
    case productUnsatisfactory = "product_unsatisfactory"
}

public enum CreditNoteStatus: String, Codable {
    case issued
    case void
}

public struct CreditNoteShippingCost: Codable {
    /// Total shipping cost before any taxes are applied.
    public var amountSubtotal: Int?
    /// Total tax amount applied due to shipping costs. If no tax was applied, defaults to 0.
    public var amountTax: Int?
    /// Total shipping cost after taxes are applied.
    public var amountTotal: Int?
    /// The ID of the ShippingRate for this invoice.
    @Expandable<ShippingRate> public var shippingRate: String?
    /// The taxes applied to the shipping rate. This field is not included by default. To include it in the response, [expand](https://stripe.com/docs/api/expanding_objects) the `taxes` field.
    public var taxes: [CreditNoteShippingCostTax]?
    
    public init(amountSubtotal: Int? = nil,
                amountTax: Int? = nil,
                amountTotal: Int? = nil,
                shippingRate: String? = nil,
                taxes: [CreditNoteShippingCostTax]? = nil) {
        self.amountSubtotal = amountSubtotal
        self.amountTax = amountTax
        self.amountTotal = amountTotal
        self._shippingRate = Expandable(id: shippingRate)
        self.taxes = taxes
    }
}

public struct CreditNoteShippingCostTax: Codable {
    /// Amount of tax applied for this rate.
    public var amount: Int?
    /// The tax rate applied.
    public var rate: TaxRate?
    
    public init(amount: Int? = nil, rate: TaxRate? = nil) {
        self.amount = amount
        self.rate = rate
    }
}

public struct CreditNoteTaxAmount: Codable {
    /// The amount, in cents, of the tax.
    public var amount: Int?
    /// Whether this tax amount is inclusive or exclusive.
    public var inclusive: Bool?
    /// The tax rate that was applied to get this tax amount.
    @Expandable<TaxRate> public var taxRate: String?
    
    public init(amount: Int? = nil,
                inclusive: Bool? = nil,
                taxRate: String? = nil) {
        self.amount = amount
        self.inclusive = inclusive
        self._taxRate = Expandable(id: taxRate)
    }
}

public enum CreditNoteType: String, Codable {
    case postPayment = "post_payment"
    case prePayment = "pre_payment"
}

public struct CreditNoteList: Codable {
    public var object: String
    public var data: [CreditNote]?
    public var hasMore: Bool?
    public var url: String?
    
    public init(object: String,
                data: [CreditNote]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}
