//
//  ChargePaymentMethods.swift
//  
//
//  Created by Andrew Edwards on 1/28/23.
//

import Foundation

// MARK: - ACH Credit Transfer
public struct ChargePaymentMethodDetailsACHCreditTransfer: Codable {
    /// Account number to transfer funds to.
    public var accountNumber: String?
    /// Name of the bank associated with the routing number.
    public var bankName: String?
    /// Routing transit number for the bank account to transfer funds to.
    public var routingNumber: String?
    /// SWIFT code of the bank associated with the routing number
    public var swiftCode: String?
    
    public init(accountNumber: String? = nil,
                bankName: String? = nil,
                routingNumber: String? = nil,
                swiftCode: String? = nil) {
        self.accountNumber = accountNumber
        self.bankName = bankName
        self.routingNumber = routingNumber
        self.swiftCode = swiftCode
    }
}

// MARK: - ACHDebit
public struct ChargePaymentMethodDetailsACHDebit: Codable {
    /// Type of entity that holds the account. This can be either `individual` or `company`.
    public var accountHolderType: ChargePaymentMethodDetailsACHDebitAccountHolderType?
    /// Name of the bank associated with the bank account.
    public var bankName: String?
    /// Two-letter ISO code representing the country the bank account is located in.
    public var country: String?
    /// Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    public var fingerprint: String?
    /// Account number to transfer funds to.
    public var last4: String?
    /// Routing transit number for the bank account.
    public var routingNumber: String?
    
    public init(accountHolderType: ChargePaymentMethodDetailsACHDebitAccountHolderType? = nil,
                bankName: String? = nil,
                country: String? = nil,
                fingerprint: String? = nil,
                last4: String? = nil,
                routingNumber: String? = nil) {
        self.accountHolderType = accountHolderType
        self.bankName = bankName
        self.country = country
        self.fingerprint = fingerprint
        self.last4 = last4
        self.routingNumber = routingNumber
    }
}

public enum ChargePaymentMethodDetailsACHDebitAccountHolderType: String, Codable {
    case individual
    case company
}

// MARK: - ACSSDebit
public struct ChargePaymentMethodDetailsACSSDebit: Codable {
    /// Name of the bank associated with the bank account.
    public var bankName: String?
    /// Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    public var fingerprint: String?
    /// Institution number of the bank account
    public var institutionNumber: String?
    /// Last four digits of the bank account number.
    public var last4: String?
    /// ID of the mandate used to make this payment.
    public var mandate: String?
    /// Transit number of the bank account.
    public var transitNumber: String?
    
    public init(bankName: String? = nil,
                fingerprint: String? = nil,
                institutionNumber: String? = nil,
                last4: String? = nil,
                mandate: String? = nil,
                transitNumber: String? = nil) {
        self.bankName = bankName
        self.fingerprint = fingerprint
        self.institutionNumber = institutionNumber
        self.last4 = last4
        self.mandate = mandate
        self.transitNumber = transitNumber
    }
}

// MARK: - Affirm
public struct ChargePaymentMethodDetailsAffirm: Codable {
    public init() {}
}

// MARK: - AfterpayClearpay
public struct ChargePaymentMethodDetailsAfterpayClearpay: Codable {
    /// Order identifier shown to the merchant in Afterpay’s online portal.
    public var reference: String?
    
    public init(reference: String? = nil) {
        self.reference = reference
    }
}

// MARK: - Alipay
public struct ChargePaymentMethodDetailsAlipay: Codable {
    /// Uniquely identifies this particular Alipay account. You can use this attribute to check whether two Alipay accounts are the same.
    public var buyerId: String?
    /// Uniquely identifies this particular Alipay account. You can use this attribute to check whether two Alipay accounts are the same.
    public var fingerprint: String?
    /// Transaction ID of this particular Alipay transaction.
    public var transactionId: String?
    
    public init(buyerId: String? = nil,
                fingerprint: String? = nil,
                transactionId: String? = nil) {
        self.buyerId = buyerId
        self.fingerprint = fingerprint
        self.transactionId = transactionId
    }
}

// MARK: - AUBecsDebit
public struct ChargePaymentMethodDetailsAuBecsDebit: Codable {
    /// Bank-State-Branch number of the bank account.
    public var bsbNumber: String?
    /// Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    public var fingerprint: String?
    /// Last four digits of the bank account number.
    public var last4: String?
    /// ID of the mandate used to make this payment.
    public var mandate: String?
    
    public init(bsbNumber: String? = nil,
                fingerprint: String? = nil,
                last4: String? = nil,
                mandate: String? = nil) {
        self.bsbNumber = bsbNumber
        self.fingerprint = fingerprint
        self.last4 = last4
        self.mandate = mandate
    }
}

// MARK: - BacsDebit
public struct ChargePaymentMethodDetailsBacsDebit: Codable {
    /// Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    public var fingerprint: String?
    /// Last four digits of the bank account number.
    public var last4: String?
    /// ID of the mandate used to make this payment.
    public var mandate: String?
    /// Sort code of the bank account. (e.g., `10-20-30`)
    public var sortCode: String?
    
