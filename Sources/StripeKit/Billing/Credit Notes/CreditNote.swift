//
//  CreditNote.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/13/19.
//

import Foundation

/// The [Credit Note Object](https://stripe.com/docs/api/credit_notes/object).
public struct StripeCreditNote: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The integer amount in cents representing the total amount of the credit note.
    public var amount: Int?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// ID of the customer.
    public var customer: String?
    /// Customer balance transaction related to this credit note.
    public var customerBalanceTransaction: String?
    /// ID of the invoice.
    public var invoice: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Customer-facing text that appears on the credit note PDF.
    public var memo: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// A unique number that identifies this particular credit note and appears on the PDF of the credit note and its associated invoice.
    public var number: String?
    /// The link to download the PDF of the credit note.
    public var pdf: String?
    /// Reason for issuing this credit note, one of `duplicate`, `fraudulent`, `order_change`, or `product_unsatisfactory`
    public var reason: StripeCreditNoteReason?
    /// Refund related to this credit note.
    public var refund: String?
    /// Status of this credit note, one of issued or void. Learn more about [voiding credit notes](https://stripe.com/docs/billing/invoices/credit-notes#voiding).
    public var status: StripeCreditNoteStatus?
    /// Type of this credit note, one of `post_payment` or `pre_payment`. A `pre_payment` credit note means it was issued when the invoice was open. A `post_payment` credit note means it was issued when the invoice was paid.
    public var type: StripeCreditNoteType?
    /// The time that the credit note was voided.
    public var voidedAt: Date?
}

public enum StripeCreditNoteReason: String, StripeModel {
    case duplicate
    case fraudulent
    case orderChange = "order_change"
    case productUnsatisfactory = "product_unsatisfactory"
}

public enum StripeCreditNoteStatus: String, StripeModel {
    case issued
    case void
}

public enum StripeCreditNoteType: String, StripeModel {
    case postPayment = "post_payment"
    case prePayment = "pre_payment"
}

public struct StripeCreditNoteList: StripeModel {
    public var object: String
    public var data: [StripeCreditNote]?
    public var hasMore: Bool?
    public var url: String?
}
