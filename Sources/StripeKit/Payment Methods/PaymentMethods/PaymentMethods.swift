//
//  PaymentMethods.swift
//  
//
//  Created by Andrew Edwards on 4/29/23.
//

import Foundation

// MARK: ACSS Debit
public struct PaymentMethodAcssDebit: Codable {
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
    
    public init(bankName: String? = nil,
                fingerprint: String? = nil,
                institutionNumber: String? = nil,
                last4: String? = nil,
                transitNumber: String? = nil) {
        self.bankName = bankName
        self.fingerprint = fingerprint
        self.institutionNumber = institutionNumber
        self.last4 = last4
        self.transitNumber = transitNumber
    }
}

// MARK: Affirm
public struct PaymentMethodAffirm: Codable {
    public init(){}
}

// MARK: Afterpay Clearpay
public struct PaymentMethodAfterpayClearpay: Codable {
    public init(){}
}

// MARK: Alipay
public struct PaymentMethodAlipay: Codable {
    public init(){}
}

// MARK: AU Becs Debit
public struct PaymentMethodAuBecsDebit: Codable {
    /// Six-digit number identifying bank and branch associated with this bank account.
    public var bsbNumber: String?
    /// Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    public var fingerprint: String?
    /// Last four digits of the bank account number
    public var last4: String?
    
    public init(bsbNumber: String? = nil,
                fingerprint: String? = nil,
                last4: String? = nil) {
        self.bsbNumber = bsbNumber
        self.fingerprint = fingerprint
        self.last4 = last4
    }
}

// MARK: Bacs Debit
public struct PaymentMethodBacsDebit: Codable {
    /// Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    public var fingerprint: String?
    /// Last four digits of the bank account number
    public var last4: String?
    /// Sort code of the bank account. (e.g., `10-20-30`)
    public var sortCode: String?
    
    public init(fingerprint: String? = nil,
                last4: String? = nil,
                sortCode: String? = nil) {
        self.fingerprint = fingerprint
        self.last4 = last4
        self.sortCode = sortCode
    }
}

// MARK: Bancontact
public struct PaymentMethodBancontact: Codable {
    public init(){}
}

// MARK: Blik
public struct PaymentMethodBlik: Codable {
    public init(){}
}

// MARK: Boleto
public struct PaymentMethodBoleto: Codable {
    public var fingerprint: String?
    /// Uniquely identifies this customer tax_id (CNPJ or CPF)
    public var taxId: String?
    
    public init(fingerprint: String? = nil,
                taxId: String? = nil) {
        self.fingerprint = fingerprint
        self.taxId = taxId
    }
}

// MARK: Card
public struct PaymentMethodCard: Codable {
    /// Card brand. Can be `amex`, `diners`, `discover`, `eftpos_au`, `jcb`, `mastercard`, `unionpay`, `visa`, or `unknown`.
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
    public var generatedFrom: PaymentMethodCardGeneratedFrom?
    /// The last four digits of the card.
    public var last4: String?
    /// Contains information about card networks that can be used to process the payment.
    public var networks: PaymentMethodCardNetworks?
    /// Contains details on how this Card maybe be used for 3D Secure authentication.
    public var threeDSecureUsage: PaymentMethodCardThreeDSecureUsage?
    /// If this Card is part of a card wallet, this contains the details of the card wallet.
    public var wallet: PaymentMethodCardWallet?
    /// The issuer identification number for the card. This is the first six digits of a card number.
    public var iin: String?
    
    public init(brand: PaymentMethodDetailsCardBrand? = nil,
                checks: PaymentMethodDetailsCardChecks? = nil,
                country: String? = nil,
                expMonth: Int? = nil,
                expYear: Int? = nil,
                fingerprint: String? = nil,
                funding: CardFundingType? = nil,
                generatedFrom: PaymentMethodCardGeneratedFrom? = nil,
                last4: String? = nil,
                networks: PaymentMethodCardNetworks? = nil,
                threeDSecureUsage: PaymentMethodCardThreeDSecureUsage? = nil,
                wallet: PaymentMethodCardWallet? = nil,
                iin: String? = nil) {
        self.brand = brand
        self.checks = checks
        self.country = country
        self.expMonth = expMonth
        self.expYear = expYear
        self.fingerprint = fingerprint
        self.funding = funding
        self.generatedFrom = generatedFrom
        self.last4 = last4
        self.networks = networks
        self.threeDSecureUsage = threeDSecureUsage
        self.wallet = wallet
        self.iin = iin
    }
}

public enum PaymentMethodDetailsCardBrand: String, Codable {
    case amex
    case diners
    case discover
    case eftposAu = "eftpos_au"
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
    case eftposAu = "eftpos_au"
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

public struct PaymentMethodCardGeneratedFrom: Codable {
    /// The charge that created this object.
    public var charge: String?
    /// Transaction-specific details of the payment method used in the payment.
    public var paymentMethodDetails: PaymentMethodCardGeneratedFromPaymentMethodDetails?
    /// The ID of the SetupAttempt that generated this PaymentMethod, if any.
    @Expandable<SetupAttempt> public var setupAttempt: String?
    
