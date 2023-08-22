//
//  File.swift
//  
//
//  Created by Andrew Edwards on 3/9/23.
//

import Foundation

// MARK: - ACSS Debit
public struct PaymentIntentPaymentMethodOptionsAcssDebit: Codable {
    /// Additional fields for Mandate creation
    public var mandateOptions: PaymentIntentPaymentMethodOptionsAcssDebitMandateOptions?
    /// Bank account verification method.
    public var verificationMethod: PaymentIntentPaymentMethodOptionsAcssDebitVerificationMethod?
    
    public init(mandateOptions: PaymentIntentPaymentMethodOptionsAcssDebitMandateOptions? = nil,
                verificationMethod: PaymentIntentPaymentMethodOptionsAcssDebitVerificationMethod? = nil) {
        self.mandateOptions = mandateOptions
        self.verificationMethod = verificationMethod
    }
}

public struct PaymentIntentPaymentMethodOptionsAcssDebitMandateOptions: Codable {
    /// A URL for custom mandate text
    public var customMandateUrl: String?
    /// Description of the interval. Only required if `payment_schedule` parmeter is `interval` or `combined`.
    public var intervalDescription: String?
    /// Payment schedule for the mandate.
    public var paymentSchedule: PaymentIntentPaymentMethodOptionsAcssDebitMandateOptionsPaymentSchedule?
    /// Transaction type of the mandate.
    public var transactionType: PaymentIntentPaymentMethodOptionsAcssDebitMandateOptionsTransactionType?
    
    public init(customMandateUrl: String? = nil,
                intervalDescription: String? = nil,
                paymentSchedule: PaymentIntentPaymentMethodOptionsAcssDebitMandateOptionsPaymentSchedule? = nil,
                transactionType: PaymentIntentPaymentMethodOptionsAcssDebitMandateOptionsTransactionType? = nil) {
        self.customMandateUrl = customMandateUrl
        self.intervalDescription = intervalDescription
        self.paymentSchedule = paymentSchedule
        self.transactionType = transactionType
    }
}

public enum PaymentIntentPaymentMethodOptionsAcssDebitMandateOptionsPaymentSchedule: String, Codable {
    /// Payments are initiated at a regular pre-defined interval
    case interval
    /// Payments are initiated sporadically
    case sporadic
    /// Payments can be initiated at a pre-defined interval or sporadically
    case combined
}

public enum PaymentIntentPaymentMethodOptionsAcssDebitMandateOptionsTransactionType: String, Codable {
    /// Transactions are made for personal reasons
    case personal
    /// Transactions are made for business reasons
    case business
}

public enum PaymentIntentPaymentMethodOptionsAcssDebitVerificationMethod: String, Codable {
    /// Instant verification with fallback to microdeposits.
    case automatic
    /// Instant verification.
    case instant
    /// Verification using microdeposits.
    case microdeposits
}

// MARK: - Affirm
public struct PaymentIntentPaymentMethodOptionsAffirm: Codable {
    /// Controls when the funds will be captured from the customer’s account.
    public var captureMethod: PaymentIntentPaymentMethodOptionsAffirmCaptureMethod?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsAffirmSetupFutureUsage?
    
    public init(captureMethod: PaymentIntentPaymentMethodOptionsAffirmCaptureMethod? = nil,
                setupFutureUsage: PaymentIntentPaymentMethodOptionsAffirmSetupFutureUsage? = nil) {
        self.captureMethod = captureMethod
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsAffirmCaptureMethod: String, Codable {
    /// Use manual if you intend to place the funds on hold and want to override the top-level `capture_method` value for this payment method.
    case manual
}

public enum PaymentIntentPaymentMethodOptionsAffirmSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case none
}

// MARK: - Afterpay Clearpay
public struct PaymentIntentPaymentMethodOptionsAfterpayClearpay: Codable {
    /// Controls when the funds will be captured from the customer’s account.
    public var captureMethod: PaymentIntentPaymentMethodOptionsAfterpayClearpayCaptureMethod?
    /// Order identifier shown to the merchant in Afterpay’s online portal. We recommend using a value that helps you answer any questions a customer might have about the payment. The identifier is limited to 128 characters and may contain only letters, digits, underscores, backslashes and dashes.
    public var reference: String?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsAfterpayClearpaySetupFutureUsage?
    
