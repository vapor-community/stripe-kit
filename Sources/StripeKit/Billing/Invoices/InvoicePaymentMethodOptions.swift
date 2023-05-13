//
//  InvoicePaymentMethodOptions.swift
//  
//
//  Created by Andrew Edwards on 5/12/23.
//

import Foundation

public struct InvoicePaymentSettingsPaymentMethodOptions: Codable {
    /// If paying by `acss_debit`, this sub-hash contains details about the Canadian pre-authorized debit payment method options to pass to the invoice’s PaymentIntent.
    public var acssDebit: InvoicePaymentSettingsPaymentMethodOptionsAcssDebit?
    /// If paying by `bancontact`, this sub-hash contains details about the Bancontact payment method options to pass to the invoice’s PaymentIntent.
    public var bancontact: InvoicePaymentSettingsPaymentMethodOptionsBancontact?
    /// If paying by `card`, this sub-hash contains details about the Card payment method options to pass to the invoice’s PaymentIntent.
    public var card: InvoicePaymentSettingsPaymentMethodOptionsCard?
    /// If paying by `customer_balance`, this sub-hash contains details about the Bank transfer payment method options to pass to the invoice’s PaymentIntent.
    public var customerBalance: InvoicePaymentSettingsPaymentMethodOptionsCustomerBalance?
    /// If paying by `konbini`, this sub-hash contains details about the Konbini payment method options to pass to the invoice’s PaymentIntent.
    public var konbini: InvoicePaymentSettingsPaymentMethodOptionsKonbini?
    /// If paying by `us_bank_account`, this sub-hash contains details about the ACH direct debit payment method options to pass to the invoice’s PaymentIntent.
    public var usBankAccount: InvoicePaymentSettingsPaymentMethodOptionsUSBankAccount?
    
    public init(acssDebit: InvoicePaymentSettingsPaymentMethodOptionsAcssDebit? = nil,
                bancontact: InvoicePaymentSettingsPaymentMethodOptionsBancontact? = nil,
                card: InvoicePaymentSettingsPaymentMethodOptionsCard? = nil,
                customerBalance: InvoicePaymentSettingsPaymentMethodOptionsCustomerBalance? = nil,
                konbini: InvoicePaymentSettingsPaymentMethodOptionsKonbini? = nil,
                usBankAccount: InvoicePaymentSettingsPaymentMethodOptionsUSBankAccount? = nil) {
        self.acssDebit = acssDebit
        self.bancontact = bancontact
        self.card = card
        self.customerBalance = customerBalance
        self.konbini = konbini
        self.usBankAccount = usBankAccount
    }
}

// MARK: ACSS Debit
public struct InvoicePaymentSettingsPaymentMethodOptionsAcssDebit: Codable {
    /// Additional fields for Mandate creation
    public var mandateOptions: InvoicePaymentSettingsPaymentMethodOptionsAcssDebitManadteOptions?
    /// Bank account verification method.
    public var verificationMethod: InvoicePaymentSettingsPaymentMethodOptionsAcssDebitVerificationMethod?
    
    public init(mandateOptions: InvoicePaymentSettingsPaymentMethodOptionsAcssDebitManadteOptions? = nil,
                verificationMethod: InvoicePaymentSettingsPaymentMethodOptionsAcssDebitVerificationMethod? = nil) {
        self.mandateOptions = mandateOptions
        self.verificationMethod = verificationMethod
    }
}

public struct InvoicePaymentSettingsPaymentMethodOptionsAcssDebitManadteOptions: Codable {
    /// Transaction type of the mandate.
    public var transactionType: InvoicePaymentSettingsPaymentMethodOptionsAcssDebitManadteOptionsTransactionType?
    
    public init(transactionType: InvoicePaymentSettingsPaymentMethodOptionsAcssDebitManadteOptionsTransactionType? = nil) {
        self.transactionType = transactionType
    }
}

public enum InvoicePaymentSettingsPaymentMethodOptionsAcssDebitManadteOptionsTransactionType: String, Codable {
    /// Transactions are made for personal reasons
    case personal
    /// Transactions are made for business reasons
    case business
}

public enum InvoicePaymentSettingsPaymentMethodOptionsAcssDebitVerificationMethod: String, Codable {
    /// Instant verification with fallback to microdeposits.
    case automatic
    /// Instant verification.
    case instant
    /// Verification using microdeposits.
    case microdeposits
}

// MARK: Bancontact
public struct InvoicePaymentSettingsPaymentMethodOptionsBancontact: Codable {
    /// Preferred language of the Bancontact authorization page that the customer is redirected to.
    public var preferredLanguage: String?
    
    public init(preferredLanguage: String? = nil) {
        self.preferredLanguage = preferredLanguage
    }
}

// MARK: Card
public struct InvoicePaymentSettingsPaymentMethodOptionsCard: Codable {
    /// Installment details for this Invoice (Mexico only). For more information, see the installments integration guide.
    public var installments: InvoicePaymentSettingsPaymentMethodOptionsCardInstallments?
    
    /// We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and other requirements. However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. Read our guide on manually requesting 3D Secure for more information on how this configuration interacts with Radar and our SCA Engine.
    public var requestThreeDSecure: InvoicePaymentSettingsPaymentMethodOptionsCardRequestThreedSecure?
    
    public init(installments: InvoicePaymentSettingsPaymentMethodOptionsCardInstallments? = nil,
                requestThreeDSecure: InvoicePaymentSettingsPaymentMethodOptionsCardRequestThreedSecure? = nil) {
        self.installments = installments
        self.requestThreeDSecure = requestThreeDSecure
    }
}

