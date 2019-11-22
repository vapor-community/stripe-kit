//
//  UsageRecord.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/14/19.
//

import Foundation

public struct StripeUsageRecord: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// The usage quantity for the specified date.
    public var quantity: Int?
    /// The ID of the subscription item this usage record contains data for.
    public var subscriptionItem: String?
    /// The timestamp when this usage occurred.
    public var timestamp: Date?
}

public struct StripeUsageRecordList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeUsageRecord]?
}
