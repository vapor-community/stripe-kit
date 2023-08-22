//
//  SetupIntentPaymentMethods.swift
//  
//
//  Created by Andrew Edwards on 4/29/23.
//

import Foundation

public struct SetupIntentPaymentMethodOptions: Codable {
    /// If the SetupIntent’s `payment_method_types` includes `acss_debit`, this hash contains the configurations that will be applied to each setup attempt of that type.
    public var acssDebit: SetupIntentPaymentMethodOptionsAcssDebit?
    /// If the SetupIntent’s `payment_method_types` includes `blik`, this hash contains the configurations that will be applied to each setup attempt of that type.
    public var blik: SetupIntentPaymentMethodOptionsBlik?
    /// If the SetupIntent’s `payment_method_types` includes `card`, this hash contains the configurations that will be applied to each setup attempt of that type.
    public var card: SetupIntentPaymentMethodOptionsCard?
    /// If the SetupIntent’s `payment_method_types` includes `link`, this hash contains the configurations that will be applied to each setup attempt of that type.
    public var link: SetupIntentPaymentMethodOptionsLink?
    /// If the SetupIntent’s `payment_method_types` includes `sepa_debit`, this hash contains the configurations that will be applied to each setup attempt of that type.
    public var sepaDebit: SetupIntentPaymentMethodOptionsSepaDebit?
    /// If the SetupIntent’s `payment_method_types` includes `us_bank_account`, this hash contains the configurations that will be applied to each setup attempt of that type.
    public var usBankAccount: SetupIntentPaymentMethodOptionsUSBankAccount?
    
    public init(acssDebit: SetupIntentPaymentMethodOptionsAcssDebit? = nil,
                blik: SetupIntentPaymentMethodOptionsBlik? = nil,
                card: SetupIntentPaymentMethodOptionsCard? = nil,
                link: SetupIntentPaymentMethodOptionsLink? = nil,
                sepaDebit: SetupIntentPaymentMethodOptionsSepaDebit? = nil,
                usBankAccount: SetupIntentPaymentMethodOptionsUSBankAccount? = nil) {
        self.acssDebit = acssDebit
        self.blik = blik
        self.card = card
        self.link = link
        self.sepaDebit = sepaDebit
        self.usBankAccount = usBankAccount
    }
}

// MARK: ACSS Debit
public struct SetupIntentPaymentMethodOptionsAcssDebit: Codable {
    /// Currency supported by the bank account
    public var currency: Currency?
    /// Additional fields for Mandate creation
    public var mandateOptions: SetupIntentPaymentMethodOptionsAcssDebitMandateOptions?
    /// Bank account verification method.
    public var verificationMethod: SetupIntentPaymentMethodOptionsAcssDebitMandateOptionsVerificationMethod?

    public init(currency: Currency? = nil,
                mandateOptions: SetupIntentPaymentMethodOptionsAcssDebitMandateOptions? = nil,
                verificationMethod: SetupIntentPaymentMethodOptionsAcssDebitMandateOptionsVerificationMethod? = nil) {
        self.currency = currency
        self.mandateOptions = mandateOptions
        self.verificationMethod = verificationMethod
    }
}

public struct SetupIntentPaymentMethodOptionsAcssDebitMandateOptions: Codable {
    /// A URL for custom mandate text
    public var customMandateUrl: String?
    /// List of Stripe products where this mandate can be selected automatically.
    public var defaultFor: [String]?
    /// Description of the interval. Only required if the `payment_schedule` parameter is `interval` or `combined`.
    public var intervalDescription: String?
    /// Payment schedule for the mandate.
    public var payoutSchedule: SetupIntentPaymentMethodOptionsAcssDebitMandateOptionsPayoutSchedule?
    /// Transaction type of the mandate.
    public var transactionType: SetupIntentPaymentMethodOptionsAcssDebitMandateOptionsTransactionType?
    
    public init(customMandateUrl: String? = nil,
                defaultFor: [String]? = nil,
                intervalDescription: String? = nil,
                payoutSchedule: SetupIntentPaymentMethodOptionsAcssDebitMandateOptionsPayoutSchedule? = nil,
                transactionType: SetupIntentPaymentMethodOptionsAcssDebitMandateOptionsTransactionType? = nil) {
        self.customMandateUrl = customMandateUrl
        self.defaultFor = defaultFor
        self.intervalDescription = intervalDescription
        self.payoutSchedule = payoutSchedule
        self.transactionType = transactionType
    }
}

