//
//  PaymentMethod.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/15/19.
//

import Foundation

/// The [PaymentMethod Object](https://stripe.com/docs/api/payment_methods/object).
public struct StripePaymentMethod: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// If this is an `acss_debit` PaymentMethod, this hash contains details about the ACSS Debit payment method.
    public var acssDebit: StripePaymentMethodAcssDebit?
    /// If this is an AfterpayClearpay PaymentMethod, this hash contains details about the AfterpayClearpay payment method.
    public var afterpayClearpay: StripePaymentMethodAfterpayClearpay?
    /// If this is an Alipay PaymentMethod, this hash contains details about the Alipay payment method.
    public var alipay: StripePaymentMethodAlipay?
    /// If this is an `au_becs_debit` PaymentMethod, this hash contains details about the bank account.
    public var auBecsDebit: StripePaymentMethodAuBecsDebit?
    /// If this is a `bacs_debit` PaymentMethod, this hash contains details about the Bacs Direct Debit bank account.
    public var bacsDebit: StripePaymentMethodBacsDebit?
    /// If this is a `bancontact` PaymentMethod, this hash contains details about the Bancontact payment method.
    public var bancontact: StripePaymentMethodBancontact?
    /// If this is a `boleto` PaymentMethod, this hash contains details about the Boleto payment method.
    public var boleto: StripePaymentMethodBoleto?
    /// Billing information associated with the PaymentMethod that may be used or required by particular types of payment methods.
    public var billingDetails: StripeBillingDetails?
    /// If this is a `card` PaymentMethod, this hash contains details about the card.
    public var card: StripePaymentMethodCard?
    /// If this is an `card_present` PaymentMethod, this hash contains details about the Card Present payment method.
    public var cardPresent: StripePaymentMethodCardPresent?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The ID of the Customer to which this PaymentMethod is saved. This will not be set when the PaymentMethod has not been saved to a Customer.
    @Expandable<Customer> public var customer: String?
    /// If this is an `eps` PaymentMethod, this hash contains details about the EPS payment method.
    public var eps: StripePaymentMethodEps?
    /// If this is an `fpx` PaymentMethod, this hash contains details about the FPX payment method.
    public var fpx: StripePaymentMethodFpx?
    /// If this is an `giropay` PaymentMethod, this hash contains details about the Giropay payment method.
    public var giropay: StripePaymentMethodGiropay?
    /// If this is a `grabpay` PaymentMethod, this hash contains details about the GrabPay payment method.
    public var grabpay: StripePaymentMethodGrabpay?
    /// If this is an `ideal` PaymentMethod, this hash contains details about the iDEAL payment method.
    public var ideal: StripePaymentMethodIdeal?
    /// If this is a klarna PaymentMethod, this hash contains details about the Klarna payment method.
    public var klarna: StripePaymentMethodKlarna?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// If this is an oxxo PaymentMethod, this hash contains details about the OXXO payment method.
    public var oxxo: StripePaymentMethodOXXO?
    /// If this is a `p24` PaymentMethod, this hash contains details about the P24 payment method.
    public var p24: StripePaymentMethodP24?
    /// If this is a `sepa_debit` PaymentMethod, this hash contains details about the SEPA debit bank account.
    public var sepaDebit: StripePaymentMethodSepaDebit?
    /// If this is a sofort PaymentMethod, this hash contains details about the SOFORT payment method.
    public var sofort: StripePaymentMethodSofort?
    /// If this is an `wechat_pay` PaymentMethod, this hash contains details about the `wechat_pay` payment method.
    public var wechatPay: StripePaymentMethodWechatPay?
    /// The type of the PaymentMethod. An additional hash is included on the PaymentMethod with a name matching this value. It contains additional information specific to the PaymentMethod type.
    public var type: StripePaymentMethodType?
}