    public init(fingerprint: String? = nil,
                last4: String? = nil,
                mandate: String? = nil,
                sortCode: String? = nil) {
        self.fingerprint = fingerprint
        self.last4 = last4
        self.mandate = mandate
        self.sortCode = sortCode
    }
}

// MARK: - Bancontact
public struct ChargePaymentMethodDetailsBancontact: Codable {
    /// Bank code of bank associated with the bank account.
    public var bankCode: String?
    /// Name of the bank associated with the bank account.
    public var bankName: String?
    /// Bank Identifier Code of the bank associated with the bank account.
    public var bic: String?
    /// The ID of the SEPA Direct Debit PaymentMethod which was generated by this Charge.
    public var generatedSepaDebit: String?
    /// The mandate for the SEPA Direct Debit PaymentMethod which was generated by this Charge.
    public var generatedSepaDebitMandate: String?
    /// Last four characters of the IBAN.
    public var ibanLast4: String?
    /// Preferred language of the Bancontact authorization page that the customer is redirected to. Can be one of `en`, `de`, `fr`, or `nl`
    public var preferredLanguage: ChargePaymentMethodDetailsBancontactPreferredLanguage?
    /// Owner’s verified full name. Values are verified or provided by Bancontact directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedName: String?
    
    public init(bankCode: String? = nil,
                bankName: String? = nil,
                bic: String? = nil,
                generatedSepaDebit: String? = nil,
                generatedSepaDebitMandate: String? = nil,
                ibanLast4: String? = nil,
                preferredLanguage: ChargePaymentMethodDetailsBancontactPreferredLanguage? = nil,
                verifiedName: String? = nil) {
        self.bankCode = bankCode
        self.bankName = bankName
        self.bic = bic
        self.generatedSepaDebit = generatedSepaDebit
        self.generatedSepaDebitMandate = generatedSepaDebitMandate
        self.ibanLast4 = ibanLast4
        self.preferredLanguage = preferredLanguage
        self.verifiedName = verifiedName
    }
}

public enum ChargePaymentMethodDetailsBancontactPreferredLanguage: String, Codable {
    case en
    case de
    case fr
    case nl
}

// MARK: - Blik
public struct ChargePaymentMethodDetailsBlik: Codable {
    public init() {}
}

// MARK: - Boleto
public struct ChargePaymentMethodDetailsBoleto: Codable {
    /// The tax ID of the customer (CPF for individuals consumers or CNPJ for businesses consumers)
    public var taxId: String?
    
    public init(taxId: String? = nil) {
        self.taxId = taxId
    }
}

// MARK: - Card
public struct ChargePaymentMethodDetailsCard: Codable {
    /// Card brand. Can be `amex`, `diners`, `discover`, `jcb`, `mastercard`, `unionpay`, `visa`, or `unknown`.
    public var brand: PaymentMethodDetailsCardBrand?
    /// Check results by Card networks on Card address and CVC at time of payment.
    public var checks: PaymentMethodDetailsCardChecks?
    /// Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you’ve collected.
    public var country: String?
    /// Two-digit number representing the card’s expiration month.
    public var expMonth: Int?
    /// Four-digit number representing the card’s expiration year.
    public var expYear: Int?
    /// Uniquely identifies this particular card number. You can use this attribute to check whether two customers who’ve signed up with you are using the same card number, for example. For payment methods that tokenize card information (Apple Pay, Google Pay), the tokenized number might be provided instead of the underlying card number.
    public var fingerprint: String?
    /// Card funding type. Can be `credit`, `debit`, `prepaid`, or `unknown`.
    public var funding: CardFundingType?
    /// Installment details for this payment (Mexico only). For more information, see the [installments integration guide.](https://stripe.com/docs/payments/installments)
    public var installments: ChargePaymentMethodDetailsCardInstallments?
    /// The last four digits of the card.
    public var last4: String?
    /// Identifies which network this charge was processed on. Can be `amex`, `diners`, `discover`, `interac`, `jcb`, `mastercard`, `unionpay`, `visa`, or `unknown`.
    public var network: PaymentMethodCardNetwork?
    /// Populated if this transaction used 3D Secure authentication.
    public var threeDSecure: ChargePaymentMethodDetailsCardThreeDSecure?
    /// If this Card is part of a card wallet, this contains the details of the card wallet.
    public var wallet: ChargePaymentMethodDetailsCardWallet?
    
    public init(brand: PaymentMethodDetailsCardBrand? = nil,
                checks: PaymentMethodDetailsCardChecks? = nil,
                country: String? = nil,
                expMonth: Int? = nil,
                expYear: Int? = nil,
                fingerprint: String? = nil,
                funding: CardFundingType? = nil,
                installments: ChargePaymentMethodDetailsCardInstallments? = nil,
                last4: String? = nil,
                network: PaymentMethodCardNetwork? = nil,
                threeDSecure: ChargePaymentMethodDetailsCardThreeDSecure? = nil,
                wallet: ChargePaymentMethodDetailsCardWallet? = nil) {
        self.brand = brand
        self.checks = checks
        self.country = country
        self.expMonth = expMonth
        self.expYear = expYear
        self.fingerprint = fingerprint
        self.funding = funding
        self.installments = installments
        self.last4 = last4
        self.network = network
        self.threeDSecure = threeDSecure
        self.wallet = wallet
    }
}