public enum SetupIntentPaymentMethodOptionsAcssDebitMandateOptionsPayoutSchedule: String, Codable {
    /// Payments are initiated at a regular pre-defined interval
    case interval
    /// Payments are initiated sporadically
    case sporadic
    /// Payments can be initiated at a pre-defined interval or sporadically
    case combined
}

public enum SetupIntentPaymentMethodOptionsAcssDebitMandateOptionsTransactionType: String, Codable {
    /// Transactions are made for personal reasons
    case personal
    /// Transactions are made for business reasons
    case business
}

public enum SetupIntentPaymentMethodOptionsAcssDebitMandateOptionsVerificationMethod: String, Codable {
    /// Instant verification with fallback to microdeposits.
    case automatic
    /// Instant verification.
    case instant
    /// Verification using microdeposits.
    case microdeposits
}

// MARK: Blik
public struct SetupIntentPaymentMethodOptionsBlik: Codable {
    /// Details of the reusable mandate.
    public var mandateOptions: SetupIntentPaymentMethodOptionsBlikMandateOptions?
    
    public init(mandateOptions: SetupIntentPaymentMethodOptionsBlikMandateOptions? = nil) {
        self.mandateOptions = mandateOptions
    }
}

public struct SetupIntentPaymentMethodOptionsBlikMandateOptions: Codable {
    public var expiresAfter: Date?
    /// Details for off-session mandates.
    public var offSession: SetupIntentPaymentMethodOptionsBlikMandateOptionsOffSession?
    /// Type of the mandate.
    public var type: SetupIntentPaymentMethodOptionsBlikMandateOptionsType?
    
    public init(expiresAfter: Date? = nil,
                offSession: SetupIntentPaymentMethodOptionsBlikMandateOptionsOffSession? = nil,
                type: SetupIntentPaymentMethodOptionsBlikMandateOptionsType? = nil) {
        self.expiresAfter = expiresAfter
        self.offSession = offSession
        self.type = type
    }
}

public struct SetupIntentPaymentMethodOptionsBlikMandateOptionsOffSession: Codable {
    /// Amount of each recurring payment.
    public var amount: Int?
    /// Currency of each recurring payment.
    public var currency: Currency?
    /// Frequency interval of each recurring payment.
    public var interval: SetupIntentPaymentMethodOptionsBlikMandateOptionsOffSessionInterval?
    
    public init(amount: Int? = nil,
                currency: Currency? = nil,
                interval: SetupIntentPaymentMethodOptionsBlikMandateOptionsOffSessionInterval? = nil) {
        self.amount = amount
        self.currency = currency
        self.interval = interval
    }
}

public enum SetupIntentPaymentMethodOptionsBlikMandateOptionsOffSessionInterval: String, Codable {
    /// Payments recur every day.
    case day
    /// Payments recur every week.
    case week
    /// Payments recur every month.
    case month
    /// Payments recur every year.
    case year
}

public enum SetupIntentPaymentMethodOptionsBlikMandateOptionsType: String, Codable {
    /// Mandate for on-session payments.
    case onSession = "on_session"
    /// Mandate for off-session payments.
    case offSession = "off_session"
}

// MARK: Card
public struct SetupIntentPaymentMethodOptionsCard: Codable {
    /// Configuration options for setting up an eMandate for cards issued in India.
    public var mandateOptions: SetupIntentPaymentMethodOptionsCardMandateOptions?
    /// Selected network to process this SetupIntent on. Depends on the available networks of the card attached to the setup intent. Can be only set confirm-time.
    public var network: String?
    /// We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and other requirements. However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. Permitted values include: `automatic` or `any`. If not provided, defaults to `automatic`. Read our guide on manually requesting 3D Secure for more information on how this configuration interacts with Radar and our SCA Engine.
    public var requestThreeDSecure: String?
    
    public init(mandateOptions: SetupIntentPaymentMethodOptionsCardMandateOptions? = nil,
                network: String? = nil,
                requestThreeDSecure: String? = nil) {
        self.mandateOptions = mandateOptions
        self.network = network
        self.requestThreeDSecure = requestThreeDSecure
    }
}

