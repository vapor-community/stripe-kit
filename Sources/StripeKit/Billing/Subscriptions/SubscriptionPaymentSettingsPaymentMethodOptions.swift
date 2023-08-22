//
//  SubscriptionPaymentSettingsPaymentMethodOptions.swift
//  
//
//  Created by Andrew Edwards on 5/13/23.
//

import Foundation

public struct SubscriptionPaymentSettingsPaymentMethodOptions: Codable {
    /// If paying by `acss_debit`, this sub-hash contains details about the Canadian pre-authorized debit payment method options to pass to the invoice’s PaymentIntent.
    public var acssDebit: SubscriptionPaymentSettingsPaymentMethodOptionsAcssDebit?
    /// If paying by `bancontact`, this sub-hash contains details about the Bancontact payment method options to pass to the invoice’s PaymentIntent.
    public var bancontact: SubscriptionPaymentSettingsPaymentMethodOptionsBancontact?
    /// If paying by `card`, this sub-hash contains details about the Card payment method options to pass to the invoice’s PaymentIntent.
    public var card: SubscriptionPaymentSettingsPaymentMethodOptionsCard?
    /// If paying by `customer_balance`, this sub-hash contains details about the Bank transfer payment method options to pass to the invoice’s PaymentIntent.
    public var customerBalance: SubscriptionPaymentSettingsPaymentMethodOptionsCustomerBalance?
    /// If paying by `konbini`, this sub-hash contains details about the Konbini payment method options to pass to the invoice’s PaymentIntent.
    public var konbini: SubscriptionPaymentSettingsPaymentMethodOptionsKonbini?
    /// If paying by `us_bank_account`, this sub-hash contains details about the ACH direct debit payment method options to pass to the invoice’s PaymentIntent.
    public var usBankAccount: SubscriptionPaymentSettingsPaymentMethodOptionsUSBankAccount?
    
    public init(acssDebit: SubscriptionPaymentSettingsPaymentMethodOptionsAcssDebit? = nil,
                bancontact: SubscriptionPaymentSettingsPaymentMethodOptionsBancontact? = nil,
                card: SubscriptionPaymentSettingsPaymentMethodOptionsCard? = nil,
                customerBalance: SubscriptionPaymentSettingsPaymentMethodOptionsCustomerBalance? = nil,
                konbini: SubscriptionPaymentSettingsPaymentMethodOptionsKonbini? = nil,
                usBankAccount: SubscriptionPaymentSettingsPaymentMethodOptionsUSBankAccount? = nil) {
        self.acssDebit = acssDebit
        self.bancontact = bancontact
        self.card = card
        self.customerBalance = customerBalance
        self.konbini = konbini
        self.usBankAccount = usBankAccount
    }
}

// MARK: ACSS Debit
public struct SubscriptionPaymentSettingsPaymentMethodOptionsAcssDebit: Codable {
    /// Additional fields for Mandate creation
    public var mandateOptions: SubscriptionPaymentSettingsPaymentMethodOptionsAcssDebitManadteOptions?
    /// Bank account verification method.
    public var verificationMethod: SubscriptionPaymentSettingsPaymentMethodOptionsAcssDebitVerificationMethod?
    
    public init(mandateOptions: SubscriptionPaymentSettingsPaymentMethodOptionsAcssDebitManadteOptions? = nil,
                verificationMethod: SubscriptionPaymentSettingsPaymentMethodOptionsAcssDebitVerificationMethod? = nil) {
        self.mandateOptions = mandateOptions
        self.verificationMethod = verificationMethod
    }
}

public struct SubscriptionPaymentSettingsPaymentMethodOptionsAcssDebitManadteOptions: Codable {
    /// Transaction type of the mandate.
    public var transactionType: SubscriptionPaymentSettingsPaymentMethodOptionsAcssDebitManadteOptionsTransactionType?
    
    public init(transactionType: SubscriptionPaymentSettingsPaymentMethodOptionsAcssDebitManadteOptionsTransactionType? = nil) {
        self.transactionType = transactionType
    }
}

