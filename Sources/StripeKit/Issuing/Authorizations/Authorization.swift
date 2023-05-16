//
//  Authorization.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/20/19.
//

import Foundation

/// The [Authorization Object](https://stripe.com/docs/api/issuing/authorizations/object)
public struct Authorization: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// The total amount that was authorized or rejected. This amount is in the card’s currency and in the smallest currency unit.
    public var amount: Int?
    /// Whether the authorization has been approved.
    public var approved: Bool?
    /// Card associated with this authorization.
    public var card: IssuingCard?
    /// The cardholder to whom this authorization belongs.
    @Expandable<Cardholder> public var cardholder: String?
    /// Three-letter ISO currency code. Must be a supported currency.
    public var currency: Currency?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The current status of the authorization in its lifecycle.
    public var status: AuthorizationStatus?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Detailed breakdown of amount components. These amounts are denominated in currency and in the smallest currency unit.
    public var amountDetails: AuthorizationAmountDetails?
    /// How the card details were provided. One of `chip`, `contactless`, `keyed_in`, `online`, or `swipe`.
    public var authorizationMethod: AuthorizationMethod?
    /// List of balance transactions associated with this authorization.
    public var balanceTransactions: [BalanceTransaction]?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// The total amount that was authorized or rejected. This amount is in the `merchant_currency` and in the smallest currency unit.
    public var merchantAmount: Int?
    /// The currency that was presented to the cardholder for the authorization. Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var merchantCurrency: Currency?
    /// Details about the merchant (grocery store, e-commerce website, etc.) where the card authorization happened.
    public var merchantData: AuthorizationMerchantData?
    /// Details about the authorization, such as identifiers, set by the card network.
    public var networkData: AuthorizationNetworkData?
    /// The pending authorization request. This field will only be non-null during an `issuing_authorization.request` webhook.
    public var pendingRequest: AuthorizationPendingRequest?
    /// History of every time the authorization was approved/denied (whether approved/denied by you directly or by Stripe based on your `spending_controls`). If the merchant changes the authorization by performing an incremental authorization or partial capture, you can look at this field to see the previous states of the authorization.
    public var requestHistory: [AuthorizationRequestHistory]?
    /// List of transactions associated with this authorization.
    public var transactions: [Transaction]?
    /// Verifications that Stripe performed on information that the cardholder provided to the merchant.
    public var verificationData: AuthorizationVerificationData?
    /// What, if any, digital wallet was used for this authorization. One of `apple_pay`, `google_pay`, or `samsung_pay`.
    public var wallet: AuthorizationWallet?
    
    public init(id: String,
                amount: Int? = nil,
                approved: Bool? = nil,
                card: IssuingCard? = nil,
                cardholder: String? = nil,
                currency: Currency? = nil,
                metadata: [String : String]? = nil,
                status: AuthorizationStatus? = nil,
                object: String,
                amountDetails: AuthorizationAmountDetails? = nil,
                authorizationMethod: AuthorizationMethod? = nil,
                balanceTransactions: [BalanceTransaction]? = nil,
                created: Date,
                livemode: Bool? = nil,
                merchantAmount: Int? = nil,
                merchantCurrency: Currency? = nil,
                merchantData: AuthorizationMerchantData? = nil,
                networkData: AuthorizationNetworkData? = nil,
                pendingRequest: AuthorizationPendingRequest? = nil,
                requestHistory: [AuthorizationRequestHistory]? = nil,
                transactions: [Transaction]? = nil,
                verificationData: AuthorizationVerificationData? = nil,
                wallet: AuthorizationWallet? = nil) {
        self.id = id
        self.amount = amount
        self.approved = approved
        self.card = card
        self._cardholder = Expandable(id: cardholder)
        self.currency = currency
        self.metadata = metadata
        self.status = status
        self.object = object
        self.amountDetails = amountDetails
        self.authorizationMethod = authorizationMethod
        self.balanceTransactions = balanceTransactions
        self.created = created
        self.livemode = livemode
        self.merchantAmount = merchantAmount
        self.merchantCurrency = merchantCurrency
        self.merchantData = merchantData
        self.networkData = networkData
        self.pendingRequest = pendingRequest
        self.requestHistory = requestHistory
        self.transactions = transactions
        self.verificationData = verificationData
        self.wallet = wallet
    }
}

public struct AuthorizationAmountDetails: Codable {
    /// The fee charged by the ATM for the cash withdrawal.
    public var atmFee: Int?
    