    public init(charge: String? = nil,
                paymentMethodDetails: PaymentMethodCardGeneratedFromPaymentMethodDetails? = nil,
                setupAttempt: String? = nil) {
        self.charge = charge
        self.paymentMethodDetails = paymentMethodDetails
        self._setupAttempt = Expandable(id: setupAttempt)
    }
}

public struct PaymentMethodCardGeneratedFromPaymentMethodDetails: Codable {
    /// This hash contains the snapshot of the `card_present` transaction-specific details which generated this card payment method.
    public var cardPresent: PaymentMethodCardGeneratedFromPaymentMethodDetailsCardPresent?
    /// The type of payment method transaction-specific details from the transaction that generated this card payment method. Always card_present.
    public var type: String?
    
    public init(cardPresent: PaymentMethodCardGeneratedFromPaymentMethodDetailsCardPresent? = nil,
                type: String? = nil) {
        self.cardPresent = cardPresent
        self.type = type
    }
}

public struct PaymentMethodCardGeneratedFromPaymentMethodDetailsCardPresent: Codable {
    /// The authorized amount
    public var authorizedAmount: Int?
    /// Card brand. Can be `amex`, `diners`, `discover`, `jcb`, `mastercard`, `unionpay`, `visa`, or `unknown`.
    public var brand: PaymentMethodDetailsCardBrand?
    /// When using manual capture, a future timestamp after which the charge will be automatically refunded if uncaptured.
    public var captureBefore: Date?
    /// The cardholder name as read from the card, in ISO 7813 format. May include alphanumeric characters, special characters and first/last name separator (/). In some cases, the cardholder name may not be available depending on how the issuer has configured the card. Cardholder name is typically not available on swipe or contactless payments, such as those made with Apple Pay and Google Pay.
    public var cardholderName: String?
    /// Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you’ve collected.
    public var country: String?
    /// Authorization response cryptogram.
    public var emvAuthData: String?
    /// Two-digit number representing the card’s expiration month.
    public var expMonth: Int?
    /// Four-digit number representing the card’s expiration year.
    public var expYear: Int?
    /// Uniquely identifies this particular card number. You can use this attribute to check whether two customers who’ve signed up with you are using the same card number, for example.
    public var fingerprint: String?
    /// Card funding type. Can be `credit`, `debit`, `prepaid`, or `unknown`.
    public var funding: CardFundingType?
    /// ID of a card PaymentMethod generated from the `card_present` PaymentMethod that may be attached to a Customer for future transactions. Only present if it was possible to generate a card PaymentMethod.
    public var generatedCard: String?
    /// Whether this PaymentIntent is eligible for incremental authorizations.
    public var incrementalAuthorizationSupported: Bool?
    /// The last four digits of the card.
    public var last4: String?
    /// Identifies which network this charge was processed on. Can be `amex`, `diners`, `discover`, `interac`, `jcb`, `mastercard`, `unionpay`, `visa`, or `unknown`.
    public var network: PaymentMethodCardNetwork?
    /// Defines whether the authorized amount can be over-captured or not
    public var overCaptureSupported: Bool?
    /// How were card details read in this transaction. Can be `contact_emv`, `contactless_emv`, `magnetic_stripe_fallback`, `magnetic_stripe_track2`, or `contactless_magstripe_mode`
    public var readMethod: PaymentMethodCardGeneratedFromPaymentMethodDetailsCardPresentReadMethod?
    /// A collection of fields required to be displayed on receipts. Only required for EMV transactions.
    public var receipt: PaymentMethodCardGeneratedFromPaymentMethodDetailsCardPresentReceipt?
    
