//
//  Payout.swift
//  Async
//
//  Created by Andrew Edwards on 8/20/18.
//

import Foundation

/// The [Payout Object](https://stripe.com/docs/api/payouts/object).
public struct Payout: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// Amount (in cents) to be transferred to your bank account or debit card.
    public var amount: Int?
    /// Date the payout is expected to arrive in the bank. This factors in delays like weekends or bank holidays.
    public var arrivalDate: Date?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Extra information about a payout to be displayed on the user’s bank statement.
    public var statementDescriptor: String?
    /// Current status of the payout (`paid`, `pending`, `in_transit`, `canceled` or `failed`). A payout will be `pending` until it is submitted to the bank, at which point it becomes `in_transit`. It will then change to `paid` if the transaction goes through. If it does not go through successfully, its status will change to `failed` or `canceled`.
    public var status: PayoutStatus?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Returns `true` if the payout was created by an automated payout schedule, and false if it was requested manually.
    public var automatic: Bool?
    /// ID of the balance transaction that describes the impact of this payout on your account balance.
    @Expandable<BalanceTransaction> public var balanceTransaction: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// ID of the bank account or card the payout was sent to.
    @DynamicExpandable<StripeCard, StripeBankAccount> public var destination: String?
    /// If the payout failed or was canceled, this will be the ID of the balance transaction that reversed the initial balance transaction, and puts the funds from the failed payout back in your balance.
    @Expandable<BalanceTransaction> public var failureBalanceTransaction: String?
    /// Error code explaining reason for payout failure if available. See Types of payout failures for a list of failure codes.
    public var failureCode: PayoutFailureCode?
    /// Message to user further explaining reason for payout failure if available.
    public var failureMessage: String?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// The method used to send this payout, which can be `standard` or `instant`. `instant` is only supported for payouts to debit cards. (See [Instant payouts for marketplaces](https://stripe.com/blog/instant-payouts-for-marketplaces) for more information.)
    public var method: PayoutMethod?
    /// If the payout reverses another, this is the ID of the original payout.
    @Expandable<Payout> public var originalPayout: String?
    /// If completed, the Balance Transactions API may be used to list all Balance Transactions that were paid out in this payout.
    public var reconciliationStatus: PayoutReconciliationStatus?
    /// If the payout was reversed, this is the ID of the payout that reverses this payout.
    @Expandable<Payout> public var reversedBy: String?
    /// The source balance this payout came from. One of `card`, `fpx`, or `bank_account`.
    public var sourceType: PayoutSourceType?
    /// Can be `bank_account` or `card`.
    public var type: PayoutType?
    
    public init(id: String,
                amount: Int? = nil,
                arrivalDate: Date? = nil,
                currency: Currency? = nil,
                description: String? = nil,
                metadata: [String : String]? = nil,
                statementDescriptor: String? = nil,
                status: PayoutStatus? = nil,
                object: String,
                automatic: Bool? = nil,
                balanceTransaction: String? = nil,
                created: Date,
                destination: String? = nil,
                failureBalanceTransaction: String? = nil,
                failureCode: PayoutFailureCode? = nil,
                failureMessage: String? = nil,
                livemode: Bool? = nil,
                method: PayoutMethod? = nil,
                originalPayout: String? = nil,
                reconciliationStatus: PayoutReconciliationStatus? = nil,
                reversedBy: String? = nil,
                sourceType: PayoutSourceType? = nil,
                type: PayoutType? = nil) {
        self.id = id
        self.amount = amount
        self.arrivalDate = arrivalDate
        self.currency = currency
        self.description = description
        self.metadata = metadata
        self.statementDescriptor = statementDescriptor
        self.status = status
        self.object = object
        self.automatic = automatic
        self._balanceTransaction = Expandable(id: balanceTransaction)
        self.created = created
        self._destination = DynamicExpandable(id: destination)
        self._failureBalanceTransaction = Expandable(id: failureBalanceTransaction)
        self.failureCode = failureCode
        self.failureMessage = failureMessage
        self.livemode = livemode
        self.method = method
        self._originalPayout = Expandable(id: originalPayout)
        self.reconciliationStatus = reconciliationStatus
        self._reversedBy = Expandable(id: reversedBy)
        self.sourceType = sourceType
        self.type = type
    }
}

public enum PayoutFailureCode: String, Codable {
    /// The bank account has been closed.
    case accountClosed = "account_closed"
    /// The bank account has been frozen.
    case accountFrozen = "account_frozen"
    /// The bank account has restrictions on either the type, or the number, of payouts allowed. This normally indicates that the bank account is a savings or other non-checking account.
    case bankAccountRestricted = "bank_account_restricted"
    /// The destination bank account is no longer valid because its branch has changed ownership.
    case bankOwnershipChanged = "bank_ownership_changed"
    /// The bank could not process this payout.
    case couldNotProcess = "could_not_process"
    /// Debit transactions are not approved on the bank account. (Stripe requires bank accounts to be set up for both credit and debit payouts.)
    case debitNotAuthorized = "debit_not_authorized"
    /// The bank has declined this transfer. Please contact the bank before retrying.
    case declined
    /// Your Stripe account has insufficient funds to cover the payout.
    case insufficientFunds = "insufficient_funds"
    /// The routing number seems correct, but the account number is invalid.
    case invalidAccountNumber = "invalid_account_number"
    /// Your bank notified us that the bank account holder name on file is incorrect.
    case incorrectAccountHolderName = "incorrect_account_holder_name"
    /// Your bank notified us that the bank account holder address on file is incorrect.
    case incorrectAccountHolderAddress = "incorrect_account_holder_address"
    /// Your bank notified us that the bank account holder tax ID on file is incorrect.
    case incorrectAccountHolderTaxId = "incorrect_account_holder_tax_id"
    /// The bank was unable to process this payout because of its currency. This is probably because the bank account cannot accept payments in that currency.
    case invalidCurrency = "invalid_currency"
    /// The bank account details on file are probably incorrect. No bank account could be located with those details.
    case noAccount = "no_account"
    /// The bank no longer supports payouts to this card.
    case unsupportedCard = "unsupported_card"
}

public enum PayoutMethod: String, Codable {
    case standard
    case instant
}

public enum PayoutReconciliationStatus: String, Codable {
    case notApplicable = "not_applicable"
    case inProgress = "in_progress"
    case completed
}

public enum PayoutSourceType: String, Codable {
    case card
    case fpx
    case bankAccount = "bank_account"
}

public enum PayoutStatus: String, Codable {
    case paid
    case pending
    case inTransit = "in_transit"
    case canceled
    case failed
}

public enum PayoutType: String, Codable {
    case bankAccount = "bank_account"
    case card
}

public struct PayoutsList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [Payout]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [Payout]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
