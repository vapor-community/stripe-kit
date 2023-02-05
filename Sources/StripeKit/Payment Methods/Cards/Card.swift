//
//  Card.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

/// The [Card Object](https://stripe.com/docs/api/external_account_cards/object).
public struct StripeCard: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The account this card belongs to. This attribute will not be in the card object if the card belongs to a customer or recipient instead.
    @Expandable<StripeConnectAccount> public var account: String?
    /// City/District/Suburb/Town/Village.
    public var addressCity: String?
    /// Billing address country, if provided when creating card.
    public var addressCountry: String?
    /// Address line 1 (Street address/PO Box/Company name).
    public var addressLine1: String?
    /// If `address_line1` was provided, results of the check: `pass`, `fail`, `unavailable`, or `unchecked`.
    public var addressLine1Check: CardValidationCheck?
    /// Address line 2 (Apartment/Suite/Unit/Building).
    public var addressLine2: String?
    /// State/County/Province/Region.
    public var addressState: String?
    /// ZIP or postal code.
    public var addressZip: String?
    /// If `address_zip` was provided, results of the check: `pass`, `fail`, `unavailable`, or `unchecked`.
    public var addressZipCheck: CardValidationCheck?
    /// A set of available payout methods for this card. Will be either `["standard"]` or `["standard", "instant"]`. Only values from this set should be passed as the `method` when creating a transfer.
    public var availablePayoutMethods: [String]?
    /// Card brand. Can be `American Express`, `Diners Club`, `Discover`, `JCB`, `MasterCard`, `UnionPay`, `Visa`, or `Unknown`.
    public var brand: StripeCardBrand?
    /// Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you’ve collected.
    public var country: String?
    /// Three-letter ISO code for currency. Only applicable on accounts (not customers or recipients). The card can be used as a transfer destination for funds in this currency.
    public var currency: Currency?
    /// The customer that this card belongs to. This attribute will not be in the card object if the card belongs to an account or recipient instead.
    @Expandable<Customer> public var customer: String?
    /// If a CVC was provided, results of the check: `pass`, `fail`, `unavailable`, or `unchecked`.
    public var cvcCheck: CardValidationCheck?
    /// Whether this card is the default external account for its currency.
    public var defaultForCurrency: Bool?
    /// (For tokenized numbers only.) The last four digits of the device account number.
    public var dynamicLast4: String?
    /// Two-digit number representing the card’s expiration month.
    public var expMonth: Int?
    /// Four-digit number representing the card’s expiration year.
    public var expYear: Int?
    /// Uniquely identifies this particular card number. You can use this attribute to check whether two customers who’ve signed up with you are using the same card number, for example.
    public var fingerprint: String?
    /// Card funding type. Can be `credit`, `debit`, `prepaid`, or `unknown`.
    public var funding: CardFundingType?
    /// The last four digits of the card.
    public var last4: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Cardholder name.
    public var name: String?
    /// The recipient that this card belongs to. This attribute will not be in the card object if the card belongs to a customer or account instead.
    public var recipient: String?
    /// If the card number is tokenized, this is the method that was used. Can be `android_pay` (includes Google Pay), `apple_pay`, `masterpass`, `visa_checkout`, or null.
    public var tokenizationMethod: StripeCardTokenizedMethod?
}

public struct StripeCardList: Codable {
    /// String representing the object’s type. Objects of the same type share the same value. Always has the value list.
    public var object: String
    /// An array of `StripeCard`s associated with the account.
    public var data: [StripeCard]?
    /// True if this list has another page of items after this one that can be fetched.
    public var hasMore: Bool?
    /// The URL where this list can be accessed.
    public var url: String?
}

public enum CardValidationCheck: String, Codable {
    case pass
    case fail
    case unavailable
    case unchecked
}

public enum StripeCardBrand: String, Codable {
    case americanExpress = "American Express"
    case dinersClub = "Diners Club"
    case discover = "Discover"
    case jcb = "JCB"
    case masterCard = "MasterCard"
    case unionPay = "UnionPay"
    case visa = "Visa"
    case unknown = "Unknown"
}

public enum CardFundingType: String, Codable {
    case credit
    case debit
    case prepaid
    case unknown
}

public enum StripeCardTokenizedMethod: String, Codable {
    case androidPay = "android_pay"
    case applePay = "apple_pay"
    case masterpass
    case visaCheckout = "visa_checkout"
}
