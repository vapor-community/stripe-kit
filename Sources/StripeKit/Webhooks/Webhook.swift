//
//  Webhook.swift
//  
//
//  Created by Andrew Edwards on 12/27/19.
//

import Foundation

/// The [Webhook Object](https://stripe.com/docs/api/webhook_endpoints)
public struct Webhook: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// The API version events are rendered as for this webhook endpoint.
    public var apiVersion: String?
    /// An optional description of what the webhook is used for.
    public var description: String?
    /// The list of events to enable for this endpoint. `['*']` indicates that all events are enabled, except those that require explicit selection.
    public var enabledEvents: [String]?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The endpoint’s secret, used to generate webhook signatures. Only returned at creation.
    public var secret: String?
    /// The status of the webhook. It can be  `enabled` or `disabled`.
    public var status: WebhookStatus?
    /// The URL of the webhook endpoint.
    public var url: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The ID of the associated Connect application.
    public var application: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool?
    
    public init(id: String,
                apiVersion: String? = nil,
                description: String? = nil,
                enabledEvents: [String]? = nil,
                metadata: [String : String]? = nil,
                secret: String? = nil,
                status: WebhookStatus? = nil,
                url: String? = nil,
                object: String,
                application: String? = nil,
                created: Date,
                livemode: Bool? = nil) {
        self.id = id
        self.apiVersion = apiVersion
        self.description = description
        self.enabledEvents = enabledEvents
        self.metadata = metadata
        self.secret = secret
        self.status = status
        self.url = url
        self.object = object
        self.application = application
        self.created = created
        self.livemode = livemode
    }
}

public enum WebhookStatus: String, Codable {
    case enabled
    case disabled
}

public struct WebhookList: Codable {
    public var object: String
    public var data: [Webhook]?
    public var hasMore: Bool?
    public var url: String?
    
    public init(object: String,
                data: [Webhook]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}
