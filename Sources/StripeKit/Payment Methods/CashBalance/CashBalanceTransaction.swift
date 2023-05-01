//
//  CashBalanceTransaction.swift
//  
//
//  Created by Andrew Edwards on 5/1/23.
//

import Foundation

public struct CashBalanceTransaction: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// If this is a `type=applied_to_payment` transaction, contains information about how funds were applied.
    public var appliedToPayment: CashBalanceTransactionAppliedToPayment?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// The customer whose available cash balance changed as a result of this transaction.
    @Expandable<Customer> public var customer: String?
    /// The total available cash balance for the specified currency after this transaction was applied. Represented in the smallest currency unit.
    public var endingBalance: Int?
    /// If this is a`type=funded` transaction, contains information about the funding.
    public var funded: CashBalanceTransactionFunded?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool
    /// The amount by which the cash balance changed, represented in the smallest currency unit. A positive value represents funds being added to the cash balance, a negative value represents funds being removed from the cash balance.
    public var netAmount: Int?
    /// If this is a `type=refunded_from_payment` transaction, contains information about the source of the refund.
    public var refundedFromPayment: CashBalanceTransactionRefundedFromPayment?
    /// The type of the cash balance transaction. One of `applied_to_payment`, `unapplied_from_payment`, `refunded_from_payment`, `funded`, `return_initiated`, or `return_canceled`. New types may be added in future. See Customer Balance to learn more about these types.
    public var type: String?
    /// If this is a `type=unapplied_from_payment` transaction, contains information about how funds were unapplied.
    public var unappliedFromPayment: CashBalanceTransactionUnappliedFromPayment?
    
    public init(id: String,
                object: String,
                appliedToPayment: CashBalanceTransactionAppliedToPayment? = nil,
                created: Date,
                currency: Currency? = nil,
                customer: String? = nil,
                endingBalance: Int? = nil,
                funded: CashBalanceTransactionFunded? = nil,
                livemode: Bool,
                netAmount: Int? = nil,
                refundedFromPayment: CashBalanceTransactionRefundedFromPayment? = nil,
                type: String? = nil,
                unappliedFromPayment: CashBalanceTransactionUnappliedFromPayment? = nil) {
        self.id = id
        self.object = object
        self.appliedToPayment = appliedToPayment
        self.created = created
        self.currency = currency
        self._customer = Expandable(id: customer)
        self.endingBalance = endingBalance
        self.funded = funded
        self.livemode = livemode
        self.netAmount = netAmount
        self.refundedFromPayment = refundedFromPayment
        self.type = type
        self.unappliedFromPayment = unappliedFromPayment
    }
}

public struct CashBalanceTransactionAppliedToPayment: Codable {
    /// The Payment Intent that funds were applied to.
    @Expandable<PaymentIntent> public var paymentIntent: String?
    
    public init(paymentIntent: String? = nil) {
        self._paymentIntent = Expandable(id: paymentIntent)
    }
}

public struct CashBalanceTransactionFunded: Codable {
    /// Information about the bank transfer that funded the customer’s cash balance.
    public var bankTransfer: CashBalanceTransactionFundedBankTransfer?
    
    public init(bankTransfer: CashBalanceTransactionFundedBankTransfer? = nil) {
        self.bankTransfer = bankTransfer
    }
}

public struct CashBalanceTransactionFundedBankTransfer: Codable {
    /// EU-specific details of the bank transfer.
    public var euBankTransfer: CashBalanceTransactionFundedBankTransferEUBankTransfer?
    /// The user-supplied reference field on the bank transfer.
    public var reference: String?
    /// The funding method type used to fund the customer balance. Permitted values include: `eu_bank_transfer`, `gb_bank_transfer`, `jp_bank_transfer`, or `mx_bank_transfer`.
    public var type: CashBalanceTransactionFundedBankTransferType?
    
    public init(euBankTransfer: CashBalanceTransactionFundedBankTransferEUBankTransfer? = nil,
                reference: String? = nil,
                type: CashBalanceTransactionFundedBankTransferType? = nil) {
        self.euBankTransfer = euBankTransfer
        self.reference = reference
        self.type = type
    }
}

public enum CashBalanceTransactionFundedBankTransferType: String, Codable {
    /// A bank transfer of type `eu_bank_transfer`
    case euBankTransfer = "eu_bank_transfer"
    /// A bank transfer of type `gb_bank_transfer`
    case gbBankTransfer = "gb_bank_transfer"
    /// A bank transfer of type `jp_bank_transfer`
    case jpBankTransfer = "jp_bank_transfer"
    /// A bank transfer of type `mx_bank_transfer`
    case mxBankTransfer = "mx_bank_transfer"
}

public struct CashBalanceTransactionFundedBankTransferEUBankTransfer: Codable {
    /// The BIC of the bank of the sender of the funding.
    public var bic: String?
    /// The last 4 digits of the IBAN of the sender of the funding.
    public var ibanLast4: String?
    /// The full name of the sender, as supplied by the sending bank.
    public var senderName: String?
    
    public init(bic: String? = nil,
                ibanLast4: String? = nil,
                senderName: String? = nil) {
        self.bic = bic
        self.ibanLast4 = ibanLast4
        self.senderName = senderName
    }
}

public struct CashBalanceTransactionRefundedFromPayment: Codable {
    /// The Refund that moved these funds into the customer’s cash balance.
    @Expandable<Refund> public var refund: String?
    
    public init(refund: String? = nil) {
        self._refund = Expandable(id: refund)
    }
}

public struct CashBalanceTransactionUnappliedFromPayment: Codable {
    /// The Payment Intent that funds were unapplied from.
    @Expandable<PaymentIntent> public var paymentIntent: String?
    
    public init(paymentIntent: String? = nil) {
        self._paymentIntent = Expandable(id: paymentIntent)
    }
}

public struct CashBalanceTransactionList: Codable {
    /// String representing the object’s type. Objects of the same type share the same value. Always has the value list.
    public var object: String
    /// An array of `CashBalanceTransaction`s associated with the account.
    public var data: [CashBalanceTransaction]?
    /// True if this list has another page of items after this one that can be fetched.
    public var hasMore: Bool?
    /// The URL where this list can be accessed.
    public var url: String?
    
    public init(object: String,
                data: [CashBalanceTransaction]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}
