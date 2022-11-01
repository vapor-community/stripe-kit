//
//  BalanceTransactionItem.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation

/// The [Balance Transaction Object](https://stripe.com/docs/api/balance/balance_transaction)
public struct BalanceTransaction: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Gross amount of the transaction, in cents.
    public var amount: Int?
    /// The date the transaction’s net funds will become available in the Stripe balance.
    public var availableOn: Date?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// The exchange rate used, if applicable, for this transaction. Specifically, if money was converted from currency A to currency B, then the `amount` in currency A, times `exchange_rate`, would be the amount in currency B. For example, suppose you charged a customer 10.00 EUR. Then the PaymentIntent’s `amount` would be `1000` and `currency` would be `eur`. Suppose this was converted into 12.34 USD in your Stripe account. Then the BalanceTransaction’s `amount` would be `1234`, `currency` would be `usd`, and `exchange_rate` would be `1.234`.
    public var exchangeRate: Double?
    /// Fees (in cents) paid for this transaction.
    public var fee: Int?
    /// Detailed breakdown of fees (in cents) paid for this transaction.
    public var feeDetails: [StripeBalanceTransactionFeeDetails]?
    /// Net amount of the transaction, in cents.
    public var net: Int?
    /// The Stripe object to which this transaction is related.
    public var source: String?
    /// If the transaction’s net funds are available in the Stripe balance yet. Either `available` or `pending`.
    public var status: StripeBalanceTransactionStatus?
    /// Transaction type: `adjustment`, `advance`, `advance_funding`, `application_fee`, `application_fee_refund`, `charge`, `connect_collection_transfer`, `issuing_authorization_hold`, `issuing_authorization_release`, `issuing_transaction`, `payment`, `payment_failure_refund`, `payment_refund`, `payout`, `payout_cancel`, `payout_failure`, `refund`, `refund_failure`, `reserve_transaction`, `reserved_funds`, `stripe_fee`, `stripe_fx_fee`, `tax_fee`, `topup`, `topup_reversal`, `transfer`, `transfer_cancel`, `transfer_failure`, or `transfer_refund`. Learn more about balance transaction types and what they represent.
    public var type: StripeBalanceTransactionType?
}

public struct StripeBalanceTransactionFeeDetails: StripeModel {
    /// Amount of the fee, in cents.
    public var amount: Int?
    /// ID of the Connect application that earned the fee.
    public var application: String?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// Type of the fee, one of: `application_fee`, `stripe_fee` or `tax`.
    public var type: StripeBalanceTransactionFeeDetailsType?
}

public enum StripeBalanceTransactionFeeDetailsType: String, StripeModel {
    case applicationFee = "application_fee"
    case stripeFee = "stripe_fee"
    case tax
}

public enum StripeBalanceTransactionStatus: String, StripeModel {
    case available
    case pending
}

public enum StripeBalanceTransactionType: String, StripeModel {
    case adjustment
    case advance
    case advanceFunding = "advance_funding"
    case anticipationRepayment = "anticipation_repayment"
    case applicationFee = "application_fee"
    case applicationFeeRefund = "application_fee_refund"
    case charge
    case connectCollectionTransfer = "connect_collection_transfer"
    case contribution
    case issuingAuthorizationHold = "issuing_authorization_hold"
    case issuingAuthorizationRelease = "issuing_authorization_release"
    case issuingDispute = "issuing_dispute"
    case issuingTransaction = "issuing_transaction"
    case payment
    case paymentFailureRefund = "payment_failure_refund"
    case paymentRefund = "payment_refund"
    case payout
    case payoutCancel = "payout_cancel"
    case payoutFailure = "payout_failure"
    case refund
    case refundFailure = "refund_failure"
    case reserveTransaction = "reserve_transaction"
    case reservedFunds = "reserved_funds"
    case stripeFee = "stripe_fee"
    case stripeFxFee = "stripe_fx_fee"
    case taxFee = "tax_fee"
    case topup
    case topupReversal = "topup_reversal"
    case transfer
    case transferCancel = "transfer_cancel"
    case transferFailure = "transfer_failure"
    case transferRefund = "transfer_refund"
}

public struct StripeBalanceTransactionList: StripeModel {
    public var object: String
    public var url: String?
    public var hasMore: Bool?
    public var data: [BalanceTransaction]?
}
