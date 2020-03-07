//
//  CreditNoteLineItem.swift
//  
//
//  Created by Andrew Edwards on 3/7/20.
//

import Foundation

/// The [Credit Note Line Item](https://stripe.com/docs/api/credit_notes/line_item)
public struct StripeCreditNoteLineItem: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The integer amount in `cents` representing the total amount being credited for this line item, excluding (exclusive) tax and discounts.
    public var amount: Int?
    /// Description of the item being credited.
    public var description: String?
    /// The integer amount in `cents` representing the discount being credited for this line item.
    public var discountAmount: Int?
    /// ID of the invoice line item being credited
    public var invoiceLineItem: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// The number of units of product being credited.
    public var quantity: Int?
    /// The amount of tax calculated per tax rate for this line item
    public var taxAmounts: [StripeInvoiceTotalTaxAmount]?
    /// The tax rates which apply to the line item.
    public var taxRates: [StripeTaxRate]?
    /// The type of the credit note line item, one of `invoice_line_item` or `custom_line_item`. When the type is `invoice_line_item` there is an additional `invoice_line_item` property on the resource the value of which is the id of the credited line item on the invoice.
    public var type: StripeCreditNoteLineItemType?
    /// The cost of each unit of product being credited.
    public var unitAmount: Int?
    /// Same as `unit_amount`, but contains a decimal value with at most 12 decimal places.
    public var unitAmountDecimal: Decimal?
}

public enum StripeCreditNoteLineItemType: String, StripeModel {
    case invoiceLineItem = "invoice_line_item"
    case customLineItem = "custom_line_item"
}

public struct StripeCreditNoteLineItemList: StripeModel {
    /// String representing the object’s type. Objects of the same type share the same value. Always has the value list.
    public var object: String?
    /// Details about each object.
    public var data: [StripeCreditNoteLineItem]?
    /// True if this list has another page of items after this one that can be fetched.
    public var hasMore: Bool?
    /// The URL where this list can be accessed.
    public var url: String?
}
