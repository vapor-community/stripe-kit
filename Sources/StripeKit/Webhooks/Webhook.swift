//
//  Webhook.swift
//  
//
//  Created by Andrew Edwards on 12/27/19.
//

import Foundation

/// The [Webhook Object](https://stripe.com/docs/api/webhook_endpoints)
public struct StripeWebhook: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The API version events are rendered as for this webhook endpoint.
    public var apiVersion: String?
    /// The ID of the associated Connect application.
    public var application: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The list of events to enable for this endpoint. `['*']` indicates that all events are enabled, except those that require explicit selection.
    public var enabledEvents: [String]?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    /// The endpoint’s secret, used to generate webhook signatures. Only returned at creation.
    public var secret: String?
    /// The status of the webhook. It can be  `enabled` or `disabled`.
    public var status: StripeWebhookStatus?
    /// The URL of the webhook endpoint.
    public var url: String?
}

public enum StripeWebhookStatus: String, Codable {
    case enabled
    case disabled
}

public struct StripeWebhookList: Codable {
    public var object: String
    public var data: [StripeWebhook]?
    public var hasMore: Bool?
    public var url: String?
}
