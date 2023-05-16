//
//  Cards.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/21/19.
//

import Foundation

/// The [Card Object](https://stripe.com/docs/api/issuing/cards/object)
public struct IssuingCard: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// The reason why the card was canceled.
    public var cencellationReason: IssuingCardCancellationReason?
    /// The [Cardholder](https://stripe.com/docs/api#issuing_cardholder_object) object to which the card belongs.
    public var cardholder: Cardholder?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// The expiration month of the card.
    public var expMonth: Int?
    /// The expiration year of the card.
    public var expYear: Int?
    /// The last 4 digits of the card number.
    public var last4: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Whether authorizations can be approved on this card.
    public var status: IssuingCardStatus?
    /// The type of the card.
    public var type: IssuingCardType?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The brand of the card.
    public var brand: CardBrand?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The card’s CVC. For security reasons, this is only available for virtual cards, and will be omitted unless you explicitly request it with the expand parameter. Additionally, it’s only available via the “Retrieve a card” endpoint, not via “List all cards” or any other endpoint.
    public var cvc: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// The full unredacted card number. For security reasons, this is only available for virtual cards, and will be omitted unless you explicitly request it with the expand parameter. Additionally, it’s only available via the “Retrieve a card” endpoint, not via “List all cards” or any other endpoint.
    public var number: String?
    /// The latest card that replaces this card, if any.
    @Expandable<IssuingCard> public var replacedBy: String?
    /// The card this card replaces, if any.
    @Expandable<IssuingCard> public var replacementFor: String?
    /// Why the card that this card replaces (if any) needed to be replaced. One of damage, expiration, loss, or theft.
    public var replacementReason: IssuingCardReplacementReason?
    /// Where and how the card will be shipped.
    public var shipping: IssuingCardShipping?
    /// Spending rules that give you some control over how this card can be used. Refer to our authorizations documentation for more details.
    public var spendingControls: IssuingCardSpendingControls?
    /// Information relating to digital wallets (like Apple Pay and Google Pay).
    public var wallets: IssuingCardWallets?
    
    public init(id: String,
                cencellationReason: IssuingCardCancellationReason? = nil,
                cardholder: Cardholder? = nil,
                currency: Currency? = nil,
                expMonth: Int? = nil,
                expYear: Int? = nil,
                last4: String? = nil,
                metadata: [String : String]? = nil,
                status: IssuingCardStatus? = nil,
                type: IssuingCardType? = nil,
                object: String,
                brand: CardBrand? = nil,
                created: Date,
                cvc: String? = nil,
                livemode: Bool? = nil,
                number: String? = nil,
                replacedBy: String? = nil,
                replacementFor: String? = nil,
                replacementReason: IssuingCardReplacementReason? = nil,
                shipping: IssuingCardShipping? = nil,
                spendingControls: IssuingCardSpendingControls? = nil,
                wallets: IssuingCardWallets? = nil) {
        self.id = id
        self.cencellationReason = cencellationReason
        self.cardholder = cardholder
        self.currency = currency
        self.expMonth = expMonth
        self.expYear = expYear
        self.last4 = last4
        self.metadata = metadata
        self.status = status
        self.type = type
        self.object = object
        self.brand = brand
        self.created = created
        self.cvc = cvc
        self.livemode = livemode
        self.number = number
        self._replacedBy = Expandable(id: replacedBy)
        self._replacementFor = Expandable(id: replacementFor)
        self.replacementReason = replacementReason
        self.shipping = shipping
        self.spendingControls = spendingControls
        self.wallets = wallets
    }
}

public struct IssuingCardList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [IssuingCard]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [IssuingCard]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}

public struct IssuingCardSpendingControls: Codable {
    /// Array of strings containing categories of authorizations permitted on this card.
    public var allowedCategories: [String]?
    /// Array of strings containing categories of authorizations to always decline on this card.
    public var blockedCategories: [String]?
    /// Limit the spending with rules based on time intervals and categories.
    public var spendingLimits: [CardholderSpendingControlSpendingLimit]?
    /// Currency for the amounts within `spending_limits`. Locked to the currency of the card.
    public var spendingLimitsCurrency: Currency?
    