public enum SubscriptionPaymentSettingsPaymentMethodOptionsAcssDebitManadteOptionsTransactionType: String, Codable {
    /// Transactions are made for personal reasons
    case personal
    /// Transactions are made for business reasons
    case business
}

public enum SubscriptionPaymentSettingsPaymentMethodOptionsAcssDebitVerificationMethod: String, Codable {
    /// Instant verification with fallback to microdeposits.
    case automatic
    /// Instant verification.
    case instant
    /// Verification using microdeposits.
    case microdeposits
}

// MARK: Bancontact
public struct SubscriptionPaymentSettingsPaymentMethodOptionsBancontact: Codable {
    /// Preferred language of the Bancontact authorization page that the customer is redirected to.
    public var preferredLanguage: String?
    
    public init(preferredLanguage: String? = nil) {
        self.preferredLanguage = preferredLanguage
    }
}

// MARK: Card
public struct SubscriptionPaymentSettingsPaymentMethodOptionsCard: Codable {
    /// Installment details for this Invoice (Mexico only). For more information, see the installments integration guide.
    public var mandateOptions: SubscriptionPaymentSettingsPaymentMethodOptionsCardMandateOptions?
    /// Selected network to process this Subscription on. Depends on the available networks of the card attached to the Subscription. Can be only set confirm-time.
    public var network: String?
    /// We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and other requirements. However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. Read our guide on manually requesting 3D Secure for more information on how this configuration interacts with Radar and our SCA Engine.
    public var requestThreeDSecure: SubscriptionPaymentSettingsPaymentMethodOptionsCardRequestThreedSecure?
    
    public init(mandateOptions: SubscriptionPaymentSettingsPaymentMethodOptionsCardMandateOptions? = nil,
                network: String? = nil,
                requestThreeDSecure: SubscriptionPaymentSettingsPaymentMethodOptionsCardRequestThreedSecure? = nil) {
        self.mandateOptions = mandateOptions
        self.network = network
        self.requestThreeDSecure = requestThreeDSecure
    }
}

public struct SubscriptionPaymentSettingsPaymentMethodOptionsCardMandateOptions: Codable {
    /// Amount to be charged for future payments.
    public var amount: Int?
    /// One of `fixed` or `maximum`. If `fixed`, the `amount` param refers to the exact amount to be charged in future payments. If `maximum`, the `amount` charged can be up to the value passed for the `amount` param.
    public var amountType: SubscriptionPaymentSettingsPaymentMethodOptionsCardMandateOptionsAmountType?
    
    public init(amount: Int? = nil, amountType: SubscriptionPaymentSettingsPaymentMethodOptionsCardMandateOptionsAmountType? = nil) {
        self.amount = amount
        self.amountType = amountType
    }
}

public enum SubscriptionPaymentSettingsPaymentMethodOptionsCardMandateOptionsAmountType: String, Codable {
    /// If `fixed`, the `amount` param refers to the exact amount to be charged in future payments.
    case fixed
    /// If `maximum`, the `amount` charged can be up to the value passed for the amount param.
    case maximum
}

public enum SubscriptionPaymentSettingsPaymentMethodOptionsCardRequestThreedSecure: String, Codable {
    /// Triggers 3D Secure authentication only if it is required.
    case automatic
    /// Requires 3D Secure authentication if it is available.
    case any
}

// MARK: Customer Balance
public struct SubscriptionPaymentSettingsPaymentMethodOptionsCustomerBalance: Codable {
    /// Configuration for the bank transfer funding type, if the `funding_type` is set to `bank_transfer`.
    public var bankTransfer: SubscriptionPaymentSettingsPaymentMethodOptionsCustomerBalanceBankTransfer?
    /// The funding method type to be used when there are not enough funds in the customer balance. Permitted values include: `bank_transfer`
    public var fundingType: SubscriptionPaymentSettingsPaymentMethodOptionsCustomerBalanceFundingType?
    
    public init(bankTransfer: SubscriptionPaymentSettingsPaymentMethodOptionsCustomerBalanceBankTransfer? = nil,
                fundingType: SubscriptionPaymentSettingsPaymentMethodOptionsCustomerBalanceFundingType? = nil) {
        self.bankTransfer = bankTransfer
        self.fundingType = fundingType
    }
}