public struct SetupIntentPaymentMethodOptionsCardMandateOptions: Codable {
    /// Amount to be charged for future payments.
    public var amount: Int?
    /// One of `fixed` or `maximum`. If `fixed`, the `amount` param refers to the exact amount to be charged in future payments. If `maximum`, the amount charged can be up to the value passed for the `amount` param.
    public var amountType: SetupIntentPaymentMethodOptionsCardMandateOptionsAmountType?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// A description of the mandate or subscription that is meant to be displayed to the customer.
    public var description: String?
    /// End date of the mandate or subscription. If not provided, the mandate will be active until canceled. If provided, end date should be after start date.
    public var endDate: Date?
    /// Specifies payment frequency. One of `day`, `week`, `month`, `year`, or `sporadic`.
    public var interval: SetupIntentPaymentMethodOptionsCardMandateOptionsInterval?
    /// The number of intervals between payments. For example, `interval=month` and `interval_count=3` indicates one payment every three months. Maximum of one year interval allowed (1 year, 12 months, or 52 weeks). This parameter is optional when `interval=sporadic`.
    public var intervalCount: Int?
    /// Unique identifier for the mandate or subscription.
    public var reference: String?
    /// Start date of the mandate or subscription. Start date should not be lesser than yesterday.
    public var startDate: Date?
    /// Specifies the type of mandates supported. Possible values are india.
    public var supportedTypes: [String]?
    
    public init(amount: Int? = nil,
                amountType: SetupIntentPaymentMethodOptionsCardMandateOptionsAmountType? = nil,
                currency: Currency? = nil,
                description: String? = nil,
                endDate: Date? = nil,
                interval: SetupIntentPaymentMethodOptionsCardMandateOptionsInterval? = nil,
                intervalCount: Int? = nil,
                reference: String? = nil,
                startDate: Date? = nil,
                supportedTypes: [String]? = nil) {
        self.amount = amount
        self.amountType = amountType
        self.currency = currency
        self.description = description
        self.endDate = endDate
        self.interval = interval
        self.intervalCount = intervalCount
        self.reference = reference
        self.startDate = startDate
        self.supportedTypes = supportedTypes
    }
}

public enum SetupIntentPaymentMethodOptionsCardMandateOptionsAmountType: String, Codable {
    case fixed
    case maximum
}

public enum SetupIntentPaymentMethodOptionsCardMandateOptionsInterval: String, Codable {
    case day
    case week
    case month
    case year
    case sporadic
}

// MARK: Link
public struct SetupIntentPaymentMethodOptionsLink: Codable {
    /// Token used for persistent Link logins.
    public var persistentToken: String?
    
    public init(persistentToken: String? = nil) {
        self.persistentToken = persistentToken
    }
}

// MARK: SEPA Debit
public struct SetupIntentPaymentMethodOptionsSepaDebit: Codable {
    /// Additional fields for Mandate creation
    public var mandateOptions: SetupIntentPaymentMethodOptionsSepaDebitMandateOptions?
    
    public init(mandateOptions: SetupIntentPaymentMethodOptionsSepaDebitMandateOptions? = nil) {
        self.mandateOptions = mandateOptions
    }
}

public struct SetupIntentPaymentMethodOptionsSepaDebitMandateOptions: Codable {
    public init() { }
}

// MARK: US Bank Account
public struct SetupIntentPaymentMethodOptionsUSBankAccount: Codable {
    /// Additional fields for Financial Connections Session creation
    public var financialConnections: SetupIntentPaymentMethodOptionsUSBankAccountFinancialConnections?
    /// Bank account verification method.
    public var verificationMethod: SetupIntentPaymentMethodOptionsUSBankAccountVerificationMethod?
    
    public init(financialConnections: SetupIntentPaymentMethodOptionsUSBankAccountFinancialConnections? = nil,
                verificationMethod: SetupIntentPaymentMethodOptionsUSBankAccountVerificationMethod? = nil) {
        self.financialConnections = financialConnections
        self.verificationMethod = verificationMethod
    }
}

public struct SetupIntentPaymentMethodOptionsUSBankAccountFinancialConnections: Codable {
    /// The list of permissions to request. The `payment_method` permission must be included.
    public var permissions: [SetupIntentPaymentMethodOptionsUSBankAccountFinancialConnectionsPermission]?
    
    public init(permissions: [SetupIntentPaymentMethodOptionsUSBankAccountFinancialConnectionsPermission]? = nil) {
        self.permissions = permissions
    }
}

public enum SetupIntentPaymentMethodOptionsUSBankAccountFinancialConnectionsPermission: String, Codable {
    /// Allows the creation of a payment method from the account.
    case paymentMethod = "payment_method"
    /// Allows accessing balance data from the account.
    case balances
    /// Allows accessing transactions data from the account.
    case transactions
    /// Allows accessing ownership data from the account.
    case ownership
}

public enum SetupIntentPaymentMethodOptionsUSBankAccountVerificationMethod: String, Codable {
    /// Instant verification with fallback to microdeposits.
    case automatic
    /// Instant verification only.
    case instant
    /// Verification using microdeposits. Cannot be used with Stripe Checkout or Hosted Invoices.
    case microdeposits
}