public enum StripePaymentMethodType: String, Codable {
    case acssDebit = "acss_debit"
    case affirm
    case afterpayClearpay = "afterpay_clearpay"
    case alipay
    case auBecsDebit = "au_becs_debit"
    case bacsDebit = "bacs_debit"
    case bancontact
    case boleto
    case card
    case cardPresent = "card_present"
    case customerBalance = "customer_balance"
    case eps
    case fpx
    case giropay
    case grabpay
    case ideal
    case interactPresent = "interact_present"
    case klarna
    case konbini
    case link
    case oxxo
    case p24
    case paynow
    case sepaDebit = "sepa_debit"
    case sofort
    case usBankAccount = "us_bank_account"
    case wechatPay = "wechat_pay"
}

public struct StripePaymentMethodAcssDebit: Codable {
    /// Name of the bank associated with the bank account.
    public var bankName: String?
    /// Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    public var fingerprint: String?
    /// Institution number of the bank account.
    public var institutionNumber: String?
    /// Last four digits of the bank account number.
    public var last4: String?
    /// Transit number of the bank account.
    public var transitNumber: String?
}

public struct StripePaymentMethodAfterpayClearpay: Codable {
    // https://stripe.com/docs/api/payment_methods/object#payment_method_object-afterpay_clearpay
}

public struct StripePaymentMethodAlipay: Codable {
    // https://stripe.com/docs/api/payment_methods/object#payment_method_object-alipay
}

public struct StripePaymentMethodAuBecsDebit: Codable {
    /// Six-digit number identifying bank and branch associated with this bank account.
    public var bsbNumber: String?
    /// Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    public var fingerprint: String?
    /// Last four digits of the bank account number
    public var last4: String?
}

public struct StripePaymentMethodBacsDebit: Codable {
    /// Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    public var fingerprint: String?
    /// Last four digits of the bank account number
    public var last4: String?
    /// Sort code of the bank account. (e.g., `10-20-30`)
    public var sortCode: String?
}

public struct StripePaymentMethodBancontact: Codable {
    // https://stripe.com/docs/api/payment_methods/object#payment_method_object-bancontact
}

public struct StripePaymentMethodBoleto: Codable {
    /// Uniquely identifies this customer tax_id (CNPJ or CPF)
    public var taxId: String?
}

public struct StripePaymentMethodCard: Codable {
    /// Card brand. Can be `amex`, `diners`, `discover`, `jcb`, `mastercard`, `unionpay`, `visa`, or `unknown`.
    public var brand: PaymentMethodDetailsCardBrand?
    /// Checks on Card address and CVC if provided.
    public var checks: PaymentMethodDetailsCardChecks?
    /// Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you’ve collected.
    public var country: String?
    /// Two-digit number representing the card’s expiration month.
    public var expMonth: Int?
    /// Four-digit number representing the card’s expiration year.
    public var expYear: Int?
    /// Uniquely identifies this particular card number. You can use this attribute to check whether two customers who’ve signed up with you are using the same card number, for example.
    public var fingerprint: String?
    /// Card funding type. Can be `credit`, `debit`, `prepaid`, or `unknown`.
    public var funding: CardFundingType?
    /// Details of the original PaymentMethod that created this object.
    public var generatedFrom: StripePaymentMethodCardGeneratedFrom?
    /// The last four digits of the card.
    public var last4: String?
    /// Contains information about card networks that can be used to process the payment.
    public var networks: StripePaymentMethodCardNetworks?
    /// Contains details on how this Card maybe be used for 3D Secure authentication.
    public var threeDSecureUsage: StripePaymentMethodCardThreeDSecureUsage?
    /// If this Card is part of a card wallet, this contains the details of the card wallet.
    public var wallet: StripePaymentMethodCardWallet?
}

public enum PaymentMethodDetailsCardBrand: String, Codable {
    case amex
    case diners
    case discover
    case jcb
    case mastercard
    case unionpay
    case visa
    case unknown
}

public enum PaymentMethodCardNetwork: String, Codable {
    case amex
    case cartesBancaires = "cartes_bancaires"
    case diners
    case discover
    case interac
    case jcb
    case mastercard
    case unionpay
    case visa
    case unknown
}