public struct SubscriptionPaymentSettingsPaymentMethodOptionsCustomerBalanceBankTransfer: Codable {
    /// Configuration for `eu_bank_transfer` funding type.
    public var euBankTransfer: SubscriptionPaymentSettingsPaymentMethodOptionsCustomerBalanceBankTransferEUBankTransfer?
    /// The bank transfer type that can be used for funding. Permitted values include: `eu_bank_transfer`, `gb_bank_transfer`, `jp_bank_transfer`, or `mx_bank_transfe`.
    public var type: SubscriptionPaymentSettingsPaymentMethodOptionsCustomerBalanceBankTransferType?
    
    public init(euBankTransfer: SubscriptionPaymentSettingsPaymentMethodOptionsCustomerBalanceBankTransferEUBankTransfer? = nil,
                type: SubscriptionPaymentSettingsPaymentMethodOptionsCustomerBalanceBankTransferType? = nil) {
        self.euBankTransfer = euBankTransfer
        self.type = type
    }
}

public struct SubscriptionPaymentSettingsPaymentMethodOptionsCustomerBalanceBankTransferEUBankTransfer: Codable {
    /// The desired country code of the bank account information. Permitted values include: `BE`, `DE`, `ES`, `FR`, `IE`, or `NL`.
    public var country: String?
    
    public init(country: String? = nil) {
        self.country = country
    }
}

public enum SubscriptionPaymentSettingsPaymentMethodOptionsCustomerBalanceBankTransferType: String, Codable {
    case euBankTransfer = "eu_bank_transfer"
    case gbBankTransfer = "gb_bank_transfer"
    case jpBankTransfer = "jp_bank_transfer"
    case mxBankTransfer = "mx_bank_transfer"
}

public enum SubscriptionPaymentSettingsPaymentMethodOptionsCustomerBalanceFundingType: String, Codable {
    case bankTransfer = "bank_transfer"
}

// MARK: Konbini
public struct SubscriptionPaymentSettingsPaymentMethodOptionsKonbini: Codable {
    public init(){}
}

// MARK: US Bank Account
public struct SubscriptionPaymentSettingsPaymentMethodOptionsUSBankAccount: Codable {
    /// Additional fields for Financial Connections Session creation
    public var financialConnections: SubscriptionPaymentSettingsPaymentMethodOptionsUSBankAccountFinancialConnections?
    /// Bank account verification method.
    public var verificationMethod: SubscriptionPaymentSettingsPaymentMethodOptionsUSBankAccountVerificationMethod?
    
    public init(financialConnections: SubscriptionPaymentSettingsPaymentMethodOptionsUSBankAccountFinancialConnections? = nil,
                verificationMethod: SubscriptionPaymentSettingsPaymentMethodOptionsUSBankAccountVerificationMethod? = nil) {
        self.financialConnections = financialConnections
        self.verificationMethod = verificationMethod
    }
}

public struct SubscriptionPaymentSettingsPaymentMethodOptionsUSBankAccountFinancialConnections: Codable {
    /// The list of permissions to request. The `payment_method` permission must be included.
    public var permissions: [SubscriptionPaymentSettingsPaymentMethodOptionsUSBankAccountFinancialConnectionsPermission]?
    
    public init(permissions: [SubscriptionPaymentSettingsPaymentMethodOptionsUSBankAccountFinancialConnectionsPermission]? = nil) {
        self.permissions = permissions
    }
}

public enum SubscriptionPaymentSettingsPaymentMethodOptionsUSBankAccountFinancialConnectionsPermission: String, Codable {
    /// Allows the creation of a payment method from the account.
    case paymentMethod = "payment_method"
    /// Allows accessing balance data from the account.
    case balances
    /// Allows accessing transactions data from the account.
    case transactions
}

public enum SubscriptionPaymentSettingsPaymentMethodOptionsUSBankAccountVerificationMethod: String, Codable {
    /// Instant verification with fallback to microdeposits.
    case automatic
    /// Instant verification only.
    case instant
    /// Verification using microdeposits. Cannot be used with Stripe Checkout or Hosted Invoices.
    case microdeposits
}