    public init(atmFee: Int? = nil) {
        self.atmFee = atmFee
    }
}

public struct AuthorizationPendingRequest: Codable {
    /// The additional amount Stripe will hold if the authorization is approved, in the card’s currency and in the smallest currency unit.
    public var amount: Int?
    /// Detailed breakdown of amount components. These amounts are denominated in currency and in the smallest currency unit.
    public var amountDetails: AuthorizationPendingRequestAmountDetails?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// If set true, you may provide amount to control how much to hold for the authorization.
    public var isAmountControllable: Bool?
    /// The amount the merchant is requesting to be authorized in the merchant_currency. The amount is in the smallest currency unit.
    public var merchantAmount: Int?
    /// The local currency the merchant is requesting to authorize.
    public var merchantCurrency: Currency?
    
    public init(amount: Int? = nil,
                amountDetails: AuthorizationPendingRequestAmountDetails? = nil,
                currency: Currency? = nil,
                isAmountControllable: Bool? = nil,
                merchantAmount: Int? = nil,
                merchantCurrency: Currency? = nil) {
        self.amount = amount
        self.amountDetails = amountDetails
        self.currency = currency
        self.isAmountControllable = isAmountControllable
        self.merchantAmount = merchantAmount
        self.merchantCurrency = merchantCurrency
    }
}

public struct AuthorizationPendingRequestAmountDetails: Codable {
    /// The fee charged by the ATM for the cash withdrawal.
    public var atmFee: Int?
    
    public init(atmFee: Int? = nil) {
        self.atmFee = atmFee
    }
}

public enum AuthorizationMethod: String, Codable {
    /// The card number was manually entered into a terminal.
    case keyedIn = "keyed_in"
    /// The card was physically swiped in a terminal.
    case swipe
    /// The card was physically present and inserted into a chip-enabled terminal. The transaction is cryptographically secured.
    case chip
    /// The card was tapped on a contactless-enabled terminal. If a digital wallet copy of the card was used, the wallet field will be present.
    case contactless
    /// The card was used in a card-not-present scenario, such as a transaction initiated at an online e-commerce checkout.
    case online
}

public struct AuthorizationMerchantData: Codable {
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
    /// An ID assigned by the seller to the location of the sale.
    public var terminalId: String?
    
    public init(category: String? = nil,
                categoryCode: String? = nil,
                city: String? = nil,
                country: String? = nil,
                name: String? = nil,
                networkId: String? = nil,
                postalCode: String? = nil,
                state: String? = nil,
                terminalId: String? = nil) {
        self.category = category
        self.categoryCode = categoryCode
        self.city = city
        self.country = country
        self.name = name
        self.networkId = networkId
        self.postalCode = postalCode
        self.state = state
        self.terminalId = terminalId
    }
}

public struct AuthorizationNetworkData: Codable {
    /// Identifier assigned to the acquirer by the card network. Sometimes this value is not provided by the network; in this case, the value will be `null`.
    public var acquiringInstitutionId: String?
    
    public init(acquiringInstitutionId: String? = nil) {
        self.acquiringInstitutionId = acquiringInstitutionId
    }
}

public struct AuthorizationRequestHistory: Codable {
    /// The `pending_request.amount` at the time of the request, presented in your card’s currency and in the smallest currency unit. Stripe held this amount from your account to fund the authorization if the request was approved.
    public var amount: Int?
    /// Detailed breakdown of amount components. These amounts are denominated in currency and in the smallest currency unit.
    public var amountDetails: AuthorizationRequestHistoryAmountDetails?
    /// Whether this request was approved.
    public var approved: Bool?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// The `pending_request.merchant_amount` at the time of the request, presented in the `merchant_currency` and in the smallest currency unit.
    public var merchantAmount: Int?
    /// The currency that was collected by the merchant and presented to the cardholder for the authorization. Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var merchantCurrency: Currency?
    /// When an authorization is approved or declined by you or by Stripe, this field provides additional detail on the reason for the outcome.
    public var reason: AuthorizationRequestHistoryReason?
    
    public init(amount: Int? = nil,
                amountDetails: AuthorizationRequestHistoryAmountDetails? = nil,
                approved: Bool? = nil,
                created: Date,
                currency: Currency? = nil,
                merchantAmount: Int? = nil,
                merchantCurrency: Currency? = nil,
                reason: AuthorizationRequestHistoryReason? = nil) {
        self.amount = amount
        self.amountDetails = amountDetails
        self.approved = approved
        self.created = created
        self.currency = currency
        self.merchantAmount = merchantAmount
        self.merchantCurrency = merchantCurrency
        self.reason = reason
    }
}

