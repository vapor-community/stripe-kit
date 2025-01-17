//
//  MeterEventSummary.swift
//  stripe-kit
//
//  Created by TelemetryDeck on 17.01.25.
//

import Foundation

/// The [Meter Event Summary Object](https://docs.stripe.com/api/billing/meter-event-summary)
public struct MeterEventSummary: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Aggregated value of all the events within `start_time` (inclusive) and `end_time` (inclusive). The aggregation strategy is defined on meter via `default_aggregation`.
    public var aggregatedValue: Float
    /// End timestamp for this event summary (exclusive). Must be aligned with minute boundaries.
    public var endTime: Date
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool
    /// The meter associated with this event summary.
    public var meter: String
    /// Start timestamp for this event summary (inclusive). Must be aligned with minute boundaries.
    public var startTime: Date

    public init(
        id: String,
        object: String,
        aggregatedValue: Float,
        endTime: Date,
        livemode: Bool,
        meter: String,
        startTime: Date
    ) {
        self.id = id
        self.object = object
        self.aggregatedValue = aggregatedValue
        self.endTime = endTime
        self.livemode = livemode
        self.meter = meter
        self.startTime = startTime
    }
}

public enum MeterEventSummaryValueGroupingWindow: String, Codable {
    case day
    case hour
}
