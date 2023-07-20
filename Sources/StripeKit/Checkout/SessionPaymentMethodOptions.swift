//
//  SessionPaymentMethodOptions.swift
//  
//
//  Created by Andrew Edwards on 5/6/23.
//

import Foundation


public struct SessionPaymentMethodOptions: Codable {
    /// If the Checkout Session’s `payment_method_types` includes `acss_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var acssDebit: SessionPaymentMethodOptionsAcssDebit?
    /// If the Checkout Session’s `payment_method_types` includes `affirm`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var affirm: SessionPaymentMethodAffirm?
    /// If the Checkout Session’s `payment_method_types` includes `afterpay_clearpay`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var afterpayClearpay: SessionPaymentMethodAfterpayClearpay?
    /// If the Checkout Session’s `payment_method_types` includes `alipay`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var alipay: SessionPaymentMethodAlipay?
    /// If the Checkout Session’s `payment_method_types` includes `au_becs_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var auBecsDebit: SessionPaymentMethodAuBecsDebit?
    /// If the Checkout Session’s `payment_method_types` includes `bacs_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var bacsDebit: SessionPaymentMethodBacsDebit?
    /// If the Checkout Session’s `payment_method_types` includes `bancontact`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var bancontact: SessionPaymentMethodBancontact?
    /// If the Checkout Session’s `payment_method_types` includes `boleto`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var boleto: SessionPaymentMethodOptionsBoleto?
    /// If the Checkout Session’s `payment_method_types` includes `card`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var card: SessionPaymentMethodCard?
    /// If the Checkout Session’s `payment_method_types` includes `cashapp`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var cashapp: SessionPaymentMethodOptionsCashapp?
    /// If the Checkout Session’s `payment_method_types` includes `customer_balance`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var customerBalance: SessionPaymentMethodOptionsCustomerBalance?
    /// If the Checkout Session’s `payment_method_types` includes `eps`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var eps: SessionPaymentMethodOptionsEps?
    /// If the Checkout Session’s `payment_method_types` includes `fpx`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var fpx: SessionPaymentMethodOptionsFpx?
    /// If the Checkout Session’s `payment_method_types` includes `giropay`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var giropay: SessionPaymentMethodOptionsGiropay?
    /// If the Checkout Session’s `payment_method_types` includes `grabpay`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var grabpay: SessionPaymentMethodOptionsGrabpay?
    /// If the Checkout Session’s `payment_method_types` includes `ideal`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var ideal: SessionPaymentMethodOptionsIdeal?
    /// If the Checkout Session’s `payment_method_types` includes `klarna`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var klarna: SessionPaymentMethodOptionsKlarna?
    /// If the Checkout Session’s `payment_method_types` includes `konbini`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var konbini: SessionPaymentMethodOptionsKonbini?
    /// If the Checkout Session’s `payment_method_types` includes `link`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var link: SessionPaymentMethodOptionsLink?
    /// If the Checkout Session’s `payment_method_types` includes `oxxo`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var oxxo: SessionPaymentMethodOptionsOXXO?
    /// If the Checkout Session’s `payment_method_types` includes `p24`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var p24: SessionPaymentMethodOptionsP24?
    /// If the Checkout Session’s `payment_method_types` includes `paynow`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var paynow: SessionPaymentMethodOptionsPaynow?
    /// If the Checkout Session’s `payment_method_types` includes `pix`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var pix: SessionPaymentMethodOptionsPix?
    /// If the Checkout Session’s `payment_method_types` includes `sepa_debit`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var sepaDebit: SessionPaymentMethodOptionsSepaDebit?
    /// If the Checkout Session’s `payment_method_types` includes `sofort`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var sofort: SessionPaymentMethodOptionsSofort?
    /// If the Checkout Session’s `payment_method_types` includes `us_bank_account`, this hash contains the configurations that will be applied to each payment attempt of that type.
    public var usBankAccount: SessionPaymentMethodOptionsUSBankAccount?
    