public struct InvoicePaymentSettingsPaymentMethodOptionsCardInstallments: Codable {
    /// Whether Installments are enabled for this Invoice.
    public var enabled: Bool?
    
    public init(enabled: Bool? = nil) {
        self.enabled = enabled
    }
}

public enum InvoicePaymentSettingsPaymentMethodOptionsCardRequestThreedSecure: String, Codable {
    /// Triggers 3D Secure authentication only if it is required.
    case automatic
    /// Requires 3D Secure authentication if it is available.
    case any
}

// MARK: Customer Balance
public struct InvoicePaymentSettingsPaymentMethodOptionsCustomerBalance: Codable {
    /// Configuration for the bank transfer funding type, if the `funding_type` is set to `bank_transfer`.
    public var bankTransfer: InvoicePaymentSettingsPaymentMethodOptionsCustomerBalanceBankTransfer?
    /// The funding method type to be used when there are not enough funds in the customer balance. Permitted values include: `bank_transfer`
    public var fundingType: InvoicePaymentSettingsPaymentMethodOptionsCustomerBalanceFundingType?
    
    public init(bankTransfer: InvoicePaymentSettingsPaymentMethodOptionsCustomerBalanceBankTransfer? = nil,
                fundingType: InvoicePaymentSettingsPaymentMethodOptionsCustomerBalanceFundingType? = nil) {
        self.bankTransfer = bankTransfer
        self.fundingType = fundingType
    }
}

public struct InvoicePaymentSettingsPaymentMethodOptionsCustomerBalanceBankTransfer: Codable {
    /// Configuration for `eu_bank_transfer` funding type.
    public var euBankTransfer: InvoicePaymentSettingsPaymentMethodOptionsCustomerBalanceBankTransferEUBankTransfer?
    /// The bank transfer type that can be used for funding. Permitted values include: `eu_bank_transfer`, `gb_bank_transfer`, `jp_bank_transfer`, or `mx_bank_transfe`.
    public var type: InvoicePaymentSettingsPaymentMethodOptionsCustomerBalanceBankTransferType?
    
    public init(euBankTransfer: InvoicePaymentSettingsPaymentMethodOptionsCustomerBalanceBankTransferEUBankTransfer? = nil,
                type: InvoicePaymentSettingsPaymentMethodOptionsCustomerBalanceBankTransferType? = nil) {
        self.euBankTransfer = euBankTransfer
        self.type = type
    }
}

public struct InvoicePaymentSettingsPaymentMethodOptionsCustomerBalanceBankTransferEUBankTransfer: Codable {
    /// The desired country code of the bank account information. Permitted values include: `BE`, `DE`, `ES`, `FR`, `IE`, or `NL`.
    public var country: String?
    
    public init(country: String? = nil) {
        self.country = country
    }
}

public enum InvoicePaymentSettingsPaymentMethodOptionsCustomerBalanceBankTransferType: String, Codable {
    case euBankTransfer = "eu_bank_transfer"
    case gbBankTransfer = "gb_bank_transfer"
    case jpBankTransfer = "jp_bank_transfer"
    case mxBankTransfer = "mx_bank_transfer"
}

public enum InvoicePaymentSettingsPaymentMethodOptionsCustomerBalanceFundingType: String, Codable {
    case bankTransfer = "bank_transfer"
}

// MARK: Konbini
public struct InvoicePaymentSettingsPaymentMethodOptionsKonbini: Codable {
    public init(){}
}

// MARK: US Bank Account
public struct InvoicePaymentSettingsPaymentMethodOptionsUSBankAccount: Codable {
    /// Additional fields for Financial Connections Session creation
    public var financialConnections: InvoicePaymentSettingsPaymentMethodOptionsUSBankAccountFinancialConnections?
    /// Bank account verification method.
    public var verificationMethod: InvoicePaymentSettingsPaymentMethodOptionsUSBankAccountVerificationMethod?
    
    public init(financialConnections: InvoicePaymentSettingsPaymentMethodOptionsUSBankAccountFinancialConnections? = nil,
                verificationMethod: InvoicePaymentSettingsPaymentMethodOptionsUSBankAccountVerificationMethod? = nil) {
        self.financialConnections = financialConnections
        self.verificationMethod = verificationMethod
    }
}

public struct InvoicePaymentSettingsPaymentMethodOptionsUSBankAccountFinancialConnections: Codable {
    /// The list of permissions to request. The `payment_method` permission must be included.
    public var permissions: [InvoicePaymentSettingsPaymentMethodOptionsUSBankAccountFinancialConnectionsPermission]?
    
    public init(permissions: [InvoicePaymentSettingsPaymentMethodOptionsUSBankAccountFinancialConnectionsPermission]? = nil) {
        self.permissions = permissions
    }
}

public enum InvoicePaymentSettingsPaymentMethodOptionsUSBankAccountFinancialConnectionsPermission: String, Codable {
    /// Allows the creation of a payment method from the account.
    case paymentMethod = "payment_method"
    /// Allows accessing balance data from the account.
    case balances
    /// Allows accessing transactions data from the account.
    case transactions
}

public enum InvoicePaymentSettingsPaymentMethodOptionsUSBankAccountVerificationMethod: String, Codable {
    /// Instant verification with fallback to microdeposits.
    case automatic
    /// Instant verification only.
    case instant
    /// Verification using microdeposits. Cannot be used with Stripe Checkout or Hosted Invoices.
    case microdeposits
}
