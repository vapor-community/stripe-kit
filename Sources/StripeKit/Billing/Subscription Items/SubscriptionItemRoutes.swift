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
// TODO: - Price
public protocol SubscriptionItemRoutes {
    /// Adds a new item to an existing subscription. No existing items will be changed or replaced.
    ///
    /// - Parameters:
    ///   - plan: The identifier of the plan to add to the subscription.
    ///   - subscription: The identifier of the subscription to modify.
    ///   - billingThresholds: Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - paymentBehavior: Use `allow_incomplete` to create subscriptions with `status=incomplete` if the first invoice cannot be paid. Creating subscriptions with this status allows you to manage scenarios where additional user actions are needed to pay a subscription’s invoice. For example, SCA regulation may require 3DS authentication to complete payment. See the SCA Migration Guide for Billing to learn more. This is the default behavior. Use `error_if_incomplete` if you want Stripe to return an HTTP 402 status code if a subscription’s first invoice cannot be paid. For example, if a payment method requires 3DS authentication due to SCA regulation and further user action is needed, this parameter does not create a subscription and returns an error instead. This was the default behavior for API versions prior to 2019-03-14. See the changelog to learn more.
    ///   - prorate: Flag indicating whether to prorate switching plans during a billing cycle.
    ///   - prorationBehavior: Determines how to handle prorations when the billing cycle changes (e.g., when switching plans, resetting `billing_cycle_anchor=now`, or starting a trial), or if an item’s `quantity` changes. Valid values are `create_prorations`, `none`, or `always_invoice`. Passing `create_prorations` will cause proration invoice items to be created when applicable. These proration items will only be invoiced immediately under certain conditions. In order to always invoice immediately for prorations, pass `always_invoice`. Prorations can be disabled by passing `none`.
    ///   - prorationDate: If set, the proration will be calculated as though the subscription was updated at the given time. This can be used to apply the same proration that was previewed with the upcoming invoice endpoint.
    ///   - quantity: The quantity you’d like to apply to the subscription item you’re creating.
    ///   - taxRates: The tax rates which apply to this subscription_item. When set, the default_tax_rates on the subscription do not apply to this subscription_item.
    /// - Returns: A `StripeSubscriptionItem`.
    func create(plan: String,
                subscription: String,
                billingThresholds: [String: Any]?,
                metadata: [String: String]?,
                paymentBehavior: StripeSubscriptionItemPaymentBehavior?,
                prorate: Bool?,
                prorationBehavior: StripeSubscriptionItemProrationBehavior?,
                prorationDate: Date?,
                quantity: Int?,
                taxRates: [String]?) -> EventLoopFuture<StripeSubscriptionItem>
    
    /// Retrieves the invoice item with the given ID.
    ///
    /// - Parameter item: The identifier of the subscription item to retrieve.
    /// - Returns: A `StripeSubscriptionItem`.
    func retrieve(item: String) -> EventLoopFuture<StripeSubscriptionItem>
    
    /// Updates the plan or quantity of an item on a current subscription.
    ///
    /// - Parameters:
    ///   - item: The identifier of the subscription item to modify.
    ///   - billingThresholds: Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period. When updating, pass an empty string to remove previously-defined thresholds.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - plan: The identifier of the new plan for this subscription item.
    ///   - prorate: Flag indicating whether to prorate switching plans during a billing cycle.
    ///   - prorationBehavior:Determines how to handle prorations when the billing cycle changes (e.g., when switching plans, resetting `billing_cycle_anchor=now`, or starting a trial), or if an item’s `quantity` changes. Valid values are `create_prorations`, `none`, or `always_invoice`. Passing `create_prorations` will cause proration invoice items to be created when applicable. These proration items will only be invoiced immediately under certain conditions. In order to always invoice immediately for prorations, pass `always_invoice`. Prorations can be disabled by passing `none`.
    ///   - prorationDate: If set, the proration will be calculated as though the subscription was updated at the given time. This can be used to apply the same proration that was previewed with the upcoming invoice endpoint.
    ///   - quantity: The quantity you’d like to apply to the subscription item you’re creating.
    ///   - taxRates: The tax rates which apply to this subscription_item. When set, the default_tax_rates on the subscription do not apply to this subscription_item.
    /// - Returns: A `StripeSubscriptionItem`.
    func update(item: String,
                billingThresholds: [String: Any]?,
                metadata: [String: String]?,
                offSession: Bool?,
                paymentBehavior: StripeSubscriptionItemPaymentBehavior?,
                plan: String?,
                prorate: Bool?,
                prorationBehavior: StripeSubscriptionItemProrationBehavior?,
                prorationDate: Date?,
                quantity: Int?,
                taxRates: [String]?) -> EventLoopFuture<StripeSubscriptionItem>
    
    /// Deletes an item from the subscription. Removing a subscription item from a subscription will not cancel the subscription.
    ///
    /// - Parameters:
    ///   - item: The identifier of the subscription item to delete.
    ///   - clearUsage: Delete all usage for the given subscription item. Allowed only when the current plan’s `usage_type` is `metered`.
    ///   - prorate: Flag indicating whether to prorate switching plans during a billing cycle.
    ///   - prorationDate: If set, the proration will be calculated as though the subscription was updated at the given time. This can be used to apply the same proration that was previewed with the upcoming invoice endpoint.
    /// - Returns: A `StripeSubscriptionItem`.
    func delete(item: String, clearUsage: Bool?, prorate: Bool?, prorationDate: Date?) -> EventLoopFuture<StripeSubscriptionItem>
    