    public init(acssDebit: SessionPaymentMethodOptionsAcssDebit? = nil,
                affirm: SessionPaymentMethodAffirm? = nil,
                afterpayClearpay: SessionPaymentMethodAfterpayClearpay? = nil,
                alipay: SessionPaymentMethodAlipay? = nil,
                auBecsDebit: SessionPaymentMethodAuBecsDebit? = nil,
                bacsDebit: SessionPaymentMethodBacsDebit? = nil,
                bancontact: SessionPaymentMethodBancontact? = nil,
                boleto: SessionPaymentMethodOptionsBoleto? = nil,
                card: SessionPaymentMethodCard? = nil,
                cashapp: SessionPaymentMethodOptionsCashapp? = nil,
                customerBalance: SessionPaymentMethodOptionsCustomerBalance? = nil,
                eps: SessionPaymentMethodOptionsEps? = nil,
                fpx: SessionPaymentMethodOptionsFpx? = nil,
                giropay: SessionPaymentMethodOptionsGiropay? = nil,
                grabpay: SessionPaymentMethodOptionsGrabpay? = nil,
                ideal: SessionPaymentMethodOptionsIdeal? = nil,
                klarna: SessionPaymentMethodOptionsKlarna? = nil,
                konbini: SessionPaymentMethodOptionsKonbini? = nil,
                link: SessionPaymentMethodOptionsLink? = nil,
                oxxo: SessionPaymentMethodOptionsOXXO? = nil,
                p24: SessionPaymentMethodOptionsP24? = nil,
                paynow: SessionPaymentMethodOptionsPaynow? = nil,
                pix: SessionPaymentMethodOptionsPix? = nil,
                sepaDebit: SessionPaymentMethodOptionsSepaDebit? = nil,
                sofort: SessionPaymentMethodOptionsSofort? = nil,
                usBankAccount: SessionPaymentMethodOptionsUSBankAccount? = nil) {
        self.acssDebit = acssDebit
        self.affirm = affirm
        self.afterpayClearpay = afterpayClearpay
        self.alipay = alipay
        self.auBecsDebit = auBecsDebit
        self.bacsDebit = bacsDebit
        self.bancontact = bancontact
        self.boleto = boleto
        self.card = card
        self.cashapp = cashapp
        self.customerBalance = customerBalance
        self.eps = eps
        self.fpx = fpx
        self.giropay = giropay
        self.grabpay = grabpay
        self.ideal = ideal
        self.klarna = klarna
        self.konbini = konbini
        self.link = link
        self.oxxo = oxxo
        self.p24 = p24
        self.paynow = paynow
        self.pix = pix
        self.sepaDebit = sepaDebit
        self.sofort = sofort
        self.usBankAccount = usBankAccount
    }
}

// MARK: Acss Debit
public struct SessionPaymentMethodOptionsAcssDebit: Codable {
    /// Currency supported by the bank account. Returned when the Session is in `setup` mode.
    public var currency: Currency?
    /// Additional fields for Mandate creation
    public var mandateOptions: SessionPaymentMethodOptionsAcssDebitMandateOptions?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsAcssDebitSetupFutureUsage?
    /// Bank account verification method.
    public var verificationMethod: SessionPaymentMethodOptionsAcssDebitVerificationMethod?
    
    public init(currency: Currency? = nil,
                mandateOptions: SessionPaymentMethodOptionsAcssDebitMandateOptions? = nil,
                setupFutureUsage: SessionPaymentMethodOptionsAcssDebitSetupFutureUsage? = nil,
                verificationMethod: SessionPaymentMethodOptionsAcssDebitVerificationMethod? = nil) {
        self.currency = currency
        self.mandateOptions = mandateOptions
        self.setupFutureUsage = setupFutureUsage
        self.verificationMethod = verificationMethod
    }
}

public struct SessionPaymentMethodOptionsAcssDebitMandateOptions: Codable {
    /// A URL for custom mandate text
    public var customMandateUrl: String?
    /// List of Stripe products where this mandate can be selected automatically. Returned when the Session is in setup mode.
    public var defaultFor: [SessionPaymentMethodOptionsAcssDebitMandateOptionsDefaultFor]?
    /// Description of the interval. Only required if `payment_schedule` parmeter is `interval` or `combined`.
    public var intervalDescription: String?
    /// Payment schedule for the mandate.
    public var paymentSchedule: SessionPaymentMethodOptionsAcssDebitMandateOptionsPaymentSchedule?
    /// Transaction type of the mandate.
    public var transactionType: SessionPaymentMethodOptionsAcssDebitMandateOptionsTransactionType?
    
