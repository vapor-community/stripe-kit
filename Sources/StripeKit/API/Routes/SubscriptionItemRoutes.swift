//
//  SubscriptionItemRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/6/17.
//
//

import NIO
import NIOHTTP1
import Foundation

public protocol SubscriptionItemRoutes {
    /// Adds a new item to an existing subscription. No existing items will be changed or replaced.
    ///
    /// - Parameters:
    ///   - plan: The identifier of the plan to add to the subscription.
    ///   - subscription: The identifier of the subscription to modify.
    ///   - billingThresholds: Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - prorate: Flag indicating whether to prorate switching plans during a billing cycle.
    ///   - prorationDate: If set, the proration will be calculated as though the subscription was updated at the given time. This can be used to apply the same proration that was previewed with the upcoming invoice endpoint.
    ///   - quantity: The quantity you’d like to apply to the subscription item you’re creating.
    ///   - taxRates: The tax rates which apply to this subscription_item. When set, the default_tax_rates on the subscription do not apply to this subscription_item.
    /// - Returns: A `StripeSubscriptionItem`.
    /// - Throws: A `StripeError`.
    func create(plan: String,
                subscription: String,
                billingThresholds: [String: Any]?,
                metadata: [String: String]?,
                prorate: Bool?,
                prorationDate: Date?,
                quantity: Int?,
                taxRates: [String]?) throws -> EventLoopFuture<StripeSubscriptionItem>
    
    /// Retrieves the invoice item with the given ID.
    ///
    /// - Parameter item: The identifier of the subscription item to retrieve.
    /// - Returns: A `StripeSubscriptionItem`.
    /// - Throws: A `StripeError`.
    func retrieve(item: String) throws -> EventLoopFuture<StripeSubscriptionItem>
    
    /// Updates the plan or quantity of an item on a current subscription.
    ///
    /// - Parameters:
    ///   - item: The identifier of the subscription item to modify.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - plan: The identifier of the new plan for this subscription item.
    ///   - prorate: Flag indicating whether to prorate switching plans during a billing cycle.
    ///   - prorationDate: If set, the proration will be calculated as though the subscription was updated at the given time. This can be used to apply the same proration that was previewed with the upcoming invoice endpoint.
    ///   - quantity: The quantity you’d like to apply to the subscription item you’re creating.
    ///   - taxRates: The tax rates which apply to this subscription_item. When set, the default_tax_rates on the subscription do not apply to this subscription_item.
    /// - Returns: A `StripeSubscriptionItem`.
    /// - Throws: A `StripeError`.
    func update(item: String,
                metadata: [String: String]?,
                plan: String?,
                prorate: Bool?,
                prorationDate: Date?,
                quantity: Int?,
                taxRates: [String]?) throws -> EventLoopFuture<StripeSubscriptionItem>
    
    /// Deletes an item from the subscription. Removing a subscription item from a subscription will not cancel the subscription.
    ///
    /// - Parameters:
    ///   - item: The identifier of the subscription item to delete.
    ///   - clearUsage: Delete all usage for the given subscription item. Allowed only when the current plan’s `usage_type` is `metered`.
    ///   - prorate: Flag indicating whether to prorate switching plans during a billing cycle.
    ///   - prorationDate: If set, the proration will be calculated as though the subscription was updated at the given time. This can be used to apply the same proration that was previewed with the upcoming invoice endpoint.
    /// - Returns: A `StripeSubscriptionItem`.
    /// - Throws: A `StripeError`.
    func delete(item: String, clearUsage: Bool?, prorate: Bool?, prorationDate: Date?) throws -> EventLoopFuture<StripeSubscriptionItem>
    
    /// Returns a list of your subscription items for a given subscription.
    ///
    /// - Parameters:
    ///   - subscription: The ID of the subscription whose items will be retrieved.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/subscription_items/list)
    /// - Returns: A `StripeSubscriptionItemList`.
    /// - Throws: A `StripeError`.
    func listAll(subscription: String, filter: [String: Any]?) throws -> EventLoopFuture<StripeSubscriptionItemList>
    
    var headers: HTTPHeaders { get set }
}

