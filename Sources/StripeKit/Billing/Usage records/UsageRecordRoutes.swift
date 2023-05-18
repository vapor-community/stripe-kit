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
    /// Creates a usage record for a specified subscription item and date, and fills it with a quantity.
    ///
    /// Usage records provide `quantity` information that Stripe uses to track how much a customer is using your service. With usage information and the pricing model set up by the [metered billing](https://stripe.com/docs/billing/subscriptions/metered-billing) plan, Stripe helps you send accurate invoices to your customers.
    ///
    /// The default calculation for usage is to add up all the `quantity` values of the usage records within a billing period. You can change this default behavior with the billing plan’s `aggregate_usage` [parameter](https://stripe.com/docs/api/plans/create#create_plan-aggregate_usage). When there is more than one usage record with the same timestamp, Stripe adds the `quantity` values together. In most cases, this is the desired resolution, however, you can change this behavior with the `action` parameter.
    ///
    /// The default pricing model for metered billing is [per-unit pricing](https://stripe.com/docs/api/plans/object#plan_object-billing_scheme). For finer granularity, you can configure metered billing to have a [tiered pricing](https://stripe.com/docs/billing/subscriptions/tiers) model.
    ///
    /// - Parameters:
    ///   - quantity: The usage quantity for the specified timestamp.
    ///   - action: Valid values are `increment` (default) or `set`. When using `increment` the specified `quantity` will be added to the usage at the specified timestamp. The `set` action will overwrite the usage quantity at that timestamp. If the subscription has [billing thresholds](https://stripe.com/docs/api/subscriptions/object#subscription_object-billing_thresholds), `increment` is the only allowed value.
    ///   - subscriptionItem: The ID of the subscription item for this usage record.
    ///   - timestamp: The timestamp for the usage event. This timestamp must be within the current billing period of the subscription of the provided `subscription_item`.
    /// - Returns: Returns the usage record object.
    func create(quantity: Int,
                subscriptionItem: String,
                timestamp: Date?,
                action: UsageRecordAction?) async throws -> UsageRecord
    
    /// For the specified subscription item, returns a list of summary objects. Each object in the list provides usage information that’s been summarized from multiple usage records and over a subscription billing period (e.g., 15 usage records in the billing plan’s month of September). \n The list is sorted in reverse-chronological order (newest first). The first list item represents the most current usage period that hasn’t ended yet. Since new usage records can still be added, the returned summary information for the subscription item’s ID should be seen as unstable until the subscription billing period ends.
    ///
    /// - Parameters:
    ///   - subscriptionItem: Only summary items for the given subscription item.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/usage_records/subscription_item_summary_list)
    /// - Returns: A `StripeUsageRecordList`.
    func listAll(subscriptionItem: String, filter: [String: Any]?) async throws -> UsageRecordSummaryList
}

public struct StripeUsageRecordRoutes: UsageRecordRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let subscriptionitems = APIBase + APIVersion + "subscription_items"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func create(quantity: Int,
                       subscriptionItem: String,
                       timestamp: Date? = nil,
                       action: UsageRecordAction? = nil) async throws -> UsageRecord {
        var body: [String: Any] = ["quantity": quantity]
        
        if let timestamp {
            body["timestamp"] = Int(timestamp.timeIntervalSince1970)
        }
        
        if let action {
            body["action"] = action.rawValue
        }
        
        return try await apiHandler.send(method: .POST, path: "\(subscriptionitems)/\(subscriptionItem)/usage_records", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(subscriptionItem: String, filter: [String: Any]? = nil) async throws -> UsageRecordSummaryList {
        var queryParams = ""
        if let filter = filter {
            queryParams += filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(subscriptionitems)/\(subscriptionItem)/usage_record_summaries", query: queryParams, headers: headers)
    }
}
