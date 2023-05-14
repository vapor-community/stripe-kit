//
//  ApplicationFee.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/16/19.
//

import Foundation
/// When you collect a transaction fee on top of a charge made for your user (using [Connect](https://stripe.com/docs/connect) ), an `Application Fee` object is created in your account. You can list, retrieve, and refund application fees. For details, see [Collecting application fees](https://stripe.com/docs/connect/direct-charges#collecting-fees). [Learn More](https://stripe.com/docs/api/application_fees)
public struct ApplicationFee: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// ID of the Stripe account this fee was taken from.
    @Expandable<ConnectAccount> public var account: String?
    /// Amount earned, in cents.
    public var amount: Int?
    /// Amount in cents refunded (can be less than the amount attribute on the fee if a partial refund was issued)
    public var amountRefunded: Int?
    /// ID of the charge that the application fee was taken from.
    @Expandable<Charge> public var charge: String?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// Whether the fee has been fully refunded. If the fee is only partially refunded, this attribute will still be false.
    public var refunded: Bool?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// ID of the Connect application that earned the fee.
    public var application: String?
    /// Balance transaction that describes the impact of this collected application fee on your account balance (not including refunds).
    @Expandable<BalanceTransaction> public var balanceTransaction: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool
    /// ID of the corresponding charge on the platform account, if this fee was the result of a charge using the destination parameter.
    @DynamicExpandable<Charge, StripeTransfer> public var originatingTransaction: String?
    /// A list of refunds that have been applied to the fee.
    public var refunds: ApplicationFeeRefundList?
    ///
    public var source: ApplicationFeeSource?
    
    public init(id: String,
                account: String? = nil,
                amount: Int? = nil,
                amountRefunded: Int? = nil,
                charge: String? = nil,
                currency: Currency? = nil,
                refunded: Bool? = nil,
                object: String,
                application: String? = nil,
                balanceTransaction: String? = nil,
                created: Date,
                livemode: Bool,
                originatingTransaction: String? = nil,
                refunds: ApplicationFeeRefundList? = nil,
                source: ApplicationFeeSource? = nil) {
        self.id = id
        self._account = Expandable(id: account)
        self.amount = amount
        self.amountRefunded = amountRefunded
        self._charge = Expandable(id: charge)
        self.currency = currency
        self.refunded = refunded
        self.object = object
        self.application = application
        self._balanceTransaction = Expandable(id: balanceTransaction)
        self.created = created
        self.livemode = livemode
        self._originatingTransaction = DynamicExpandable(id: originatingTransaction)
        self.refunds = refunds
        self.source = source
    }
}

public struct ApplicationFeeSource: Codable {
    public var feeType: String?
    public var resource: ApplicationFeeSourceResource?
    
    public init(feeType: String? = nil, resource: ApplicationFeeSourceResource? = nil) {
        self.feeType = feeType
        self.resource = resource
    }
}

public struct ApplicationFeeSourceResource: Codable {
    public var charge: String?
    public var payout: String?
    public var type: String?
    
    public init(charge: String? = nil,
                payout: String? = nil,
                type: String? = nil) {
        self.charge = charge
        self.payout = payout
        self.type = type
    }
}

public struct ApplicationFeeList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [ApplicationFee]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [ApplicationFee]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
