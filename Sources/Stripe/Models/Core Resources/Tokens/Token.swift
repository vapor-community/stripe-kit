//
//  Token.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/23/17.
//
//

import Foundation

/// The [Token Object](https://stripe.com/docs/api/tokens/object?lang=curl).
public struct StripeToken: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Hash describing the bank account.
    public var bankAccount: StripeBankAccount?
    /// Hash describing the card used to make the charge.
    public var card: StripeCard?
    /// IP address of the client that generated the token.
    public var clientIp: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Type of the token: `account`, `bank_account`, `card`, or `pii`.
    public var type: StripeTokenType?
    /// Whether this token has already been used (tokens can be used only once).
    public var used: Bool?
}

public enum StripeTokenType: String, StripeModel {
    case account
    case bankAccount = "bank_account"
    case card
    case pii
}