    public init(authorizedAmount: Int? = nil,
                brand: PaymentMethodDetailsCardBrand? = nil,
                captureBefore: Date? = nil,
                cardholderName: String? = nil,
                country: String? = nil,
                emvAuthData: String? = nil,
                expMonth: Int? = nil,
                expYear: Int? = nil,
                fingerprint: String? = nil,
                funding: CardFundingType? = nil,
                generatedCard: String? = nil,
                incrementalAuthorizationSupported: Bool? = nil,
                last4: String? = nil,
                network: PaymentMethodCardNetwork? = nil,
                overCaptureSupported: Bool? = nil,
                readMethod: PaymentMethodCardGeneratedFromPaymentMethodDetailsCardPresentReadMethod? = nil,
                receipt: PaymentMethodCardGeneratedFromPaymentMethodDetailsCardPresentReceipt? = nil) {
        self.authorizedAmount = authorizedAmount
        self.brand = brand
        self.captureBefore = captureBefore
        self.cardholderName = cardholderName
        self.country = country
        self.emvAuthData = emvAuthData
        self.expMonth = expMonth
        self.expYear = expYear
        self.fingerprint = fingerprint
        self.funding = funding
        self.generatedCard = generatedCard
        self.incrementalAuthorizationSupported = incrementalAuthorizationSupported
        self.last4 = last4
        self.network = network
        self.overCaptureSupported = overCaptureSupported
        self.readMethod = readMethod
        self.receipt = receipt
    }
}

public enum PaymentMethodCardGeneratedFromPaymentMethodDetailsCardPresentReadMethod: String, Codable {
    /// Inserting a chip card into the card reader.
    case contactEmv = "contact_emv"
    /// Tapping a contactless-enabled chip card or mobile wallet.
    case contactlessEmv = "contactless_emv"
    /// Swiping a card using the magnetic stripe reader.
    case magneticStripeTrack2 = "magnetic_stripe_track2"
    /// When inserting a chip card fails three times in a row, fallback to a magnetic stripe read.
    case magneticStripeFallback = "magnetic_stripe_fallback"
    /// Older standard for contactless payments that emulated a magnetic stripe read.
    case contactlessMagstripeMode = "contactless_magstripe_mode"
}

public struct PaymentMethodCardGeneratedFromPaymentMethodDetailsCardPresentReceipt: Codable {
    /// The type of account being debited or credited
    public var accountType: PaymentMethodCardGeneratedFromPaymentMethodDetailsCardPresentReceiptAccountType?
    /// EMV tag 9F26, cryptogram generated by the integrated circuit chip.
    public var applicationCryptogram: String?
    /// Mnenomic of the Application Identifier.
    public var applicationPreferredName: String?
    /// Identifier for this transaction.
    public var authorizationCode: String?
    /// EMV tag 8A. A code returned by the card issuer.
    public var authorizationResponseCode: String?
    /// How the cardholder verified ownership of the card.
    public var cardholderVerificationMethod: String?
    /// EMV tag 84. Similar to the application identifier stored on the integrated circuit chip.
    public var dedicatedFileName: String?
    /// The outcome of a series of EMV functions performed by the card reader.
    public var terminalVerificationResults: String?
    /// An indication of various EMV functions performed during the transaction.
    public var transactionStatusInformation: String?
    
    public init(accountType: PaymentMethodCardGeneratedFromPaymentMethodDetailsCardPresentReceiptAccountType? = nil,
                applicationCryptogram: String? = nil,
                applicationPreferredName: String? = nil,
                authorizationCode: String? = nil,
                authorizationResponseCode: String? = nil,
                cardholderVerificationMethod: String? = nil,
                dedicatedFileName: String? = nil,
                terminalVerificationResults: String? = nil,
                transactionStatusInformation: String? = nil) {
        self.accountType = accountType
        self.applicationCryptogram = applicationCryptogram
        self.applicationPreferredName = applicationPreferredName
        self.authorizationCode = authorizationCode
        self.authorizationResponseCode = authorizationResponseCode
        self.cardholderVerificationMethod = cardholderVerificationMethod
        self.dedicatedFileName = dedicatedFileName
        self.terminalVerificationResults = terminalVerificationResults
        self.transactionStatusInformation = transactionStatusInformation
    }
}

public enum PaymentMethodCardGeneratedFromPaymentMethodDetailsCardPresentReceiptAccountType: String, Codable {
    /// A credit account, as when using a credit card
    case credit
    /// A checking account, as when using a debit card
    case checking
    /// A prepaid account, as when using a debit gift card
    case prepaid
    /// An unknown account
    case unknown
}

public struct PaymentMethodCardNetworks: Codable {
    /// All available networks for the card.
    public var available: [String]?
    /// The preferred network for the card.
    public var preferred: String?
    
    public init(available: [String]? = nil, preferred: String? = nil) {
        self.available = available
        self.preferred = preferred
    }
}

public struct PaymentMethodCardThreeDSecureUsage: Codable {
    /// Whether 3D Secure is supported on this card.
    public var supported: Bool?
    
    public init(supported: Bool? = nil) {
        self.supported = supported
    }
}

public struct PaymentMethodCardWallet: Codable {
    /// If this is a `amex_express_checkout` card wallet, this hash contains details about the wallet.
    /// Stripe does not [provide any details](https://stripe.com/docs/api/payment_methods/object#payment_method_object-card-wallet-amex_express_checkout) about possible values so this will remain nil/unimplemented.
    public var amexExpressCheckout: PaymentMethodCardWalletAmexExpressCheckout?
    /// If this is a `apple_pay` card wallet, this hash contains details about the wallet.
    /// Stripe does not [provide any details](https://stripe.com/docs/api/payment_methods/object#payment_method_object-card-wallet-apple_pay) about possible values so this will remain nil/unimplemented.
    public var applePay: PaymentMethodCardWalletApplePay?
    /// (For tokenized numbers only.) The last four digits of the device account number.
    public var dynamicLast4: String?
    /// If this is a `google_pay` card wallet, this hash contains details about the wallet.
    /// Stripe does not [provide any details](https://stripe.com/docs/api/payment_methods/object#payment_method_object-card-wallet-google_pay) about possible values so this will remain nil/unimplemented.
    public var googlePay: PaymentMethodCardWalletGooglePay?
    /// If this is a `masterpass` card wallet, this hash contains details about the wallet.
    public var masterpass: PaymentMethodCardWalletMasterPass?
    /// If this is a `samsung_pay` card wallet, this hash contains details about the wallet.
    /// Stripe does not [provide any details](https://stripe.com/docs/api/payment_methods/object#payment_method_object-card-wallet-samsung_pay) about possible values so this will remain nil/unimplemented.
    public var samsungPay: PaymentMethodCardWalletSamsungPay?
    /// The type of the card wallet, one of `amex_express_checkout`, `apple_pay`, `google_pay`, `masterpass`, `samsung_pay`, or `visa_checkout`. An additional hash is included on the Wallet subhash with a name matching this value. It contains additional information specific to the card wallet type.
    public var type: PaymentMethodDetailsCardWalletType?
    /// If this is a `visa_checkout` card wallet, this hash contains details about the wallet.
    public var visaCheckout: PaymentMethodCardWalletVisaCheckout?
    