    public init(allowedCategories: [String]? = nil,
                blockedCategories: [String]? = nil,
                spendingLimits: [CardholderSpendingControlSpendingLimit]? = nil,
                spendingLimitsCurrency: Currency? = nil) {
        self.allowedCategories = allowedCategories
        self.blockedCategories = blockedCategories
        self.spendingLimits = spendingLimits
        self.spendingLimitsCurrency = spendingLimitsCurrency
    }
}

public enum IssuingCardReplacementReason: String, Codable {
    /// The card was lost. This status is only valid if the card it replaces is marked as lost.
    case lost
    /// The card was stolen. This status is only valid if the card it replaces is marked as stolen.
    case stolen
    /// The physical card has been damaged and cannot be used at terminals. This reason is only valid for cards of type `physical`.
    case damaged
    /// The expiration date has passed or is imminent.
    case expired
}

public struct IssuingCardShipping: Codable {
    /// Shipping address.
    public var address: Address?
    /// The delivery company that shipped a card.
    public var carrier: IssuingCardShippingCarrier?
    /// Additional information that may be required for clearing customs.
    public var customs: [IssuingCardShippingCustom]?
    /// A unix timestamp representing a best estimate of when the card will be delivered.
    public var eta: Date?
    /// Recipient name.
    public var name: String?
    /// The phone number of the receiver of the bulk shipment. This phone number will be provided to the shipping company, who might use it to contact the receiver in case of delivery issues.
    public var phoneNumber: String?
    /// Whether a signature is required for card delivery. This feature is only supported for US users. Standard shipping service does not support signature on delivery. The default value for standard shipping service is false and for express and priority services is true.
    public var requireSignature: Bool?
    /// Shipment service, such as `standard` or `express`.
    public var service: IssuingCardShippingService?
    /// The delivery status of the card.
    public var status: IssuingCardShippingStatus?
    /// A tracking number for a card shipment.
    public var trackingNumber: String?
    /// A link to the shipping carrier’s site where you can view detailed information about a card shipment.
    public var trackingUrl: String?
    /// Packaging options.
    public var type: IssuingCardShippingType?
    
    public init(address: Address? = nil,
                carrier: IssuingCardShippingCarrier? = nil,
                customs: [IssuingCardShippingCustom]? = nil,
                eta: Date? = nil,
                name: String? = nil,
                phoneNumber: String? = nil,
                requireSignature: Bool? = nil,
                service: IssuingCardShippingService? = nil,
                status: IssuingCardShippingStatus? = nil,
                trackingNumber: String? = nil,
                trackingUrl: String? = nil,
                type: IssuingCardShippingType? = nil) {
        self.address = address
        self.carrier = carrier
        self.customs = customs
        self.eta = eta
        self.name = name
        self.phoneNumber = phoneNumber
        self.requireSignature = requireSignature
        self.service = service
        self.status = status
        self.trackingNumber = trackingNumber
        self.trackingUrl = trackingUrl
        self.type = type
    }
}

public struct IssuingCardShippingCustom: Codable {
    /// A registration number used for customs in Europe. See https://www.gov.uk/eori and https://ec.europa.eu/taxation_customs/business/customs-procedures-import-and-export/customs-procedures/economic-operators-registration-and-identification-number-eori_en.
    public var eoriNumber: String?
    
    public init(eoriNumber: String? = nil) {
        self.eoriNumber = eoriNumber
    }
}

public enum IssuingCardShippingCarrier: String, Codable {
    /// FedEx
    case fedex
    /// USPS
    case usps
    /// Royal Mail
    case royalMail = "royal_mail"
    /// DHL
    case dhl
}

public enum IssuingCardShippingService: String, Codable {
    /// Cards arrive in 5-8 business days.
    case standard
    /// Cards arrive in 4 business days.
    case express
    /// Cards arrive in 2-3 business days.
    case priority
}

