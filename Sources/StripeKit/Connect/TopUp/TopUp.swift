//
//  TopUp.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/24/19.
//

import Foundation
/// The top-up object [see here](https://stripe.com/docs/api/topups/object)
public struct TopUp: Codable {
    
    
    /// Unique identifier for the object.
    public var id: String
    /// Amount transferred.
    public var amount: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The status of the top-up is either `canceled`, `failed`, `pending`, `reversed`, or `succeeded`.
    public var status: TopUpStatus?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// ID of the balance transaction that describes the impact of this top-up on your account balance. May not be specified depending on status of top-up.
    @Expandable<BalanceTransaction> public var balanceTransaction: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Date the funds are expected to arrive in your Stripe account for payouts. This factors in delays like weekends or bank holidays. May not be specified depending on status of top-up.
    public var expectedAvailabilityDate: Date?
    /// Error code explaining reason for top-up failure if available (see [the errors section](https://stripe.com/docs/api#errors) for a list of codes).
    public var failureCode: String?
    /// Message to user further explaining reason for top-up failure if available.
    public var failureMessage: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// For most Stripe users, the source of every top-up is a bank account. This hash is then the [source object](https://stripe.com/docs/api/topups/object#source_object) describing that bank account.
    public var source: Source?
    /// Extra information about a top-up. This will appear on your source’s bank statement. It must contain at least one letter.
    public var statementDescriptor: String?
    /// A string that identifies this top-up as part of a group.
    public var transferGroup: String?
    
    public init(id: String,
                amount: Int? = nil,
                currency: Currency? = nil,
                description: String? = nil,
                metadata: [String : String]? = nil,
                status: TopUpStatus? = nil,
                object: String,
                balanceTransaction: String? = nil,
                created: Date,
                expectedAvailabilityDate: Date? = nil,
                failureCode: String? = nil,
                failureMessage: String? = nil,
                livemode: Bool? = nil,
                source: Source? = nil,
                statementDescriptor: String? = nil,
                transferGroup: String? = nil) {
        self.id = id
        self.amount = amount
        self.currency = currency
        self.description = description
        self.metadata = metadata
        self.status = status
        self.object = object
        self._balanceTransaction = Expandable(id: balanceTransaction)
        self.created = created
        self.expectedAvailabilityDate = expectedAvailabilityDate
        self.failureCode = failureCode
        self.failureMessage = failureMessage
        self.livemode = livemode
        self.source = source
        self.statementDescriptor = statementDescriptor
        self.transferGroup = transferGroup
    }
}

public enum TopUpStatus: String, Codable {
    case canceled
    case failed
    case pending
    case reversed
    case succeeded
}

public struct TopUpList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [TopUp]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [TopUp]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
