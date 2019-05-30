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
    /// Spending rules that give you some control over how your cards can be used. Refer to our authorizations documentation for more details.
    public var authorizationControls: StripeIssuingCardAuthorizationControls?
    /// The brand of the card.
    public var brand: StripeCardBrand?
    /// The [Cardholder](https://stripe.com/docs/api#issuing_cardholder_object) object to which the card belongs.
    public var cardholder: StripeCardholder?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// The expiration month of the card.
    public var expMonth: Int?
    /// The expiration year of the card.
    public var expYear: Int?
    /// The last 4 digits of the card number.
    public var last4: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The name of the cardholder, printed on the card.
    public var name: String?
    /// The card this card replaces, if any.
    public var replacementFor: String?
    /// Why the card that this card replaces (if any) needed to be replaced. One of damage, expiration, loss, or theft.
    public var replacementReason: StripeIssuingCardReplacementReason?
    /// Where and how the card will be shipped.
    public var shipping: StripeIssuingCardShipping?
    /// One of `active`, `inactive`, `canceled`, `lost`, `stolen`, or `pending`.
    public var status: StripeIssuingCardStatus?
    /// One of virtual or physical.
    public var type: StripeIssuingCardType?
}

public struct StripeIssuingCardAuthorizationControls: StripeModel {
    /// Array of strings containing categories of authorizations permitted on this card.
    public var allowedCategories: [String]?
    /// Array of strings containing categories of authorizations to always decline on this card.
    public var blockedCategories: [String]?
    /// The currency of the card. See max_amount
    public var currency: StripeCurrency?
    /// Maximum amount allowed per authorization on this card, in the currency of the card. Authorization amounts in a different currency will be converted to the card’s currency when evaluating this control.
    public var maxAmount: Int?
    /// Maximum count of approved authorizations on this card. Counts all authorizations retroactively.
    public var maxApprovals: Int?
    /// Limit the spending with rules based on time intervals and categories.
    public var spendingLimits: [StripeCardholderAuthorizationControlSpendingLimit]?
    /// Currency for the amounts within spending_limits. Locked to the currency of the card.
    public var spendingLimitsCurrency: StripeCurrency?
}

public enum StripeIssuingCardReplacementReason: String, StripeModel {
    case damage
    case expiration
    case loss
    case theft
}

public struct StripeIssuingCardShipping: StripeModel {
    /// Shipping address.
    public var address: StripeAddress?
    /// The delivery service that shipped a physical product, such as Fedex, UPS, USPS, etc.
    public var carrier: String?
    /// A unix timestamp representing a best estimate of when the card will be delivered.
    public var eta: Date?
    /// Recipient name.
    public var name: String?
    /// The delivery status of the card. One of `pending`, `shipped`, `delivered`, `returned`, `failure`, or `canceled`.
    public var status: StripeIssuingCardShippingStatus?
    /// A tracking number for a card shipment.
    public var trackingNumber: String?
    /// A link to the shipping carrier’s site where you can view detailed information about a card shipment.
    public var trackingUrl: String?
    /// One of `bulk` or `individual`. Bulk shipments will be grouped and mailed together, while individual ones will not.
    public var type: StripeIssuingCardShippingType?
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

public enum StripeIssuingCardStatus: String, StripeModel {
    case active
    case inactive
    case canceled
    case lost
    case stolen
    case pending
}

public enum StripeIssuingCardType: String, StripeModel {
    case virtual
    case physical
}
