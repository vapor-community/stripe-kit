//
//  FundingInstructions.swift
//  
//
//  Created by Andrew Edwards on 5/16/23.
//

import Foundation

public struct FundingInstructions: Codable {
    /// Details to display instructions for initiating a bank transfer
    public var bankTransfer: FundingInstructionsBankTransfer?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// The `funding_type` of the returned instructions.
    public var fundingType: FundingInstructionsFundingType?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool
    
    public init(bankTransfer: FundingInstructionsBankTransfer? = nil,
                currency: Currency? = nil,
                fundingType: FundingInstructionsFundingType? = nil,
                object: String,
                livemode: Bool) {
        self.bankTransfer = bankTransfer
        self.currency = currency
        self.fundingType = fundingType
        self.object = object
        self.livemode = livemode
    }
}

public struct FundingInstructionsBankTransfer: Codable {
    /// The country of the bank account to fund
    public var country: String?
    /// A list of financial addresses that can be used to fund a particular balance
    public var financialAddresses: [FundingInstructionsBankTransferFinancialAddress]?
    /// The `bank_transfer` type
    public var type: FundingInstructionsBankTransferType?
}

public struct FundingInstructionsBankTransferFinancialAddress: Codable {
    /// An IBAN-based FinancialAddress
    public var iban: FundingInstructionsBankTransferFinancialAddressIban?
    /// An account number and sort code-based FinancialAddress
    public var sortCode: FundingInstructionsBankTransferFinancialAddressSortCode?
    /// The payment networks supported by this FinancialAddress
    public var supportedNetworks: [FundingInstructionsBankTransferFinancialAddressSupportedNetwork]?
    /// The type of financial address
    public var type: FundingInstructionsBankTransferFinancialAddressType?
    
    public init(iban: FundingInstructionsBankTransferFinancialAddressIban? = nil,
                sortCode: FundingInstructionsBankTransferFinancialAddressSortCode? = nil,
                supportedNetworks: [FundingInstructionsBankTransferFinancialAddressSupportedNetwork]? = nil,
                type: FundingInstructionsBankTransferFinancialAddressType? = nil) {
        self.iban = iban
        self.sortCode = sortCode
        self.supportedNetworks = supportedNetworks
        self.type = type
    }
}

public enum FundingInstructionsBankTransferFinancialAddressType: String, Codable {
    case iban
    case sortCode = "sort_code"
}

public struct FundingInstructionsBankTransferFinancialAddressIban: Codable {
    /// The name of the person or business that owns the bank account
    public var accountHolderName: String?
    /// The BIC/SWIFT code of the account.
    public var bic: String?
    /// Two-letter country code (ISO 3166-1 alpha-2).
    public var country: String?
    /// The IBAN of the account.
    public var iban: String?
    
    public init(accountHolderName: String? = nil,
                bic: String? = nil,
                country: String? = nil,
                iban: String? = nil) {
        self.accountHolderName = accountHolderName
        self.bic = bic
        self.country = country
        self.iban = iban
    }
}

public struct FundingInstructionsBankTransferFinancialAddressSortCode: Codable {
    /// The name of the person or business that owns the bank account
    public var accountHolderName: String?
    /// The account number
    public var accountNumber: String?
    /// The six-digit sort code
    public var sortCode: String?
    
    public init(accountHolderName: String? = nil,
                accountNumber: String? = nil,
                sortCode: String? = nil) {
        self.accountHolderName = accountHolderName
        self.accountNumber = accountNumber
        self.sortCode = sortCode
    }
}

public enum FundingInstructionsBankTransferFinancialAddressSupportedNetwork: String, Codable {
    case bacs
    case fps
    case sepa
}

public enum FundingInstructionsBankTransferType: String, Codable {
    /// A  bank transfer to an EU bank account
    case euBankTransfer = "eu_bank_transfer"
    /// A bank transfer to a GB bank account
    case gbBankTransfer = "gb_bank_transfer"
}

public enum FundingInstructionsFundingType: String, Codable {
    /// Use a `bank_transfer` hash to define the bank transfer type
    case bankTransfer = "bank_transfer"
}

public struct FundingInstructionsList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [FundingInstructions]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [FundingInstructions]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