public struct PaymentMethodDetailsCardChecks: Codable {
    /// If a address line1 was provided, results of the check, one of ‘pass’, ‘failed’, ‘unavailable’ or ‘unchecked’.
    public var addressLine1Check: CardValidationCheck?
    /// If a address postal code was provided, results of the check, one of ‘pass’, ‘failed’, ‘unavailable’ or ‘unchecked’.
    public var addressPostalCodeCheck: CardValidationCheck?
    /// If a CVC was provided, results of the check, one of ‘pass’, ‘failed’, ‘unavailable’ or ‘unchecked’.
    public var cvcCheck: CardValidationCheck?
    
    public init(addressLine1Check: CardValidationCheck? = nil,
                addressPostalCodeCheck: CardValidationCheck? = nil,
                cvcCheck: CardValidationCheck? = nil) {
        self.addressLine1Check = addressLine1Check
        self.addressPostalCodeCheck = addressPostalCodeCheck
        self.cvcCheck = cvcCheck
    }
}

public struct StripePaymentMethodCardGeneratedFrom: Codable {
    /// The charge that created this object.
    public var charge: String?
    /// Transaction-specific details of the payment method used in the payment.
    public var paymentMethodDetails: ChargePaymentMethodDetails?
}

public struct StripePaymentMethodCardNetworks: Codable {
    /// All available networks for the card.
    public var available: [String]?
    /// The preferred network for the card.
    public var preferred: String?
}

public struct StripePaymentMethodCardThreeDSecureUsage: Codable {
    /// Whether 3D Secure is supported on this card.
    public var supported: Bool?
}

public struct StripePaymentMethodCardWallet: Codable {
    /// If this is a `amex_express_checkout` card wallet, this hash contains details about the wallet.
    /// Stripe does not [provide any details](https://stripe.com/docs/api/payment_methods/object#payment_method_object-card-wallet-amex_express_checkout) about possible values so this will remain nil/unimplemented.
    public var amexExpressCheckout: StripePaymentMethodAmexExpressCheckout? = nil
    /// If this is a `apple_pay` card wallet, this hash contains details about the wallet.
    /// Stripe does not [provide any details](https://stripe.com/docs/api/payment_methods/object#payment_method_object-card-wallet-apple_pay) about possible values so this will remain nil/unimplemented.
    public var applePay: StripePaymentMethodApplePay? = nil
    /// (For tokenized numbers only.) The last four digits of the device account number.
    public var dynamicLast4: String?
    /// If this is a `google_pay` card wallet, this hash contains details about the wallet.
    /// Stripe does not [provide any details](https://stripe.com/docs/api/payment_methods/object#payment_method_object-card-wallet-google_pay) about possible values so this will remain nil/unimplemented.
    public var googlePay: StripePaymentMethodGooglePay? = nil
    /// If this is a `masterpass` card wallet, this hash contains details about the wallet.
    public var masterpass: StripePaymentMethodCardWalletMasterPass?
    /// If this is a `samsung_pay` card wallet, this hash contains details about the wallet.
    /// Stripe does not [provide any details](https://stripe.com/docs/api/payment_methods/object#payment_method_object-card-wallet-samsung_pay) about possible values so this will remain nil/unimplemented.
    public var samsungPay: StripePaymentMethodSamsungPay? = nil
    /// The type of the card wallet, one of `amex_express_checkout`, `apple_pay`, `google_pay`, `masterpass`, `samsung_pay`, or `visa_checkout`. An additional hash is included on the Wallet subhash with a name matching this value. It contains additional information specific to the card wallet type.
    public var type: PaymentMethodDetailsCardWalletType?
    /// If this is a `visa_checkout` card wallet, this hash contains details about the wallet.
    public var visaCheckout: StripePaymentMethodCardWalletVisaCheckout?
}

public struct StripePaymentMethodCardWalletMasterPass: Codable {
    /// Owner’s verified billing address. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var billingAddress: Address?
    /// Owner’s verified email. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var email: String?
    /// Owner’s verified full name. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var name: String?
    /// Owner’s verified shipping address. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var shippingAddress: Address?
}

public enum PaymentMethodDetailsCardWalletType: String, Codable {
    case amexExpressCheckout = "amex_express_checkout"
    case applePay = "apple_pay"
    case googlePay = "google_pay"
    case masterpass
    case samsungPay = "samsung_pay"
    case visaCheckout = "visa_checkout"
}

