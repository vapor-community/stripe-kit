//
//  MeterEvent.swift
//  stripe-kit
//
//  Created by TelemetryDeck on 08.01.25.
//

import Foundation

/// The [Meter Even Object](https://docs.stripe.com/api/billing/meter-event/object).
public struct MeterEvent: Codable {
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// The name of the meter event. Corresponds with the `event_name` field on a meter.
    public var eventName: String
    /// A unique identifier for the event.
    public var identifier: String
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool
    /// The payload of the event. This contains the fields corresponding to a meter’s `customer_mapping.event_payload_key` (default is `stripe_customer_id`) and `value_settings.event_payload_key` (default is `value`). Read more about the [payload](https://docs.stripe.com/billing/subscriptions/usage-based/recording-usage#payload-key-overrides).
    public var payload: [String: String]
    /// The timestamp passed in when creating the event. Measured in seconds since the Unix epoch.
    public var timestamp: Date

    public init(
        object: String,
        created: Date? = nil,
        eventName: String,
        identifier: String,
        livemode: Bool,
        payload: [String: String],
        timestamp: Date
    ) {
        self.object = object
        self.created = created
        self.eventName = eventName
        self.identifier = identifier
        self.livemode = livemode
        self.payload = payload
        self.timestamp = timestamp
    }
}
