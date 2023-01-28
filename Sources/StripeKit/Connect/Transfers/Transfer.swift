//
//  Transfer.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/2/18.
//

import Foundation

/// The [Transfer Object](https://stripe.com/docs/api/transfers/object).
public struct StripeTransfer: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Amount in cents to be transferred.
    public var amount: Int?
    /// Amount in cents reversed (can be less than the amount attribute on the transfer if a partial reversal was issued).
    public var amountReversed: Int?
    /// Balance transaction that describes the impact of this transfer on your account balance.
    @Expandable<BalanceTransaction> public var balanceTransaction: String?
    /// Time that this record of the transfer was first created.
    public var created: Date
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// ID of the Stripe account the transfer was sent to.
    @Expandable<StripeConnectAccount> public var destination: String?
    /// If the destination is a Stripe account, this will be the ID of the payment that the destination account received for the transfer.
    // Charge used here https://github.com/stripe/stripe-dotnet/blob/8fc1398369ed461816002a65bfc87f1b5860d76a/src/Stripe.net/Entities/Transfers/Transfer.cs#L81
    @Expandable<StripeCharge> public var destinationPayment: String?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// A set of key-value pairs that you can attach to a transfer object. It can be useful for storing additional information about the transfer in a structured format.
    public var metadata: [String: String]?
    /// A list of reversals that have been applied to the transfer.
    public var reversals: StripeTransferReversalList?
    /// Whether the transfer has been fully reversed. If the transfer is only partially reversed, this attribute will still be false.
    public var reversed: Bool?
    /// ID of the charge or payment that was used to fund the transfer. If null, the transfer was funded from the available balance.
    @Expandable<StripeCharge> public var sourceTransaction: String?
    /// The source balance this transfer came from. One of `card` or `bank_account`.
    public var sourceType: StripeTransferSourceType?
    /// A string that identifies this transaction as part of a group. See the Connect documentation for details.
    public var transferGroup: String?
}

public enum StripeTransferSourceType: String, Codable {
    case card
    case bankAccount = "bank_account"
}

public struct StripeTransferList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeTransfer]?
}
