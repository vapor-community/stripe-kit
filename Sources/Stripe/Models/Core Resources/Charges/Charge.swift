//
//  Charge.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation

/// The [Charge Object](https://stripe.com/docs/api/charges/object).
public struct StripeCharge: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// A positive integer in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal) (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency) representing how much to charge. The minimum amount is $0.50 US or [equivalent in charge currency](https://support.stripe.com/questions/what-is-the-minimum-amount-i-can-charge-with-stripe).
    public var amount: Int?
    /// Amount in cents refunded (can be less than the amount attribute on the charge if a partial refund was issued).
    public var amountRefunded: Int?
    /// ID of the Connect application that created the charge.
    public var application: String?
    /// The application fee (if any) for the charge. [See the Connect documentation](https://stripe.com/docs/connect/direct-charges#collecting-fees) for details.
    public var applicationFee: String?
    /// The amount of the application fee (if any) for the charge. [See the Connect documentation](https://stripe.com/docs/connect/direct-charges#collecting-fees) for details.
    public var applicationFeeAmount: Int?
    /// ID of the balance transaction that describes the impact of this charge on your account balance (not including refunds or disputes).
    public var balanceTransaction: String?
    /// Billing information associated with the payment method at the time of the transaction.
    public var billingDetails: StripeChargeBillingDetails?
    /// If the charge was created without capturing, this Boolean represents whether it is still uncaptured or has since been captured.
    public var captured: Bool?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// ID of the customer this charge is for if one exists.
    public var customer: String?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// Details about the dispute if the charge has been disputed.
    public var dispute: String?
    /// Error code explaining reason for charge failure if available (see [the errors section](https://stripe.com/docs/api#errors) for a list of codes).
    public var failureCode: String?
    /// Message to user further explaining reason for charge failure if available.
    public var failureMessage: String?
    /// Information on fraud assessments for the charge.
    public var fraudDetails: StripeChargeFraudDetails?
    /// ID of the invoice this charge is for if one exists.
    public var invoice: String?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The account (if any) the charge was made on behalf of without triggering an automatic transfer. See the [Connect documentation](https://stripe.com/docs/connect/charges-transfers) for details.
    public var onBehalfOf: String?
    /// ID of the order this charge is for if one exists.
    public var order: String?
    /// Details about whether the payment was accepted, and why. See [understanding declines](https://stripe.com/docs/declines) for details.
    public var outcome: StripeChargeOutcome?
    /// `true` if the charge succeeded, or was successfully authorized for later capture.
    public var paid: Bool?
    /// ID of the PaymentIntent associated with this charge, if one exists.
    public var paymentIntent: String?
    /// ID of the payment method used in this charge.
    public var paymentMethod: String?
    ///
    // TODO: - PaymentMethod API
    /// This is the email address that the receipt for this charge was sent to.
    public var receiptEmail: String?
    /// This is the transaction number that appears on email receipts sent for this charge. This attribute will be `null` until a receipt has been sent.
    public var receiptNumber: String?
    /// This is the URL to view the receipt for this charge. The receipt is kept up-to-date to the latest state of the charge, including any refunds. If the charge is for an Invoice, the receipt will be stylized as an Invoice receipt.
    public var receiptUrl: String?
    /// Whether the charge has been fully refunded. If the charge is only partially refunded, this attribute will still be false.
    public var refunded: Bool?
    /// A list of refunds that have been applied to the charge.
    public var refunds: RefundsList
    /// ID of the review associated with this charge if one exists.
    public var review: String?
    /// Shipping information for the charge.
    public var shipping: StripeShippingLabel?
    /// For most Stripe users, the source of every charge is a credit or debit card. This hash is then the [card object](https://stripe.com/docs/api/charges/object#card_object) describing that card.
    public var source: StripeSource?
    /// The transfer ID which created this charge. Only present if the charge came from another Stripe account. [See the Connect documentation](https://stripe.com/docs/connect/destination-charges) for details.
    public var sourceTransfer: String?
    /// Extra information about a charge. This will appear on your customer’s credit card statement. It must contain at least one letter.
    public var statementDescriptor: String?
    /// The status of the payment is either `succeeded`, `pending`, or `failed`.
    public var status: StripeChargeStatus?
    /// ID of the transfer to the `destination` account (only applicable if the charge was created using the `destination` parameter).
    public var transfer: String?
    /// An optional dictionary including the account to automatically transfer to as part of a destination charge. [See the Connect documentation](https://stripe.com/docs/connect/destination-charges) for details.
    public var transferData: StripeChargeTransferData?
    /// A string that identifies this transaction as part of a group. See the [Connect documentation](https://stripe.com/docs/connect/charges-transfers#grouping-transactions) for details.
    public var transferGroup: String?
}