    public init(amexExpressCheckout: PaymentMethodCardWalletAmexExpressCheckout? = nil,
                applePay: PaymentMethodCardWalletApplePay? = nil,
                dynamicLast4: String? = nil,
                googlePay: PaymentMethodCardWalletGooglePay? = nil,
                masterpass: PaymentMethodCardWalletMasterPass? = nil,
                samsungPay: PaymentMethodCardWalletSamsungPay? = nil,
                type: PaymentMethodDetailsCardWalletType? = nil,
                visaCheckout: PaymentMethodCardWalletVisaCheckout? = nil) {
        self.amexExpressCheckout = amexExpressCheckout
        self.applePay = applePay
        self.dynamicLast4 = dynamicLast4
        self.googlePay = googlePay
        self.masterpass = masterpass
        self.samsungPay = samsungPay
        self.type = type
        self.visaCheckout = visaCheckout
    }
}

public struct PaymentMethodCardWalletAmexExpressCheckout: Codable {
    public init() {}
}

public struct PaymentMethodCardWalletApplePay: Codable {
    public var type: String?
    
    public init(type: String? = nil) {
        self.type = type
    }
}

public struct PaymentMethodCardWalletGooglePay: Codable {
    public init() {}
}

public struct PaymentMethodCardWalletMasterPass: Codable {
    /// Owner’s verified billing address. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var billingAddress: Address?
    /// Owner’s verified email. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var email: String?
    /// Owner’s verified full name. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var name: String?
    /// Owner’s verified shipping address. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var shippingAddress: Address?
    
    public init(billingAddress: Address? = nil,
                email: String? = nil,
                name: String? = nil,
                shippingAddress: Address? = nil) {
        self.billingAddress = billingAddress
        self.email = email
        self.name = name
        self.shippingAddress = shippingAddress
    }
}

public struct PaymentMethodCardWalletSamsungPay: Codable {
    public init() {}
}

public enum PaymentMethodDetailsCardWalletType: String, Codable {
    case amexExpressCheckout = "amex_express_checkout"
    case applePay = "apple_pay"
    case googlePay = "google_pay"
    case masterpass
    case samsungPay = "samsung_pay"
    case visaCheckout = "visa_checkout"
    case link
}

public struct PaymentMethodCardWalletVisaCheckout: Codable {
    /// Owner’s verified billing address. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var billingAddress: Address?
    /// Owner’s verified email. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var email: String?
    /// Owner’s verified full name. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var name: String?
    /// Owner’s verified shipping address. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var shippingAddress: Address?
    
    public init(billingAddress: Address? = nil,
                email: String? = nil,
                name: String? = nil,
                shippingAddress: Address? = nil) {
        self.billingAddress = billingAddress
        self.email = email
        self.name = name
        self.shippingAddress = shippingAddress
    }
}

// MARK: Card Present
public struct PaymentMethodCardPresent: Codable {
    /// Card brand. Can be `amex`, `diners`, `discover`, `jcb`, `mastercard`, `unionpay`, `visa`, or `unknown`.
    public var brand: PaymentMethodDetailsCardBrand?
    /// The cardholder name as read from the card, in ISO 7813 format. May include alphanumeric characters, special characters and first/last name separator (/). In some cases, the cardholder name may not be available depending on how the issuer has configured the card. Cardholder name is typically not available on swipe or contactless payments, such as those made with Apple Pay and Google Pay.
    public var cardholderName: String?
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
    /// The last four digits of the card.
    public var last4: String?
    /// Identifies which network this charge was processed on. Can be `amex`, `diners`, `discover`, `interac`, `jcb`, `mastercard`, `unionpay`, `visa`, or `unknown`.
    public var networks: PaymentMethodCardNetworks?
    /// How were card details read in this transaction. Can be `contact_emv`, `contactless_emv`, `magnetic_stripe_fallback`, `magnetic_stripe_track2`, or `contactless_magstripe_mode`
    public var readMethod: PaymentMethodCardPresentReadMethod?
    
