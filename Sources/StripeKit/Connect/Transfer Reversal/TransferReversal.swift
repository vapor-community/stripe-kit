//
//  TransferReversal.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/2/18.
//

import Foundation

/// The [Transfer Reversal Object](https://stripe.com/docs/api/transfer_reversals/object) .
public struct TransferReversal: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// Amount, in cents.
    public var amount: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// ID of the transfer that was reversed.
    @Expandable<Transfer> public var transfer: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Balance transaction that describes the impact on your account balance.
    @Expandable<BalanceTransaction> public var balanceTransaction: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Linked payment refund for the transfer reversal.
    @Expandable<Refund> public var destinationPaymentRefund: String?
    /// ID of the refund responsible for the transfer reversal.
    @Expandable<Refund> public var sourceRefund: String?
    
    public init(id: String,
                amount: Int? = nil,
                currency: Currency? = nil,
                metadata: [String : String]? = nil,
                transfer: String? = nil,
                object: String,
                balanceTransaction: String? = nil,
                created: Date,
                destinationPaymentRefund: String? = nil,
                sourceRefund: String? = nil) {
        self.id = id
        self.amount = amount
        self.currency = currency
        self.metadata = metadata
        self._transfer = Expandable(id: transfer)
        self.object = object
        self._balanceTransaction = Expandable(id: balanceTransaction)
        self.created = created
        self._destinationPaymentRefund = Expandable(id: destinationPaymentRefund)
        self._sourceRefund = Expandable(id: sourceRefund)
    }
}

public struct TransferReversalList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [TransferReversal]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [TransferReversal]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