public struct ChargePaymentMethodDetailsCardInstallments: Codable {
    /// Installment plan selected for the payment.
    public var plan: ChargePaymentMethodDetailsCardInstallmentPlan?
    
    public init(plan: ChargePaymentMethodDetailsCardInstallmentPlan? = nil) {
        self.plan = plan
    }
}

public struct ChargePaymentMethodDetailsCardInstallmentPlan: Codable {
    /// For `fixed_count` installment plans, this is the number of installment payments your customer will make to their credit card.
    public var count: Int?
    /// For `fixed_count` installment plans, this is the interval between installment payments your customer will make to their credit card. One of `month`.
    public var interval: PlanInterval?
    /// Type of installment plan, one of `fixed_count`.
    public var type: String?
    
    public init(count: Int? = nil,
                interval: PlanInterval? = nil,
                type: String? = nil) {
        self.count = count
        self.interval = interval
        self.type = type
    }
}

public struct ChargePaymentMethodDetailsCardThreeDSecure: Codable {
    /// For authenticated transactions: how the customer was authenticated by the issuing bank.
    public var authenticationFlow: ChargePaymentMethodDetailsCardThreeDSecureAuthenticationFlow?
    /// Indicates the outcome of 3D Secure authentication.
    public var result: ChargePaymentMethodDetailsCardThreeDSecureResult?
    /// Additional information about why 3D Secure succeeded or failed based on the `result`.
    public var resultReason: ChargePaymentMethodDetailsCardThreeDSecureResultReason?
    /// The version of 3D Secure that was used.
    public var version: String?
    
    public init(authenticationFlow: ChargePaymentMethodDetailsCardThreeDSecureAuthenticationFlow? = nil,
                result: ChargePaymentMethodDetailsCardThreeDSecureResult? = nil,
                resultReason: ChargePaymentMethodDetailsCardThreeDSecureResultReason? = nil,
                version: String? = nil) {
        self.authenticationFlow = authenticationFlow
        self.result = result
        self.resultReason = resultReason
        self.version = version
    }
}

public enum ChargePaymentMethodDetailsCardThreeDSecureAuthenticationFlow: String, Codable {
    /// The issuing bank authenticated the customer by presenting a traditional challenge window.
    case challenge
    /// The issuing bank authenticated the customer via the 3DS2 frictionless flow.
    case frictionless
}

public enum ChargePaymentMethodDetailsCardThreeDSecureResult: String, Codable {
    /// 3D Secure authentication succeeded.
    case authenticated
    /// The issuing bank does not support 3D Secure, has not set up 3D Secure for the card, or is experiencing an outage. No authentication was performed, but the card network has provided proof of the attempt.
    /// In most cases the attempt qualifies for liability shift and it is safe to make a charge.
    case attemptAcknowledged = "attempt_acknowledged"
    /// A 3D Secure exemption has been applied to this transaction. Exemption may be requested for a number of reasons including merchant initiation, low value, or low risk.
    case exempted
    /// 3D Secure authentication cannot be run on this card. Liability will generally not be shifted to the issuer.
    case notSupported = "not_supported"
    /// The customer failed 3D Secure authentication.
    case failed
    /// The issuing bank’s 3D Secure system is temporarily unavailable and the card network is unable to provide proof of the attempt. Liability will generally not be shifted to the issuer.
    case processingError = "processing_error"
}

public enum ChargePaymentMethodDetailsCardThreeDSecureResultReason: String, Codable {
    /// For `not_supported`. The issuing bank does not support 3D Secure or has not set up 3D Secure for the card, and the card network did not provide proof of the attempt. This occurs when running 3D Secure on certain kinds of prepaid cards and in rare cases where the issuing bank is exempt from the requirement to support 3D Secure.
    case cardNotEnrolled = "card_not_enrolled"
    /// For `not_supported`. Stripe does not support 3D Secure on this card network.
    case networkNotSupported = "network_not_supported"
    /// For `failed`. The transaction timed out: the cardholder dropped off before completing authentication.
    case abandoned
    /// For `failed`. The cardholder canceled authentication (where possible to identify).
    case canceled
    /// For `failed`. The cardholder was redirected back from the issuing bank without completing authentication.
    case rejected
    /// For `processing_error`. Stripe bypassed 3D Secure because the issuing bank’s web-facing server was returning errors or timeouts to customers in the challenge window.
    case bypassed
    /// For `processing_error`. Stripe bypassed 3D Secure because the issuing bank’s web-facing server was returning errors or timeouts to customers in the challenge window.
    case protocolError = "protocol_error"
}

