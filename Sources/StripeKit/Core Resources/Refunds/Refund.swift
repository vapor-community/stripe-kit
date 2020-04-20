//
//  RefundItem.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation

/// The [Refund Object](https://stripe.com/docs/api/refunds/object ).
public struct StripeRefund: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Amount, in cents.
    public var amount: Int?
    /// Balance transaction that describes the impact on your account balance.
    @Expandable<StripeBalanceTransaction> public var balanceTransaction: String?
    /// ID of the charge that was refunded.
    @Expandable<StripeCharge> public var charge: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// An arbitrary string attached to the object. Often useful for displaying to users. (Available on non-card refunds only)
    public var description: String?
    /// If the refund failed, this balance transaction describes the adjustment made on your account balance that reverses the initial balance transaction.
    @Expandable<StripeBalanceTransaction> public var failureBalanceTransaction: String?
    /// If the refund failed, the reason for refund failure if known. Possible values are `lost_or_stolen_card`, `expired_or_canceled_card`, or `unknown`.
    public var failureReason: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// ID of the PaymentIntent that was refunded.
    @Expandable<StripePaymentIntent> public var paymentIntent: String?
    /// Reason for the refund. If set, possible values are `duplicate`, `fraudulent`, and `requested_by_customer`.
    public var reason: StripeRefundReason?
    /// This is the transaction number that appears on email receipts sent for this refund.
    public var receiptNumber: String?
    /// The transfer reversal that is associated with the refund. Only present if the charge came from another Stripe account. See the Connect documentation for details.
    @Expandable<StripeTransferReversal> public var sourceTransferReversal: String?
    /// Status of the refund. For credit card refunds, this can be `pending`, `succeeded`, or `failed`. For other types of refunds, it can be `pending`, `succeeded`, `failed`, or `canceled`. Refer to our refunds documentation for more details.
    public var status: StripeRefundStatus?
    /// If the accompanying transfer was reversed, the transfer reversal object. Only applicable if the charge was created using the destination parameter.
    @Expandable<StripeTransferReversal> public var transferReversal: String?
}

public enum StripeRefundFailureReason: String, StripeModel {
    case lostOrStolenCard = "lost_or_stolen_card"
    case expiredOrCanceledCard = "expired_or_canceled_card"
    case unknown
}

public enum StripeRefundReason: String, StripeModel {
    case duplicate
    case fraudulent
    case requestedByCustomer = "requested_by_customer"
}

public struct StripeRefundsList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeRefund]?
}

public enum StripeRefundStatus: String, StripeModel {
    case pending
    case succeeded
    case failed
    case canceled
}
