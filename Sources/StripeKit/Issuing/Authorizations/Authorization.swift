//
//  Authorization.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/20/19.
//

import Foundation

/// The [Authorization Object](https://stripe.com/docs/api/issuing/authorizations/object).
public struct StripeAuthorization: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The total amount that was authorized or rejected. This amount is in the card’s currency and in the smallest currency unit.
    public var amount: Int?
    /// Detailed breakdown of amount components. These amounts are denominated in currency and in the smallest currency unit.
    public var amountDetails: StripeAuthorizationAmountDetails?
    /// Whether the authorization has been approved.
    public var approved: Bool?
    /// How the card details were provided. One of `chip`, `contactless`, `keyed_in`, `online`, or `swipe`.
    public var authorizationMethod: StripeAuthorizationMethod?
    /// List of balance transactions associated with this authorization.
    public var balanceTransactions: [BalanceTransaction]?
    /// Card associated with this authorization.
    public var card: StripeIssuingCard?
    /// The cardholder to whom this authorization belongs.
    @Expandable<StripeCardholder> public var cardholder: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Three-letter ISO currency code. Must be a supported currency.
    public var currency: Currency?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// The total amount that was authorized or rejected. This amount is in the `merchant_currency` and in the smallest currency unit.
    public var merchantAmount: Int?
    /// The currency that was presented to the cardholder for the authorization. Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var merchantCurrency: Currency?
    /// Details about the merchant (grocery store, e-commerce website, etc.) where the card authorization happened.
    public var merchantData: StripeAuthorizationMerchantData?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The pending authorization request. This field will only be non-null during an `issuing_authorization.request` webhook.
    public var pendingRequest: StripeAuthorizationPendingRequest?
    /// History of every time the authorization was approved/denied (whether approved/denied by you directly or by Stripe based on your `spending_controls`). If the merchant changes the authorization by performing an incremental authorization or partial capture, you can look at this field to see the previous states of the authorization.
    public var requestHistory: [StripeAuthorizationRequestHistory]?
    /// The current status of the authorization in its lifecycle.
    public var status: StripeAuthorizationStatus?
    /// List of transactions associated with this authorization.
    public var transactions: [StripeTransaction]?
    /// Verifications that Stripe performed on information that the cardholder provided to the merchant.
    public var verificationData: StripeAuthorizationVerificationData?
    /// What, if any, digital wallet was used for this authorization. One of `apple_pay`, `google_pay`, or `samsung_pay`.
    public var wallet: StripeAuthorizationWallet?
}

public struct StripeAuthorizationAmountDetails: Codable {
    /// The fee charged by the ATM for the cash withdrawal.
    public var atmFee: Int?
}

public struct StripeAuthorizationPendingRequest: Codable {
    /// The additional amount Stripe will hold if the authorization is approved, in the card’s currency and in the smallest currency unit.
    public var amount: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// If set true, you may provide amount to control how much to hold for the authorization.
    public var isAmountControllable: Bool?
    /// The amount the merchant is requesting to be authorized in the merchant_currency. The amount is in the smallest currency unit.
    public var merchantAmount: Int?
    /// The local currency the merchant is requesting to authorize.
    public var merchantCurrency: Currency?
}

public enum StripeAuthorizationMethod: String, Codable {
    case keyedIn = "keyed_in"
    case swipe
    case chip
    case contactless
    case online
}

public struct StripeAuthorizationMerchantData: Codable {
    // TODO: - Make this an enum once it's solidified. https://stripe.com/docs/issuing/merchant-categories
    /// A categorization of the seller’s type of business. See our merchant categories guide for a list of possible values.
    public var category: String?
    /// The merchant category code for the seller’s business
    public var categoryCode: String?
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

public struct StripeAuthorizationRequestHistory: Codable {
    /// Whether this request was approved.
    public var approved: Bool?
    /// The amount that was authorized at the time of this request
    public var authorizedAmount: Int?
    /// The currency that was presented to the cardholder for the authorization. Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var authorizedCurrency: Currency?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The amount Stripe held from your account to fund the authorization, if the request was approved
    public var heldAmount: Int?
    /// The currency of the held amount
    public var heldCurrency: Currency?
    /// One of `authorization_controls` , `card_active`, `card_inactive`, `insufficient_funds`, `account_compliance_disabled`, `account_inactive`, `suspected_fraud`, `webhook_approved`, `webhook_declined`, or `webhook_timeout`.
    public var reason: StripeAuthorizationRequestHistoryReason?
}

public enum StripeAuthorizationRequestHistoryReason: String, Codable {
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

public enum StripeAuthorizationStatus: String, Codable {
    case pending
    case reversed
    case closed
}

public struct StripeAuthorizationVerificationData: Codable {
    /// One of `match`, `mismatch`, or `not_provided`.
    public var addressLine1Check: StripeAuthorizationVerificationDataCheck?
    /// One of `match`, `mismatch`, or `not_provided`.
    public var addressZipCheck: StripeAuthorizationVerificationDataCheck?
    /// One of `exempt`, `failure`, `none`, or `success`.
    public var authentication: StripeAuthorizationVerificationDataAuthorization?
    /// One of `match`, `mismatch`, or `not_provided`.
    public var cvcCheck: StripeAuthorizationVerificationDataCheck?
    /// One of `match`, `mismatch`, or `not_provided`.
    public var expiryCheck: StripeAuthorizationVerificationDataCheck?
}

public enum StripeAuthorizationVerificationDataCheck: String, Codable {
    case match
    case mismatch
    case notProvided = "not_provided"
}

public enum StripeAuthorizationVerificationDataAuthorization: String, Codable {
    case exempt
    case failure
    case none
    case success
}

public enum StripeAuthorizationWallet: String, Codable {
    case applePay = "apple_pay"
    case googlePay = "google_pay"
    case samsungPay = "samsung_pay"
}

public struct StripeAuthorizationList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeAuthorization]?
}