    public init(brand: PaymentMethodDetailsCardBrand? = nil,
                cardholderName: String? = nil,
                country: String? = nil,
                expMonth: Int? = nil,
                expYear: Int? = nil,
                fingerprint: String? = nil,
                funding: CardFundingType? = nil,
                last4: String? = nil,
                networks: PaymentMethodCardNetworks? = nil,
                readMethod: PaymentMethodCardPresentReadMethod? = nil) {
        self.brand = brand
        self.cardholderName = cardholderName
        self.country = country
        self.expMonth = expMonth
        self.expYear = expYear
        self.fingerprint = fingerprint
        self.funding = funding
        self.last4 = last4
        self.networks = networks
        self.readMethod = readMethod
    }
}

public enum PaymentMethodCardPresentReadMethod: String, Codable {
    /// Inserting a chip card into the card reader.
    case contactEmv = "contact_emv"
    /// Tapping a contactless-enabled chip card or mobile wallet.
    case contactlessEmv = "contactless_emv"
    /// Swiping a card using the magnetic stripe reader.
    case magneticStripeTrack2 = "magnetic_stripe_track2"
    /// When inserting a chip card fails three times in a row, fallback to a magnetic stripe read.
    case magneticStripeFallback = "magnetic_stripe_fallback"
    /// Older standard for contactless payments that emulated a magnetic stripe read.
    case contactlessMagstripeMode = "contactless_magstripe_mode"
}

// MARK: Cashapp
public struct PaymentMethodCashapp: Codable {
    public init() { }
}

// MARK: CustomerBalance
public struct PaymentMethodCustomerBalance: Codable {
    public init() { }
}

// MARK: EPS
public struct PaymentMethodEps: Codable {
    /// The customer’s bank. Should be one of `arzte_und_apotheker_bank`, `austrian_anadi_bank_ag`, `bank_austria`, `bankhaus_carl_spangler`, `bankhaus_schelhammer_und_schattera_ag`, `bawag_psk_ag`, `bks_bank_ag`, `brull_kallmus_bank_ag`, `btv_vier_lander_bank`, `capital_bank_grawe_gruppe_ag`, `deutsche_bank_ag`, `dolomitenbank`, `easybank_ag`, `erste_bank_und_sparkassen`, `hypo_alpeadriabank_international_ag`, `hypo_noe_lb_fur_niederosterreich_u_wien`, `hypo_oberosterreich_salzburg_steiermark`, `hypo_tirol_bank_ag`, `hypo_vorarlberg_bank_ag`, `hypo_bank_burgenland_aktiengesellschaft`, `marchfelder_bank`, `oberbank_ag`, `raiffeisen_bankengruppe_osterreich`, `schoellerbank_ag`, `sparda_bank_wien`, `volksbank_gruppe`, `volkskreditbank_ag`, or `vr_bank_braunau`.
    public var bank: PaymentMethodEpsBank?
    
    public init(bank: PaymentMethodEpsBank? = nil) {
        self.bank = bank
    }
}

public enum PaymentMethodEpsBank: String, Codable {
    case arzteUndApothekerBank = "arzte_und_apotheker_bank"
    case austrianAnadiBankAg = "austrian_anadi_bank_ag"
    case bankAustria = "bank_austria"
    case bankhausCarlSpangler = "bankhaus_carl_spangler"
    case bankhausSchelhammerUndSchatteraAg = "bankhaus_schelhammer_und_schattera_ag"
    case bawagPskAg = "bawag_psk_ag"
    case bksBankAg = "bks_bank_ag"
    case brullKallmusBankAg = "brull_kallmus_bank_ag"
    case btvVierLanderBank = "btv_vier_lander_bank"
    case capitalBankGraweGruppeAg = "capital_bank_grawe_gruppe_ag"
    case deutscheBankAg = "deutsche_bank_ag"
    case dolomitenbank = "dolomitenbank"
    case easybankAg = "easybank_ag"
    case ersteBankUndSparkassen = "erste_bank_und_sparkassen"
    case hypoAlpeadriabankInternationalAg = "hypo_alpeadriabank_international_ag"
    case hypoNoeLbFurNiederosterreichUWien = "hypo_noe_lb_fur_niederosterreich_u_wien"
    case hypoOberosterreichSalzburgSteiermark = "hypo_oberosterreich_salzburg_steiermark"
    case hypoTirolBankAg = "hypo_tirol_bank_ag"
    case hypoVorarlbergBankAg = "hypo_vorarlberg_bank_ag"
    case hypoBankBurgenlandAktiengesellschaft = "hypo_bank_burgenland_aktiengesellschaft"
    case marchfelderBank = "marchfelder_bank"
    case oberbankAg = "oberbank_ag"
    case raiffeisenBankengruppeOsterreich = "raiffeisen_bankengruppe_osterreich"
    case schoellerbankAg = "schoellerbank_ag"
    case spardaBankWien = "sparda_bank_wien"
    case volksbankGruppe = "volksbank_gruppe"
    case volkskreditbankAg = "volkskreditbank_ag"
    case vrBankBraunau = "vr_bank_braunau"
}
    
// MARK: FPX
public struct PaymentMethodFpx: Codable {
    /// The customer’s bank, if provided. Can be one of `affin_bank`, `agrobank`, `alliance_bank`, `ambank`, `bank_islam`, `bank_muamalat`, `bank_rakyat`, `bsn`, `cimb`, `hong_leong_bank`, `hsbc`, `kfh`, `maybank2u`, `ocbc`, `public_bank`, `rhb`, `standard_chartered`, `uob`, `deutsche_bank`, `maybank2e`, `pb_enterprise`, or  `bank_of_china`.
    public var bank: PaymentMethodFpxBank?
}

public enum PaymentMethodFpxBank: String, Codable {
    case affinBank = "affin_bank"
    case agrobank = "agrobank"
    case allianceBank = "alliance_bank"
    case ambank = "ambank"
    case bankIslam = "bank_islam"
    case bankMuamalat = "bank_muamalat"
    case bankRakyat = "bank_rakyat"
    case bsn = "bsn"
    case cimb = "cimb"
    case hongLeongBank = "hong_leong_bank"
    case hsbc = "hsbc"
    case kfh = "kfh"
    case maybank2u = "maybank2u"
    case ocbc = "ocbc"
    case publicBank = "public_bank"
    case rhb = "rhb"
    case standardChartered = "standard_chartered"
    case uob = "uob"
    case deutscheBank = "deutsche_bank"
    case maybank2e = "maybank2e"
    case pbEnterprise = "pb_enterprise"
    case bankOfChina = "bank_of_china"
}
    
// MARK: Giropay
public struct PaymentMethodGiropay: Codable {
    public init() {}
}

// MARK: Grabpay
public struct PaymentMethodGrabpay: Codable {
    public init() {}
}

// MARK: Ideal
public struct PaymentMethodIdeal: Codable {
    /// The customer’s bank, if provided. Can be one of `abn_amro`, `asn_bank`, `bunq`, `handelsbanken`, `ing`, `knab`, `moneyou`, `rabobank`, `regiobank`, `revolut`, `sns_bank`, `triodos_bank`,`van_lanschot` or `yoursafe`.
    public var bank: PaymentMethodIdealBank?
    /// The Bank Identifier Code of the customer’s bank, if the bank was provided.
    public var bic: String?
    