// MARK: - Wallet
public struct ChargePaymentMethodDetailsCardWallet: Codable {
    /// If this is a `amex_express_checkout` card wallet, this hash contains details about the wallet.
    public var amexExpressCheckout: ChargePaymentMethodDetailsAmexExpressCheckout?
    /// If this is a `apple_pay` card wallet, this hash contains details about the wallet.
    public var applePay: ChargePaymentMethodDetailsApplePay?
    /// (For tokenized numbers only.) The last four digits of the device account number.
    public var dynamicLast4: String?
    /// If this is a `google_pay` card wallet, this hash contains details about the wallet.
    public var googlePay: ChargePaymentMethodDetailsGooglePay?
    /// If this is a `masterpass` card wallet, this hash contains details about the wallet.
    public var masterpass: ChargePaymentMethodDetailsMasterpass?
    /// If this is a `samsung_pay` card wallet, this hash contains details about the wallet.
    public var samsungPay: ChargePaymentMethodDetailsSamsungPay?
    /// The type of the card wallet, one of `amex_express_checkout`, `apple_pay`, `google_pay`, `masterpass`, `samsung_pay`, or `visa_checkout`. An additional hash is included on the Wallet subhash with a name matching this value. It contains additional information specific to the card wallet type.
    public var type: PaymentMethodDetailsCardWalletType?
    /// If this is a `visa_checkout` card wallet, this hash contains details about the wallet.
    public var visaCheckout: ChargePaymentMethodDetailsVisaCheckout?
    