extension SubscriptionItemRoutes {
    public func create(plan: String,
                       subscription: String,
                       billingThresholds: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       prorate: Bool? = nil,
                       prorationDate: Date? = nil,
                       quantity: Int? = nil,
                       taxRates: [String]? = nil) throws -> EventLoopFuture<StripeSubscriptionItem> {
        return try create(plan: plan,
                          subscription: subscription,
                          billingThresholds: billingThresholds,
                          metadata: metadata,
                          prorate: prorate,
                          prorationDate: prorationDate,
                          quantity: quantity,
                          taxRates: taxRates)
    }
    
    public func retrieve(item: String) throws -> EventLoopFuture<StripeSubscriptionItem> {
        return try retrieve(item: item)
    }
    
    public func update(item: String,
                       metadata: [String: String]? = nil,
                       plan: String? = nil,
                       prorate: Bool? = nil,
                       prorationDate: Date? = nil,
                       quantity: Int? = nil,
                       taxRates: [String]? = nil) throws -> EventLoopFuture<StripeSubscriptionItem> {
        return try update(item: item,
                          metadata: metadata,
                          plan: plan,
                          prorate: prorate,
                          prorationDate: prorationDate,
                          quantity: quantity,
                          taxRates: taxRates)
    }
    
    public func delete(item: String,
                       clearUsage: Bool? = nil,
                       prorate: Bool? = nil,
                       prorationDate: Date? = nil) throws -> EventLoopFuture<StripeSubscriptionItem> {
        return try delete(item: item,
                          clearUsage: clearUsage,
                          prorate: prorate,
                          prorationDate: prorationDate)
    }
    
    public func listAll(subscription: String, filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeSubscriptionItemList> {
        return try listAll(subscription: subscription, filter: filter)
    }
}

public struct StripeSubscriptionItemRoutes: SubscriptionItemRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func create(plan: String,
                       subscription: String,
                       billingThresholds: [String: Any]?,
                       metadata: [String: String]?,
                       prorate: Bool?,
                       prorationDate: Date?,
                       quantity: Int?,
                       taxRates: [String]?) throws -> EventLoopFuture<StripeSubscriptionItem> {
        var body: [String: Any] = ["plan": plan,
                                   "subscription": subscription]
        
        if let billingThresholds = billingThresholds {
            billingThresholds.forEach { body["billing_thresholds[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let prorate = prorate {
            body["prorate"] = prorate
        }
        
        if let prorationDate = prorationDate {
            body["proration_date"] = Int(prorationDate.timeIntervalSince1970)
        }
        
        if let quantity = quantity {
            body["quantity"] = quantity
        }
        
        if let taxRates = taxRates {
            body["tax_rates"] = taxRates
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.subscriptionItem.endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(item: String) throws -> EventLoopFuture<StripeSubscriptionItem> {
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.subscriptionItems(item).endpoint, headers: headers)
    }
    
    public func update(item: String,
                       metadata: [String: String]?,
                       plan: String?,
                       prorate: Bool?,
                       prorationDate: Date?,
                       quantity: Int?,
                       taxRates: [String]?) throws -> EventLoopFuture<StripeSubscriptionItem> {
        var body: [String: Any] = [:]
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        if let plan = plan {
            body["plan"] = plan
        }

        if let prorate = prorate {
            body["prorate"] = prorate
        }
        
        if let prorationDate = prorationDate {
            body["proration_date"] = Int(prorationDate.timeIntervalSince1970)
        }
        
        if let quantity = quantity {
            body["quantity"] = quantity
        }
        
        if let taxRates = taxRates {
            body["tax_rates"] = taxRates
        }

        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.subscriptionItems(item).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(item: String,
                       clearUsage: Bool?,
                       prorate: Bool?,
                       prorationDate: Date?) throws -> EventLoopFuture<StripeSubscriptionItem> {
        var body: [String: Any] = [:]

        if let prorate = prorate {
            body["prorate"] = prorate
        }
        
        if let clearUsage = clearUsage {
            body["clear_usage"] = clearUsage
        }
        
        if let prorationDate = prorationDate {
            body["proration_date"] = Int(prorationDate.timeIntervalSince1970)
        }

        return try apiHandler.send(method: .DELETE, path: StripeAPIEndpoint.subscriptionItems(item).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(subscription: String, filter: [String: Any]?) throws -> EventLoopFuture<StripeSubscriptionItemList> {
        var queryParams = "subscription=\(subscription)"
        if let filter = filter {
            queryParams = "&" + filter.queryParameters
        }
        
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.subscriptionItem.endpoint, query: queryParams)
    }
}
