//
//  SubscriptionScheduleRoutes.swift
//  
//
//  Created by Andrew Edwards on 1/4/20.
//

import NIO
import NIOHTTP1
import Foundation

public protocol SubscriptionScheduleRoutes {
    /// Creates a new subscription schedule object.
    /// - Parameter customer: The identifier of the customer to create the subscription schedule for.
    /// - Parameter defaultSettings: Object representing the subscription schedule’s default settings.
    /// - Parameter endBehavior: Configures how the subscription schedule behaves when it ends. Possible values are release or cancel with the default being release. release will end the subscription schedule and keep the underlying subscription running.cancel will end the subscription schedule and cancel the underlying subscription.
    /// - Parameter fromSubscription: Migrate an existing subscription to be managed by a subscription schedule. If this parameter is set, a subscription schedule will be created using the subscription’s plan(s), set to auto-renew using the subscription’s interval. When using this parameter, other parameters (such as phase values) cannot be set. To create a subscription schedule with other modifications, we recommend making two separate API calls.
    /// - Parameter metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    /// - Parameter phases: List representing phases of the subscription schedule. Each phase can be customized to have different durations, plans, and coupons. If there are multiple phases, the `end_date` of one phase will always equal the `start_date` of the next phase.
    /// - Parameter startDate: When the subscription schedule starts. We recommend using `now` so that it starts the subscription immediately. You can also use a Unix timestamp to backdate the subscription so that it starts on a past date, or set a future date for the subscription to start on. When you backdate, the `billing_cycle_anchor` of the subscription is equivalent to the `start_date`.
    /// - Parameter expand: An array of properties to expand.
    func create(customer: String?,
                defaultSettings: [String: Any]?,
                endBehavior: StripeSubscriptionScheduleEndBehavior?,
                fromSubscription: Bool?,
                metadata: [String: String]?,
                phases: [[String: Any]]?,
                startDate: Date?,
                expand: [String]?) -> EventLoopFuture<StripeSubscriptionSchedule>
    
    /// Retrieves the details of an existing subscription schedule. You only need to supply the unique subscription schedule identifier that was returned upon subscription schedule creation.
    /// - Parameters:
    ///   - schedule: The identifier of the subscription schedule to be retrieved.
    ///   - expand: An array of properties to expand.
    func retrieve(schedule: String, expand: [String]?) -> EventLoopFuture<StripeSubscriptionSchedule>
    
    /// Updates an existing subscription schedule.
    /// - Parameter schedule: The identifier of the subscription schedule to be updated.
    /// - Parameter defaultSettings: Object representing the subscription schedule’s default settings.
    /// - Parameter endBehavior: Configures how the subscription schedule behaves when it ends. Possible values are `release` or `cancel` with the default being `release`. `release` will end the subscription schedule and keep the underlying subscription running. `cancel` will end the subscription schedule and cancel the underlying subscription.
    /// - Parameter metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    /// - Parameter phases: List representing phases of the subscription schedule. Each phase can be customized to have different durations, plans, and coupons. If there are multiple phases, the `end_date` of one phase will always equal the `start_date` of the next phase.
    /// - Parameter prorationBehavior: If the update changes the current phase, indicates if the changes should be prorated. Defaults to true.
    /// - Parameter expand: An array of properties to expand.
    func update(schedule: String,
                defaultSettings: [String: Any]?,
                endBehavior: StripeSubscriptionScheduleEndBehavior?,
                metadata: [String: String]?,
                phases: [[String: Any]]?,
                prorationBehavior: StripeSubscriptionSchedulePhaseProrationBehavior?,
                expand: [String]?) -> EventLoopFuture<StripeSubscriptionSchedule>
    
    /// Cancels a subscription schedule and its associated subscription immediately (if the subscription schedule has an active subscription). A subscription schedule can only be canceled if its status is `not_started` or `active`.
    /// - Parameter schedule: The identifier of the subscription schedule to be canceled.
    /// - Parameter invoiceNow: If the subscription schedule is `active`, indicates whether or not to generate a final invoice that contains any un-invoiced metered usage and new/pending proration invoice items. Defaults to `true`.
    /// - Parameter prorate: If the subscription schedule is `active`, indicates if the cancellation should be prorated. Defaults to `true`.
    /// - Parameter expand: An array of properties to expand.
    func cancel(schedule: String,
                invoiceNow: Bool?,
                prorate: Bool?,
                expand: [String]?) -> EventLoopFuture<StripeSubscriptionSchedule>
    
    /// Releases the subscription schedule immediately, which will stop scheduling of its phases, but leave any existing subscription in place. A schedule can only be released if its status is `not_started` or `active`. If the subscription schedule is currently associated with a subscription, releasing it will remove its `subscription` property and set the subscription’s ID to the `released_subscription` property.
    /// - Parameter schedule: The identifier of the subscription schedule to be released.
    /// - Parameter preserveCancelDate: Keep any cancellation on the subscription that the schedule has set
    /// - Parameter expand: An array of properties to expand.
    func release(schedule: String,
                 preserveCancelDate: Bool?,
                 expand: [String]?) -> EventLoopFuture<StripeSubscriptionSchedule>
    
