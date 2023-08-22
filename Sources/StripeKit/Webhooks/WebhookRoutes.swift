//
//  WebhookRoutes.swift
//  
//
//  Created by Andrew Edwards on 12/27/19.
//

import NIO
import NIOHTTP1

public protocol WebhookEndpointRoutes: StripeAPIRoute {
    /// A webhook endpoint must have a `url` and a list of `enabled_events`. You may optionally specify the Boolean `connect` parameter. If set to true, then a Connect webhook endpoint that notifies the specified `url` about events from all connected accounts is created; otherwise an account webhook endpoint that notifies the specified `url` only about events from your account is created. You can also create webhook endpoints in the [webhooks settings](https://dashboard.stripe.com/account/webhooks) section of the Dashboard.
    /// - Parameter enabledEvents: The list of events to enable for this endpoint. You may specify `['*']` to enable all events, except those that require explicit selection.
    /// - Parameter url: The URL of the webhook endpoint.
    /// - Parameter apiVersion: Events sent to this endpoint will be generated with this Stripe Version instead of your account’s default Stripe Version.
    /// - Parameter metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    /// - Parameter description: An optional description of what the webhook is used for.
    /// - Parameter connect: Whether this endpoint should receive events from connected accounts (true), or from your account (false). Defaults to false.
    func create(enabledEvents: [String],
                url: String,
                apiVersion: String?,
                description: String?,
                metadata: [String: String]?,
                connect: Bool?) async throws -> Webhook
    
    /// Retrieves the webhook endpoint with the given ID.
    /// - Parameter webhookEndpoint: The ID of the desired webhook endpoint.
    func retrieve(webhookEndpoint: String) async throws -> Webhook
    
    /// Updates the webhook endpoint. You may edit the `url`, the list of `enabled_events`, and the status of your endpoint.
    /// - Parameter webhookEndpoint: The ID of the desired webhook endpoint.
    /// - Parameter description: An optional description of what the webhook is used for.
    /// - Parameter enabledEvents: The list of events to enable for this endpoint. You may specify `['*']` to enable all events, except those that require explicit selection.
    /// - Parameter metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    /// - Parameter url: The URL of the webhook endpoint.
    /// - Parameter disabled: Disable the webhook endpoint if set to true.
    func update(webhookEndpoint: String,
                description: String?,
                enabledEvents: [String]?,
                metadata: [String: String]?,
                url: String?,
                disabled: Bool?) async throws -> Webhook
    
    /// Returns a list of your webhook endpoints.
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/sigma/webhooks/list)
    func listAll(filter: [String: Any]?) async throws -> WebhookList
    
    /// You can also delete webhook endpoints via the webhook endpoint management page of the Stripe dashboard.
    /// - Parameter webhookEndpoint: The ID of the webhook endpoint to delete.
    func delete(webhookEndpoint: String) async throws -> Webhook
}

public struct StripeWebhookEndpointRoutes: WebhookEndpointRoutes {
    public var headers: HTTPHeaders = [:]

    private let apiHandler: StripeAPIHandler
    private let webhooks = APIBase + APIVersion + "webhook_endpoints"

    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(enabledEvents: [String],
                       url: String,
                       apiVersion: String? = nil,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       connect: Bool? = nil) async throws -> Webhook {
        var body: [String: Any] = ["enabled_events": enabledEvents,
                                   "url": url]
        
        if let apiVersion {
            body["api_version"] = apiVersion
        }
        
        if let description {
            body["description"] = description
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let connect {
            body["connect"] = connect
        }
        
        return try await apiHandler.send(method: .POST, path: webhooks, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(webhookEndpoint: String) async throws -> Webhook {
        try await apiHandler.send(method: .GET, path: "\(webhooks)/\(webhookEndpoint)", headers: headers)
    }
    
    public func update(webhookEndpoint: String,
                       description: String? = nil,
                       enabledEvents: [String]? = nil,
                       metadata: [String: String]? = nil,
                       url: String? = nil,
                       disabled: Bool? = nil) async throws -> Webhook {
        var body: [String: Any] = [:]
        
        if let description {
            body["description"] = description
        }
        
        if let enabledEvents {
            body["enabled_events"] = enabledEvents
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let url {
            body["url"] = url
        }
        
        if let disabled {
            body["disabled"] = disabled
        }
        
        return try await apiHandler.send(method: .POST, path: "\(webhooks)/\(webhookEndpoint)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> WebhookList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        return try await apiHandler.send(method: .GET, path: webhooks, query: queryParams, headers: headers)
    }
    
    public func delete(webhookEndpoint: String) async throws -> Webhook {
        try await apiHandler.send(method: .DELETE, path: "\(webhooks)/\(webhookEndpoint)", headers: headers)
    }
}