    public init(bank: PaymentMethodIdealBank? = nil, bic: String? = nil) {
        self.bank = bank
        self.bic = bic
    }
}

public enum PaymentMethodIdealBank: String, Codable {
    case abnAmro = "abn_amro"
    case asnBank = "asn_bank"
    case bunq
    case handelsbanken
    case ing
    case knab
    case moneyou
    case rabobank
    case regiobank
    case revolut
    case snsBank = "sns_bank"
    case triodosBank = "triodos_bank"
    case vanLanschot = "van_lanschot"
    case yoursafe
}

// MARK: InteracPresent
public struct PaymentMethodInteractPresent: Codable {
    /// Card brand. Can be interac, mastercard or visa.
    public var brand: String?
    /// The cardholder name as read from the card, in ISO 7813 format. May include alphanumeric characters, special characters and first/last name separator (/). In some cases, the cardholder name may not be available depending on how the issuer has configured the card. Cardholder name is typically not available on swipe or contactless payments, such as those made with Apple Pay and Google Pay.
    public var cardholderName: String?
    /// Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you’ve collected.
    public var country: String?
    /// Two-digit number representing the card’s expiration month.
    public var expMonth: Int?
    /// Four-digit number representing the card’s expiration year.
    public var expYear: Int?
    /// Uniquely identifies this particular card number. You can use this attribute to check whether two customers who’ve signed up with you are using the same card number, for example. For payment methods that tokenize card information (Apple Pay, Google Pay), the tokenized number might be provided instead of the underlying card number.
    /// Starting May 1, 2021, card fingerprint in India for Connect will change to allow two fingerprints for the same card — one for India and one for the rest of the world.
    public var fingerprint: String?
    /// Card funding type. Can be credit, debit, prepaid, or unknown.
    public var funding: CardFundingType?
    /// The last four digits of the card.
    public var last4: String?
    /// Contains information about card networks that can be used to process the payment.
    public var networks: PaymentMethodCardNetworks?
    /// EMV tag 5F2D. Preferred languages specified by the integrated circuit chip.
    public var preferredLocales: [String]?
    /// How card details were read in this transaction.
    public var readMethod: PaymentMethodInteractPresentReadMethod?
    
    public init(brand: String? = nil,
                cardholderName: String? = nil,
                country: String? = nil,
                expMonth: Int? = nil,
                expYear: Int? = nil,
                fingerprint: String? = nil,
                funding: CardFundingType? = nil,
                last4: String? = nil,
                networks: PaymentMethodCardNetworks? = nil,
                preferredLocales: [String]? = nil,
                readMethod: PaymentMethodInteractPresentReadMethod? = nil) {
        self.brand = brand
        self.cardholderName = cardholderName
        self.country = country
        self.expMonth = expMonth
        self.expYear = expYear
        self.fingerprint = fingerprint
        self.funding = funding
        self.last4 = last4
        self.networks = networks
        self.preferredLocales = preferredLocales
        self.readMethod = readMethod
    }
}

public enum PaymentMethodInteractPresentReadMethod: String, Codable {
    /// Inserting a chip card into the card reader.
    case contactEmv = "contact_emv"
    /// Tapping a contactless-enabled chip card or mobile wallet.
    case contactlessEmv = "contactless_emv"
    /// Swiping a card using the magnetic stripe reader.
    case magneticStripeTrack2 = "magnetic_stripe_track2"
    /// When inserting a chip card fails three times in a row, fallback to a magnetic stripe read.
    case magneticStripeFallback = "magnetic_stripe_fallback"
    /// Older standard for contactless payments that emulated a magnetic stripe read.
    case contactlessMagstripeMode = "contactless_magstripe_mode"
}

// MARK: Klarna
public struct PaymentMethodKlarna: Codable {
    /// The customer’s date of birth, if provided.
    /// This field is not included by default. To include it in the response, expand the dob field.
    public var dob: PersonDOB?
    
