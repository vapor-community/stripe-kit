//
//  SetupAttemptPaymentMethodDetails.swift
//  
//
//  Created by Andrew Edwards on 4/29/23.
//

import Foundation

public struct SetupAttemptPaymentMethodDetails: Codable {
    /// If this is a `acss_debit` payment method, this hash contains confirmation-specific information for the `acss_debit` payment method.
    public var acssDebit: SetupAttemptPaymentMethodDetailsACSSDebit?
    /// If this is a `au_becs_debit` payment method, this hash contains confirmation-specific information for the `au_becs_debit` payment method.
    public var auBecsDebit: SetupAttemptPaymentMethodDetailsAuBecsDebit?
    /// If this is a `bacs_debit` PaymentMethod, this hash contains details about the Bacs Direct Debit bank account.
    public var bacsDebit: SetupAttemptPaymentMethodDetailsBacsDebit?
    /// If this is a `bancontact` PaymentMethod, this hash contains details about the Bancontact payment method.
    public var bancontact: SetupAttemptPaymentMethodDetailsBancontact?
    /// If this is a `blik` payment method, this hash contains confirmation-specific information for the `blik` payment method.
    public var blik: SetupAttemptPaymentMethodDetailsBlik?
    /// If this is a`boleto` payment method, this hash contains confirmation-specific information for the `boleto` payment method.
    public var boleto: SetupAttemptPaymentMethodDetailsBoleto?
    /// If this is a `card` PaymentMethod, this hash contains details about the card.
    public var card: SetupAttemptPaymentMethodDetailsCard?
    /// If this is an `card_present` PaymentMethod, this hash contains details about the Card Present payment method.
    public var cardPresent: SetupAttemptPaymentMethodDetailsCardPresent?
    /// If this is a `cashapp` payment method, this hash contains confirmation-specific information for the `cashapp` payment method.
    public var cashapp: StripeSetupAttemptPaymentMethodDetailsCashapp?
    /// If this is a `ideal` payment method, this hash contains confirmation-specific information for the `ideal` payment method.
    public var ideal: SetupAttemptPaymentMethodDetailsIdeal?
    /// If this is a `klarna` payment method, this hash contains confirmation-specific information for the `klarna` payment method.
    public var klarna: SetupAttemptPaymentMethodDetailsKlarna?
    /// If this is a `link` payment method, this hash contains confirmation-specific information for the `link` payment method.
    public var link: SetupAttemptPaymentMethodDetailsLink?
    /// If this is a `sepa_debit` PaymentMethod, this hash contains details about the SEPA debit bank account.
    public var sepaDebit: SetupAttemptPaymentMethodDetailsSepaDebit?
    /// If this is a sofort PaymentMethod, this hash contains details about the SOFORT payment method.
    public var sofort: SetupAttemptPaymentMethodDetailsSofort?
    /// The type of the PaymentMethod, one of `card` or `card_present`. An additional hash is included on the PaymentMethod with a name matching this value. It contains additional information specific to the PaymentMethod type.
    public var type: String?
    /// If this is a `us_bank_account` payment method, this hash contains confirmation-specific information for the `us_bank_account` payment method.
    public var usBankAccount: SetupAttemptPaymentMethodDetailsUSBankAccount?
    
    public init(acssDebit: SetupAttemptPaymentMethodDetailsACSSDebit? = nil,
                auBecsDebit: SetupAttemptPaymentMethodDetailsAuBecsDebit? = nil,
                bacsDebit: SetupAttemptPaymentMethodDetailsBacsDebit? = nil,
                bancontact: SetupAttemptPaymentMethodDetailsBancontact? = nil,
                blik: SetupAttemptPaymentMethodDetailsBlik? = nil,
                boleto: SetupAttemptPaymentMethodDetailsBoleto? = nil,
                card: SetupAttemptPaymentMethodDetailsCard? = nil,
                cardPresent: SetupAttemptPaymentMethodDetailsCardPresent? = nil,
                cashapp: StripeSetupAttemptPaymentMethodDetailsCashapp? = nil,
                ideal: SetupAttemptPaymentMethodDetailsIdeal? = nil,
                klarna: SetupAttemptPaymentMethodDetailsKlarna? = nil,
                link: SetupAttemptPaymentMethodDetailsLink? = nil,
                sepaDebit: SetupAttemptPaymentMethodDetailsSepaDebit? = nil,
                sofort: SetupAttemptPaymentMethodDetailsSofort? = nil,
                type: String? = nil,
                usBankAccount: SetupAttemptPaymentMethodDetailsUSBankAccount? = nil) {
        self.acssDebit = acssDebit
        self.auBecsDebit = auBecsDebit
        self.bacsDebit = bacsDebit
        self.bancontact = bancontact
        self.blik = blik
        self.boleto = boleto
        self.card = card
        self.cardPresent = cardPresent
        self.cashapp = cashapp
        self.ideal = ideal
        self.klarna = klarna
        self.link = link
        self.sepaDebit = sepaDebit
        self.sofort = sofort
        self.type = type
        self.usBankAccount = usBankAccount
    }
}


