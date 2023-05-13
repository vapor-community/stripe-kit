//
//  CustomerBalanceTransaction.swift
//  
//
//  Created by Andrew Edwards on 11/28/19.
//

import Foundation

/// The [Customer Balance Transaction Object](https://stripe.com/docs/api/customer_balance_transactions/object) .
public struct CustomerBalanceTransaction: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// The amount of the transaction. A negative value is a credit for the customer’s balance, and a positive value is a debit to the customer’s balance.
    public var amount: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// The ID of the customer the transaction belongs to.
    @Expandable<Customer> public var customer: String?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// The customer’s balance after the transaction was applied. A negative value decreases the amount due on the customer’s next invoice. A positive value increases the amount due on the customer’s next invoice.
    public var endingBalance: Int?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Transaction type: `adjustment`, `applied_to_invoice`, `credit_note`, `initial`, `invoice_too_large`, `invoice_too_small`, `unapplied_from_invoice`, or `unspent_receiver_credit`. See the Customer Balance page to learn more about transaction types.
    public var type: CustomerBalanceTransactionType?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The ID of the credit note (if any) related to the transaction.
    @Expandable<CreditNote> public var creditNote: String?
    /// The ID of the invoice (if any) related to the transaction.
    @Expandable<Invoice> public var invoice: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    
    public init(id: String,
                amount: Int? = nil,
                currency: Currency? = nil,
                customer: String? = nil,
                description: String? = nil,
                endingBalance: Int? = nil,
                metadata: [String : String]? = nil,
                type: CustomerBalanceTransactionType? = nil,
                object: String,
                created: Date,
                creditNote: String? = nil,
                invoice: String? = nil,
                livemode: Bool? = nil) {
        self.id = id
        self.amount = amount
        self.currency = currency
        self._customer = Expandable(id: customer)
        self.description = description
        self.endingBalance = endingBalance
        self.metadata = metadata
        self.type = type
        self.object = object
        self.created = created
        self._creditNote = Expandable(id: creditNote)
        self._invoice = Expandable(id: invoice)
        self.livemode = livemode
    }
}

public enum CustomerBalanceTransactionType: String, Codable {
    case adjustment
    case appliedToInvoice = "applied_to_invoice"
    case creditNote = "credit_note"
    case initial
    case invoiceOverpaid = "invoice_overpaid"
    case invoiceTooLarge = "invoice_too_large"
    case invoiceTooSmall = "invoice_too_small"
    case unspentReceiverCredit = "unspent_receiver_credit"
    case unappliedFromInvoice = "unapplied_from_invoice"
}

public struct CustomerBalanceTransactionList: Codable {
    public var object: String
    public var data: [CustomerBalanceTransaction]?
    public var hasMore: Bool?
    public var url: String?
    
    public init(object: String,
                data: [CustomerBalanceTransaction]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}