    public init(dob: PersonDOB? = nil) {
        self.dob = dob
    }
}

// MARK: Konbini
public struct PaymentMethodKonbini: Codable {
    public init() {}
}

// MARK: Link
public struct PaymentMethodLink: Codable {
    /// Account owner’s email address.
    public var email: String?
    /// Token used for persistent Link logins.
    public var persistentToken: String?
    
    public init(email: String? = nil, persistentToken: String? = nil) {
        self.email = email
        self.persistentToken = persistentToken
    }
}

// MARK: OXXO
public struct PaymentMethodOXXO: Codable {
    public init() {}
}

// MARK: P24
public struct PaymentMethodP24: Codable {
    /// The customer’s bank, if provided.
    public var bank: PaymentMethodP24Bank?
    
    public init(bank: PaymentMethodP24Bank? = nil) {
        self.bank = bank
    }
}

public enum PaymentMethodP24Bank: String, Codable {
    case ing = "ing"
    case citiHandlowy = "citi_handlowy"
    case tmobileUsbugiBankowe = "tmobile_usbugi_bankowe"
    case plusBank = "plus_bank"
    case etransferPocztowy24 = "etransfer_pocztowy24"
    case bankiSpbdzielcze = "banki_spbdzielcze"
    case bankNowyBfgSa = "bank_nowy_bfg_sa"
    case getinBank = "getin_bank"
    case blik = "blik"
    case noblePay = "noble_pay"
    case ideabank = "ideabank"
    case envelobank = "envelobank"
    case santanderPrzelew24 = "santander_przelew24"
    case nestPrzelew = "nest_przelew"
    case mbankMtransfer = "mbank_mtransfer"
    case inteligo = "inteligo"
    case pbacZIpko = "pbac_z_ipko"
    case bnpParibas = "bnp_paribas"
    case creditAgricole = "credit_agricole"
    case toyotaBank = "toyota_bank"
    case bankPekaoSa = "bank_pekao_sa"
    case volkswagenBank = "volkswagen_bank"
    case bankMillennium = "bank_millennium"
    case aliorBank = "alior_bank"
    case boz = "boz"
}

// MARK: Paynow
public struct PaymentMethodPaynow: Codable {
    public init() {}
}

// MARK: Pix
public struct PaymentMethodPix: Codable {
    public init() {}
}

// MARK: PromptPay
public struct PaymentMethodPromptPay: Codable {
    public init() {}
}
 
// MARK: Sepa Debit
public struct PaymentMethodSepaDebit: Codable {
    /// Bank code of bank associated with the bank account.
    public var bankCode: String?
    /// Branch code of bank associated with the bank account.
    public var branchCode: String?
    /// Two-letter ISO code representing the country the bank account is located in.
    public var country: String?
    /// Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    public var fingerprint: String?
    /// Information about the object that generated this PaymentMethod.
    public var generatedFrom: PaymentMethodSepaDebitGeneratedFrom?
    /// Last four characters of the IBAN.
    public var last4: String?
    
    public init(bankCode: String? = nil,
                branchCode: String? = nil,
                country: String? = nil,
                fingerprint: String? = nil,
                generatedFrom: PaymentMethodSepaDebitGeneratedFrom? = nil,
                last4: String? = nil) {
        self.bankCode = bankCode
        self.branchCode = branchCode
        self.country = country
        self.fingerprint = fingerprint
        self.generatedFrom = generatedFrom
        self.last4 = last4
    }
}

public struct PaymentMethodSepaDebitGeneratedFrom: Codable {
    /// The ID of the Charge that generated this PaymentMethod, if any.
    @Expandable<Charge> public var charge: String?
    /// The ID of the SetupAttempt that generated this PaymentMethod, if any.
    @Expandable<SetupAttempt> public var setupAttempt: String?
    
    public init(charge: String? = nil, setupAttempt: String? = nil) {
        self._charge = Expandable(id: charge)
        self._setupAttempt = Expandable(id: setupAttempt)
    }
}

// MARK: Sofort
public struct PaymentMethodSofort: Codable {
    /// Two-letter ISO code representing the country the bank account is located in.
    public var country: String?
    
