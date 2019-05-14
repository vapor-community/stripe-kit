//
//  UsageRecordRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/14/19.
//

import NIO
import NIOHTTP1
import Foundation

public protocol UsageRecordRoutes {
    /// Creates a usage record for a specified subscription item and date, and fills it with a quantity. /n Usage records provide `quantity` information that Stripe uses to track how much a customer is using your service. With usage information and the pricing model set up by the [metered billing](https://stripe.com/docs/billing/subscriptions/metered-billing) plan, Stripe helps you send accurate invoices to your customers. /n The default calculation for usage is to add up all the `quantity` values of the usage records within a billing period. You can change this default behavior with the billing plan’s `aggregate_usage` [parameter](https://stripe.com/docs/api/plans/create#create_plan-aggregate_usage). When there is more than one usage record with the same timestamp, Stripe adds the `quantity` values together. In most cases, this is the desired resolution, however, you can change this behavior with the `action` parameter. /n The default pricing model for metered billing is [per-unit pricing](https://stripe.com/docs/api/plans/object#plan_object-billing_scheme). For finer granularity, you can configure metered billing to have a [tiered pricing](https://stripe.com/docs/billing/subscriptions/tiers) model.
    ///
    /// - Parameters:
    ///   - quantity: The usage quantity for the specified timestamp.
    ///   - subscriptionItem: The ID of the subscription item for this usage record.
    ///   - timestamp: The timestamp for the usage event. This timestamp must be within the current billing period of the subscription of the provided `subscription_item`.
    ///   - action: Valid values are `increment` (default) or `set`. When using `increment` the specified `quantity` will be added to the usage at the specified timestamp. The `set` action will overwrite the usage quantity at that timestamp. If the subscription has [billing thresholds](https://stripe.com/docs/api/subscriptions/object#subscription_object-billing_thresholds), `increment` is the only allowed value.
    /// - Returns: A `StripeUsageRecord`.
    /// - Throws: A `StripeError`.
    func create(quantity: Int,
                subscriptionItem: String,
                timestamp: Date,
                action: String?) throws -> EventLoopFuture<StripeUsageRecord>
    
    /// For the specified subscription item, returns a list of summary objects. Each object in the list provides usage information that’s been summarized from multiple usage records and over a subscription billing period (e.g., 15 usage records in the billing plan’s month of September). \n The list is sorted in reverse-chronological order (newest first). The first list item represents the most current usage period that hasn’t ended yet. Since new usage records can still be added, the returned summary information for the subscription item’s ID should be seen as unstable until the subscription billing period ends.
    ///
    /// - Parameters:
    ///   - subscriptionItem: Only summary items for the given subscription item.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/usage_records/subscription_item_summary_list?lang=curl)
    /// - Returns: A `StripeUsageRecordList`.
    /// - Throws: A `StripeError`.
    func listAll(subscriptionItem: String, filter: [String: Any]?) throws -> EventLoopFuture<StripeUsageRecordList>
    
    mutating func addHeaders(_ : HTTPHeaders)
}

extension UsageRecordRoutes {
    public func create(quantity: Int,
                       subscriptionItem: String,
                       timestamp: Date,
                       action: String? = nil) throws -> EventLoopFuture<StripeUsageRecord> {
        return try create(quantity: quantity,
                          subscriptionItem: subscriptionItem,
                          timestamp: timestamp,
                          action: action)
    }
    
    public func listAll(subscriptionItem: String, filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeUsageRecordList> {
        return try listAll(subscriptionItem: subscriptionItem, filter: filter)
    }
}

public struct StripeUsageRecordRoutes: UsageRecordRoutes {
    private let apiHandler: StripeAPIHandler
    private var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public mutating func addHeaders(_ _headers: HTTPHeaders) {
        _headers.forEach { self.headers.replaceOrAdd(name: $0.name, value: $0.value) }
    }

    public func create(quantity: Int,
                       subscriptionItem: String,
                       timestamp: Date,
                       action: String?) throws -> EventLoopFuture<StripeUsageRecord> {
        var body: [String: Any] = ["quantity": quantity,
                                   "timestamp": Int(timestamp.timeIntervalSince1970)]
        
        if let action = action {
            body["action"] = action
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.usageRecords(subscriptionItem).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(subscriptionItem: String, filter: [String: Any]?) throws -> EventLoopFuture<StripeUsageRecordList> {
        var queryParams = ""
        if let filter = filter {
            queryParams += filter.queryParameters
        }
        
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.usageRecordSummaries(subscriptionItem).endpoint, query: queryParams, headers: headers)
    }
}
