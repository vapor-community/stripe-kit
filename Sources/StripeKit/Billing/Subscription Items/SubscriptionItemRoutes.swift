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

public protocol SubscriptionItemRoutes: StripeAPIRoute {
    /// Adds a new item to an existing subscription. No existing items will be changed or replaced.
    ///
    /// - Parameters:
    ///   - subscription: The identifier of the subscription to modify.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - paymentBehavior: Use `allow_incomplete` to create subscriptions with `status=incomplete` if the first invoice cannot be paid. Creating subscriptions with this status allows you to manage scenarios where additional user actions are needed to pay a subscription’s invoice. For example, SCA regulation may require 3DS authentication to complete payment. See the SCA Migration Guide for Billing to learn more. This is the default behavior. Use `error_if_incomplete` if you want Stripe to return an HTTP 402 status code if a subscription’s first invoice cannot be paid. For example, if a payment method requires 3DS authentication due to SCA regulation and further user action is needed, this parameter does not create a subscription and returns an error instead. This was the default behavior for API versions prior to 2019-03-14. See the changelog to learn more.
    ///   - price: The ID of the price object.
    ///   - prorationBehavior: Determines how to handle prorations when the billing cycle changes (e.g., when switching plans, resetting `billing_cycle_anchor=now`, or starting a trial), or if an item’s `quantity` changes. Valid values are `create_prorations`, `none`, or `always_invoice`. Passing `create_prorations` will cause proration invoice items to be created when applicable. These proration items will only be invoiced immediately under certain conditions. In order to always invoice immediately for prorations, pass `always_invoice`. Prorations can be disabled by passing `none`.
    ///   - quantity: The quantity you’d like to apply to the subscription item you’re creating.
    ///   - billingThresholds: Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period
    ///   - priceData: Data used to generate a new price object inline.
    ///   - prorationDate: If set, the proration will be calculated as though the subscription was updated at the given time. This can be used to apply the same proration that was previewed with the upcoming invoice endpoint.
    ///   - taxRates: The tax rates which apply to this `subscription_item`. When set, the `default_tax_rates` on the subscription do not apply to this `subscription_item`.
    /// - Returns: Returns the created Subscription Item object, if successful. Otherwise, this call returns an error,
    func create(subscription: String,
                metadata: [String: String]?,
                paymentBehavior: SubscriptionItemPaymentBehavior?,
                price: String?,
                prorationBehavior: SubscriptionItemProrationBehavior?,
                quantity: Int?,
                billingThresholds: [String: Any]?,
                priceData: [String: Any]?,
                prorationDate: Date?,
                taxRates: [String]?) async throws -> SubscriptionItem
    
    /// Retrieves the invoice item with the given ID.
    ///
    /// - Parameter item: The identifier of the subscription item to retrieve.
    /// - Returns: Returns a subscription item if a valid subscription item ID was provided. Returns an error otherwise.
    func retrieve(item: String) async throws -> SubscriptionItem
    
    /// Updates the plan or quantity of an item on a current subscription.
    ///
    /// - Parameters:
    ///   - item: The identifier of the subscription item to modify.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - paymentBehavior: Use `allow_incomplete` to create subscriptions with `status=incomplete` if the first invoice cannot be paid. Creating subscriptions with this status allows you to manage scenarios where additional user actions are needed to pay a subscription’s invoice. For example, SCA regulation may require 3DS authentication to complete payment. See the SCA Migration Guide for Billing to learn more. This is the default behavior. Use `error_if_incomplete` if you want Stripe to return an HTTP 402 status code if a subscription’s first invoice cannot be paid. For example, if a payment method requires 3DS authentication due to SCA regulation and further user action is needed, this parameter does not create a subscription and returns an error instead. This was the default behavior for API versions prior to 2019-03-14. See the changelog to learn more.
    ///   - price: The ID of the price object.
    ///   - prorationBehavior:Determines how to handle prorations when the billing cycle changes (e.g., when switching plans, resetting `billing_cycle_anchor=now`, or starting a trial), or if an item’s `quantity` changes. Valid values are `create_prorations`, `none`, or `always_invoice`. Passing `create_prorations` will cause proration invoice items to be created when applicable. These proration items will only be invoiced immediately under certain conditions. In order to always invoice immediately for prorations, pass `always_invoice`. Prorations can be disabled by passing `none`.
    ///   - quantity: The quantity you’d like to apply to the subscription item you’re creating.
    ///   - billingThresholds: Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period. When updating, pass an empty string to remove previously-defined thresholds.
    ///   - offSession: Indicates if a customer is on or off-session while an invoice payment is attempted.
    ///   - priceData: Data used to generate a new price object inline.
    ///   - prorationDate: If set, the proration will be calculated as though the subscription was updated at the given time. This can be used to apply the same proration that was previewed with the upcoming invoice endpoint.
    ///   - taxRates: The tax rates which apply to this `subscription_item`. When set, the `default_tax_rates` on the subscription do not apply to this `subscription_item`.
    /// - Returns: The updated subscription item.
    func update(item: String,
                metadata: [String: String]?,
                paymentBehavior: SubscriptionItemPaymentBehavior?,
                price: String?,
                prorationBehavior: SubscriptionItemProrationBehavior?,
                quantity: Int?,
                billingThresholds: [String: Any]?,
                offSession: Bool?,
                priceData: [String: Any]?,
                prorationDate: Date?,
                taxRates: [String]?) async throws -> SubscriptionItem
    
