//
//  Cards.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/21/19.
//

import Foundation

/// The [Card Object](https://stripe.com/docs/api/issuing/cards/object)
public struct StripeIssuingCard: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The reason why the card was canceled.
    public var cencellationReason: StripeIssuingCardCancellationReason?
    /// The [Cardholder](https://stripe.com/docs/api#issuing_cardholder_object) object to which the card belongs.
    public var cardholder: StripeCardholder?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// The expiration month of the card.
    public var expMonth: Int?
    /// The expiration year of the card.
    public var expYear: Int?
    /// The last 4 digits of the card number.
    public var last4: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Whether authorizations can be approved on this card.
    public var status: StripeIssuingCardStatus?
    /// The type of the card.
    public var type: StripeIssuingCardType?
    /// The brand of the card.
    public var brand: StripeCardBrand?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The card’s CVC. For security reasons, this is only available for virtual cards, and will be omitted unless you explicitly request it with the expand parameter. Additionally, it’s only available via the “Retrieve a card” endpoint, not via “List all cards” or any other endpoint.
    public var cvc: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// The full unredacted card number. For security reasons, this is only available for virtual cards, and will be omitted unless you explicitly request it with the expand parameter. Additionally, it’s only available via the “Retrieve a card” endpoint, not via “List all cards” or any other endpoint.
    public var number: String?
    /// The latest card that replaces this card, if any.
    @Expandable<StripeIssuingCard> public var replacedBy: String?
    /// The card this card replaces, if any.
    @Expandable<StripeIssuingCard> public var replacementFor: String?
    /// Why the card that this card replaces (if any) needed to be replaced. One of damage, expiration, loss, or theft.
    public var replacementReason: StripeIssuingCardReplacementReason?
    /// Where and how the card will be shipped.
    public var shipping: StripeIssuingCardShipping?
    /// Spending rules that give you some control over how this card can be used. Refer to our authorizations documentation for more details.
    public var spendingControls: StripeIssuingCardSpendingControls?
    /// Information relating to digital wallets (like Apple Pay and Google Pay).
    public var wallets: StripeIssuingCardWallets?
}

public struct StripeIssuingCardList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeIssuingCard]?
}

public struct StripeIssuingCardSpendingControls: StripeModel {
    /// Array of strings containing categories of authorizations permitted on this card.
    public var allowedCategories: [String]?
    /// Array of strings containing categories of authorizations to always decline on this card.
    public var blockedCategories: [String]?
    /// Limit the spending with rules based on time intervals and categories.
    public var spendingLimits: [StripeCardholderSpendingControlSpendingLimit]?
    /// Currency for the amounts within spending_limits. Locked to the currency of the card.
    public var spendingLimitsCurrency: StripeCurrency?
}

public enum StripeIssuingCardReplacementReason: String, StripeModel {
    /// The card was lost. This status is only valid if the card it replaces is marked as lost.
    case lost
    /// The card was stolen. This status is only valid if the card it replaces is marked as stolen.
    case stolen
    /// The physical card has been damaged and cannot be used at terminals.
    case damaged
    /// The expiration date has passed or is imminent.
    case expired
}

public struct StripeIssuingCardShipping: StripeModel {
    /// Shipping address.
    public var address: StripeAddress?
    /// The delivery service that shipped a physical product, such as Fedex, UPS, USPS, etc.
    public var carrier: StripeIssuingCardShippingCarrier?
    /// A unix timestamp representing a best estimate of when the card will be delivered.
    public var eta: Date?
    /// Recipient name.
    public var name: String?
    /// Shipment speed.
    public var speed: StripeIssuingCardShippingSpeed?
    /// The delivery status of the card. One of `pending`, `shipped`, `delivered`, `returned`, `failure`, or `canceled`.
    public var status: StripeIssuingCardShippingStatus?
    /// A tracking number for a card shipment.
    public var trackingNumber: String?
    /// A link to the shipping carrier’s site where you can view detailed information about a card shipment.
    public var trackingUrl: String?
    /// One of `bulk` or `individual`. Bulk shipments will be grouped and mailed together, while individual ones will not.
    public var type: StripeIssuingCardShippingType?
}

public enum StripeIssuingCardShippingCarrier: String, StripeModel {
    case fedex
    case usps
}

public enum StripeIssuingCardShippingStatus: String, StripeModel {
    case pending
    case shipped
    case delivered
    case returned
    case failure
    case canceled
}

public enum StripeIssuingCardShippingType: String, StripeModel {
    case bulk
    case individual
}

public enum StripeIssuingCardShippingSpeed: String, StripeModel {
    /// Cards arrive in 2-6 business days.
    case standard
    /// Cards arrive in 2 business days.
    case express
    /// Cards arrive in 1 business day.
    case overnight
}

public enum StripeIssuingCardStatus: String, StripeModel {
    /// The card can approve authorizations.
    case active
    /// The card will decline authorizations with the `card_inactive` reason.
    case inactive
    /// The card will decline authorization, and no authorization object will be recorded. This status is permanent.
    case canceled
}

public enum StripeIssuingCardType: String, StripeModel {
    /// No physical card will be printed. The card can be used online and can be added to digital wallets.
    case virtual
    /// A physical card will be printed and shipped. It can be used at physical terminals.
    case physical
}

public enum StripeIssuingCardCancellationReason: String, StripeModel {
    /// The card was lost.
    case lost
    /// The card was stolen.
    case stolen
}

public struct StripeIssuingCardWallets: StripeModel {
    /// Apple Pay Details
    public var applePay: StripeIssuingCardWalletsApplePay?
    /// Google Pay Details
    public var googlePay: StripeIssuingCardWalletsGooglePay?
    /// Unique identifier for a card used with digital wallets
    public var primaryAccountIdentifier: String?
}

public struct StripeIssuingCardWalletsApplePay: StripeModel {
    /// Apple Pay Eligibility
    public var eligible: Bool?
    /// Reason the card is ineligible for Apple Pay
    public var ineligibleReason: StripeIssuingCardWalletsApplePayIneligibleReason?
}

public enum StripeIssuingCardWalletsApplePayIneligibleReason: String, StripeModel {
    /// Apple Pay is not supported in the cardholder’s country.
    case unsupportedReason = "unsupported_reason"
    /// Apple Pay is not enabled for your account.
    case missingAgreement = "missing_agreement"
    /// Cardholder phone number or email required.
    case missingCardholderContact = "missing_cardholder_contact"
}

public struct StripeIssuingCardWalletsGooglePay: StripeModel {
    /// Google Pay Eligibility
    public var eligible: Bool?
    /// Reason the card is ineligible for Google Pay
    public var ineligibleReason: StripeIssuingCardWalletsGooglePayIneligibleReason?
}

public enum StripeIssuingCardWalletsGooglePayIneligibleReason: String, StripeModel {
    /// Google Pay is not supported in the cardholder’s country.
    case unsupportedReason = "unsupported_reason"
    /// Google Pay is not enabled for your account.
    case missingAgreement = "missing_agreement"
    /// Cardholder phone number or email required.
    case missingCardholderContact = "missing_cardholder_contact"
}
