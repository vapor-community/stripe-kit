//
//  UsageRecord.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/14/19.
//

import Foundation

public struct UsageRecord: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool
    /// The usage quantity for the specified date.
    public var quantity: Int?
    /// The ID of the subscription item this usage record contains data for.
    public var subscriptionItem: String?
    /// The timestamp when this usage occurred.
    public var timestamp: Date?
    
    public init(id: String,
                object: String,
                livemode: Bool,
                quantity: Int? = nil,
                subscriptionItem: String? = nil,
                timestamp: Date? = nil) {
        self.id = id
        self.object = object
        self.livemode = livemode
        self.quantity = quantity
        self.subscriptionItem = subscriptionItem
        self.timestamp = timestamp
    }
}

public enum UsageRecordAction: String, Codable {
    case set
    case increment
}

public struct UsageRecordSummary: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object's type. Objects of the same type share the same value.
    public var object: String
    /// The invoice in which this usage period has been billed for.
    public var invoice: String?
    /// Has the value `true`if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool
    ///
    public var period: UsageRecordSummaryPeriod?
    /// The ID of the subscription item this summary is describing
    public var subscriptionItem: String?
    /// The total usage within this usage period.
    public var totalUsage: Int?
    
    public init(id: String,
                object: String,
                invoice: String? = nil,
                livemode: Bool,
                period: UsageRecordSummaryPeriod? = nil,
                subscriptionItem: String? = nil,
                totalUsage: Int? = nil) {
        self.id = id
        self.object = object
        self.invoice = invoice
        self.livemode = livemode
        self.period = period
        self.subscriptionItem = subscriptionItem
        self.totalUsage = totalUsage
    }
}

public struct UsageRecordSummaryPeriod: Codable {
    /// The end date of this usage period. All usage up to and including this point in time is included.
    public var end: Date?
    /// The start date of this usage period. All usage after this point in time is included.
    public var start: Date?
    
    public init(end: Date? = nil, start: Date? = nil) {
        self.end = end
        self.start = start
    }
}

public struct UsageRecordSummaryList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [UsageRecordSummary]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [UsageRecordSummary]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
