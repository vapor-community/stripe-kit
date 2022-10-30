//
//  Balance.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

/// The [Balance Object](https://stripe.com/docs/api/balance/balance_object)
public struct Balance: Codable {
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Funds that are available to be transferred or paid out, whether automatically by Stripe or explicitly via the [Transfers API](https://stripe.com/docs/api/balance/balance_object#transfers) or [Payouts API](https://stripe.com/docs/api/balance/balance_object#payouts). The available balance for each currency and payment type can be found in the `source_types` property.
    public var available: [BalanceAmount]?
    /// Funds held due to negative balances on connected Custom accounts. The connect reserve balance for each currency and payment type can be found in the `source_types` property.
    public var connectReserved: [BalanceAmount]?
    /// Funds that can be paid out using Instant Payouts.
    public var instantAvailable: [BalanceAmount]?
    /// Funds that can be spent on your Issued Cards.
    public var issuing: BalanceIssuing?
    ///Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// Funds that are not yet available in the balance, due to the 7-day rolling pay cycle. The pending balance for each currency, and for each payment type, can be found in the `source_types` property.
    public var pending: [BalanceAmount]?
    
    public init(object: String,
                available: [BalanceAmount]? = nil,
                connectReserved: [BalanceAmount]? = nil,
                instantAvailable: [BalanceAmount]? = nil,
                issuing: BalanceIssuing? = nil,
                livemode: Bool? = nil,
                pending: [BalanceAmount]? = nil) {
        self.object = object
        self.available = available
        self.connectReserved = connectReserved
        self.instantAvailable = instantAvailable
        self.issuing = issuing
        self.livemode = livemode
        self.pending = pending
    }
}

public struct BalanceIssuing: Codable {
    /// Funds that are available for use.
    public var available: [BalanceAmount]?
    
    public init(available: [BalanceAmount]? = nil) {
        self.available = available
    }
}

public struct BalanceAmount: Codable {
    /// Balance amount.
    public var amount: Int?
    /// Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies) .
    public var currency: StripeCurrency?
    /// Breakdown of balance by source types.
    public var sourceTypes: BalanceAmountSourceType?
    
    public init(amount: Int? = nil,
                currency: StripeCurrency? = nil,
                sourceTypes: BalanceAmountSourceType? = nil) {
        self.amount = amount
        self.currency = currency
        self.sourceTypes = sourceTypes
    }
}

public struct BalanceAmountSourceType: Codable {
    /// Amount for bank account.
    public var bankAccount: Int?
    /// Amount for card.
    public var card: Int?
    /// Amount for FPX.
    public var fpx: Int?
    
    public init(bankAccount: Int? = nil,
                card: Int? = nil,
                fpx: Int? = nil) {
        self.bankAccount = bankAccount
        self.card = card
        self.fpx = fpx
    }
}