    public init(amexExpressCheckout: ChargePaymentMethodDetailsAmexExpressCheckout? = nil,
                applePay: ChargePaymentMethodDetailsApplePay? = nil,
                dynamicLast4: String? = nil,
                googlePay: ChargePaymentMethodDetailsGooglePay? = nil,
                masterpass: ChargePaymentMethodDetailsMasterpass? = nil,
                samsungPay: ChargePaymentMethodDetailsSamsungPay? = nil,
                type: PaymentMethodDetailsCardWalletType? = nil,
                visaCheckout: ChargePaymentMethodDetailsVisaCheckout? = nil) {
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

// MARK: - Amex Express Checkout
public struct ChargePaymentMethodDetailsAmexExpressCheckout: Codable {
    public init() {}
}

// MARK: - ApplePay
public struct ChargePaymentMethodDetailsApplePay: Codable {
    public init() {}
}

// MARK: - GooglePay
public struct ChargePaymentMethodDetailsGooglePay: Codable {
    public init() {}
}

// MARK: - Masterpass
public struct ChargePaymentMethodDetailsMasterpass: Codable {
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

// MARK: - SamsungPay
public struct ChargePaymentMethodDetailsSamsungPay: Codable {
    public init() {}
}

// MARK: - Visa Checkout
public struct ChargePaymentMethodDetailsVisaCheckout: Codable {
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

// MARK: - Card Present
public struct ChargePaymentMethodDetailsCardPresent: Codable {
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
    public var readMethod: ChargePaymentMethodDetailsCardPresentReadMethod?
    /// A collection of fields required to be displayed on receipts. Only required for EMV transactions.
    public var receipt: ChargePaymentMethodDetailsCardPresentReceipt?
    
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
                readMethod: ChargePaymentMethodDetailsCardPresentReadMethod? = nil,
                receipt: ChargePaymentMethodDetailsCardPresentReceipt? = nil) {
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

public enum ChargePaymentMethodDetailsCardPresentReadMethod: String, Codable {
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

public struct ChargePaymentMethodDetailsCardPresentReceipt: Codable {
    /// The type of account being debited or credited
    public var accountType: ChargePaymentMethodDetailsCardPresentReceiptAccountType?
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
    
    public init(accountType: ChargePaymentMethodDetailsCardPresentReceiptAccountType? = nil,
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

public enum ChargePaymentMethodDetailsCardPresentReceiptAccountType: String, Codable {
    /// A credit account, as when using a credit card
    case credit
    /// A checking account, as when using a debit card
    case checking
    /// A prepaid account, as when using a debit gift card
    case prepaid
    /// An unknown account
    case unknown
}

// MARK: - Customer Balance
public struct ChargePaymentMethodDetailsCustomerBalance: Codable {
    public init() {}
}

// MARK: - EPS
public struct ChargePaymentMethodDetailsEPS: Codable {
    /// The customer’s bank. Should be one of `arzte_und_apotheker_bank`, `austrian_anadi_bank_ag`, `bank_austria`, `bankhaus_carl_spangler`, `bankhaus_schelhammer_und_schattera_ag`, `bawag_psk_ag`, `bks_bank_ag`, `brull_kallmus_bank_ag`, `btv_vier_lander_bank`, `capital_bank_grawe_gruppe_ag`, `deutsche_bank_ag`, `dolomitenbank`, `easybank_ag`, `erste_bank_und_sparkassen`, `hypo_alpeadriabank_international_ag`, `hypo_noe_lb_fur_niederosterreich_u_wien`, `hypo_oberosterreich_salzburg_steiermark`, `hypo_tirol_bank_ag`, `hypo_vorarlberg_bank_ag`, `hypo_bank_burgenland_aktiengesellschaft`, `marchfelder_bank`, `oberbank_ag`, `raiffeisen_bankengruppe_osterreich`, `schoellerbank_ag`, `sparda_bank_wien`, `volksbank_gruppe`, `volkskreditbank_ag`, or `vr_bank_braunau`.
    public var bank: ChargePaymentMethodDetailsEPSBank?
    /// Owner’s verified full name. Values are verified or provided by EPS directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedName: String?
    
    public init(bank: ChargePaymentMethodDetailsEPSBank? = nil,
                verifiedName: String? = nil) {
        self.bank = bank
        self.verifiedName = verifiedName
    }
}

public enum ChargePaymentMethodDetailsEPSBank: String, Codable {
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
    case dolomitenbank
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
    case vrBankBrauna = "vr_bank_brauna"
}

// MARK: - FPX
public struct ChargePaymentMethodDetailsFpx: Codable {
    /// The customer’s bank. Can be one of `affin_bank`, `agrobank`, `alliance_bank`, `ambank`, `bank_islam`, `bank_muamalat`, `bank_rakyat`, `bsn`, `cimb`, `hong_leong_bank`, `hsbc`, `kfh`, `maybank2u`, `ocbc`, `public_bank`, `rhb`, `standard_chartered`, `uob`, `deutsche_bank`, `maybank2e`, `pb_enterprise` or `bank_of_china`.
    public var bank: ChargePaymentMethodDetailsFpxBank?
    /// Unique transaction id generated by FPX for every request from the merchant
    public var transactionId: String?
    
    public init(bank: ChargePaymentMethodDetailsFpxBank? = nil,
                transactionId: String? = nil) {
        self.bank = bank
        self.transactionId = transactionId
    }
}

public enum ChargePaymentMethodDetailsFpxBank: String, Codable {
    case affinBank = "affin_bank"
    case agrobank
    case allianceBank = "alliance_bank"
    case ambank
    case bankIslam = "bank_islam"
    case bankMuamalat = "bank_muamalat"
    case bankRakyat = "bank_rakyat"
    case bsn
    case cimb
    case hongLeongBank = "hong_leong_bank"
    case hsbc
    case kfh
    case maybank2u
    case ocbc
    case publicBank = "public_bank"
    case rhb
    case standardChartered = "standard_chartered"
    case uob
    case deutscheBank = "deutsche_bank"
    case maybank2e
    case pbEnterprise = "pb_enterprise"
    case bankOfChina = "bank_of_china"
}

// MARK: - Grabpay
public struct ChargePaymentMethodDetailsGrabpay: Codable {
    /// Unique transaction id generated by GrabPay
    public var transactionId: String?
    
    public init(transactionId: String? = nil) {
        self.transactionId = transactionId
    }
}

// MARK: - Giropay
public struct ChargePaymentMethodDetailsGiropay: Codable {
    /// Bank code of bank associated with the bank account.
    public var bankCode: String?
    /// Name of the bank associated with the bank account.
    public var bankName: String?
    /// Bank Identifier Code of the bank associated with the bank account.
    public var bic: String?
    /// Owner’s verified full name. Values are verified or provided by Giropay directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedName: String?
    
    public init(bankCode: String? = nil,
                bankName: String? = nil,
                bic: String? = nil,
                verifiedName: String? = nil) {
        self.bankCode = bankCode
        self.bankName = bankName
        self.bic = bic
        self.verifiedName = verifiedName
    }
}

// MARK: - Ideal
public struct ChargePaymentMethodDetailsIdeal: Codable {
    /// The customer’s bank. Can be one of `abn_amro`, `asn_bank`, `bunq`, `handelsbanken`, `ing`, `knab`, `moneyou`, `rabobank`, `regiobank`, `sns_bank`, `triodos_bank`, or `van_lanschot`.
    public var bank: ChargePaymentMethodDetailsIdealBank?
    /// The Bank Identifier Code of the customer’s bank.
    public var bic: String?
    /// The ID of the SEPA Direct Debit PaymentMethod which was generated by this Charge.
    public var generatedSepaDebit: String?
    /// The mandate for the SEPA Direct Debit PaymentMethod which was generated by this Charge.
    public var generatedSepaDebitMandate: String?
    /// Last four characters of the IBAN.
    public var ibanLast4: String?
    /// Owner’s verified full name. Values are verified or provided by iDEAL directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedName: String?
    
    public init(bank: ChargePaymentMethodDetailsIdealBank? = nil,
                bic: String? = nil,
                generatedSepaDebit: String? = nil,
                generatedSepaDebitMandate: String? = nil,
                ibanLast4: String? = nil,
                verifiedName: String? = nil) {
        self.bank = bank
        self.bic = bic
        self.generatedSepaDebit = generatedSepaDebit
        self.generatedSepaDebitMandate = generatedSepaDebitMandate
        self.ibanLast4 = ibanLast4
        self.verifiedName = verifiedName
    }
}

public enum ChargePaymentMethodDetailsIdealBank: String, Codable {
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
}

// MARK: - InteracPresent
public struct ChargePaymentMethodDetailsInteracPresent: Codable {
    /// Card brand. Can be `interac`, `mastercard` or `visa`.
    public var brand: ChargePaymentMethodDetailsInteracPresentBrand?
    /// The cardholder name as read from the card, in ISO 7813 format. May include alphanumeric characters, special characters and first/last name separator (`/`).
    public var cardholderName: String?
    /// Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you’ve collected.
    public var country: String?
    /// Authorization response cryptogram.
    public var emvAuthData: String?
    /// Two-digit number representing the card’s expiration month.
    public var expMonth: Int?
    /// Four-digit number representing the card’s expiration year.
    public var expYear: Int?
    /// Uniquely identifies this particular card number. You can use this attribute to check whether two customers who’ve signed up with you are using the same card number,for example. For payment methods that tokenize card information (Apple Pay, Google Pay), the tokenized number might be provided instead of the underlying card number.
    public var fingerprint: String?
    /// Card funding type. Can be `credit`, `debit`, `prepaid`, or `unknown`.
    public var funding: CardFundingType?
    /// ID of a card PaymentMethod generated from the `card_present` PaymentMethod that may be attached to a Customer for future transactions. Only present if it was possible to generate a card PaymentMethod.
    public var generatedCard: String?
    /// The last four digits of the card.
    public var last4: String?
    /// Identifies which network this charge was processed on. Can be `amex`, `cartes_bancaires`, `diners`, `discover`, `interac`, `jcb`, `mastercard`, `unionpay`, `visa`, or `unknown`.
    public var network: PaymentMethodCardNetwork?
    /// EMV tag 5F2D. Preferred languages specified by the integrated circuit chip.
    public var preferredLocales: [String]?
    /// How were card details read in this transaction. Can be `contact_emv`, `contactless_emv`, `magnetic_stripe_fallback`, `magnetic_stripe_track2`, or `contactless_magstripe_mode`
    public var readMethod: ChargePaymentMethodDetailsInteracPresentReadMethod?
    /// A collection of fields required to be displayed on receipts. Only required for EMV transactions.
    public var receipt: ChargePaymentMethodDetailsInteracPresentReceipt?
    
    public init(brand: ChargePaymentMethodDetailsInteracPresentBrand? = nil,
                cardholderName: String? = nil,
                country: String? = nil,
                emvAuthData: String? = nil,
                expMonth: Int? = nil,
                expYear: Int? = nil,
                fingerprint: String? = nil,
                funding: CardFundingType? = nil,
                generatedCard: String? = nil,
                last4: String? = nil,
                network: PaymentMethodCardNetwork? = nil,
                preferredLocales: [String]? = nil,
                readMethod: ChargePaymentMethodDetailsInteracPresentReadMethod? = nil,
                receipt: ChargePaymentMethodDetailsInteracPresentReceipt? = nil) {
        self.brand = brand
        self.cardholderName = cardholderName
        self.country = country
        self.emvAuthData = emvAuthData
        self.expMonth = expMonth
        self.expYear = expYear
        self.fingerprint = fingerprint
        self.funding = funding
        self.generatedCard = generatedCard
        self.last4 = last4
        self.network = network
        self.preferredLocales = preferredLocales
        self.readMethod = readMethod
        self.receipt = receipt
    }
}

public enum ChargePaymentMethodDetailsInteracPresentBrand: String, Codable {
    case interac
    case mastercard
    case visa
}

public enum ChargePaymentMethodDetailsInteracPresentReadMethod: String, Codable {
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

public struct ChargePaymentMethodDetailsInteracPresentReceipt: Codable {
    /// The type of account being debited or credited.
    public var accountType: ChargePaymentMethodDetailsInteracPresentReceiptAccountType?
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
    
    public init(accountType: ChargePaymentMethodDetailsInteracPresentReceiptAccountType? = nil,
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

public enum ChargePaymentMethodDetailsInteracPresentReceiptAccountType: String, Codable {
    /// A checking account, as selected on the reader.
    case checking
    /// A savings account, as selected on the reader.
    case savings
    /// An unknown account.
    case unknown
}


// MARK: - Klarna
public struct ChargePaymentMethodDetailsKlarna: Codable {
    /// The Klarna payment method used for this transaction. Can be one of `pay_later`, `pay_now`, `pay_with_financing`, or `pay_in_installments`.
    public var paymentMethodCategory: ChargePaymentMethodDetailsKlarnaPaymentMethodCategory?
    /// Preferred language of the Klarna authorization page that the customer is redirected to. Can be one of de-AT, en-AT, nl-BE, fr-BE, en-BE, de-DE, en-DE, da-DK, en-DK, es-ES, en-ES, fi-FI, sv-FI, en-FI, en-GB, en-IE, it-IT, en-IT, nl-NL, en-NL, nb-NO, en-NO, sv-SE, en-SE, en-US, es-US, fr-FR, en-FR, cs-CZ, en-CZ, el-GR, en-GR, en-AU, en-NZ, en-CA, fr-CA, pl-PL, en-PL, pt-PT, en-PT, de-CH, fr-CH, it-CH, or en-CH
    public var preferredLocale: ChargePaymentMethodDetailsKlarnaPreferredLocale?
    
    public init(paymentMethodCategory: ChargePaymentMethodDetailsKlarnaPaymentMethodCategory? = nil,
                preferredLocale: ChargePaymentMethodDetailsKlarnaPreferredLocale? = nil) {
        self.paymentMethodCategory = paymentMethodCategory
        self.preferredLocale = preferredLocale
    }
}

public enum ChargePaymentMethodDetailsKlarnaPaymentMethodCategory: String, Codable {
    case payLater = "pay_later"
    case payNow = "pay_now"
    case payWithFinancing = "pay_with_financing"
    case payInInstallments = "pay_in_installments"
}

public enum ChargePaymentMethodDetailsKlarnaPreferredLocale: String, Codable {
    case deAT = "de-AT"
    case enAT = "en-AT"
    case nlBE = "nl-BE"
    case frBE = "fr-BE"
    case enBE = "en-BE"
    case deDE = "de-DE"
    case enDE = "en-DE"
    case daDK = "da-DK"
    case enDK = "en-DK"
    case esES = "es-ES"
    case enES = "en-ES"
    case fiFI = "fi-FI"
    case svFI = "sv-FI"
    case enFI = "en-FI"
    case enGB = "en-GB"
    case enIE = "en-IE"
    case itIT = "it-IT"
    case enIT = "en-IT"
    case nlNL = "nl-NL"
    case enNL = "en-NL"
    case nbNO = "nb-NO"
    case enNO = "en-NO"
    case svSE = "sv-SE"
    case enSE = "en-SE"
    case enUS = "en-US"
    case esUS = "es-US"
    case frFR = "fr-FR"
    case enFR = "en-FR"
    case csCZ = "cs-CZ"
    case enCZ = "en-CZ"
    case elGR = "el-GR"
    case enGR = "en-GR"
    case enAU = "en-AU"
    case enNZ = "en-NZ"
    case enCA = "en-CA"
    case frCA = "fr-CA"
    case plPL = "pl-PL"
    case enPL = "en-PL"
    case ptPT = "pt-PT"
    case enPT = "en-PT"
    case deCH = "de-CH"
    case frCH = "fr-CH"
    case itCH = "it-CH"
    case enCH = "en-CH"
}

// MARK: - Kobini
public struct ChargePaymentMethodDetailsKobini: Codable {
    /// If the payment succeeded, this contains the details of the convenience store where the payment was completed.
    public var store: ChargePaymentMethodDetailsKobiniStore?
    
    public init(store: ChargePaymentMethodDetailsKobiniStore? = nil) {
        self.store = store
    }
}

public struct ChargePaymentMethodDetailsKobiniStore: Codable {
    /// The name of the convenience store chain where the payment was completed.
    public var chain: String?
    
    public init(chain: String? = nil) {
        self.chain = chain
    }
}

// MARK: - Link
public struct ChargePaymentMethodDetailsLink: Codable {
    public init() {}
}

// MARK: - Multibanco
public struct ChargePaymentMethodDetailsMultibanco: Codable {
    /// Entity number associated with this Multibanco payment.
    public var entity: String?
    /// Reference number associated with this Multibanco payment.
    public var reference: String?
    
    public init(entity: String? = nil, reference: String? = nil) {
        self.entity = entity
        self.reference = reference
    }
}

// MARK: - OXXO
public struct ChargePaymentMethodDetailsOXXO: Codable {
    /// OXXO reference number
    public var number: String?
    
    public init(number: String? = nil) {
        self.number = number
    }
}

// MARK: - P24
public struct ChargePaymentMethodDetailsP24: Codable {
    /// The customer’s bank. Can be one of `ing`, `citi_handlowy`, `tmobile_usbugi_bankowe`, `plus_bank`, `etransfer_pocztowy24`, `banki_spbdzielcze`, `bank_nowy_bfg_sa`, `getin_bank`, `blik`, `noble_pay`, `ideabank`, `envelobank`, `santander_przelew24`, `nest_przelew`, `mbank_mtransfer`, `inteligo`, `pbac_z_ipko`, `bnp_paribas`, `credit_agricole`, `toyota_bank`, `bank_pekao_sa`, `volkswagen_bank`, `bank_millennium`, `alior_bank`, or `boz`.
    public var bank: ChargePaymentMethodDetailsP24Bank?
    /// Unique reference for this Przelewy24 payment.
    public var reference: String?
    /// Owner’s verified full name. Values are verified or provided by Przelewy24 directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedName: String?
    
    public init(bank: ChargePaymentMethodDetailsP24Bank? = nil,
                reference: String? = nil,
                verifiedName: String? = nil) {
        self.bank = bank
        self.reference = reference
        self.verifiedName = verifiedName
    }
}

public enum ChargePaymentMethodDetailsP24Bank: String, Codable {
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

// MARK: - Paynow
public struct ChargePaymentMethodDetailsPaynow: Codable {
    /// Reference number associated with this PayNow payment
    public var reference: String?
    
    public init(reference: String? = nil) {
        self.reference = reference
    }
}

// MARK: - Pix
public struct ChargePaymentMethodDetailsPix: Codable {
    /// Unique transaction id generated by BCB
    public var bankTransactionId: String?
    
    public init(bankTransactionId: String? = nil) {
        self.bankTransactionId = bankTransactionId
    }
}

// MARK: - Promptpay
public struct ChargePaymentMethodDetailsPromptpay: Codable {
    /// Bill reference generated by PromptPay
    public var reference: String?
    
    public init(reference: String? = nil) {
        self.reference = reference
    }
}

// MARK: - SepaDebit
public struct ChargePaymentMethodDetailsSepaDebit: Codable {
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
    /// ID of the mandate used to make this payment.
    public var mandate: String?
    
    public init(bankCode: String? = nil,
                branchCode: String? = nil,
                country: String? = nil,
                fingerprint: String? = nil,
                last4: String? = nil,
                mandate: String? = nil) {
        self.bankCode = bankCode
        self.branchCode = branchCode
        self.country = country
        self.fingerprint = fingerprint
        self.last4 = last4
        self.mandate = mandate
    }
}

// MARK: - Sofort
public struct ChargePaymentMethodDetailsSofort: Codable {
    /// Bank code of bank associated with the bank account.
    public var bankCode: String?
    /// Name of the bank associated with the bank account.
    public var bankName: String?
    /// Bank Identifier Code of the bank associated with the bank account.
    public var bic: String?
    /// Two-letter ISO code representing the country the bank account is located in.
    public var country: String?
    /// The ID of the SEPA Direct Debit PaymentMethod which was generated by this Charge.
    public var generatedSepaDebit: String?
    /// The mandate for the SEPA Direct Debit PaymentMethod which was generated by this Charge.
    public var generatedSepaDebitMandate: String?
    /// Last four characters of the IBAN.
    public var ibanLast4: String?
    /// Preferred language of the SOFORT authorization page that the customer is redirected to. Can be one of de, en, es, fr, it, nl, or pl
    public var preferredLanguage: String?
    /// Owner’s verified full name. Values are verified or provided by SOFORT directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedName: String?
    
    public init(bankCode: String? = nil,
                bankName: String? = nil,
                bic: String? = nil,
                country: String? = nil,
                generatedSepaDebit: String? = nil,
                generatedSepaDebitMandate: String? = nil,
                ibanLast4: String? = nil,
                preferredLanguage: String? = nil,
                verifiedName: String? = nil) {
        self.bankCode = bankCode
        self.bankName = bankName
        self.bic = bic
        self.country = country
        self.generatedSepaDebit = generatedSepaDebit
        self.generatedSepaDebitMandate = generatedSepaDebitMandate
        self.ibanLast4 = ibanLast4
        self.preferredLanguage = preferredLanguage
        self.verifiedName = verifiedName
    }
}

// MARK: - Stripe Account
public struct ChargePaymentMethodDetailsStripeAccount: Codable {
    public init() { }
}

// MARK: - US Bank Account
public struct ChargePaymentMethodDetailsUSBankAccount: Codable {
    /// Account holder type: individual or company.
    public var accountHolderType: ChargePaymentMethodDetailsUSBankAccountAccountHolderType?
    /// Account type: checkings or savings. Defaults to checking if omitted.
    public var accountType: ChargePaymentMethodDetailsUSBankAccountAccountType?
    /// Name of the bank associated with the bank account.
    public var bankName: String?
    /// Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    public var fingerprint: String?
    /// Last four digits of the bank account number.
    public var last4: String?
    /// Routing number of the bank account.
    public var routingNumber: String?
    
    public init(accountHolderType: ChargePaymentMethodDetailsUSBankAccountAccountHolderType? = nil,
                accountType: ChargePaymentMethodDetailsUSBankAccountAccountType? = nil,
                bankName: String? = nil,
                fingerprint: String? = nil,
                last4: String? = nil,
                routingNumber: String? = nil) {
        self.accountHolderType = accountHolderType
        self.accountType = accountType
        self.bankName = bankName
        self.fingerprint = fingerprint
        self.last4 = last4
        self.routingNumber = routingNumber
    }
}

public enum ChargePaymentMethodDetailsUSBankAccountAccountHolderType: String, Codable {
    /// Account belongs to an individual
    case individual
    /// Account belongs to a company
    case company
}

public enum ChargePaymentMethodDetailsUSBankAccountAccountType: String, Codable {
    /// Bank account type is checking
    case checking
    /// Bank account type is savings
    case savings
}

// MARK: - Wechat
public struct ChargePaymentMethodDetailsWechat: Codable {
    public init() { }
}

// MARK: - WechatPay
public struct ChargePaymentMethodDetailsWechatPay: Codable {
    /// Uniquely identifies this particular WeChat Pay account. You can use this attribute to check whether two WeChat accounts are the same.
    public var fingerprint: String?
    /// Transaction ID of this particular WeChat Pay transaction.
    public var transactionId: String?
    
    public init(fingerprint: String? = nil,
                transactionId: String? = nil) {
        self.fingerprint = fingerprint
        self.transactionId = transactionId
    }
}
