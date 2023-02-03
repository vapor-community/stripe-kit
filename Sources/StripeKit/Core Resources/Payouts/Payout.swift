//
//  Payout.swift
//  Async
//
//  Created by Andrew Edwards on 8/20/18.
//

import Foundation

/// The [Payout Object](https://stripe.com/docs/api/payouts/object).
public struct StripePayout: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Amount (in cents) to be transferred to your bank account or debit card.
    public var amount: Int?
    /// Date the payout is expected to arrive in the bank. This factors in delays like weekends or bank holidays.
    public var arrivalDate: Date?
    /// Returns `true` if the payout was created by an automated payout schedule, and false if it was requested manually.
    public var automatic: Bool?
    /// ID of the balance transaction that describes the impact of this payout on your account balance.
    @Expandable<BalanceTransaction> public var balanceTransaction: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// ID of the bank account or card the payout was sent to.
    @DynamicExpandable<StripeCard, StripeBankAccount> public var destination: String?
    /// If the payout failed or was canceled, this will be the ID of the balance transaction that reversed the initial balance transaction, and puts the funds from the failed payout back in your balance.
    @Expandable<BalanceTransaction> public var failureBalanceTransaction: String?
    /// Error code explaining reason for payout failure if available. See Types of payout failures for a list of failure codes.
    public var failureCode: StripePayoutFailureCode?
    /// Message to user further explaining reason for payout failure if available.
    public var failureMessage: String?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The method used to send this payout, which can be `standard` or `instant`. `instant` is only supported for payouts to debit cards. (See [Instant payouts for marketplaces](https://stripe.com/blog/instant-payouts-for-marketplaces) for more information.)
    public var method: StripePayoutMethod?
    /// The source balance this payout came from. One of `card` or `bank_account`.
    public var sourceType: StripePayoutSourceType?
    /// Extra information about a payout to be displayed on the user’s bank statement.
    public var statementDescriptor: String?
    /// Current status of the payout (`paid`, `pending`, `in_transit`, `canceled` or `failed`). A payout will be `pending` until it is submitted to the bank, at which point it becomes `in_transit`. It will then change to `paid` if the transaction goes through. If it does not go through successfully, its status will change to `failed` or `canceled`.
    public var status: StripePayoutStatus?
    /// Can be `bank_account` or `card`.
    public var type: StripePayoutType?
}

public enum StripePayoutFailureCode: String, Codable {
    case accountClosed = "account_closed"
    case accountFrozen = "account_frozen"
    case bankAccountRestricted = "bank_account_restricted"
    case bankOwnershipChanged = "bank_ownership_changed"
    case couldNotProcess = "could_not_process"
    case debitNotAuthorized = "debit_not_authorized"
    case declined
    case insufficientFunds = "insufficient_funds"
    case invalidAccountNumber = "invalid_account_number"
    case incorrectAccountHolderName = "incorrect_account_holder_name"
    case invalidCurrency = "invalid_currency"
    case noAccount = "no_account"
    case unsupportedCard = "unsupported_card"
}

public enum StripePayoutMethod: String, Codable {
    case standard
    case instant
}

public enum StripePayoutSourceType: String, Codable {
    case bankAccount = "bank_account"
    case card
}

public enum StripePayoutStatus: String, Codable {
    case paid
    case pending
    case inTransit = "in_transit"
    case canceled
    case failed
}

public enum StripePayoutType: String, Codable {
    case bankAccount = "bank_account"
    case card
}

public struct StripePayoutsList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripePayout]?
}