    /// Retrieves the list of your subscription schedules.
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/subscription_schedules/list)
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeSubscriptionScheduleList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension SubscriptionScheduleRoutes {
    public func create(customer: String? = nil,
                       defaultSettings: [String: Any]? = nil,
                       endBehavior: StripeSubscriptionScheduleEndBehavior? = nil,
                       fromSubscription: Bool? = nil,
                       metadata: [String: String]? = nil,
                       phases: [[String: Any]]? = nil,
                       startDate: Date? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeSubscriptionSchedule> {
        return create(customer: customer,
                      defaultSettings: defaultSettings,
                      endBehavior: endBehavior,
                      fromSubscription: fromSubscription,
                      metadata: metadata,
                      phases: phases,
                      startDate: startDate,
                      expand: expand)
    }
    
    public func retrieve(schedule: String, expand: [String]? = nil) -> EventLoopFuture<StripeSubscriptionSchedule> {
        return retrieve(schedule: schedule, expand: expand)
    }
    
    public func update(schedule: String,
                       defaultSettings: [String: Any]? = nil,
                       endBehavior: StripeSubscriptionScheduleEndBehavior? = nil,
                       metadata: [String: String]? = nil,
                       phases: [[String: Any]]? = nil,
                       prorationBehavior: StripeSubscriptionSchedulePhaseProrationBehavior? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeSubscriptionSchedule> {
        return update(schedule: schedule,
                      defaultSettings: defaultSettings,
                      endBehavior: endBehavior,
                      metadata: metadata,
                      phases: phases,
                      prorationBehavior: prorationBehavior,
                      expand: expand)
    }
    
    public func cancel(schedule: String,
                       invoiceNow: Bool? = nil,
                       prorate: Bool? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeSubscriptionSchedule> {
        return cancel(schedule: schedule,
                      invoiceNow: invoiceNow,
                      prorate: prorate,
                      expand: expand)
    }
    
    public func release(schedule: String,
                        preserveCancelDate: Bool? = nil,
                        expand: [String]? = nil) -> EventLoopFuture<StripeSubscriptionSchedule> {
        return release(schedule: schedule,
                       preserveCancelDate: preserveCancelDate,
                       expand: expand)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeSubscriptionScheduleList> {
        return listAll(filter: filter)
    }
}

public struct StripeSubscriptionScheduleRoutes: SubscriptionScheduleRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let subscriptionschedules = APIBase + APIVersion + "subscription_schedules"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(customer: String?,
                       defaultSettings: [String: Any]?,
                       endBehavior: StripeSubscriptionScheduleEndBehavior?,
                       fromSubscription: Bool?,
                       metadata: [String: String]?,
                       phases: [[String: Any]]?,
                       startDate: Date?,
                       expand: [String]?) -> EventLoopFuture<StripeSubscriptionSchedule> {
        var body: [String: Any] = [:]
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let defaultSettings = defaultSettings {
            defaultSettings.forEach { body["default_settings[\($0)]"] = $1 }
        }
        
        if let endBehavior = endBehavior {
            body["end_behavior"] = endBehavior.rawValue
        }
        
        if let fromSubscription = fromSubscription {
            body["from_subscription"] = fromSubscription
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let phases = phases {
            body["phases"] = phases
        }
        
        if let startDate = startDate {
            body["start_date"] = Int(startDate.timeIntervalSince1970)
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: subscriptionschedules, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(schedule: String, expand: [String]?) -> EventLoopFuture<StripeSubscriptionSchedule> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(subscriptionschedules)/\(schedule)", query: queryParams, headers: headers)
    }
    
    public func update(schedule: String,
                       defaultSettings: [String: Any]?,
                       endBehavior: StripeSubscriptionScheduleEndBehavior?,
                       metadata: [String: String]?,
                       phases: [[String: Any]]?,
                       prorationBehavior: StripeSubscriptionSchedulePhaseProrationBehavior?,
                       expand: [String]?) -> EventLoopFuture<StripeSubscriptionSchedule> {
        var body: [String: Any] = [:]
        
        if let defaultSettings = defaultSettings {
            defaultSettings.forEach { body["default_settings[\($0)]"] = $1 }
        }
        
        if let endBehavior = endBehavior {
            body["end_behavior"] = endBehavior.rawValue
        }
                
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let phases = phases {
            body["phases"] = phases
        }
        
        if let prorationBehavior = prorationBehavior {
            body["proration_behavior"] = prorationBehavior.rawValue
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(subscriptionschedules)/\(schedule)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func cancel(schedule: String,
                       invoiceNow: Bool?,
                       prorate: Bool?,
                       expand: [String]?) -> EventLoopFuture<StripeSubscriptionSchedule> {
        var body: [String: Any] = [:]
        
        if let invoiceNow = invoiceNow {
            body["invoice_now"] = invoiceNow
        }
        
        if let prorate = prorate {
            body["prorate"] = prorate
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(subscriptionschedules)/\(schedule)/cancel", body: .string(body.queryParameters), headers: headers)
    }
    
    public func release(schedule: String, preserveCancelDate: Bool?, expand: [String]?) -> EventLoopFuture<StripeSubscriptionSchedule> {
        var body: [String: Any] = [:]
        
        if let preserveCancelDate = preserveCancelDate {
            body["preserve_cancel_date"] = preserveCancelDate
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(subscriptionschedules)/\(schedule)/release", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeSubscriptionScheduleList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: subscriptionschedules, query: queryParams, headers: headers)
    }
}
