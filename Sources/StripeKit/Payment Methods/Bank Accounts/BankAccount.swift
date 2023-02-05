//
//  BankAccount.swift
//  Stripe
//
//  Created by Anthony Castelli on 5/12/17.
//
//

/// The [Bak Account Object](https://stripe.com/docs/api/customer_bank_accounts/object).
public struct StripeBankAccount: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The account this bank account belongs to.
    @Expandable<StripeConnectAccount> public var account: String?
    /// The bank account type. This can only be `checking` or `savings` in most countries. In Japan, this can only be `futsu` or `toza`.
    public var accountType: String?
    /// The name of the person or business that owns the bank account.
    public var accountHolderName: String?
    /// The type of entity that holds the account. This can be either `individual` or `company`.
    public var accountHolderType: StripeBankAccountHolderType?
    /// A set of available payout methods for this bank account. Only values from this set should be passed as the `method` when creating a payout.
    public var availablePayoutMethods: [String]?
    /// Name of the bank associated with the routing number (e.g., WELLS FARGO).
    public var bankName: String?
    /// Two-letter ISO code representing the country the bank account is located in.
    public var country: String?
    /// Three-letter ISO code for the currency paid out to the bank account.
    public var currency: Currency?
    /// The customer that this bank account belongs to.
    @Expandable<Customer> public var customer: String?
    /// Whether this bank account is the default external account for its currency.
    public var defaultForCurrency: Bool?
    /// Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    public var fingerprint: String?
    /// The last four digits of the bank account.
    public var last4: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The routing transit number for the bank account.
    public var routingNumber: String?
    /// For bank accounts, possible values are `new`, `validated`, `verified`, `verification_failed`, or `errored`. A bank account that hasn’t had any activity or validation performed is `new`. If Stripe can determine that the bank account exists, its status will be `validated`. Note that there often isn’t enough information to know (e.g., for smaller credit unions), and the validation is not always run. If customer bank account verification has succeeded, the bank account status will be `verified`. If the verification failed for any reason, such as microdeposit failure, the status will be `verification_failed`. If a transfer sent to this bank account fails, we’ll set the status to `errored` and will not continue to send transfers until the bank details are updated. \n For external accounts, possible values are `new` and `errored`. Validations aren’t run against external accounts because they’re only used for payouts. This means the other statuses don’t apply. If a transfer fails, the status is set to `errored` and transfers are stopped until account details are updated.
    public var status: StripeBankAccountStatus?
}

public struct StripeBankAccountList: Codable {
    /// String representing the object’s type. Objects of the same type share the same value. Always has the value list.
    public var object: String
    /// An array of `StripeCard`s associated with the account.
    public var data: [StripeBankAccount]?
    /// True if this list has another page of items after this one that can be fetched.
    public var hasMore: Bool?
    /// The URL where this list can be accessed.
    public var url: String?
}

public enum StripeBankAccountStatus: String, Codable {
    case new
    case validated
    case verified
    case verificationFailed = "verification_failed"
    case errored
}

public enum StripeBankAccountHolderType: String, Codable {
    case individual
    case company
}
