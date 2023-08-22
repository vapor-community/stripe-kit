//
//  Card.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

/// You can store multiple cards on a customer in order to charge the customer later. You can also store multiple debit cards on a recipient in order to transfer to those cards later.
public struct Card: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// City/District/Suburb/Town/Village.
    public var addressCity: String?
    /// Billing address country, if provided when creating card.
    public var addressCountry: String?
    /// Address line 1 (Street address/PO Box/Company name).
    public var addressLine1: String?
    /// Address line 2 (Apartment/Suite/Unit/Building).
    public var addressLine2: String?
    /// State/County/Province/Region.
    public var addressState: String?
    /// ZIP or postal code.
    public var addressZip: String?
    /// If `address_zip` was provided, results of the check: `pass`, `fail`, `unavailable`, or `unchecked`.
    public var addressZipCheck: CardValidationCheck?
    /// Card brand. Can be `American Express`, `Diners Club`, `Discover`, `JCB`, `MasterCard`, `UnionPay`, `Visa`, or `Unknown`.
    public var brand: CardBrand?
    /// Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you’ve collected.
    public var country: String?
    /// The customer that this card belongs to. This attribute will not be in the card object if the card belongs to an account or recipient instead.
    @Expandable<Customer> public var customer: String?
    /// If a CVC was provided, results of the check: `pass`, `fail`, `unavailable`, or `unchecked`.
    public var cvcCheck: CardValidationCheck?
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
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The account this card belongs to. This attribute will not be in the card object if the card belongs to a customer or recipient instead.
    @Expandable<ConnectAccount> public var account: String?
    /// If `address_line1` was provided, results of the check: `pass`, `fail`, `unavailable`, or `unchecked`.
    public var addressLine1Check: CardValidationCheck?
    /// A set of available payout methods for this card. Only values from this set should be passed as the method when creating a payout.
    public var availablePayoutMethods: [String]?
    /// Three-letter ISO code for currency. Only applicable on accounts (not customers or recipients). The card can be used as a transfer destination for funds in this currency.
    public var currency: Currency?
    /// (For tokenized numbers only.) The last four digits of the device account number.
    public var dynamicLast4: String?
    /// If the card number is tokenized, this is the method that was used. Can be `android_pay` (includes Google Pay), `apple_pay`, `masterpass`, `visa_checkout`, or null.
    public var tokenizationMethod: CardTokenizedMethod?
    /// If this Card is part of a card wallet, this contains the details of the card wallet.
    public var wallet: CardWallet?
    
    public init(id: String,
                addressCity: String? = nil,
                addressCountry: String? = nil,
                addressLine1: String? = nil,
                addressLine2: String? = nil,
                addressState: String? = nil,
                addressZip: String? = nil,
                addressZipCheck: CardValidationCheck? = nil,
                brand: CardBrand? = nil,
                country: String? = nil,
                customer: String? = nil,
                cvcCheck: CardValidationCheck? = nil,
                expMonth: Int? = nil,
                expYear: Int? = nil,
                fingerprint: String? = nil,
                funding: CardFundingType? = nil,
                last4: String? = nil,
                metadata: [String : String]? = nil,
                name: String? = nil,
                object: String,
                account: String? = nil,
                addressLine1Check: CardValidationCheck? = nil,
                availablePayoutMethods: [String]? = nil,
                currency: Currency? = nil,
                dynamicLast4: String? = nil,
                tokenizationMethod: CardTokenizedMethod? = nil,
                wallet: CardWallet? = nil) {
        self.id = id
        self.addressCity = addressCity
        self.addressCountry = addressCountry
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.addressState = addressState
        self.addressZip = addressZip
        self.addressZipCheck = addressZipCheck
        self.brand = brand
        self.country = country
        self._customer = Expandable(id: customer)
        self.cvcCheck = cvcCheck
        self.expMonth = expMonth
        self.expYear = expYear
        self.fingerprint = fingerprint
        self.funding = funding
        self.last4 = last4
        self.metadata = metadata
        self.name = name
        self.object = object
        self._account = Expandable(id: account)
        self.addressLine1Check = addressLine1Check
        self.availablePayoutMethods = availablePayoutMethods
        self.currency = currency
        self.dynamicLast4 = dynamicLast4
        self.tokenizationMethod = tokenizationMethod
        self.wallet = wallet
    }
}

public enum CardValidationCheck: String, Codable {
    case pass
    case fail
    case unavailable
    case unchecked
}

public enum CardBrand: String, Codable {
    case americanExpress = "American Express"
    case dinersClub = "Diners Club"
    case discover = "Discover"
    case eftpos = "Eftpos"
    case australia = "Australia"
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

public enum CardTokenizedMethod: String, Codable {
    case androidPay = "android_pay"
    case applePay = "apple_pay"
    case masterpass
    case visaCheckout = "visa_checkout"
}

public struct CardWallet: Codable {
    /// If this is an `apple_pay` card wallet, this hash contains details about the wallet.
    public var applePay: CardWalletApplePay?
    /// The type of the card wallet, one of `apple_pay`. An additional hash is included on the Wallet subhash with a name matching this value. It contains additional information specific to the card wallet type.
    public var type: String?
    
    public init(applePay: CardWalletApplePay? = nil, type: String? = nil) {
        self.applePay = applePay
        self.type = type
    }
}

public struct CardWalletApplePay: Codable {
    public var type: String?
    
    public init(type: String? = nil) {
        self.type = type
    }
}

public struct CardList: Codable {
    /// String representing the object’s type. Objects of the same type share the same value. Always has the value list.
    public var object: String
    /// An array of `Card`s associated with the account.
    public var data: [Card]?
    /// True if this list has another page of items after this one that can be fetched.
    public var hasMore: Bool?
    /// The URL where this list can be accessed.
    public var url: String?
    
    init(object: String,
         data: [Card]? = nil,
         hasMore: Bool? = nil,
         url: String? = nil) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}