    /// Deletes an item from the subscription. Removing a subscription item from a subscription will not cancel the subscription.
    ///
    /// - Parameters:
    ///   - item: The identifier of the subscription item to delete.
    ///   - prorationBehavior: Determines how to handle prorations when the billing cycle changes (e.g., when switching plans, resetting `billing_cycle_anchor=now`, or starting a trial), or if an item’s `quantity` changes. Valid values are `create_prorations`, `none`, or `always_invoice`. Passing `create_prorations` will cause proration invoice items to be created when applicable. These proration items will only be invoiced immediately under certain conditions. In order to always invoice immediately for prorations, pass `always_invoice`. Prorations can be disabled by passing `none`.
    ///   - clearUsage: Delete all usage for the given subscription item. Allowed only when the current plan’s `usage_type` is `metered`.
    ///   - prorationDate: If set, the proration will be calculated as though the subscription was updated at the given time. This can be used to apply the same proration that was previewed with the upcoming invoice endpoint.
    /// - Returns: An subscription item object with a deleted flag upon success. Otherwise, this call returns an error, such as if the subscription item has already been deleted.
    func delete(item: String,
                prorationBehavior: SubscriptionItemProrationBehavior?,
                clearUsage: Bool?,
                prorationDate: Date?) async throws -> DeletedObject
    
    /// Returns a list of your subscription items for a given subscription.
    ///
    /// - Parameters:
    ///   - subscription: The ID of the subscription whose items will be retrieved.
    ///   - filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/subscription_items/list)
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` subscription items, starting after subscription item `starting_after`. Each entry in the array is a separate subscription item object. If no more subscription items are available, the resulting array will be empty. This request should never return an error.
    func listAll(subscription: String, filter: [String: Any]?) async throws -> SubscriptionItemList
}

public struct StripeSubscriptionItemRoutes: SubscriptionItemRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let subscirptionitems = APIBase + APIVersion + "subscription_items"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func create(subscription: String,
                       metadata: [String: String]? = nil,
                       paymentBehavior: SubscriptionItemPaymentBehavior? = nil,
                       price: String? = nil,
                       prorationBehavior: SubscriptionItemProrationBehavior? = nil,
                       quantity: Int? = nil,
                       billingThresholds: [String: Any]? = nil,
                       priceData: [String: Any]? = nil,
                       prorationDate: Date? = nil,
                       taxRates: [String]? = nil) async throws -> SubscriptionItem {
        var body: [String: Any] = ["subscription": subscription]
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
             
        if let paymentBehavior {
            body["payment_behavior"] = paymentBehavior.rawValue
        }
        
        if let price {
            body["price"] = price
        }
        
        if let prorationBehavior {
            body["proration_behavior"] = prorationBehavior.rawValue
        }
        
        if let quantity {
            body["quantity"] = quantity
        }
        
        if let billingThresholds {
            billingThresholds.forEach { body["billing_thresholds[\($0)]"] = $1 }
        }
        
        if let priceData {
            priceData.forEach { body["price_data[\($0)]"] = $1 }
        }
        
        if let prorationDate {
            body["proration_date"] = Int(prorationDate.timeIntervalSince1970)
        }

        if let taxRates {
            body["tax_rates"] = taxRates
        }
        
        return try await apiHandler.send(method: .POST, path: subscirptionitems, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(item: String) async throws -> SubscriptionItem {
        try await apiHandler.send(method: .GET, path: "\(subscirptionitems)/\(item)", headers: headers)
    }
    
    public func update(item: String,
                       metadata: [String: String]? = nil,
                       paymentBehavior: SubscriptionItemPaymentBehavior? = nil,
                       price: String? = nil,
                       prorationBehavior: SubscriptionItemProrationBehavior? = nil,
                       quantity: Int? = nil,
                       billingThresholds: [String: Any]? = nil,
                       offSession: Bool? = nil,
                       priceData: [String: Any]? = nil,
                       prorationDate: Date? = nil,
                       taxRates: [String]? = nil) async throws -> SubscriptionItem {
        var body: [String: Any] = [:]
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        if let paymentBehavior {
            body["payment_behavior"] = paymentBehavior
        }
        
        if let price {
            body["price"] = price
        }
        
        if let prorationBehavior {
            body["proration_behavior"] = prorationBehavior.rawValue
        }
        
        if let quantity {
            body["quantity"] = quantity
        }
        
        if let billingThresholds {
            billingThresholds.forEach { body["billing_thresholds[\($0)]"] = $1 }
        }
        
        if let offSession {
            body["off_session"] = offSession
        }
        
        if let priceData {
            priceData.forEach { body["price_data[\($0)]"] = $1 }
        }
        
        if let prorationDate {
            body["proration_date"] = Int(prorationDate.timeIntervalSince1970)
        }
        
        if let taxRates {
            body["tax_rates"] = taxRates
        }

        return try await apiHandler.send(method: .POST, path: "\(subscirptionitems)/\(item)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(item: String,
                       prorationBehavior: SubscriptionItemProrationBehavior? = nil,
                       clearUsage: Bool? = nil,
                       prorationDate: Date? = nil) async throws -> DeletedObject {
        var body: [String: Any] = [:]
        
        if let clearUsage {
            body["clear_usage"] = clearUsage
        }
        
        if let prorationBehavior {
            body["proration_behavior"] = prorationBehavior.rawValue
        }
        
        if let prorationDate {
            body["proration_date"] = Int(prorationDate.timeIntervalSince1970)
        }

        return try await apiHandler.send(method: .DELETE, path: "\(subscirptionitems)/\(item)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(subscription: String, filter: [String: Any]? = nil) async throws -> SubscriptionItemList {
        var queryParams = "subscription=\(subscription)"
        if let filter {
            queryParams += "&" + filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: subscirptionitems, query: queryParams, headers: headers)
    }
}
