//
//  ApplicationFeeRefund.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/17/19.
//

import Foundation
/// `Application Fee Refund` objects allow you to refund an application fee that has previously been created but not yet refunded. Funds will be refunded to the Stripe account from which the fee was originally collected.
public struct ApplicationFeeRefund: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Amount, in cents.
    public var amount: Int?
    /// Balance transaction that describes the impact on your account balance.
    @Expandable<BalanceTransaction> public var balanceTransaction: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// ID of the application fee that was refunded.
    @Expandable<ApplicationFee> public var fee: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    
    public init(id: String,
                object: String,
                amount: Int? = nil,
                balanceTransaction: String? = nil,
                created: Date,
                currency: Currency? = nil,
                fee: String? = nil,
                metadata: [String : String]? = nil) {
        self.id = id
        self.object = object
        self.amount = amount
        self._balanceTransaction = Expandable(id: balanceTransaction)
        self.created = created
        self.currency = currency
        self._fee = Expandable(id: fee)
        self.metadata = metadata
    }
}

public struct ApplicationFeeRefundList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [ApplicationFeeRefund]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [ApplicationFeeRefund]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