public struct StripeChargeBillingDetails: StripeModel {
    /// Billing address.
    public var address: StripeAddress?
    /// Email address.
    public var email: String?
    /// Full name.
    public var name: String?
    /// Billing phone number (including extension).
    public var phone: String?
}

public struct StripeChargeFraudDetails: StripeModel {
    /// Assessments reported by you. If set, possible values of are `safe` and `fraudulent`.
    public var userReport: StripeChargeFraudDetailsReportType?
    /// Assessments from Stripe. If set, the value is `fraudulent`.
    public var stripeReport: StripeChargeFraudDetailsReportType?
}

public enum StripeChargeFraudDetailsReportType: String, StripeModel {
    case safe
    case fraudulent
}

public struct StripeChargeOutcome: StripeModel {
    /// Possible values are `approved_by_network`, `declined_by_network`, `not_sent_to_network`, and `reversed_after_approval`. The value `reversed_after_approval` indicates the payment was [blocked by Stripe](https://stripe.com/docs/declines#blocked-payments) after bank authorization, and may temporarily appear as “pending” on a cardholder’s statement.
    public var networkStatus: StripeChargeOutcomeNetworkStatus?
    /// An enumerated value providing a more detailed explanation of the outcome’s `type`. Charges blocked by Radar’s default block rule have the value `highest_risk_level`. Charges placed in review by Radar’s default review rule have the value `elevated_risk_level`. Charges authorized, blocked, or placed in review by custom rules have the value `rule`. See [understanding declines](https://stripe.com/docs/declines) for more details.
    public var reason: String?
    /// Stripe’s evaluation of the riskiness of the payment. Possible values for evaluated payments are `normal`, `elevated`, `highest`. For non-card payments, and card-based payments predating the public assignment of risk levels, this field will have the value `not_assessed`. In the event of an error in the evaluation, this field will have the value `unknown`.
    public var riskLevel: StripeChargeOutcomeRiskLevel?
    /// Stripe’s evaluation of the riskiness of the payment. Possible values for evaluated payments are between 0 and 100. For non-card payments, card-based payments predating the public assignment of risk scores, or in the event of an error during evaluation, this field will not be present. This field is only available with Radar for Fraud Teams.
    public var riskScore: Int?
    /// The ID of the Radar rule that matched the payment, if applicable.
    public var rule: String?
    /// A human-readable description of the outcome type and reason, designed for you (the recipient of the payment), not your customer.
    public var sellerMessage: String?
    /// Possible values are `authorized`, `manual_review`, `issuer_declined`, `blocked`, and `invalid`. See understanding declines and Radar reviews for details.
    public var type: StripeChargeOutcomeType?
}

public enum StripeChargeOutcomeNetworkStatus: String, StripeModel {
    case approvedByNetwork = "approved_by_network"
    case declinedByNetwork = "declined_by_network"
    case notSentToNetwork = "not_sent_to_network"
    case reversedAfterApproval = "reversed_after_approval"
}

public enum StripeChargeOutcomeRiskLevel: String, StripeModel {
    case normal
    case elevated
    case highest
    case notAssessed = "not_assessed"
    case unknown
}

public enum StripeChargeOutcomeType: String, StripeModel {
    case authorized
    case manualReview = "manual_review"
    case issuerDeclined = "issuer_declined"
    case blocked
    case invalid
}

public enum StripeChargeStatus: String, StripeModel {
    case succeeded
    case pending
    case failed
}

public struct StripeChargeTransferData: StripeModel {
    /// The amount transferred to the destination account, if specified. By default, the entire charge amount is transferred to the destination account.
    public var amount: Int?
    /// ID of an existing, connected Stripe account to transfer funds to if `transfer_data` was specified in the charge request.
    public var destination: String?
}

public struct StripeChargesList: StripeModel {
    /// String representing the object’s type. Objects of the same type share the same value. Always has the value list.
    public var object: String
    /// True if this list has another page of items after this one that can be fetched.
    public var hasMore: Bool?
    /// The URL where this list can be accessed.
    public var url: String?
    public var data: [StripeCharge]?
}