// MARK: ACSS Debit
public struct SetupAttemptPaymentMethodDetailsACSSDebit: Codable {
    public init() {}
}

// MARK: AUBecsDebit
public struct SetupAttemptPaymentMethodDetailsAuBecsDebit: Codable {
    public init() {}
}

// MARK: BacsDebit
public struct SetupAttemptPaymentMethodDetailsBacsDebit: Codable {
    public init() {}
}

// MARK: Bancontact
public struct SetupAttemptPaymentMethodDetailsBancontact: Codable {
    /// Bank code of bank associated with the bank account.
    public var bankCode: String?
    /// Name of the bank associated with the bank account.
    public var bankName: String?
    /// Bank Identifier Code of the bank associated with the bank account.
    public var bic: String?
    /// The ID of the SEPA Direct Debit PaymentMethod which was generated by this SetupAttempt.
    @Expandable<PaymentMethodSepaDebit> public var generatedSepaDebit: String?
    /// The mandate for the SEPA Direct Debit PaymentMethod which was generated by this SetupAttempt.
    @Expandable<Mandate> public var generatedSepaDebitMandate: String?
    /// Last four characters of the IBAN.
    public var ibanLast4: String?
    /// Preferred language of the Bancontact authorization page that the customer is redirected to. Can be one of en, de, fr, or nl
    public var preferredLanguage: SetupAttemptPaymentMethodDetailsBancontactPreferredLanguage?
    /// Owner’s verified full name. Values are verified or provided by Bancontact directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedName: String?
    
    public init(bankCode: String? = nil,
                bankName: String? = nil,
                bic: String? = nil,
                generatedSepaDebit: String? = nil,
                generatedSepaDebitMandate: String? = nil,
                ibanLast4: String? = nil,
                preferredLanguage: SetupAttemptPaymentMethodDetailsBancontactPreferredLanguage? = nil,
                verifiedName: String? = nil) {
        self.bankCode = bankCode
        self.bankName = bankName
        self.bic = bic
        self._generatedSepaDebit = Expandable(id: generatedSepaDebit)
        self._generatedSepaDebitMandate = Expandable(id: generatedSepaDebitMandate)
        self.ibanLast4 = ibanLast4
        self.preferredLanguage = preferredLanguage
        self.verifiedName = verifiedName
    }
}

public enum SetupAttemptPaymentMethodDetailsBancontactPreferredLanguage: String, Codable {
    case en
    case de
    case fr
    case nl
}

// MARK: Blik
public struct SetupAttemptPaymentMethodDetailsBlik: Codable {
    public init() {}
}

// MARK: Boleto
public struct SetupAttemptPaymentMethodDetailsBoleto: Codable {
    public init() {}
}

// MARK: Card
public struct SetupAttemptPaymentMethodDetailsCard: Codable {
    /// Check results by Card networks on Card address and CVC at time of payment.
    public var checks: SetupAttemptPaymentMethodDetailsCardChecks?
    /// Populated if this authorization used 3D Secure authentication.
    public var threeDSecure: SetupAttemptPaymentMethodDetailsCardThreeDSecure?
}

