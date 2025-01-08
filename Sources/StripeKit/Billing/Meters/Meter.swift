//
//  Meter.swift
//  stripe-kit
//
//  Created by TelemetryDeck on 08.01.25.
//

import Foundation

/// The Meter Object
public struct Meter: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// Fields that specify how to map a meter event to a customer.
    public var customerMapping: MeterCustomerMapping
    /// The meter’s name.
    public var displayName: String
    /// The name of the meter event to record usage for. Corresponds with the `event_name` field on meter events.
    public var eventName: String
    /// The time window to pre-aggregate meter events for, if any.
    public var eventTimeWindow: MeterEventTimeWindow?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var liveMode: Bool?
    /// The meter’s status.
    public var status: MeterStatus
    /// The timestamps at which the meter status changed.
    public var meterStatusTransitions: MeterStatusTransitions
    /// Time at which the object was last updated. Measured in seconds since the Unix epoch.
    public var updated: Date
    /// Fields that specify how to calculate a meter event’s value.
    public var valueSettings: MeterValueSettings
}

public struct MeterCustomerMapping: Codable {
    /// The key in the meter event payload to use for mapping the event to a customer.
    public var eventPayloadKey: String
    /// The method for mapping a meter event to a customer.
    public var type: MeterCustomerMappingType
}

public enum MeterCustomerMappingType: String, Codable {
    /// Map a meter event to a customer by passing a customer ID in the event’s payload.
    case byID = "by_id"
}

public enum MeterEventTimeWindow: String, Codable {
    /// Events are pre-aggregated in daily buckets.
    case day
    /// Events are pre-aggregated in hourly buckets.
    case hour
}

public enum MeterStatus: String, Codable {
    /// The meter is active.
    case active
    /// The meter is inactive. No more events for this meter will be accepted. The meter cannot be attached to a price.
    case inactive
}

public struct MeterStatusTransitions: Codable {
    /// The time the meter was deactivated, if any. Measured in seconds since Unix epoch.
    public var deactivatedAt: Date?
}

public struct MeterValueSettings: Codable {
    /// The key in the meter event payload to use as the value for this meter.
    public var eventPayloadKey: String
}

public struct MeterDefaultAggregation: Codable {
    public var formula: MeterDefaultAggregationFormula
}

public enum MeterDefaultAggregationFormula: String, Codable {
    /// Count the number of events.
    case count
    /// Sum each event’s value.
    case sum
}
