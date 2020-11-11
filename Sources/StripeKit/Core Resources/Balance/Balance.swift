//
//  Balance.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

/// The [Balance Object](https://stripe.com/docs/api/balance/balance_object)
public struct StripeBalance: StripeModel {
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Funds that are available to be transferred or paid out, whether automatically by Stripe or explicitly via the [Transfers API](https://stripe.com/docs/api/balance/balance_object#transfers) or [Payouts API](https://stripe.com/docs/api/balance/balance_object#payouts). The available balance for each currency and payment type can be found in the `source_types` property.
    public var available: [StripeBalanceAmount]?
    /// Funds held due to negative balances on connected Custom accounts. The connect reserve balance for each currency and payment type can be found in the `source_types` property.
    public var connectReserved: [StripeBalanceAmount]?
    /// Funds that can be paid out using Instant Payouts.
    public var instantAvailable: [StripeBalanceAmount]?
    /// Funds that can be spent on your Issued Cards.
    public var issuing: StripeBalanceIssuing?
    ///Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// Funds that are not yet available in the balance, due to the 7-day rolling pay cycle. The pending balance for each currency, and for each payment type, can be found in the `source_types` property.
    public var pending: [StripeBalanceAmount]?
}

public struct StripeBalanceIssuing: StripeModel {
    /// Funds that are available for use.
    public var available: [StripeBalanceAmount]?
}

public struct StripeBalanceAmount: StripeModel {
    /// Balance amount.
    public var amount: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// Breakdown of balance by source types.
    public var sourceTypes: StripeBalanceAmountSourceType?
}

public struct StripeBalanceAmountSourceType: StripeModel {
    /// Amount for bank account.
    public var bankAccount: Int?
    /// Amount for card.
    public var card: Int?
    /// Amount for FPX.
    public var fpx: Int?
}