public struct StripePaymentMethodCardWalletVisaCheckout: Codable {
    /// Owner’s verified billing address. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var billingAddress: Address?
    /// Owner’s verified email. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var email: String?
    /// Owner’s verified full name. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var name: String?
    /// Owner’s verified shipping address. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var shippingAddress: Address?
}

public struct StripePaymentMethodCardPresent: Codable {
    // https://stripe.com/docs/api/payment_methods/object#payment_method_object-card_present
}

public struct StripePaymentMethodEps: Codable {
    // https://stripe.com/docs/api/payment_methods/object#payment_method_object-eps
}
    
public struct StripePaymentMethodFpx: Codable {
    // https://stripe.com/docs/api/payment_methods/object#payment_method_object-fpx
}
    
public struct StripePaymentMethodGiropay: Codable {
    // https://stripe.com/docs/api/payment_methods/object#payment_method_object-giropay
}

public struct StripePaymentMethodGrabpay: Codable {
    // https://stripe.com/docs/api/payment_methods/object#payment_method_object-grabpay
}

public struct StripePaymentMethodIdeal: Codable {
    /// The customer’s bank, if provided. Can be one of `abn_amro`, `asn_bank`, `bunq`, `handelsbanken`, `ing`, `knab`, `moneyou`, `rabobank`, `regiobank`, `sns_bank`, `triodos_bank`, or `van_lanschot`.
    public var bank: StripePaymentMethodIdealBank?
    /// The Bank Identifier Code of the customer’s bank, if the bank was provided.
    public var bic: String?
}

public enum StripePaymentMethodIdealBank: String, Codable {
    case abnAmro = "abn_amro"
    case asnBank = "asn_bank"
    case bunq
    case handelsbanken
    case ing
    case knab
    case moneyou
    case rabobank
    case regiobank
    case snsBank = "sns_bank"
    case triodosBank = "triodos_bank"
    case vanLanschot = "van_lanschot"
}

public struct StripePaymentMethodKlarna: Codable {
    /// The customer’s date of birth, if provided.
    /// This field is not included by default. To include it in the response, expand the dob field.
    public var dob: StripePersonDOB?
}

public struct StripePaymentMethodOXXO: Codable {
    // https://stripe.com/docs/api/payment_methods/object#payment_method_object-oxxo
}

public struct StripePaymentMethodP24: Codable {
    // https://stripe.com/docs/api/payment_methods/object#payment_method_object-p24
}

public struct StripePaymentMethodAmexExpressCheckout: Codable {
    // https://stripe.com/docs/api/payment_methods/object#payment_method_object-card-wallet-amex_express_checkout
}

public struct StripePaymentMethodApplePay: Codable {
    // https://stripe.com/docs/api/payment_methods/object#payment_method_object-card-wallet-apple_pay
}

public struct StripePaymentMethodGooglePay: Codable {
    // https://stripe.com/docs/api/payment_methods/object#payment_method_object-card-wallet-google_pay
}

public struct StripePaymentMethodSamsungPay: Codable {
    // https://stripe.com/docs/api/payment_methods/object#payment_method_object-card-wallet-samsung_pay
}

public struct StripePaymentMethodSofort: Codable {
    /// Two-letter ISO code representing the country the bank account is located in.
    public var country: String?
}
    
public struct StripePaymentMethodSepaDebit: Codable {
    /// Bank code of bank associated with the bank account.
    public var bankCode: String?
    /// Branch code of bank associated with the bank account.
    public var branchCode: String?
    /// Two-letter ISO code representing the country the bank account is located in.
    public var country: String?
    /// Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    public var fingerprint: String?
    /// Last four characters of the IBAN.
    public var last4: String?
}

public struct StripePaymentMethodWechatPay: Codable {
    // https://stripe.com/docs/api/payment_methods/object#payment_method_object-wechat_pay
}

public struct StripePaymentMethodList: Codable {
    public var object: String
    public var data: [StripePaymentMethod]?
    public var hasMore: Bool?
    public var url: String?
}
