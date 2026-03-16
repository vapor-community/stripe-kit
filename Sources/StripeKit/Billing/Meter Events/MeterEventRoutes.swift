//
//  MeterEventRoutes.swift
//  stripe-kit
//
//  Created by TelemetryDeck on 08.01.25.
//

import Foundation
import NIO
import NIOHTTP1

public protocol MeterEventRoutes: StripeAPIRoute {
    /// Creates a billing meter event.
    ///
    /// - Parameters:
    ///  - event_name: The name of the meter event. Corresponds with the `event_name` field on a meter.
    ///  - payload: The payload of the event. This contains the fields corresponding to a meter’s `customer_mapping.event_payload_key` (default is `stripe_customer_id`) and `value_settings.event_payload_key` (default is `value`). Read more about the [payload](https://docs.stripe.com/billing/subscriptions/usage-based/recording-usage#payload-key-overrides).
    ///  - identifier: A unique identifier for the event.
    ///  - timestamp: The timestamp passed in when creating the event. Measured in seconds since the Unix epoch. Must be within the past 35 calendar days or up to 5 minutes in the future. Defaults to current timestamp if not specified.
    func create(
        event_name: String,
        payload: [String: String],
        identifier: String?,
        timestamp: Date?) async throws -> MeterEvent
}

public struct StripeMeterEventRoutes: MeterEventRoutes {
    public var headers: HTTPHeaders = [:]

    private let apiHandler: StripeAPIHandler
    private let meterevents = APIBase + APIVersion + "billing/meter_events"

    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func create(
        event_name: String,
        payload: [String: String],
        identifier: String?,
        timestamp: Date?) async throws -> MeterEvent
    {
        var body: [String: Any] = [
            "event_name": event_name,
            "payload": payload
        ]

        if let identifier {
            body["identifier"] = identifier
        }

        if let timestamp {
            body["timestamp"] = Int(timestamp.timeIntervalSince1970)
        }

        return try await apiHandler.send(
            method: .POST,
            path: meterevents,
            body: .string(body.queryParameters),
            headers: headers)
    }
}
