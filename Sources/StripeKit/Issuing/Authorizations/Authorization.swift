//
//  Authorization.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/20/19.
//

import Foundation

/// The [Authorization Object](https://stripe.com/docs/api/issuing/authorizations/object).
public struct StripeAuthorization: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Whether the authorization has been approved.
    public var approved: Bool?
    /// How the card details were provided. One of `chip`, `contactless`, `keyed_in`, `online`, or `swipe`.
    public var authorizationMethod: StripeAuthorizationMethod?
    /// The amount that has been authorized. This will be `0` when the object is created, and increase after it has been approved.
    public var authorizedAmount: Int?
    /// The currency that was presented to the cardholder for the authorization. Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var authorizedCurrency: StripeCurrency?
    /// array, contains: balance_transaction object
    public var balanceTransactions: [StripeBalanceTransaction]?
    ///
    public var card: StripeIssuingCard?
    /// The cardholder to whom this authorization belongs.
    public var cardholder: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// The amount the authorization is expected to be in held_currency. When Stripe holds funds from you, this is the amount reserved for the authorization. This will be 0 when the object is created, and increase after it has been approved. For multi-currency transactions, held_amount can be used to determine the expected exchange rate.
    public var heldAmount: Int?
    /// The currency of the held amount. This will always be the card currency.
    public var heldCurrency: StripeCurrency?
    ///
    public var isHeldAmountControllable: Bool?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    ///
    public var merchantData: StripeAuthorizationMerchantData?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The amount the user is requesting to be authorized. This field will only be non-zero during an `issuing.authorization.request` webhook.
    public var pendingAuthorizedAmount: Int?
    /// The additional amount Stripe will hold if the authorization is approved. This field will only be non-zero during an `issuing.authorization.request` webhook.
    public var pendingHeldAmount: Int?
    ///
    public var requestHistory: [StripeAuthorizationRequestHistory]?
    /// One of `pending`, `reversed`, or `closed`.
    public var status: StripeAuthorizationStatus?
    ///
    public var transactions: [StripeTransaction]?
    ///
    public var verificationData: StripeAuthorizationVerificationData?
    /// What, if any, digital wallet was used for this authorization. One of `apple_pay`, `google_pay`, or `samsung_pay`.
    public var walletProvider: StripeAuthorizationWalletProvider?
}

public enum StripeAuthorizationMethod: String, StripeModel {
    case keyedIn = "keyed_in"
    case swipe
    case chip
    case contactless
    case online
}

public struct StripeAuthorizationMerchantData: StripeModel {
    // TODO: - Make an enum once it's solidified.
    /// A categorization of the seller’s type of business. See our merchant categories guide for a list of possible values.
    public var category: String?
    /// City where the seller is located
    public var city: String?
    /// Country where the seller is located
    public var country: String?
    /// Name of the seller
    public var name: String?
    /// Identifier assigned to the seller by the card brand
    public var networkId: String?
    /// Postal code where the seller is located
    public var postalCode: String?
    /// State where the seller is located
    public var state: String?
}

public struct StripeAuthorizationRequestHistory: StripeModel {
    /// Whether this request was approved.
    public var approved: Bool?
    /// The amount that was authorized at the time of this request
    public var authorizedAmount: Int?
    /// The currency that was presented to the cardholder for the authorization. Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var authorizedCurrency: StripeCurrency?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// The amount Stripe held from your account to fund the authorization, if the request was approved
    public var heldAmount: Int?
    /// The currency of the held amount
    public var heldCurrency: StripeCurrency?
    /// One of `authorization_controls` , `card_active`, `card_inactive`, `insufficient_funds`, `account_compliance_disabled`, `account_inactive`, `suspected_fraud`, `webhook_approved`, `webhook_declined`, or `webhook_timeout`.
    public var reason: StripeAuthorizationRequestHistoryReason?
}

public enum StripeAuthorizationRequestHistoryReason: String, StripeModel {
    case authorizationControls = "authorization_controls"
    case cardActive = "card_active"
    case cardInactive = "card_inactive"
    case insufficientFunds = "insufficient_funds"
    case accountComplianceDisabled = "account_compliance_disabled"
    case accountInactive = "account_inactive"
    case suspectedFraud = "suspected_fraud"
    case webhookApproved = "webhook_approved"
    case webhookDeclined = "webhook_declined"
    case webhookTimeout = "webhook_timeout"
}

public enum StripeAuthorizationStatus: String, StripeModel {
    case pending
    case reversed
    case closed
}

public struct StripeAuthorizationVerificationData: StripeModel {
    /// One of `match`, `mismatch`, or `not_provided`.
    public var addressLine1Check: StripeAuthorizationVerificationDataCheck?
    /// One of `match`, `mismatch`, or `not_provided`.
    public var addressZipCheck: StripeAuthorizationVerificationDataCheck?
    /// One of `exempt`, `failure`, `none`, or `success`.
    public var authentication: StripeAuthorizationVerificationDataAuthorization?
    /// One of `match`, `mismatch`, or `not_provided`.
    public var cvcCheck: StripeAuthorizationVerificationDataCheck?
}

public enum StripeAuthorizationVerificationDataCheck: String, StripeModel {
    case match
    case mismatch
    case notProvided = "not_provided"
}

public enum StripeAuthorizationVerificationDataAuthorization: String, StripeModel {
    case exempt
    case failure
    case none
    case success
}

public enum StripeAuthorizationWalletProvider: String, StripeModel {
    case applePay = "apple_pay"
    case googlePay = "google_pay"
    case samsungPay = "samsung_pay"
}

public struct StripeAuthorizationList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeAuthorization]?
}
