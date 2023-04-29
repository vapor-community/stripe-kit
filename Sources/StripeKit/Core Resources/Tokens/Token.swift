//
//  Token.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/23/17.
//
//

import Foundation

/// The [Token Object](https://stripe.com/docs/api/tokens/object) .
public struct Token: Codable {
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
    public var created: Date
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Type of the token: `account`, `bank_account`, `card`, or `pii`.
    public var type: TokenType?
    /// Whether this token has already been used (tokens can be used only once).
    public var used: Bool?
    
    public init(id: String,
                object: String,
                bankAccount: StripeBankAccount? = nil,
                card: StripeCard? = nil,
                clientIp: String? = nil,
                created: Date,
                livemode: Bool? = nil,
                type: TokenType? = nil,
                used: Bool? = nil) {
        self.id = id
        self.object = object
        self.bankAccount = bankAccount
        self.card = card
        self.clientIp = clientIp
        self.created = created
        self.livemode = livemode
        self.type = type
        self.used = used
    }
}

public enum TokenType: String, Codable {
    case account
    case person
    case bankAccount = "bank_account"
    case card
    case cvcUpdate = "cvc_update"
    case pii
}