    public init(country: String? = nil) {
        self.country = country
    }
}

// MARK: US Bank Account
public struct PaymentMethodUSBankAccount: Codable {
    /// Account holder type: individual or company.
    public var accountHolderType: PaymentMethodUSBankAccountAccountHolderType?
    /// Account type: checkings or savings. Defaults to checking if omitted.
    public var accountType: PaymentMethodUSBankAccountAccountType?
    /// The name of the bank.
    public var bankName: String?
    /// The ID of the Financial Connections Account used to create the payment method.
    public var financialConnectionsAccount: String?
    /// Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    public var fingerprint: String?
    /// Last four digits of the bank account number
    public var last4: String?
    /// Contains information about US bank account networks that can be used.
    public var networks: PaymentMethodUSBankAccountNetworks?
    /// Routing number of the bank account.
    public var routingNumber: String?
    /// Contains information about the future reusability of this PaymentMethod.
    public var statusDetails: PaymentMethodUSBankAccountStatusDetails?
    
    public init(accountHolderType: PaymentMethodUSBankAccountAccountHolderType? = nil,
                accountType: PaymentMethodUSBankAccountAccountType? = nil,
                bankName: String? = nil,
                financialConnectionsAccount: String? = nil,
                fingerprint: String? = nil,
                last4: String? = nil,
                networks: PaymentMethodUSBankAccountNetworks? = nil,
                routingNumber: String? = nil,
                statusDetails: PaymentMethodUSBankAccountStatusDetails? = nil) {
        self.accountHolderType = accountHolderType
        self.accountType = accountType
        self.bankName = bankName
        self.financialConnectionsAccount = financialConnectionsAccount
        self.fingerprint = fingerprint
        self.last4 = last4
        self.networks = networks
        self.routingNumber = routingNumber
        self.statusDetails = statusDetails
    }
}

public enum PaymentMethodUSBankAccountAccountHolderType: String, Codable {
    /// Account belongs to an individual
    case individual
    /// Account belongs to a company
    case company
}

public enum PaymentMethodUSBankAccountAccountType: String, Codable {
    /// Bank account type is checking
    case checking
    /// Bank account type is savings
    case savings
}

public struct PaymentMethodUSBankAccountNetworks: Codable {
    /// All available networks for the card.
    public var available: [String]?
    /// The preferred network for the card.
    public var preferred: String?
    
    public init(available: [String]? = nil, preferred: String? = nil) {
        self.available = available
        self.preferred = preferred
    }
}

public struct PaymentMethodUSBankAccountStatusDetails: Codable {
    /// Contains more information about the underlying block. This field will only be rendered if the PaymentMethod is blocked.
    public var blocked: PaymentMethodUSBankAccountStatusDetailsBlocked?
    
    public init(blocked: PaymentMethodUSBankAccountStatusDetailsBlocked? = nil) {
        self.blocked = blocked
    }
}

public struct PaymentMethodUSBankAccountStatusDetailsBlocked: Codable {
    /// The ACH network code that resulted in this block.
    public var network: PaymentMethodUSBankAccountStatusDetailsBlockedNetwork?
    /// The reason why this PaymentMethod’s fingerprint has been blocked
    public var reason: PaymentMethodUSBankAccountStatusDetailsBlockedReason?
    
    public init(network: PaymentMethodUSBankAccountStatusDetailsBlockedNetwork? = nil,
                reason: PaymentMethodUSBankAccountStatusDetailsBlockedReason? = nil) {
        self.network = network
        self.reason = reason
    }
}

public enum PaymentMethodUSBankAccountStatusDetailsBlockedNetwork: String, Codable {
    /// Account Closed
    case R02
    /// No Account, Unable to Locate Account
    case R03
    /// Invalid Account Number Structure
    case R04
    /// Unauthorized Debit to Consumer Account Using Corporate SEC Code
    case R05
    /// Authorization Revoked By Consumer
    case R07
    /// Payment Stopped
    case R08
    /// Customer Advises Originator is Not Known to Receiver and/or Originator is Not Authorized by Receiver to Debit Receiver’s Account
    case R10
    /// Customer Advises Entry Not in Accordance with the Terms of Authorization
    case R11
    /// Account Frozen, Entry Returned Per OFAC Instructions
    case R16
    /// Non-Transaction Account
    case R20
    /// Corporate Customer Advises Not Authorized
    case R29
    /// Permissible Return Entry (CCD and CTX only)
    case R31
}

public enum PaymentMethodUSBankAccountStatusDetailsBlockedReason: String, Codable {
    /// Customer has disputed a previous payment with their bank. If the `network_code` is R29, please confirm that Stripe’s Company IDs are allowlisted before attempting additional payments.
    case debitNotAuthorized = "debit_not_authorized"
    /// Bank account has been closed.
    case bankAccountClosed = "bank_account_closed"
    /// Bank account has been frozen.
    case bankAccountFrozen = "bank_account_frozen"
    /// Bank account details are incorrect. Please check the account number, routing number, account holder name, and account type.
    case bankAccountInvalidDetails = "bank_account_invalid_details"
    /// Bank account does not support debits.
    case bankAccountRestricted = "bank_account_restricted"
    /// Bank account has been blocked by Stripe. Please contact Support.
    case bankAccountUnusable = "bank_account_unusable"
}

// MARK: WechatPay
public struct PaymentMethodWechatPay: Codable {
    public init() {}
}
