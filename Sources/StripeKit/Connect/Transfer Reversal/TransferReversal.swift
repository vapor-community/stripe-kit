//
//  TransferReversal.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/2/18.
//

import Foundation

/// The [Transfer Reversal Object](https://stripe.com/docs/api/transfer_reversals/object).
public struct StripeTransferReversal: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Amount, in cents.
    public var amount: Int?
    /// Balance transaction that describes the impact on your account balance.
    public var balanceTransaction: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// Linked payment refund for the transfer reversal.
    public var destinationPaymentRefund: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// ID of the refund responsible for the transfer reversal.
    public var sourceRefund: String?
    /// ID of the transfer that was reversed.
    public var transfer: String?
}

public struct StripeTransferReversalList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeTransferReversal]?
}