    public init(customMandateUrl: String? = nil,
                intervalDescription: String? = nil,
                paymentSchedule: SessionPaymentMethodOptionsAcssDebitMandateOptionsPaymentSchedule? = nil,
                transactionType: SessionPaymentMethodOptionsAcssDebitMandateOptionsTransactionType? = nil) {
        self.customMandateUrl = customMandateUrl
        self.intervalDescription = intervalDescription
        self.paymentSchedule = paymentSchedule
        self.transactionType = transactionType
    }
}

public enum SessionPaymentMethodOptionsAcssDebitMandateOptionsDefaultFor: Codable {
    /// Enables payments for Stripe Invoices. ‘subscription’ must also be provided.
    case invoice
    /// Enables payments for Stripe Subscriptions. ‘invoice’ must also be provided.
    case subscription
}

public enum SessionPaymentMethodOptionsAcssDebitMandateOptionsPaymentSchedule: String, Codable {
    /// Payments are initiated at a regular pre-defined interval
    case interval
    /// Payments are initiated sporadically
    case sporadic
    /// Payments can be initiated at a pre-defined interval or sporadically
    case combined
}

public enum SessionPaymentMethodOptionsAcssDebitMandateOptionsTransactionType: String, Codable {
    /// Transaction are made for personal reasons
    case personal
    /// Transactions are made for business reasons
    case business
}

public enum SessionPaymentMethodOptionsAcssDebitSetupFutureUsage: String, Codable {
    /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
    case onSession = "on_session"
    /// Use `off_session` if your customer may or may not be present in your checkout flow.
    case offSession = "off_session"
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

public enum SessionPaymentMethodOptionsAcssDebitVerificationMethod: String, Codable {
    /// Instant verification with fallback to microdeposits.
    case automatic
    /// Instant verification.
    case instant
    /// Verification using microdeposits.
    case microdeposits
}

// MARK: Affirm
public struct SessionPaymentMethodAffirm: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.

    public var setupFutureUsage: SessionPaymentMethodOptionsAffirmSetupFutureUsage?
    