public struct SetupAttemptPaymentMethodDetailsCardChecks: Codable {
    /// If a address line1 was provided, results of the check, one of `pass`, `fail`, `unavailable`, or `unchecked`.
    public var addressLine1Check: SetupAttemptPaymentMethodDetailsCardCheck?
    /// If a address postal code was provided, results of the check, one of `pass`, `fail`, `unavailable`, or `unchecked`.
    public var addressPostalCodeCheck: SetupAttemptPaymentMethodDetailsCardCheck?
    /// If a CVC was provided, results of the check, one of `pass`, `fail`, `unavailable`, or `unchecked`.
    public var cvcCheck: SetupAttemptPaymentMethodDetailsCardCheck?
    
    public init(addressLine1Check: SetupAttemptPaymentMethodDetailsCardCheck? = nil,
                addressPostalCodeCheck: SetupAttemptPaymentMethodDetailsCardCheck? = nil,
                cvcCheck: SetupAttemptPaymentMethodDetailsCardCheck? = nil) {
        self.addressLine1Check = addressLine1Check
        self.addressPostalCodeCheck = addressPostalCodeCheck
        self.cvcCheck = cvcCheck
    }
}

public enum SetupAttemptPaymentMethodDetailsCardCheck: String, Codable {
    case pass
    case fail
    case unavailable
    case unchecked
}

public struct SetupAttemptPaymentMethodDetailsCardThreeDSecure: Codable {
    /// For authenticated transactions: how the customer was authenticated by the issuing bank.
    public var authenticationFlow: SetupAttemptPaymentMethodDetailsCardThreeDSecureAuthenticationFlow?
    /// Indicates the outcome of 3D Secure authentication.
    public var result: SetupAttemptPaymentMethodDetailsCardThreeDSecureResult?
    /// Additional information about why 3D Secure succeeded or failed based on the `result`.
    public var resultReason: SetupAttemptPaymentMethodDetailsCardThreeDSecureResultReason?
    /// The version of 3D Secure that was used.
    public var version: String?
}

public enum SetupAttemptPaymentMethodDetailsCardThreeDSecureAuthenticationFlow: String, Codable {
    /// The issuing bank authenticated the customer by presenting a traditional challenge window.
    case challenge
    /// The issuing bank authenticated the customer via the 3DS2 frictionless flow.
    case frictionless
}

public enum SetupAttemptPaymentMethodDetailsCardThreeDSecureResult: String, Codable {
    /// 3D Secure authentication succeeded.
    case authenticated
    /// The issuing bank does not support 3D Secure, has not set up 3D Secure for the card, or is experiencing an outage. No authentication was peformed, but the card network has provided proof of the attempt.
    /// In most cases the attempt qualifies for liability shift and it is safe to make a charge.
    case attemptAcknowledged = "attempt_acknowledged"
    /// A 3D Secure exemption has been applied to this transaction. Exemption may be requested for a number of reasons including merchant initiation, low value, or low risk.
    case exempted
    /// 3D Secure authentication cannot be run on this card.
    case notSupported = "not_supported"
    /// The customer failed 3D Secure authentication.
    case failed
    /// The issuing bank’s 3D Secure system is temporarily unavailable and the card network is unable to provide proof of the attempt.
    case processingError = "processing_error"
}

public enum SetupAttemptPaymentMethodDetailsCardThreeDSecureResultReason: String, Codable {
    /// For `not_supported`. The issuing bank does not support 3D Secure or has not set up 3D Secure for the card, and the card network did not provide proof of the attempt.
    /// This occurs when running 3D Secure on certain kinds of prepaid cards and in rare cases where the issuing bank is exempt from the requirement to support 3D Secure.
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
    /// For `processing_error`. An invalid message was received from the card network or issuing bank. (Includes “downgrades” and similar errors).
    case protocolError = "protocol_error"
}

// MARK: Card Present
public struct SetupAttemptPaymentMethodDetailsCardPresent: Codable {
    /// The ID of the Card PaymentMethod which was generated by this SetupAttempt.
    @Expandable<StripeCard> public var generatedCard: String?
    
    public init(generatedCard: String? = nil) {
        self._generatedCard = Expandable(id: generatedCard)
    }
}

// MARK: Cashapp

public struct StripeSetupAttemptPaymentMethodDetailsCashapp: Codable {
    public init() {}
}

