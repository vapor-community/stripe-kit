//
//  MeterRoutes.swift
//  stripe-kit
//
//  Created by TelemetryDeck on 08.01.25.
//

import Foundation
import NIO
import NIOHTTP1

/// Meters specify how to aggregate meter events over a billing period. Meter events represent the actions that customers take in your system. Meters attach to prices and form the basis of the bill.
///
/// Related guide: [Usage based billing](https://docs.stripe.com/billing/subscriptions/usage-based).
public protocol MeterRoutes: StripeAPIRoute {
    /// Creates a billing meter.
    ///
    /// - Parameters:
    ///  - defaultAggregation: The default settings to aggregate a meter’s events with.
    ///  - displayName: The meter’s name. Not visible to the customer.
    ///  - eventName: The name of the meter event to record usage for. Corresponds with the `event_name` field on meter events.
    ///  - customerMapping: Fields that specify how to map a meter event to a customer.
    func create(
        defaultAggregation: MeterDefaultAggregation,
        displayName: String,
        eventName: String,
        customerMapping: MeterCustomerMapping?,
        eventTimeWindow: MeterEventTimeWindow?,
        valueSettings: MeterValueSettings?
    ) async throws -> Meter

    /// Updates a billing meter.
    ///
    /// - Parameters:
    /// - id: Unique identifier for the object.
    /// - displayName: The meter’s name. Not visible to the customer.
    func update(
        id: String,
        displayName: String?
    ) async throws -> Meter

    /// Retrieves a billing meter.
    ///
    /// - Parameters:
    /// - id: Unique identifier for the object.
    func retrieve(id: String) async throws -> Meter

    /// Returns a list of your billing meters.
    func listAll() async throws -> [Meter]

    /// Deactivates a billing meter.
    ///
    /// - Parameters:
    /// - id: Unique identifier for the object.
    func deactivate(id: String) async throws -> Meter

    /// Reactivates a billing meter.
    ///
    /// - Parameters:
    /// - id: Unique identifier for the object.
    func reactivate(id: String) async throws -> Meter
}

public struct StripeMeterRoutes: MeterRoutes {
    public var headers: HTTPHeaders = [:]

    private let apiHandler: StripeAPIHandler
    private let meters = APIBase + APIVersion + "billing/meters"

    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func create(
        defaultAggregation: MeterDefaultAggregation,
        displayName: String,
        eventName: String,
        customerMapping: MeterCustomerMapping?,
        eventTimeWindow: MeterEventTimeWindow?,
        valueSettings: MeterValueSettings?
    ) async throws -> Meter {
        var body: [String: Any] = [
            "default_aggregation[formula]": defaultAggregation.formula.rawValue,
            "display_name": displayName,
            "event_name": eventName
        ]

        if let customerMapping = customerMapping {
            body["customer_mapping[event_payload_key]"] = customerMapping.eventPayloadKey
            body["customer_mapping[type]"] = customerMapping.type.rawValue
        }

        if let eventTimeWindow = eventTimeWindow {
            body["event_time_window"] = eventTimeWindow.rawValue
        }

        if let valueSettings = valueSettings {
            body["value_settings[event_payload_key]"] = valueSettings.eventPayloadKey
        }

        return try await apiHandler.send(
            method: .POST,
            path: meters,
            body: .string(body.queryParameters),
            headers: headers
        )
    }

    public func update(id: String, displayName: String?) async throws -> Meter {
        var body: [String: Any] = [:]

        if let displayName = displayName {
            body["display_name"] = displayName
        }

        return try await apiHandler.send(
            method: .POST,
            path: "\(meters)/\(id)",
            body: .string(body.queryParameters),
            headers: headers
        )
    }

    public func retrieve(id: String) async throws -> Meter {
        return try await apiHandler.send(method: .GET, path: "\(meters)/\(id)", headers: headers)
    }

    public func listAll() async throws -> [Meter] {
        return try await apiHandler.send(
            method: .GET,
            path: meters,
            headers: headers
        )
    }

    public func deactivate(id: String) async throws -> Meter {
        return try await apiHandler.send(
            method: .POST,
            path: "\(meters)/\(id)/deactivate",
            headers: headers
        )
    }

    public func reactivate(id: String) async throws -> Meter {
        return try await apiHandler.send(
            method: .POST,
            path: "\(meters)/\(id)/reactivate",
            headers: headers
        )
    }
}