public enum IssuingCardShippingStatus: String, Codable {
    /// The card is being prepared and has not yet shipped.
    case pending
    /// The card has been shipped. If the card’s shipping carrier does not support tracking, this will be the card’s final status.
    case shipped
    /// The card has been delivered to its destination.
    case delivered
    /// The card failed to be delivered and was returned to the sender.
    case returned
    /// The card failed to be delivered but was not returned.
    case failure
    /// The card was canceled before being shipped.
    case canceled
}

public enum IssuingCardShippingType: String, Codable {
    /// Cards are grouped and mailed together.
    case bulk
    /// Cards are sent individually in an envelope.
    case individual
}

public enum IssuingCardStatus: String, Codable {
    /// The card can approve authorizations. If the card is linked to a cardholder with past-due requirements, you may be unable to change the card’s status to ‘active’.
    case active
    /// The card will decline authorizations with the `card_inactive` reason.
    case inactive
    /// The card will decline authorization, and no authorization object will be recorded. This status is permanent.
    case canceled
}

public enum IssuingCardType: String, Codable {
    /// No physical card will be printed. The card can be used online and can be added to digital wallets.
    case virtual
    /// A physical card will be printed and shipped. It can be used at physical terminals.
    case physical
}

public enum IssuingCardCancellationReason: String, Codable {
    /// The card was lost.
    case lost
    /// The card was stolen.
    case stolen
    /// The design of this card was rejected by Stripe for violating our partner guidelines.
    case designRejected = "design_rejected"
}

public struct IssuingCardWallets: Codable {
    /// Apple Pay Details
    public var applePay: IssuingCardWalletsApplePay?
    /// Google Pay Details
    public var googlePay: IssuingCardWalletsGooglePay?
    /// Unique identifier for a card used with digital wallets
    public var primaryAccountIdentifier: String?
    
    public init(applePay: IssuingCardWalletsApplePay? = nil,
                googlePay: IssuingCardWalletsGooglePay? = nil,
                primaryAccountIdentifier: String? = nil) {
        self.applePay = applePay
        self.googlePay = googlePay
        self.primaryAccountIdentifier = primaryAccountIdentifier
    }
}

public struct IssuingCardWalletsApplePay: Codable {
    /// Apple Pay Eligibility
    public var eligible: Bool?
    /// Reason the card is ineligible for Apple Pay
    public var ineligibleReason: IssuingCardWalletsApplePayIneligibleReason?
    
    public init(eligible: Bool? = nil,
                ineligibleReason: IssuingCardWalletsApplePayIneligibleReason? = nil) {
        self.eligible = eligible
        self.ineligibleReason = ineligibleReason
    }
}

public enum IssuingCardWalletsApplePayIneligibleReason: String, Codable {
    /// Apple Pay is not supported in the cardholder’s country.
    case unsupportedReason = "unsupported_reason"
    /// Apple Pay is not enabled for your account.
    case missingAgreement = "missing_agreement"
    /// Cardholder phone number or email required.
    case missingCardholderContact = "missing_cardholder_contact"
}

public struct IssuingCardWalletsGooglePay: Codable {
    /// Google Pay Eligibility
    public var eligible: Bool?
    /// Reason the card is ineligible for Google Pay
    public var ineligibleReason: IssuingCardWalletsGooglePayIneligibleReason?
    
    public init(eligible: Bool? = nil,
                ineligibleReason: IssuingCardWalletsGooglePayIneligibleReason? = nil) {
        self.eligible = eligible
        self.ineligibleReason = ineligibleReason
    }
}

public enum IssuingCardWalletsGooglePayIneligibleReason: String, Codable {
    /// Google Pay is not supported in the cardholder’s country.
    case unsupportedReason = "unsupported_reason"
    /// Google Pay is not enabled for your account.
    case missingAgreement = "missing_agreement"
    /// Cardholder phone number or email required.
    case missingCardholderContact = "missing_cardholder_contact"
}