public struct AuthorizationRequestHistoryAmountDetails: Codable {
    /// The fee charged by the ATM for the cash withdrawal.
    public var atmFee: Int?
    
    public init(atmFee: Int? = nil) {
        self.atmFee = atmFee
    }
}

public enum AuthorizationRequestHistoryReason: String, Codable {
    /// The authorization request was declined because your account is disabled. For more information, please contact us at support-issuing@stripe.com. Replaces the deprecated `account_inactive` and `account_compliance_disabled` enums.
    case accountDisabled = "account_disabled"
    /// The authorization was declined because of your spending controls. Documentation for updating your spending controls can be found here. Replaces the deprecated `authorization_controls` enum.
    case spendingControls = "spending_controls"
    /// The authorization was approved according to your Issuing default settings. Authorization outcome was not driven by real-time auth webhook or spending controls as neither were configured.
    case cardActive = "card_active"
    /// The authorization request was declined because the card was inactive. To activate the card, refer to our documentation.
    case cardInactive = "card_inactive"
    /// The authorization request was declined because the cardholder was inactive. You can activate the cardholder in the dashboard or via the API update endpoint.
    case cardholderInactive = "cardholder_inactive"
    /// The authorization request was declined because your account had insufficient funds. Documentation for topping up your Issuing Balance can be found here.
    case insufficientFunds = "insufficient_funds"
    /// The authorization was not approved because the cardholder still required verification. More details can be found by querying the API and obtaining the requirements field of the Cardholder object.
    case cardholderVerificationRequired = "cardholder_verification_required"
    /// The charge is not allowed on the Stripe network, possibly because it is an ATM withdrawal or cash advance.
    case notAllowed = "not_allowed"
    /// The authorization was suspected to be fraud based on Stripe’s risk controls.
    case suspectedFraud = "suspected_fraud"
    /// The authorization was approved via the real-time auth webhook. More details on this can be found here.
    case webhookApproved = "webhook_approved"
    /// The authorization was declined via the real-time auth webhook. More details on this can be found here.
    case webhookDeclined = "webhook_declined"
    /// If you are using the real-time auth webhook, the webhook timed out before we received your authorization decision. Stripe approved or declined the authorization based on what you’ve configured in your Issuing default or Autopilot settings.
    case webhookTimeout = "webhook_timeout"
    /// The response sent through the real-time auth webhook is invalid.
    case webhookError = "webhook_error"
    /// The authorization failed required verification checks. See `authorization.verification_data` for more information. Replaces the deprecated `authentication_failed`, `incorrect_cvc`, and `incorrect_expiry` enums.
    case verificationFailed = "verification_failed"
}

public enum AuthorizationStatus: String, Codable {
    case pending
    case reversed
    case closed
}

public struct AuthorizationVerificationData: Codable {
    /// Whether the cardholder provided an address first line and if it matched the cardholder’s `billing.address.line1`.
    public var addressLine1Check: AuthorizationVerificationDataCheck?
    /// Whether the cardholder provided a postal code and if it matched the cardholder’s `billing.address.postal_code`.
    public var addressPostalCodeCheck: AuthorizationVerificationDataCheck?
    /// Whether the cardholder provided a CVC and if it matched Stripe’s record.
    public var cvcCheck: AuthorizationVerificationDataCheck?
    /// Whether the cardholder provided an expiry date and if it matched Stripe’s record.
    public var expiryCheck: AuthorizationVerificationDataCheck?
    
    public init(addressLine1Check: AuthorizationVerificationDataCheck? = nil,
                addressPostalCodeCheck: AuthorizationVerificationDataCheck? = nil,
                cvcCheck: AuthorizationVerificationDataCheck? = nil,
                expiryCheck: AuthorizationVerificationDataCheck? = nil) {
        self.addressLine1Check = addressLine1Check
        self.addressPostalCodeCheck = addressPostalCodeCheck
        self.cvcCheck = cvcCheck
        self.expiryCheck = expiryCheck
    }
}

public enum AuthorizationVerificationDataCheck: String, Codable {
    case match
    case mismatch
    case notProvided = "not_provided"
}

public enum AuthorizationWallet: String, Codable {
    case applePay = "apple_pay"
    case googlePay = "google_pay"
    case samsungPay = "samsung_pay"
}

public struct AuthorizationList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [Authorization]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [Authorization]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
