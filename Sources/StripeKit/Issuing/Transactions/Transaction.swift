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
    /// The amount of this transaction in your currency. This is the amount that your balance will be updated by.
    public var amount: Int?
    /// The Authorization object that led to this transaction.
    @Expandable<StripeAuthorization> public var authorization: String?
    /// ID of the balance transaction associated with this transaction.
    @Expandable<StripeBalanceTransaction> public var balanceTransaction: String?
    /// The card used to make this transaction.
    @Expandable<StripeIssuingCard> public var card: String?
    /// The cardholder to whom this transaction belongs.
    @Expandable<StripeCardholder> public var cardholder: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// The amount that the merchant will receive, denominated in `merchant_currency`. It will be different from `amount` if the merchant is taking payment in a different currency.
    public var merchantAmount: Int?
    /// The currency with which the merchant is taking payment.
    public var merchantCurrency: StripeCurrency?
    /// More information about the user involved in the transaction.
    public var merchantData: StripeAuthorizationMerchantData?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The nature of the transaction.
    public var type: StripeTransactionType?
}

public struct StripeTransactionList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeTransaction]?
}

public enum StripeTransactionType: String, StripeModel {
    /// Funds were captured by the acquirer. amount will be negative as funds are moving out of your balance. Not all captures will be linked to an authorization, as acquirers can force capture in some cases.
    case capture
    /// An acquirer initiated a refund. This transaction might not be linked to an original capture, for example credits are original transactions. amount will be positive for refunds and negative for refund reversals.
    case refund
}