// MARK: Ideal
public struct SetupAttemptPaymentMethodDetailsIdeal: Codable {
    /// The customer’s bank. Can be one of `abn_amro`, `asn_bank`, `bunq`, `handelsbanken`, `ing`, `knab`, `moneyou`, `rabobank`, `regiobank`, `revolut`, `sns_bank`, `triodos_bank`, `van_lanschot` or `yourself`.
    public var bank: SetupAttemptPaymentMethodDetailsIdealBank?
    /// The Bank Identifier Code of the customer’s bank.
    public var bic: String?
    /// The ID of the SEPA Direct Debit PaymentMethod which was generated by this SetupAttempt.
    @Expandable<PaymentMethodSepaDebit> public var generatedSepaDebit: String?
    /// The mandate for the SEPA Direct Debit PaymentMethod which was generated by this SetupAttempt.
    @Expandable<Mandate> public var generatedSepaDebitMandate: String?
    /// Last four characters of the IBAN.
    public var ibanLast4: String?
    /// Owner’s verified full name. Values are verified or provided by iDEAL directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedName: String?
    
    public init(bank: SetupAttemptPaymentMethodDetailsIdealBank? = nil,
                bic: String? = nil,
                generatedSepaDebit: String? = nil,
                generatedSepaDebitMandate: String? = nil,
                ibanLast4: String? = nil,
                verifiedName: String? = nil) {
        self.bank = bank
        self.bic = bic
        self._generatedSepaDebit = Expandable(id: generatedSepaDebit)
        self._generatedSepaDebitMandate = Expandable(id: generatedSepaDebitMandate)
        self.ibanLast4 = ibanLast4
        self.verifiedName = verifiedName
    }
}

public enum SetupAttemptPaymentMethodDetailsIdealBank: String, Codable {
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

// MARK: Klarna
public struct SetupAttemptPaymentMethodDetailsKlarna: Codable {
    public init() {}
}

// MARK: Link
public struct SetupAttemptPaymentMethodDetailsLink: Codable {
    public init() {}
}

// MARK: Sepa Debit
public struct SetupAttemptPaymentMethodDetailsSepaDebit: Codable {
    public init() {}
}

// MARK: Sofort
public struct SetupAttemptPaymentMethodDetailsSofort: Codable {
    /// Bank code of bank associated with the bank account.
    public var bankCode: String?
    /// Name of the bank associated with the bank account.
    public var bankName: String?
    /// Bank Identifier Code of the bank associated with the bank account.
    public var bic: String?
    /// The ID of the SEPA Direct Debit PaymentMethod which was generated by this SetupAttempt.
    @Expandable<PaymentMethodSepaDebit> public var generatedSepaDebit: String?
    /// The mandate for the SEPA Direct Debit PaymentMethod which was generated by this SetupAttempt.
    @Expandable<Mandate> public var generatedSepaDebitMandate: String?
    /// Last four characters of the IBAN.
    public var ibanLast4: String?
    /// Preferred language of the Sofort authorization page that the customer is redirected to. Can be one of `en`, `de`, `fr`, or `nl`
    public var preferredLanguage: SetupAttemptPaymentMethodDetailsSofortPreferredLanguage?
    /// Owner’s verified full name. Values are verified or provided by iDEAL directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedName: String?
    
    public init(bankCode: String? = nil,
                bankName: String? = nil,
                bic: String? = nil,
                generatedSepaDebit: String? = nil,
                generatedSepaDebitMandate: String? = nil,
                ibanLast4: String? = nil,
                preferredLanguage: SetupAttemptPaymentMethodDetailsSofortPreferredLanguage? = nil,
                verifiedName: String? = nil) {
        self.bankCode = bankCode
        self.bankName = bankName
        self.bic = bic
        self._generatedSepaDebit = Expandable(id: generatedSepaDebit)
        self._generatedSepaDebitMandate = Expandable(id: generatedSepaDebitMandate)
        self.ibanLast4 = ibanLast4
        self.preferredLanguage = preferredLanguage
        self.verifiedName = verifiedName
    }
}

public enum SetupAttemptPaymentMethodDetailsSofortPreferredLanguage: String, Codable {
    case en
    case de
    case fr
    case nl
}

// MARK: US Bank Account
public struct SetupAttemptPaymentMethodDetailsUSBankAccount: Codable {
    public init() {}
}