    public init(setupFutureUsage: SessionPaymentMethodOptionsAffirmSetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsAffirmSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: Afterpay Clearpay
public struct SessionPaymentMethodAfterpayClearpay: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsAfterpayClearpaySetupFutureUsage?
    
    public init(setupFutureUsage: SessionPaymentMethodOptionsAfterpayClearpaySetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsAfterpayClearpaySetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: Alipay
public struct SessionPaymentMethodAlipay: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsAlipaySetupFutureUsage?
    
    public init(setupFutureUsage: SessionPaymentMethodOptionsAlipaySetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsAlipaySetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: Au Becs Debit
public struct SessionPaymentMethodAuBecsDebit: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsAuBecsDebitSetupFutureUsage?
    
    public init(setupFutureUsage: SessionPaymentMethodOptionsAuBecsDebitSetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsAuBecsDebitSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: Bacs Debit
public struct SessionPaymentMethodBacsDebit: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsBacsDebitSetupFutureUsage?
    
    public init(setupFutureUsage: SessionPaymentMethodOptionsBacsDebitSetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsBacsDebitSetupFutureUsage: String, Codable {
    /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
    case onSession = "on_session"
    /// Use `off_session` if your customer may or may not be present in your checkout flow.
    case offSession = "off_session"
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: Bancontact
public struct SessionPaymentMethodBancontact: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsBancontactSetupFutureUsage?
    
    public init(setupFutureUsage: SessionPaymentMethodOptionsBancontactSetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsBancontactSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: Boleto
public struct SessionPaymentMethodOptionsBoleto: Codable {
    /// The number of calendar days before a Boleto voucher expires. For example, if you create a Boleto voucher on Monday and you set  `expires_after_days` to 2, the Boleto voucher will expire on Wednesday at 23:59 America/Sao_Paulo time.
    public var expiresAfterDays: Int?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsBoletoSetupFutureUsage?
    
    public init(expiresAfterDays: Int? = nil, setupFutureUsage: SessionPaymentMethodOptionsBoletoSetupFutureUsage? = nil) {
        self.expiresAfterDays = expiresAfterDays
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsBoletoSetupFutureUsage: String, Codable {
    /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
    case onSession = "on_session"
    /// Use `off_session` if your customer may or may not be present in your checkout flow.
    case offSession = "off_session"
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: Card
public struct SessionPaymentMethodCard: Codable {
    /// Additional fields for Installments configuration
    public var installments: SessionPaymentMethodCardInstallments?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsCardSetupFutureUsage?
    /// Provides information about a card payment that customers see on their statements. Concatenated with the Kana prefix (shortened Kana descriptor) or Kana statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters. On card statements, the concatenation of both prefix and suffix (including separators) will appear truncated to 22 characters.
    public var statementDescriptorSuffixKana: String?
    /// Provides information about a card payment that customers see on their statements. Concatenated with the Kanji prefix (shortened Kanji descriptor) or Kanji statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 17 characters. On card statements, the concatenation of both prefix and suffix (including separators) will appear truncated to 17 characters.
    public var statementDescriptorSuffixKanji: String?
    
    public init(installments: SessionPaymentMethodCardInstallments? = nil,
                setupFutureUsage: SessionPaymentMethodOptionsCardSetupFutureUsage? = nil,
                statementDescriptorSuffixKana: String? = nil,
                statementDescriptorSuffixKanji: String? = nil) {
        self.installments = installments
        self.setupFutureUsage = setupFutureUsage
        self.statementDescriptorSuffixKana = statementDescriptorSuffixKana
        self.statementDescriptorSuffixKanji = statementDescriptorSuffixKanji
    }
}

public struct SessionPaymentMethodCardInstallments: Codable {
    /// Indicates if installments are enabled
    public var enabled: Bool?
    
    public init(enabled: Bool? = nil) {
        self.enabled = enabled
    }
}

public enum SessionPaymentMethodOptionsCardSetupFutureUsage: String, Codable {
    /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
    case onSession = "on_session"
    /// Use `off_session` if your customer may or may not be present in your checkout flow.
    case offSession = "off_session"
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: Cashapp
public struct SessionPaymentMethodOptionsCashapp: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsCashappSetupFutureUsage?
    
    public init(setupFutureUsage: SessionPaymentMethodOptionsCashappSetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsCashappSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: Customer Balance
public struct SessionPaymentMethodOptionsCustomerBalance: Codable {
    /// Configuration for the bank transfer funding type, if the `funding_type` is set to `bank_transfer`.
    public var bankTransfer: SessionPaymentMethodOptionsCustomerBalanceBankTransfer?
    /// The funding method type to be used when there are not enough funds in the customer balance. Permitted values include: `bank_transfer`.
    public var fundingType: String?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsCustomerBalanceSetupFutureUsage?
    
    public init(bankTransfer: SessionPaymentMethodOptionsCustomerBalanceBankTransfer? = nil,
                fundingType: String? = nil,
                setupFutureUsage: SessionPaymentMethodOptionsCustomerBalanceSetupFutureUsage? = nil) {
        self.bankTransfer = bankTransfer
        self.fundingType = fundingType
        self.setupFutureUsage = setupFutureUsage
    }
}

public struct SessionPaymentMethodOptionsCustomerBalanceBankTransfer: Codable {
    /// Configuration for `eu_bank_transfer`
    public var euBankTransfer: SessionPaymentMethodOptionsCustomerBalanceBankTransferEuBankTransfer?
    /// List of address types that should be returned in the `financial_addresses` response. If not specified, all valid types will be returned.
    ///
    /// Permitted values include: `sort_code`, `zengin`, `iban`, or `spei`.
    public var requestedAddressTypes: [SessionPaymentMethodOptionsCustomerBalanceBankTransferRequestedAddressType]?
    /// The bank transfer type that this PaymentIntent is allowed to use for funding Permitted values include: `eu_bank_transfer`, `gb_bank_transfer`, `jp_bank_transfer`, or `mx_bank_transfer`.
    public var type: SessionPaymentMethodOptionsCustomerBalanceBankTransferType?
    
    public init(euBankTransfer: SessionPaymentMethodOptionsCustomerBalanceBankTransferEuBankTransfer? = nil,
                requestedAddressTypes: [SessionPaymentMethodOptionsCustomerBalanceBankTransferRequestedAddressType]? = nil,
                type: SessionPaymentMethodOptionsCustomerBalanceBankTransferType? = nil) {
        self.euBankTransfer = euBankTransfer
        self.requestedAddressTypes = requestedAddressTypes
        self.type = type
    }
}

public enum SessionPaymentMethodOptionsCustomerBalanceBankTransferRequestedAddressType: String, Codable {
    /// `sort_code` bank account address type
    case sortCode = "sort_code"
    /// `zengin` bank account address type
    case zengin
    /// `sepa` bank account address type
    case sepa
    /// `spei` bank account address type
    case spei
    /// `iban` bank account address type
    case iban
}

public enum SessionPaymentMethodOptionsCustomerBalanceBankTransferType: String, Codable {
    /// A bank transfer of type `eu_bank_transfer`
    case euBankTransfer = "eu_bank_transfer"
    /// A bank transfer of type `gb_bank_transfer`
    case gbBankTransfer = "gb_bank_transfer"
    /// A bank transfer of type `jp_bank_transfer`
    case jpBankTransfer = "jp_bank_transfer"
    /// A bank transfer of type `mx_bank_transfer`
    case mxBankTransfer = "mx_bank_transfer"
}


public struct SessionPaymentMethodOptionsCustomerBalanceBankTransferEuBankTransfer: Codable {
    /// The desired country code of the bank account information. Permitted values include: `BE`, `DE`, `ES`, `FR`, `IE`, or `NL`.
    public var country: String?
    
    public init(country: String? = nil) {
        self.country = country
    }
}

public enum SessionPaymentMethodOptionsCustomerBalanceSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: EPS
public struct SessionPaymentMethodOptionsEps: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsEpsSetupFutureUsage?
    
    public init(setupFutureUsage: SessionPaymentMethodOptionsEpsSetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsEpsSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: FPX
public struct SessionPaymentMethodOptionsFpx: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsFpxSetupFutureUsage?
    
    public init(setupFutureUsage: SessionPaymentMethodOptionsFpxSetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsFpxSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: Giropay
public struct SessionPaymentMethodOptionsGiropay: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsGiropaySetupFutureUsage?
    
    public init(setupFutureUsage: SessionPaymentMethodOptionsGiropaySetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsGiropaySetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: Grabpay
public struct SessionPaymentMethodOptionsGrabpay: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsGrabpaySetupFutureUsage?
    
    public init(setupFutureUsage: SessionPaymentMethodOptionsGrabpaySetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsGrabpaySetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: Ideal
public struct SessionPaymentMethodOptionsIdeal: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsIdealSetupFutureUsage?
    
    public init(setupFutureUsage: SessionPaymentMethodOptionsIdealSetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsIdealSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}


// MARK: Klarna
public struct SessionPaymentMethodOptionsKlarna: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsKlarnaSetupFutureUsage?
    
    public init(setupFutureUsage: SessionPaymentMethodOptionsKlarnaSetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsKlarnaSetupFutureUsage: String, Codable {
    /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
    case onSession = "on_session"
    /// Use `off_session` if your customer may or may not be present in your checkout flow.
    case offSession = "off_session"
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: Konbini
public struct SessionPaymentMethodOptionsKonbini: Codable {
    /// The number of calendar days (between 1 and 60) after which `Konbini` payment instructions will expire. For example, if a PaymentIntent is confirmed with `Konbini` and `expires_after_days` set to 2 on Monday JST, the instructions will expire on Wednesday 23:59:59 JST.
    public var expiresAfterDays: Int?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsKonbiniSetupFutureUsage?
    
    public init(expiresAfterDays: Int? = nil, setupFutureUsage: SessionPaymentMethodOptionsKonbiniSetupFutureUsage? = nil) {
        self.expiresAfterDays = expiresAfterDays
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsKonbiniSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: Link
public struct SessionPaymentMethodOptionsLink: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsLinkSetupFutureUsage?
    
    public init(setupFutureUsage: SessionPaymentMethodOptionsLinkSetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsLinkSetupFutureUsage: String, Codable {
    /// Use `off_session` if your customer may or may not be present in your checkout flow.
    case offSession = "off_session"
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: OXXO
public struct SessionPaymentMethodOptionsOXXO: Codable {
    /// The number of calendar days before an OXXO invoice expires. For example, if you create an OXXO invoice on Monday and you set `expires_after_days` to 2, the OXXO invoice will expire on Wednesday at 23:59 America/Mexico_City time.
    public var expiresAfterDays: Int?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsOXXOSetupFutureUsage?
    
    public init(expiresAfterDays: Int? = nil, setupFutureUsage: SessionPaymentMethodOptionsOXXOSetupFutureUsage? = nil) {
        self.expiresAfterDays = expiresAfterDays
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsOXXOSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: P24
public struct SessionPaymentMethodOptionsP24: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsP24SetupFutureUsage?
    
    public init(setupFutureUsage: SessionPaymentMethodOptionsP24SetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsP24SetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: Paynow
public struct SessionPaymentMethodOptionsPaynow: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsPaynowSetupFutureUsage?
    
    public init(setupFutureUsage: SessionPaymentMethodOptionsPaynowSetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsPaynowSetupFutureUsage: String, Codable {
    /// Use `off_session` if your customer may or may not be present in your checkout flow.
    case offSession = "off_session"
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: Pix
public struct SessionPaymentMethodOptionsPix: Codable {
    /// The number of seconds after which Pix payment will expire.
    public var expiresAfterSeconds: Int?
    
    public init(expiresAfterSeconds: Int? = nil) {
        self.expiresAfterSeconds = expiresAfterSeconds
    }
}

// MARK: SepaDebit
public struct SessionPaymentMethodOptionsSepaDebit: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsSepaDebitSetupFutureUsage?
    
    public init(setupFutureUsage: SessionPaymentMethodOptionsSepaDebitSetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsSepaDebitSetupFutureUsage: String, Codable {
    /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
    case onSession = "on_session"
    /// Use `off_session` if your customer may or may not be present in your checkout flow.
    case offSession = "off_session"
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: Sofort
public struct SessionPaymentMethodOptionsSofort: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsSofortSetupFutureUsage?
    
    public init(setupFutureUsage: SessionPaymentMethodOptionsSofortSetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum SessionPaymentMethodOptionsSofortSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: US Bank Account
public struct SessionPaymentMethodOptionsUSBankAccount: Codable {
    /// Additional fields for Financial Connections Session creation
    public var financialConnections: SessionPaymentMethodOptionsUSBankAccountFinancialConnections?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    /// Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    public var setupFutureUsage: SessionPaymentMethodOptionsUSBankAccountSetupFutureUsage?
    /// Bank account verification method.
    public var verificationMethod: SessionPaymentMethodOptionsUSBankAccountVerificationMethod?
    
    public init(financialConnections: SessionPaymentMethodOptionsUSBankAccountFinancialConnections? = nil,
                setupFutureUsage: SessionPaymentMethodOptionsUSBankAccountSetupFutureUsage? = nil,
                verificationMethod: SessionPaymentMethodOptionsUSBankAccountVerificationMethod? = nil) {
        self.financialConnections = financialConnections
        self.setupFutureUsage = setupFutureUsage
        self.verificationMethod = verificationMethod
    }
}

public struct SessionPaymentMethodOptionsUSBankAccountFinancialConnections: Codable {
    /// The list of permissions to request. The p`ayment_method` permission must be included.
    public var permissions: [SessionPaymentMethodOptionsUSBankAccountFinancialConnectionsPermission]?
    
    public init(permissions: [SessionPaymentMethodOptionsUSBankAccountFinancialConnectionsPermission]? = nil) {
        self.permissions = permissions
    }
}

public enum SessionPaymentMethodOptionsUSBankAccountFinancialConnectionsPermission: String, Codable {
    /// Allows the creation of a payment method from the account.
    case paymentMethod = "payment_method"
    /// Allows accessing balance data from the account.
    case balances
    /// Allows accessing transactions data from the account.
    case transactions
    /// Allows accessing ownership data from the account.
    case ownership
}

public enum SessionPaymentMethodOptionsUSBankAccountSetupFutureUsage: String, Codable {
    /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
    case onSession = "on_session"
    /// Use `off_session` if your customer may or may not be present in your checkout flow.
    case offSession = "off_session"
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

public enum SessionPaymentMethodOptionsUSBankAccountVerificationMethod: String, Codable {
    /// Instant verification with fallback to microdeposits.
    case automatic
    /// Instant verification only.
    case instant
}