    public init(captureMethod: PaymentIntentPaymentMethodOptionsAfterpayClearpayCaptureMethod? = nil,
                reference: String? = nil,
                setupFutureUsage: PaymentIntentPaymentMethodOptionsAfterpayClearpaySetupFutureUsage? = nil) {
        self.captureMethod = captureMethod
        self.reference = reference
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsAfterpayClearpayCaptureMethod: String, Codable {
    /// Use manual if you intend to place the funds on hold and want to override the top-level `capture_method` value for this payment method.
    case manual
}

public enum PaymentIntentPaymentMethodOptionsAfterpayClearpaySetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case none
}

// MARK: - Alipay
public struct PaymentIntentPaymentMethodOptionsAlipay: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsAlipaySetupFutureUsage?
    
    public init(setupFutureUsage: PaymentIntentPaymentMethodOptionsAlipaySetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsAlipaySetupFutureUsage: String, Codable {
    /// Use `off_session` if your customer may or may not be present in your checkout flow.
    case offSession = "off_session"
    /// Use none if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: - AU Becs Debit
public struct PaymentIntentPaymentMethodOptionsAUBecsDebit: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsAUBecsDebitSetupFutureUsage?
    
    public init(setupFutureUsage: PaymentIntentPaymentMethodOptionsAUBecsDebitSetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsAUBecsDebitSetupFutureUsage: String, Codable {
    /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
    case onSession = "on_session"
    /// Use `off_session` if your customer may or may not be present in your checkout flow.
    case offSession = "off_session"
    /// Use none if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: - Bacs Debit
public struct PaymentIntentPaymentMethodOptionsBacsDebit: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsBacsDebitSetupFutureUsage?
    
    public init(setupFutureUsage: PaymentIntentPaymentMethodOptionsBacsDebitSetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsBacsDebitSetupFutureUsage: String, Codable {
    /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
    case onSession = "on_session"
    /// Use `off_session` if your customer may or may not be present in your checkout flow.
    case offSession = "off_session"
    /// Use none if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: - Bancontact
public struct PaymentIntentPaymentMethodOptionsBancontact: Codable {
    /// Preferred language of the Bancontact authorization page that the customer is redirected to.
    public var preferredLanguage: String?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsBancontactSetupFutureUsage?
    
    public init(preferredLanguage: String? = nil,
                setupFutureUsage: PaymentIntentPaymentMethodOptionsBancontactSetupFutureUsage? = nil) {
        self.preferredLanguage = preferredLanguage
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsBancontactSetupFutureUsage: String, Codable {
    /// Use `off_session` if your customer may or may not be present in your checkout flow.
    case offSession = "off_session"
    /// Use none if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: - Blik
public struct PaymentIntentPaymentMethodOptionsBlik: Codable {
    public init() { }
}

// MARK: - Boleto
public struct PaymentIntentPaymentMethodOptionsBoleto: Codable {
    /// The number of calendar days before a Boleto voucher expires. For example, if you create a Boleto voucher on Monday and you set `expires_after_days` to 2, the Boleto voucher will expire on Wednesday at 23:59 `America/Sao_Paulo` time.
    public var expiresAfterDays: Int?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsBoletoSetupFutureUsage?

    public init(expiresAfterDays: Int? = nil,
                setupFutureUsage: PaymentIntentPaymentMethodOptionsBoletoSetupFutureUsage? = nil) {
        self.expiresAfterDays = expiresAfterDays
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsBoletoSetupFutureUsage: String, Codable {
    /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
    case onSession = "on_session"
    /// Use `off_session` if your customer may or may not be present in your checkout flow.
    case offSession = "off_session"
    /// Use none if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: - Card
public struct PaymentIntentPaymentMethodOptionsCard: Codable {
    /// Controls when the funds will be captured from the customer’s account.
    public var captureMethod: PaymentIntentPaymentMethodOptionsCardCaptureMethod?
    /// Installment details for this payment (Mexico only). For more information, see the installments integration guide.
    public var installments: PaymentIntentPaymentMethodOptionsCardInstallments?
    /// Configuration options for setting up an eMandate for cards issued in India.
    public var mandateOptions: PaymentIntentPaymentMethodOptionsCardMandateOptions?
    /// Selected network to process this PaymentIntent on. Depends on the available networks of the card attached to the PaymentIntent. Can be only set confirm-time.
    public var network: String?
    /// We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and [other requirements](https://stripe.com/docs/strong-customer-authentication). However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. Permitted values include: `automatic` or `any`. If not provided, defaults to `automatic`. Read our guide on [manually requesting 3D Secure](https://stripe.com/docs/payments/3d-secure#manual-three-ds) for more information on how this configuration interacts with Radar and our SCA Engine.
    public var requestThreeDSecure: String?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsCardSetupFutureUsage?
    /// Provides information about a card payment that customers see on their statements. Concatenated with the Kana prefix (shortened Kana descriptor) or Kana statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters. On card statements, the concatenation of both prefix and suffix (including separators) will appear truncated to 22 characters.
    public var statementDescriptorSuffixKana: String?
    /// Provides information about a card payment that customers see on their statements. Concatenated with the Kanji prefix (shortened Kanji descriptor) or Kanji statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 17 characters. On card statements, the concatenation of both prefix and suffix (including separators) will appear truncated to 17 characters.
    public var statementDescriptorSuffixKanji: String?
    
    public init(captureMethod: PaymentIntentPaymentMethodOptionsCardCaptureMethod? = nil,
                installments: PaymentIntentPaymentMethodOptionsCardInstallments? = nil,
                mandateOptions: PaymentIntentPaymentMethodOptionsCardMandateOptions? = nil,
                network: String? = nil,
                requestThreeDSecure: String? = nil,
                setupFutureUsage: PaymentIntentPaymentMethodOptionsCardSetupFutureUsage? = nil,
                statementDescriptorSuffixKana: String? = nil,
                statementDescriptorSuffixKanji: String? = nil) {
        self.captureMethod = captureMethod
        self.installments = installments
        self.mandateOptions = mandateOptions
        self.network = network
        self.requestThreeDSecure = requestThreeDSecure
        self.setupFutureUsage = setupFutureUsage
        self.statementDescriptorSuffixKana = statementDescriptorSuffixKana
        self.statementDescriptorSuffixKanji = statementDescriptorSuffixKanji
    }
}

public enum PaymentIntentPaymentMethodOptionsCardCaptureMethod: String, Codable {
    /// Use `manual` if you intend to place the funds on hold and want to override the top-level `capture_method` value for this payment method.
    case manual
}

public struct PaymentIntentPaymentMethodOptionsCardInstallments: Codable {
    /// Installment plans that may be selected for this PaymentIntent.
    public var availablePlans: [PaymentIntentPaymentMethodOptionsCardInstallmentPlan]?
    /// Whether Installments are enabled for this PaymentIntent.
    public var enabled: Bool?
    /// Installment plan selected for this PaymentIntent.
    public var plan: PaymentIntentPaymentMethodOptionsCardInstallmentPlan?
    
    public init(availablePlans: [PaymentIntentPaymentMethodOptionsCardInstallmentPlan]? = nil,
                enabled: Bool? = nil,
                plan: PaymentIntentPaymentMethodOptionsCardInstallmentPlan? = nil) {
        self.availablePlans = availablePlans
        self.enabled = enabled
        self.plan = plan
    }
}

public struct PaymentIntentPaymentMethodOptionsCardInstallmentPlan: Codable {
    /// For `fixed_count` installment plans, this is the number of installment payments your customer will make to their credit card.
    public var count: Int?
    /// For `fixed_count` installment plans, this is the interval between installment payments your customer will make to their credit card. One of `month`.
    public var interval: String?
    /// Type of installment plan, one of `fixed_count`.
    public var type: String?
    
    public init(count: Int? = nil,
                interval: String? = nil,
                type: String? = nil) {
        self.count = count
        self.interval = interval
        self.type = type
    }
}

public struct PaymentIntentPaymentMethodOptionsCardMandateOptions: Codable {
    /// Amount to be charged for future payments.
    public var amount: Int?
    /// One of `fixed` or `maximum`. If `fixed`, the `amount` param refers to the exact amount to be charged in future payments. If `maximum`, the amount charged can be up to the value passed for the `amount` param.
    public var amountType: String?
    /// A description of the mandate or subscription that is meant to be displayed to the customer.
    public var description: String?
    /// End date of the mandate or subscription. If not provided, the mandate will be active until canceled. If provided, end date should be after start date.
    public var endDate: Date?
    /// Specifies payment frequency. One of `day`, `week`, `month`, `year`, or `sporadic`.
    public var interval: String?
    /// The number of intervals between payments. For example, `interval=month` and `interval_count=3` indicates one payment every three months. Maximum of one year interval allowed (1 year, 12 months, or 52 weeks). This parameter is optional when `interval=sporadic`.
    public var intervalCount: Int?
    /// Unique identifier for the mandate or subscription.
    public var reference: String?
    /// Start date of the mandate or subscription. Start date should not be lesser than yesterday.
    public var startDate: Date?
    /// Specifies the type of mandates supported. Possible values are `india`.
    public var supportedTypes: [String]?
    
    public init(amount: Int? = nil,
                amountType: String? = nil,
                description: String? = nil,
                endDate: Date? = nil,
                interval: String? = nil,
                intervalCount: Int? = nil,
                reference: String? = nil,
                startDate: Date? = nil,
                supportedTypes: [String]? = nil) {
        self.amount = amount
        self.amountType = amountType
        self.description = description
        self.endDate = endDate
        self.interval = interval
        self.intervalCount = intervalCount
        self.reference = reference
        self.startDate = startDate
        self.supportedTypes = supportedTypes
    }
}

public enum PaymentIntentPaymentMethodOptionsCardSetupFutureUsage: String, Codable {
    /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
    case onSession = "on_session"
    /// Use `off_session` if your customer may or may not be present in your checkout flow.
    case offSession = "off_session"
    /// Use none if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: - Card present
public struct PaymentIntentPaymentMethodOptionsCardPresent: Codable {
    /// Controls when the funds will be captured from the customer’s account.
    public var captureMethod: PaymentIntentPaymentMethodOptionsCardPresentCaptureMethod?
    /// Request ability to capture this payment beyond the standard [authorization validity window](https://stripe.com/docs/terminal/features/extended-authorizations#authorization-validity)
    public var requestExtendedAuthorization: Bool?
    /// Request ability to [increment](https://stripe.com/docs/terminal/features/incremental-authorizations) this PaymentIntent if the combination of MCC and card brand is eligible. Check [incremental_authorization_supported](https://stripe.com/docs/api/charges/object#charge_object-payment_method_details-card_present-incremental_authorization_supported) in the [Confirm](https://stripe.com/docs/api/payment_intents/confirm) response to verify support
    public var requestIncrementalAuthorizationSupport: Bool?
    /// Network routing priority on co-branded EMV cards supporting domestic debit and international card schemes.
    public var routing: PaymentIntentPaymentMethodOptionsCardPresentRouting?
    
    public init(captureMethod: PaymentIntentPaymentMethodOptionsCardPresentCaptureMethod? = nil,
                requestExtendedAuthorization: Bool? = nil,
                requestIncrementalAuthorizationSupport: Bool? = nil,
                routing: PaymentIntentPaymentMethodOptionsCardPresentRouting? = nil) {
        self.captureMethod = captureMethod
        self.requestExtendedAuthorization = requestExtendedAuthorization
        self.requestIncrementalAuthorizationSupport = requestIncrementalAuthorizationSupport
        self.routing = routing
    }
}

public enum PaymentIntentPaymentMethodOptionsCardPresentCaptureMethod: String, Codable {
    /// Use `manual_preferred` if you prefer manual `capture_method` but support falling back to automatic based on the presented payment method.
    case manualPreferred = "manual_preferred"
}

public struct PaymentIntentPaymentMethodOptionsCardPresentRouting: Codable {
    /// Requested routing priority
    public var requestedPriority: PaymentIntentPaymentMethodOptionsCardPresentRoutingRequestedPriority?
    
    public init(requestedPriority: PaymentIntentPaymentMethodOptionsCardPresentRoutingRequestedPriority? = nil) {
        self.requestedPriority = requestedPriority
    }
}

public enum PaymentIntentPaymentMethodOptionsCardPresentRoutingRequestedPriority: String, Codable {
    /// Prioritize domestic debit network routing on payment method collection
    case domestic
    /// Prioritize international network routing on payment method collection
    case international
}

// MARK: - Customer Balance
public struct PaymentIntentPaymentMethodOptionsCustomerBalance: Codable {
    /// Configuration for the bank transfer funding type, if the `funding_type` is set to `bank_transfer`.
    public var bankTransfer: PaymentIntentPaymentMethodOptionsCustomerBalanceBankTransfer?
    /// The funding method type to be used when there are not enough funds in the customer balance. Permitted values include: `bank_transfer`.
    public var fundingType: String?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsCustomerBalanceSetupFutureUsage?
    
    public init(bankTransfer: PaymentIntentPaymentMethodOptionsCustomerBalanceBankTransfer? = nil,
                fundingType: String? = nil,
                setupFutureUsage: PaymentIntentPaymentMethodOptionsCustomerBalanceSetupFutureUsage? = nil) {
        self.bankTransfer = bankTransfer
        self.fundingType = fundingType
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsCustomerBalanceSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

public struct PaymentIntentPaymentMethodOptionsCustomerBalanceBankTransfer: Codable {
    /// Configuration for `eu_bank_transfer`
    public var euBankTransfer: PaymentIntentPaymentMethodOptionsCustomerBalanceBankTransferEUBankTransfer?
    /// List of address types that should be returned in the `financial_addresses` response. If not specified, all valid types will be returned.
    ///
    /// Permitted values include: `sort_code`, `zengin`, `iban`, or `spei`.
    public var requestedAddressTypes: PaymentIntentPaymentMethodOptionsCustomerBalanceBankTransferRequestedAddressType?
    /// The bank transfer type that this PaymentIntent is allowed to use for funding Permitted values include: `eu_bank_transfer`, `gb_bank_transfer`, `jp_bank_transfer`, or `mx_bank_transfer`.
    public var type: PaymentIntentPaymentMethodOptionsCustomerBalanceBankTransferType?
    
    public init(euBankTransfer: PaymentIntentPaymentMethodOptionsCustomerBalanceBankTransferEUBankTransfer? = nil,
                requestedAddressTypes: PaymentIntentPaymentMethodOptionsCustomerBalanceBankTransferRequestedAddressType? = nil,
                type: PaymentIntentPaymentMethodOptionsCustomerBalanceBankTransferType? = nil) {
        self.euBankTransfer = euBankTransfer
        self.requestedAddressTypes = requestedAddressTypes
        self.type = type
    }
}

public struct PaymentIntentPaymentMethodOptionsCustomerBalanceBankTransferEUBankTransfer: Codable {
    /// The desired country code of the bank account information. Permitted values include: `BE`, `DE`, `ES`, `FR`, `IE`, or `NL`.
    public var country: String?
    
    public init(country: String? = nil) {
        self.country = country
    }
}

public enum PaymentIntentPaymentMethodOptionsCustomerBalanceBankTransferRequestedAddressType: String, Codable {
    /// `sort_code` bank account address type
    case sortCode = "sort_code"
    /// zengin bank account address type
    case zengin
    /// sepa bank account address type
    case sepa
    /// spei bank account address type
    case spei
    /// iban bank account address type
    case iban
}

public enum PaymentIntentPaymentMethodOptionsCustomerBalanceBankTransferType: String, Codable {
    /// A bank transfer of type `eu_bank_transfer`
    case euBankTransfer = "eu_bank_transfer"
    /// A bank transfer of type `gb_bank_transfer`
    case gbBankTransfer = "gb_bank_transfer"
    /// A bank transfer of type `jp_bank_transfer`
    case jpBankTransfer = "jp_bank_transfer"
    /// A bank transfer of type `mx_bank_transfer`
    case mxBankTransfer = "mx_bank_transfer"
}

// MARK: - EPS
public struct PaymentIntentPaymentMethodOptionsEPS: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsEPSSetupFutureUsage?
    
    public init(setupFutureUsage: PaymentIntentPaymentMethodOptionsEPSSetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsEPSSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: - FPX
public struct PaymentIntentPaymentMethodOptionsFPX: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsFPXSetupFutureUsage?
    
    public init(setupFutureUsage: PaymentIntentPaymentMethodOptionsFPXSetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsFPXSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: - Giropay
public struct PaymentIntentPaymentMethodOptionsGiropay: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsGiropaySetupFutureUsage?
    
    public init(setupFutureUsage: PaymentIntentPaymentMethodOptionsGiropaySetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsGiropaySetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: - GrabPay
public struct PaymentIntentPaymentMethodOptionsGrabPay: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsGrabPaySetupFutureUsage?
    
    public init(setupFutureUsage: PaymentIntentPaymentMethodOptionsGrabPaySetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsGrabPaySetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: - Ideal
public struct PaymentIntentPaymentMethodOptionsIdeal: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsIdealSetupFutureUsage?
    
    public init(setupFutureUsage: PaymentIntentPaymentMethodOptionsIdealSetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsIdealSetupFutureUsage: String, Codable {
    /// Use `off_session` if your customer may or may not be present in your checkout flow
    case offSession = "off_session"
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: - InteracPresent
public struct PaymentIntentPaymentMethodOptionsInteracPresent: Codable {
    public init() { }
}

// MARK: - Klarna
public struct PaymentIntentPaymentMethodOptionsKlarna: Codable {
    /// Controls when the funds will be captured from the customer’s account.
    public var captureMethod: PaymentIntentPaymentMethodOptionsKlarnaCaptureMethod?
    /// Preferred locale of the Klarna checkout page that the customer is redirected to.
    public var preferredLocale: String?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsKlarnaSetupFutureUsage?
    
    public init(captureMethod: PaymentIntentPaymentMethodOptionsKlarnaCaptureMethod? = nil,
                preferredLocale: String? = nil,
                setupFutureUsage: PaymentIntentPaymentMethodOptionsKlarnaSetupFutureUsage? = nil) {
        self.captureMethod = captureMethod
        self.preferredLocale = preferredLocale
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsKlarnaCaptureMethod: String, Codable {
    /// Use manual if you intend to place the funds on hold and want to override the top-level `capture_method` value for this payment method.
    case manual
}

public enum PaymentIntentPaymentMethodOptionsKlarnaSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: - Konbini
public struct PaymentIntentPaymentMethodOptionsKonbini: Codable {
    /// An optional 10 to 11 digit numeric-only string determining the confirmation code at applicable convenience stores.
    public var confirmationNumber: String?
    /// The number of calendar days (between 1 and 60) after which Konbini payment instructions will expire. For example, if a PaymentIntent is confirmed with Konbini and `expires_after_days` set to 2 on Monday JST, the instructions will expire on Wednesday 23:59:59 JST.
    public var expiringAfterdays: Int?
    /// The timestamp at which the Konbini payment instructions will expire. Only one of `expires_after_days` or `expires_at` may be set.
    public var expiresAt: Date?
    /// A product descriptor of up to 22 characters, which will appear to customers at the convenience store.
    public var productDescription: String?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsKonbiniSetupFutureUsage?
    
    public init(confirmationNumber: String? = nil,
                expiringAfterdays: Int? = nil,
                expiresAt: Date? = nil,
                productDescription: String? = nil,
                setupFutureUsage: PaymentIntentPaymentMethodOptionsKonbiniSetupFutureUsage? = nil) {
        self.confirmationNumber = confirmationNumber
        self.expiringAfterdays = expiringAfterdays
        self.expiresAt = expiresAt
        self.productDescription = productDescription
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsKonbiniSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: - Link
public struct PaymentIntentPaymentMethodOptionsLink: Codable {
    /// Controls when the funds will be captured from the customer’s account.
    public var captureMethod: PaymentIntentPaymentMethodOptionsLinkCaptureMethod?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsLinkSetupFutureUsage?
    
    public init(captureMethod: PaymentIntentPaymentMethodOptionsLinkCaptureMethod? = nil,
                setupFutureUsage: PaymentIntentPaymentMethodOptionsLinkSetupFutureUsage? = nil) {
        self.captureMethod = captureMethod
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsLinkCaptureMethod: String, Codable {
    /// Use manual if you intend to place the funds on hold and want to override the top-level `capture_method` value for this payment method.
    case manual
}

public enum PaymentIntentPaymentMethodOptionsLinkSetupFutureUsage: String, Codable {
    /// Use `off_session` if your customer may or may not be present in your checkout flow
    case offSession = "off_session"
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: - OXXO
public struct PaymentIntentPaymentMethodOptionsOXXO: Codable {
    /// The number of calendar days before an OXXO invoice expires. For example, if you create an OXXO invoice on Monday and you set `expires_after_days` to 2, the OXXO invoice will expire on Wednesday at 23:59 America/Mexico_City time.
    public var expiresAfterDays: Int?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsOXXOSetupFutureUsage?
    
    public init(expiresAfterDays: Int? = nil, setupFutureUsage: PaymentIntentPaymentMethodOptionsOXXOSetupFutureUsage? = nil) {
        self.expiresAfterDays = expiresAfterDays
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsOXXOSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: - P24
public struct PaymentIntentPaymentMethodOptionsP24: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsP24SetupFutureUsage?
    
    public init(setupFutureUsage: PaymentIntentPaymentMethodOptionsP24SetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsP24SetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: - Paynow
public struct PaymentIntentPaymentMethodOptionsPaynow: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsPaynowSetupFutureUsage?
    
    public init(setupFutureUsage: PaymentIntentPaymentMethodOptionsPaynowSetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsPaynowSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: - Pix
public struct PaymentIntentPaymentMethodOptionsPix: Codable {
    /// The number of seconds (between 10 and 1209600) after which Pix payment will expire.
    public var expiresAfterSeconds: Int?
    /// The timestamp at which the Pix expires.
    public var expiresAt: Int?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsPixSetupFutureUsage?
    
    public init(expiresAfterSeconds: Int? = nil,
                expiresAt: Int? = nil,
                setupFutureUsage: PaymentIntentPaymentMethodOptionsPixSetupFutureUsage? = nil) {
        self.expiresAfterSeconds = expiresAfterSeconds
        self.expiresAt = expiresAt
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsPixSetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}


// MARK: - PromptPay
public struct PaymentIntentPaymentMethodOptionsPromptPay: Codable {
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsPromptPaySetupFutureUsage?
    
    public init(setupFutureUsage: PaymentIntentPaymentMethodOptionsPromptPaySetupFutureUsage? = nil) {
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsPromptPaySetupFutureUsage: String, Codable {
    /// Use `none` if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: SepaDebit
public struct PaymentIntentPaymentMethodOptionsSepaDebit: Codable {
    /// Additional fields for Mandate creation
    public var mandateOptions: PaymentIntentPaymentMethodOptionsSepaDebitMandateOptions?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsSepaDebitSetupFutureUsage?
}

public struct PaymentIntentPaymentMethodOptionsSepaDebitMandateOptions: Codable {
    public init() {}
}

public enum PaymentIntentPaymentMethodOptionsSepaDebitSetupFutureUsage: String, Codable {
    /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
    case onSession = "on_session"
    /// Use `off_session` if your customer may or may not be present in your checkout flow.
    case offSession = "off_session"
    /// Use none if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: - Sofort
public struct PaymentIntentPaymentMethodOptionsSofort: Codable {
    /// Preferred language of the SOFORT authorization page that the customer is redirected to.
    public var preferredLanguage: String?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsSofortSetupFutureUsage?
    
    public init(preferredLanguage: String? = nil,
                setupFutureUsage: PaymentIntentPaymentMethodOptionsSofortSetupFutureUsage? = nil) {
        self.preferredLanguage = preferredLanguage
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsSofortSetupFutureUsage: String, Codable {
    /// Use `off_session` if your customer may or may not be present in your checkout flow.
    case offSession = "off_session"
    /// Use none if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

// MARK: - US Bank Account
public struct PaymentIntentPaymentMethodOptionsUSBankAccount: Codable {
    /// Additional fields for Financial Connections Session creation
    public var financialConnections: PaymentIntentPaymentMethodOptionsUSBankAccountFinancialConnections?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsUSBankAccountSetupFutureUsage?
    /// Bank account verification method.
    public var verificationMethod: PaymentIntentPaymentMethodOptionsUSBankAccountVerificationMethod?
    
    public init(financialConnections: PaymentIntentPaymentMethodOptionsUSBankAccountFinancialConnections? = nil,
                setupFutureUsage: PaymentIntentPaymentMethodOptionsUSBankAccountSetupFutureUsage? = nil,
                verificationMethod: PaymentIntentPaymentMethodOptionsUSBankAccountVerificationMethod? = nil) {
        self.financialConnections = financialConnections
        self.setupFutureUsage = setupFutureUsage
        self.verificationMethod = verificationMethod
    }
}

public struct PaymentIntentPaymentMethodOptionsUSBankAccountFinancialConnections: Codable {
    /// The list of permissions to request. The `payment_method` permission must be included.
    public var permissions: [PaymentIntentPaymentMethodOptionsUSBankAccountFinancialConnectionsPermission]?
    
    public init(permissions: [PaymentIntentPaymentMethodOptionsUSBankAccountFinancialConnectionsPermission]? = nil) {
        self.permissions = permissions
    }
}

public enum PaymentIntentPaymentMethodOptionsUSBankAccountFinancialConnectionsPermission: String, Codable {
    /// Allows the creation of a payment method from the account.
    case paymentMethod = "payment_method"
    /// Allows accessing balance data from the account.
    case balances
    /// Allows accessing transactions data from the account.
    case transactions
    /// Allows accessing ownership data from the account
    case ownership
}

public enum PaymentIntentPaymentMethodOptionsUSBankAccountSetupFutureUsage: String, Codable {
    /// Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow.
    case onSession = "on_session"
    /// Use `off_session` if your customer may or may not be present in your checkout flow.
    case offSession = "off_session"
    /// Use none if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}

public enum PaymentIntentPaymentMethodOptionsUSBankAccountVerificationMethod: String, Codable {
    /// Instant verification with fallback to microdeposits.
    case automatic
    /// Instant verification only.
    case instant
    /// Verification using microdeposits. Cannot be used with Stripe Checkout or Hosted Invoices.
    case microdeposits
}

// MARK: - WechatPay
public struct PaymentIntentPaymentMethodOptionsWechatPay: Codable {
    /// The app ID registered with WeChat Pay. Only required when client is ios or android.
    public var appId: String?
    /// The client type that the end customer will pay from
    public var client: PaymentIntentPaymentMethodOptionsWechatPayClient?
    /// Indicates that you intend to make future payments with this PaymentIntent’s payment method.
    ///
    ///Providing this parameter will [attach the payment](https://stripe.com/docs/payments/save-during-payment) method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be [attached](https://stripe.com/docs/api/payment_methods/attach) to a Customer after the transaction completes.
    ///
    /// When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as [SCA](https://stripe.com/docs/strong-customer-authentication) .
    public var setupFutureUsage: PaymentIntentPaymentMethodOptionsWechatPaySetupFutureUsage?
    
    public init(appId: String? = nil,
                client: PaymentIntentPaymentMethodOptionsWechatPayClient? = nil,
                setupFutureUsage: PaymentIntentPaymentMethodOptionsWechatPaySetupFutureUsage? = nil) {
        self.appId = appId
        self.client = client
        self.setupFutureUsage = setupFutureUsage
    }
}

public enum PaymentIntentPaymentMethodOptionsWechatPayClient: String, Codable {
    /// The end customer will pay from web browser
    case web
    /// The end customer will pay from an iOS app
    case ios
    /// The end customer will pay from an Android app
    case android
}

public enum PaymentIntentPaymentMethodOptionsWechatPaySetupFutureUsage: String, Codable {
    /// Use none if you do not intend to reuse this payment method and want to override the top-level `setup_future_usage` value for this payment method.
    case `none`
}
