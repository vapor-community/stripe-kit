//
//  Transaction.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/19.
//

import Foundation

public struct StripeTransaction: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    ///
    public var amount: Int?
    /// The Authorization object that led to this transaction.
    public var authorization: String?
    ///
    public var balanceTransaction: String?
    /// The card used to make this transaction.
    public var card: String?
    /// The cardholder to whom this transaction belongs.
    public var cardholder: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    ///
    public var dispute: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    ///
    public var merchantAmount: Int?
    ///
    public var merchantCurrency: StripeCurrency?
    /// More information about the user involved in the transaction.
    public var merchantData: StripeAuthorizationMerchantData?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// One of `capture`, `refund`, `cash_withdrawal`, `refund_reversal`, `dispute`, or   `dispute_loss`.
    public var type: StripeTransactionType?
}

public struct StripeTransactionList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeTransaction]?
}

public enum StripeTransactionType: String, StripeModel {
    case capture
    case refund
    case cashWithdrawal = "cash_withdrawal"
    case refundReversal = "refund_reversal"
    case dispute
    case disputeLoss = "dispute_loss"
}