    /// Returns a list of your subscription items for a given subscription.
    ///
    /// - Parameters:
    ///   - subscription: The ID of the subscription whose items will be retrieved.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/subscription_items/list)
    /// - Returns: A `StripeSubscriptionItemList`.
    func listAll(subscription: String, filter: [String: Any]?) -> EventLoopFuture<StripeSubscriptionItemList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension SubscriptionItemRoutes {
    public func create(plan: String,
                       subscription: String,
                       billingThresholds: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       paymentBehavior: StripeSubscriptionItemPaymentBehavior? = nil,
                       prorate: Bool? = nil,
                       prorationBehavior: StripeSubscriptionItemProrationBehavior? = nil,
                       prorationDate: Date? = nil,
                       quantity: Int? = nil,
                       taxRates: [String]? = nil) -> EventLoopFuture<StripeSubscriptionItem> {
        return create(plan: plan,
                      subscription: subscription,
                      billingThresholds: billingThresholds,
                      metadata: metadata,
                      paymentBehavior: paymentBehavior,
                      prorate: prorate,
                      prorationBehavior: prorationBehavior,
                      prorationDate: prorationDate,
                      quantity: quantity,
                      taxRates: taxRates)
    }
    
    public func retrieve(item: String) -> EventLoopFuture<StripeSubscriptionItem> {
        return retrieve(item: item)
    }
    
    public func update(item: String,
                       billingThresholds: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       offSession: Bool? = nil,
                       paymentBehavior: StripeSubscriptionItemPaymentBehavior? = nil,
                       plan: String? = nil,
                       prorate: Bool? = nil,
                       prorationBehavior: StripeSubscriptionItemProrationBehavior? = nil,
                       prorationDate: Date? = nil,
                       quantity: Int? = nil,
                       taxRates: [String]? = nil) -> EventLoopFuture<StripeSubscriptionItem> {
        return update(item: item,
                      billingThresholds: billingThresholds,
                      metadata: metadata,
                      offSession: offSession,
                      paymentBehavior: paymentBehavior,
                      plan: plan,
                      prorate: prorate,
                      prorationBehavior: prorationBehavior,
                      prorationDate: prorationDate,
                      quantity: quantity,
                      taxRates: taxRates)
    }
    
    public func delete(item: String,
                       clearUsage: Bool? = nil,
                       prorate: Bool? = nil,
                       prorationDate: Date? = nil) -> EventLoopFuture<StripeSubscriptionItem> {
        return delete(item: item,
                          clearUsage: clearUsage,
                          prorate: prorate,
                          prorationDate: prorationDate)
    }
    
    public func listAll(subscription: String, filter: [String: Any]? = nil) -> EventLoopFuture<StripeSubscriptionItemList> {
        return listAll(subscription: subscription, filter: filter)
    }
}

public struct StripeSubscriptionItemRoutes: SubscriptionItemRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let subscirptionitems = APIBase + APIVersion + "subscription_items"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func create(plan: String,
                       subscription: String,
                       billingThresholds: [String: Any]?,
                       metadata: [String: String]?,
                       paymentBehavior: StripeSubscriptionItemPaymentBehavior?,
                       prorate: Bool?,
                       prorationBehavior: StripeSubscriptionItemProrationBehavior?,
                       prorationDate: Date?,
                       quantity: Int?,
                       taxRates: [String]?) -> EventLoopFuture<StripeSubscriptionItem> {
        var body: [String: Any] = ["plan": plan,
                                   "subscription": subscription]
        
        if let billingThresholds = billingThresholds {
            billingThresholds.forEach { body["billing_thresholds[\($0)]"] = $1 }
        }
        
        if let paymentBehavior = paymentBehavior {
            body["payment_behavior"] = paymentBehavior
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let prorate = prorate {
            body["prorate"] = prorate
        }
        
        if let prorationBehavior = prorationBehavior {
            body["proration_behavior"] = prorationBehavior.rawValue
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
        
        return apiHandler.send(method: .POST, path: subscirptionitems, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(item: String) -> EventLoopFuture<StripeSubscriptionItem> {
        return apiHandler.send(method: .GET, path: "\(subscirptionitems)/\(item)", headers: headers)
    }
    
    public func update(item: String,
                       billingThresholds: [String: Any]?,
                       metadata: [String: String]?,
                       offSession: Bool?,
                       paymentBehavior: StripeSubscriptionItemPaymentBehavior?,
                       plan: String?,
                       prorate: Bool?,
                       prorationBehavior: StripeSubscriptionItemProrationBehavior?,
                       prorationDate: Date?,
                       quantity: Int?,
                       taxRates: [String]?) -> EventLoopFuture<StripeSubscriptionItem> {
        var body: [String: Any] = [:]
        
        if let billingThresholds = billingThresholds {
            billingThresholds.forEach { body["billing_thresholds[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        if let offSession = offSession {
            body["off_session"] = offSession
        }
        
        if let paymentBehavior = paymentBehavior {
            body["payment_behavior"] = paymentBehavior
        }
        
        if let plan = plan {
            body["plan"] = plan
        }

        if let prorate = prorate {
            body["prorate"] = prorate
        }
        
        if let prorationBehavior = prorationBehavior {
            body["proration_behavior"] = prorationBehavior.rawValue
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

        return apiHandler.send(method: .POST, path: "\(subscirptionitems)/\(item)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(item: String,
                       clearUsage: Bool?,
                       prorate: Bool?,
                       prorationDate: Date?) -> EventLoopFuture<StripeSubscriptionItem> {
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

        return apiHandler.send(method: .DELETE, path: "\(subscirptionitems)/\(item)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(subscription: String, filter: [String: Any]?) -> EventLoopFuture<StripeSubscriptionItemList> {
        var queryParams = "subscription=\(subscription)"
        if let filter = filter {
            queryParams += "&" + filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: subscirptionitems, query: queryParams)
    }
}
