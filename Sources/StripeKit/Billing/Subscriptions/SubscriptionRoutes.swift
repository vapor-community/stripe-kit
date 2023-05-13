//
//  SubscriptionRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/9/17.
//
//

import NIO
import NIOHTTP1
import Foundation

public protocol SubscriptionRoutes: StripeAPIRoute {
    /// Creates a new subscription on an existing customer. Each customer can have up to 500 active or scheduled subscriptions.
    ///
    /// When you create a subscription with `collection_method=charge_automatically`, the first invoice is finalized as part of the request. The `payment_behavior` parameter determines the exact behavior of the initial payment.
    
    /// To start subscriptions where the first invoice always begins in a `draft` status, use [subscription schedules](https://stripe.com/docs/billing/subscriptions/subscription-schedules#managing) instead. Schedules provide the flexibility to model more complex billing configurations that change over time.
    ///
    /// - Parameters:
    ///   - customer: The identifier of the customer to subscribe
    ///   - items: A list of up to 20 subscription items, each with an attached price.
    ///   - cancelAtPeriodEnd: Boolean indicating whether this subscription should cancel at the end of the current period.
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - defaultPaymentMethod: ID of the default payment method for the subscription. It must belong to the customer associated with the subscription. If not set, invoices will use the default payment method in the customer’s invoice settings.
    ///   - description: The subscription’s description, meant to be displayable to the customer. Use this field to optionally store an explanation of the subscription for rendering in Stripe surfaces.
    ///   - metadata: A set of key-value pairs that you can attach to a Subscription object. It can be useful for storing additional information about the subscription in a structured format.
    ///   - paymentBehavior: Use `allow_incomplete` to create subscriptions with `status=incomplete` if its first invoice cannot be paid. Creating subscriptions with this status allows you to manage scenarios where additional user actions are needed to pay a subscription’s invoice. For example, SCA regulation may require 3DS authentication to complete payment. See the [SCA Migration Guide](https://stripe.com/docs/billing/migration/strong-customer-authentication) for Billing to learn more. This is the default behavior. Use `error_if_incomplete` if you want Stripe to return an HTTP 402 status code if a subscription’s first invoice cannot be paid. For example, if a payment method requires 3DS authentication due to SCA regulation and further user action is needed, this parameter does not create a subscription and returns an error instead. This was the default behavior for API versions prior to 2019-03-14. See the [changelog](https://stripe.com/docs/upgrades#2019-03-14) to learn more. `pending_if_incomplete` is only used with updates and cannot be passed when creating a subscription.
    ///   - addInvoiceItems: A list of prices and quantities that will generate invoice items appended to the first invoice for this subscription. You may pass up to 10 items.
    ///   - applicationFeePercent: A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the application owner’s Stripe account. The request must be made with an OAuth key in order to set an application fee percentage. For more information, see the application fees documentation.
    ///   - automaticTax: Automatic tax settings for this subscription. We recommend you only include this parameter when the existing value is being changed.
    ///   - backdateStartDate: For new subscriptions, a past timestamp to backdate the subscription’s start date to. If set, the first invoice will contain a proration for the timespan between the start date and the current time. Can be combined with trials and the billing cycle anchor.
    ///   - billingCycleAnchor: A future timestamp to anchor the subscription’s [billing cycle](https://stripe.com/docs/subscriptions/billing-cycle) . This is used to determine the date of the first full invoice, and, for plans with `month` or `year` intervals, the day of the month for subsequent invoices.
    ///   - billingThresholds: Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period. Pass an empty string to remove previously-defined thresholds.
    ///   - cancelAt: A timestamp at which the subscription should cancel. If set to a date before the current period ends, this will cause a proration if prorations have been enabled using proration_behavior. If set during a future period, this will always cause a proration for that period.
    ///   - collectionMethod: Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay this subscription at the end of the cycle using the default source attached to the customer. When sending an invoice, Stripe will email your customer an invoice with payment instructions. Defaults to `charge_automatically`.
    ///   - coupon: The code of the coupon to apply to this subscription. A coupon applied to a subscription will only affect invoices created for that particular subscription. This will be unset if you POST an empty value.
    ///   - daysUntilDue: Number of days a customer has to pay invoices generated by this subscription. Valid only for subscriptions where `billing` is set to `send_invoice`.
    ///   - defaultSource: ID of the default payment source for the subscription. It must belong to the customer associated with the subscription and be in a chargeable state. If not set, defaults to the customer’s default source.
    ///   - defaultTaxRates: The tax rates that will apply to any subscription item that does not have `tax_rates` set. Invoices created will have their `default_tax_rates` populated from the subscription.
    ///   - offSession: Indicates if a customer is on or off-session while an invoice payment is attempted.
    ///   - onBehalfOf: The account on behalf of which to charge, for each of the subscription’s invoices.
    ///   - paymentSettings: Payment settings to pass to invoices created by the subscription.
    ///   - pendingInvoiceItemInterval: Specifies an interval for how often to bill for any pending invoice items. It is analogous to calling [Create an invoice](https://stripe.com/docs/api#create_invoice) for the given subscription at the specified interval.
    ///   - promotionCode: The API ID of a promotion code to apply to the customer. The customer will have a discount applied on all recurring payments. Charges you create through the API will not have the discount.
    ///   - prorationBehavior: Determines how to handle prorations resulting from the `billing_cycle_anchor`. Valid values are `create_prorations` or `none`. Passing `create_prorations` will cause proration invoice items to be created when applicable. Prorations can be disabled by passing `none`. If no value is passed, the default is `create_prorations`.
    ///   - transferData: If specified, the funds from the subscription’s invoices will be transferred to the destination and the ID of the resulting transfers will be found on the resulting charges.
    ///   - trialEnd: Unix timestamp representing the end of the trial period the customer will get before being charged for the first time. This will always overwrite any trials that might apply via a subscribed plan. If set, `trial_end` will override the default trial period of the plan the customer is being subscribed to. The special value now can be provided to end the customer’s trial immediately. Can be at most two years from `billing_cycle_anchor`.
    ///   - trialFromPlan: Indicates if a plan’s `trial_period_days` should be applied to the subscription. Setting `trial_end` per subscription is preferred, and this defaults to false. Setting this flag to true together with `trial_end` is not allowed.
    ///   - trialPeriodDays: Integer representing the number of trial period days before the customer is charged for the first time. This will always overwrite any trials that might apply via a subscribed plan.
    ///   - trialSettings: Settings related to subscription trials.
    ///   - expand: An array of properties to expand.
    /// - Returns: The newly created Subscription object, if the call succeeded. If the attempted charge fails, the subscription is created in an incomplete status.
    func create(customer: String,
                items: [[String: Any]],
                cancelAtPeriodEnd: Bool?,
                currency: Currency?,
                defaultPaymentMethod: String?,
                description: String?,
                metadata: [String: String]?,
                paymentBehavior: SubscriptionPaymentBehavior?,
                addInvoiceItems: [[String: Any]]?,
                applicationFeePercent: Decimal?,
                automaticTax: [String: Any]?,
                backdateStartDate: Date?,
                billingCycleAnchor: Date?,
                billingThresholds: [String: Any]?,
                cancelAt: Date?,
                collectionMethod: SubscriptionCollectionMethod?,
                coupon: String?,
                daysUntilDue: Int?,
                defaultSource: String?,
                defaultTaxRates: [String]?,
                offSession: Bool?,
                onBehalfOf: String?,
                paymentSettings: [String: Any]?,
                pendingInvoiceItemInterval: [String: Any]?,
                promotionCode: String?,
                prorationBehavior: SubscriptionProrationBehavior?,
                transferData: [String: Any]?,
                trialEnd: Any?,
                trialFromPlan: Bool?,
                trialPeriodDays: Int?,
                trialSettings: [String: Any]?,
                expand: [String]?) async throws -> Subscription
    
    /// Retrieves the subscription with the given ID.
    ///
    /// - Parameters:
    ///   - id: ID of the subscription to retrieve.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns the subscription object.
    func retrieve(id: String, expand: [String]?) async throws -> Subscription
    
    /// Updates an existing subscription to match the specified parameters. When changing plans or quantities, we will optionally prorate the price we charge next month to make up for any price changes. To preview how the proration will be calculated, use the [upcoming invoice](https://stripe.com/docs/api/subscriptions/update#upcoming_invoice) endpoint.
    ///
    ///  By default, we prorate subscription changes. For example, if a customer signs up on May 1 for a $100 price, they'll be billed $100 immediately. If on May 15 they switch to a $200 price, then on June 1 they'll be billed $250 ($200 for a renewal of her subscription, plus a $50 prorating adjustment for half of the previous month's $100 difference). Similarly, a downgrade generates a credit that is applied to the next invoice. We also prorate when you make quantity changes.
    ///
    ///  Switching prices does not normally change the billing date or generate an immediate charge unless:
    ///  - The billing interval is changed (for example, from monthly to yearly).
    ///  - The subscription moves from free to paid, or paid to free.
    ///  - A trial starts or ends.
    ///
    /// In these cases, we apply a credit for the unused time on the previous price, immediately charge the customer using the new price, and reset the billing date.
    
    /// If you want to charge for an upgrade immediately, pass `proration_behavior` as `always_invoice` to create prorations, automatically invoice the customer for those proration adjustments, and attempt to collect payment. If you pass `create_prorations`, the prorations are created but not automatically invoiced. If you want to bill the customer for the prorations before the subscription's renewal date, you need to manually invoice the customer or use `pending_invoice_item_interval`.
    ///
    /// If you don't want to prorate, set the `proration_behavior` option to `none`. With this option, the customer is billed $100 on May 1 and $200 on June 1. Similarly, if you set `proration_behavior` to `none` when switching between different billing intervals (for example, from monthly to yearly), we don't generate any credits for the old subscription's unused time. We still reset the billing date and bill immediately for the new subscription.
    ///
    /// Updating the quantity on a subscription many times in an hour may result in [rate limiting](https://stripe.com/docs/rate-limits). If you need to bill for a frequently changing quantity, consider integrating [usage-based billing](https://stripe.com/docs/billing/subscriptions/usage-based) instead.
    ///
    /// - Parameters:
    ///   - subscription: The ID of the subscription to update.
    ///   - cancelAtPeriodEnd: Boolean indicating whether this subscription should cancel at the end of the current period.
    ///   - defaultPaymentMethod: ID of the default payment method for the subscription. It must belong to the customer associated with the subscription. If not set, invoices will use the default payment method in the customer’s invoice settings.
    ///   - description: The subscription’s description, meant to be displayable to the customer. Use this field to optionally store an explanation of the subscription for rendering in Stripe surfaces.
    ///   - items: List of subscription items, each with an attached plan.
    ///   - metadata: A set of key-value pairs that you can attach to a subscription object. This can be useful for storing additional information about the subscription in a structured format.
    ///   - paymentBehavior: Use `allow_incomplete` to transition the subscription to `status=past_due` if a payment is required but cannot be paid. This allows you to manage scenarios where additional user actions are needed to pay a subscription’s invoice. For example, SCA regulation may require 3DS authentication to complete payment. See the SCA Migration Guide for Billing to learn more. This is the default behavior. Use `default_incomplete` to transition the subscription to `status=past_due` when payment is required and await explicit confirmation of the invoice’s payment intent. This allows simpler management of scenarios where additional user actions are needed to pay a subscription’s invoice. Such as failed payments, SCA regulation, or collecting a mandate for a bank debit payment method. Use `pending_if_incomplete` to update the subscription using pending updates. When you use `pending_if_incomplete` you can only pass the parameters supported by pending updates. Use `error_if_incomplete` if you want Stripe to return an HTTP 402 status code if a subscription’s invoice cannot be paid. For example, if a payment method requires 3DS authentication due to SCA regulation and further user action is needed, this parameter does not update the subscription and returns an error instead. This was the default behavior for API versions prior to 2019-03-14. See the changelog to learn more.
    ///   - prorationBehavior: Determines how to handle prorations when the billing cycle changes (e.g., when switching plans, resetting `billing_cycle_anchor=now`, or starting a trial), or if an item’s quantity changes. Valid values are `create_prorations`, `none`, or `always_invoice`. Passing `create_prorations` will cause proration invoice items to be created when applicable. These proration items will only be invoiced immediately under certain conditions. In order to always invoice immediately for prorations, pass `always_invoice`. Prorations can be disabled by passing `none`.
    ///   - addInvoiceItems: A list of prices and quantities that will generate invoice items appended to the first invoice for this subscription. You may pass up to 10 items.
    ///   - applicationFeePercent: A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the application owner’s Stripe account. The request must be made with an OAuth key in order to set an application fee percentage. For more information, see the application fees documentation.
    ///   - billingCycleAnchor: Either `now` or `unchanged`. Setting the value to now resets the subscription’s billing cycle anchor to the current time. For more information, see the billing cycle documentation.
    ///   - billingThresholds: Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period. Pass an empty string to remove previously-defined thresholds.
    ///   - cancelAt: A timestamp at which the subscription should cancel. If set to a date before the current period ends, this will cause a proration if prorations have been enabled using `proration_behavior`. If set during a future period, this will always cause a proration for that period.
    ///   - collectionMethod: Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay this subscription at the end of the cycle using the default source attached to the customer. When sending an invoice, Stripe will email your customer an invoice with payment instructions. Defaults to `charge_automatically`.
    ///   - coupon: The code of the coupon to apply to this subscription. A coupon applied to a subscription will only affect invoices created for that particular subscription. This will be unset if you POST an empty value.
    ///   - daysUntilDue: Number of days a customer has to pay invoices generated by this subscription. Valid only for subscriptions where billing is set to send_invoice.
    ///   - defaultSource: ID of the default payment source for the subscription. It must belong to the customer associated with the subscription and be in a chargeable state. If not set, defaults to the customer’s default source.
    ///   - defaultTaxRates: The tax rates that will apply to any subscription item that does not have tax_rates set. Invoices created will have their default_tax_rates populated from the subscription.
    ///   - offSession: Indicates if a customer is on or off-session while an invoice payment is attempted.
    ///   - onBehalfOf: The account on behalf of which to charge, for each of the subscription’s invoices.
    ///   - pauseCollection: If specified, payment collection for this subscription will be paused.
    ///   - paymentSettings: Payment settings to pass to invoices created by the subscription.
    ///   - pendingInvoiceItemInterval: Specifies an interval for how often to bill for any pending invoice items. It is analogous to calling [Create an invoice](https://stripe.com/docs/api#create_invoice) for the given subscription at the specified interval.
    ///   - promotionCode: The API ID of a promotion code to apply to the customer. The customer will have a discount applied on all recurring payments. Charges you create through the API will not have the discount.
    ///   - prorationDate: If set, the proration will be calculated as though the subscription was updated at the given time. This can be used to apply exactly the same proration that was previewed with [upcoming invoice](https://stripe.com/docs/api/subscriptions/update#retrieve_customer_invoice) endpoint. It can also be used to implement custom proration logic, such as prorating by day instead of by second, by providing the time that you wish to use for proration calculations.
    ///   - transferData: If specified, the funds from the subscription’s invoices will be transferred to the destination and the ID of the resulting transfers will be found on the resulting charges. This will be unset if you POST an empty value.
    ///   - trialEnd: Unix timestamp representing the end of the trial period the customer will get before being charged for the first time. This will always overwrite any trials that might apply via a subscribed plan. If set, `trial_end` will override the default trial period of the plan the customer is being subscribed to. The special value `now` can be provided to end the customer’s trial immediately. Can be at most two years from `billing_cycle_anchor`.
    ///   - trialFromPlan: Indicates if a plan’s `trial_period_days` should be applied to the subscription. Setting `trial_end` per subscription is preferred, and this defaults to `false`. Setting this flag to true together with `trial_end` is not allowed.
    ///   - trialSettings: Settings related to subscription trials.
    ///   - expand: An array of properties to expand.
    /// - Returns: The newly updated Subscription object, if the call succeeded. If `payment_behavior` is `error_if_incomplete` and a charge is required for the update and it fails, this call returns an error, and the subscription update does not go into effect.
    func update(subscription: String,
                cancelAtPeriodEnd: Bool?,
                defaultPaymentMethod: String?,
                description: String?,
                items: [[String: Any]]?,
                metadata: [String: String]?,
                paymentBehavior: SubscriptionPaymentBehavior?,
                prorationBehavior: SubscriptionProrationBehavior?,
                addInvoiceItems: [[String: Any]]?,
                applicationFeePercent: Decimal?,
                billingCycleAnchor: String?,
                billingThresholds: [String: Any]?,
                cancelAt: Date?,
                collectionMethod: SubscriptionCollectionMethod?,
                coupon: String?,
                daysUntilDue: Int?,
                defaultSource: String?,
                defaultTaxRates: [String]?,
                offSession: Bool?,
                onBehalfOf: String?,
                pauseCollection: [String: Any]?,
                paymentSettings: [String: Any]?,
                pendingInvoiceItemInterval: [String: Any]?,
                promotionCode: String?,
                prorationDate: Date?,
                transferData: [String: Any]?,
                trialEnd: Any?,
                trialFromPlan: Bool?,
                trialSettings: [String: Any]?,
                expand: [String]?) async throws -> Subscription
    
    /// Initiates resumption of a paused subscription, optionally resetting the billing cycle anchor and creating prorations. If a resumption invoice is generated, it must be paid or marked uncollectible before the subscription will be unpaused. If payment succeeds the subscription will become `active`, and if payment fails the subscription will be `past_due`. The resumption invoice will void automatically if not paid by the expiration date.
    /// - Parameters:
    ///   - subscription: Id of the subscription to resume.
    ///   - billingCycleAnchor: Either `now` or `unchanged`. Setting the value to `now` resets the subscription’s billing cycle anchor to the current time (in UTC). Setting the value to `unchanged` advances the subscription’s billing cycle anchor to the period that surrounds the current time. For more information, see the billing cycle documentation.
    ///   - prorationBehavior: Determines how to handle prorations when the billing cycle changes (e.g., when switching plans, resetting `billing_cycle_anchor=now`, or starting a trial), or if an item’s `quantity` changes. The default value is `create_prorations`.
    ///   - prorationDate: If set, the proration will be calculated as though the subscription was resumed at the given time. This can be used to apply exactly the same proration that was previewed with upcoming invoice endpoint.
    ///   - expand: An array of properties to expand.
    /// - Returns: The subscription object.
    func resume(subscription: String,
                billingCycleAnchor: String?,
                prorationBehavior: SubscriptionProrationBehavior?,
                prorationDate: Date?,
                expand: [String]?) async throws -> Subscription
    
    /// Cancels a customer’s subscription immediately. The customer will not be charged again for the subscription.
    ///
    /// Note, however, that any pending invoice items that you’ve created will still be charged for at the end of the period, unless manually [deleted](https://stripe.com/docs/api/subscriptions/cancel#delete_invoiceitem) . If you’ve set the subscription to cancel at the end of the period, any pending prorations will also be left in place and collected at the end of the period. But if the subscription is set to cancel immediately, pending prorations will be removed.
    ///
    /// By default, upon subscription cancellation, Stripe will stop automatic collection of all finalized invoices for the customer. This is intended to prevent unexpected payment attempts after the customer has canceled a subscription. However, you can resume automatic collection of the invoices manually after subscription cancellation to have us proceed. Or, you could check for unpaid invoices before allowing the customer to cancel the subscription at all.
    ///
    /// - Parameters:
    ///   - subscription: ID of the subscription to cancel.
    ///   - cancellationDetails: Details about why this subscription was cancelled.
    ///   - invoiceNow: Will generate a final invoice that invoices for any un-invoiced metered usage and new/pending proration invoice items.
    ///   - prorate: Will generate a proration invoice item that credits remaining unused time until the subscription period end.
    ///   - expand: An array of properties to expand.
    /// - Returns: The canceled ``Subscription`` object. Its subscription status will be set to `canceled`.
    func cancel(subscription: String,
                cancellationDetails: [String: Any]?,
                invoiceNow: Bool?,
                prorate: Bool?,
                expand: [String]?) async throws -> Subscription
    
    /// By default, returns a list of subscriptions that have not been canceled. In order to list canceled subscriptions, specify status=canceled.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/subscriptions/list)
    /// - Returns: Returns a list of subscriptions.
    func listAll(filter: [String: Any]?) async throws -> SubscriptionList
    
    /// Search for subscriptions you’ve previously created using Stripe’s Search Query Language. Don’t use search in read-after-write flows where strict consistency is necessary. Under normal operating conditions, data is searchable in less than a minute. Occasionally, propagation of new or updated data can be up to an hour behind during outages. Search functionality is not available to merchants in India.
    /// - Parameters:
    ///   - query: The search query string. See search query language and the list of supported query fields for invoices.
    ///   - limit: A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
    ///   - page: A cursor for pagination across multiple pages of results. Don’t include this parameter on the first call. Use the `next_page` value returned in a previous response to request subsequent results.
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` subscriptions. If no objects match the query, the resulting array will be empty. See the related guide on expanding properties in lists.
    func search(query: String, limit: Int?, page: String?) async throws -> SubscriptionSearchResult
}

public struct StripeSubscriptionRoutes: SubscriptionRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let subscriptions = APIBase + APIVersion + "subscriptions"
    private let search = APIBase + APIVersion + "subscriptions/search"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(customer: String,
                       items: [[String: Any]],
                       cancelAtPeriodEnd: Bool? = nil,
                       currency: Currency? = nil,
                       defaultPaymentMethod: String? = nil,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       paymentBehavior: SubscriptionPaymentBehavior? = nil,
                       addInvoiceItems: [[String: Any]]? = nil,
                       applicationFeePercent: Decimal? = nil,
                       automaticTax: [String: Any]? = nil,
                       backdateStartDate: Date? = nil,
                       billingCycleAnchor: Date? = nil,
                       billingThresholds: [String: Any]? = nil,
                       cancelAt: Date? = nil,
                       collectionMethod: SubscriptionCollectionMethod? = nil,
                       coupon: String? = nil,
                       daysUntilDue: Int? = nil,
                       defaultSource: String? = nil,
                       defaultTaxRates: [String]? = nil,
                       offSession: Bool? = nil,
                       onBehalfOf: String? = nil,
                       paymentSettings: [String: Any]? = nil,
                       pendingInvoiceItemInterval: [String: Any]? = nil,
                       promotionCode: String? = nil,
                       prorationBehavior: SubscriptionProrationBehavior? = nil,
                       transferData: [String: Any]? = nil,
                       trialEnd: Any? = nil,
                       trialFromPlan: Bool? = nil,
                       trialPeriodDays: Int? = nil,
                       trialSettings: [String: Any]? = nil,
                       expand: [String]? = nil) async throws -> Subscription {
        
        var body: [String: Any] = ["customer": customer,
                                   "items": items]
        
        if let cancelAtPeriodEnd {
            body["cancel_at_period_end"] = cancelAtPeriodEnd
        }
        
        if let currency {
            body["currency"] = currency.rawValue
        }
        
        if let defaultPaymentMethod {
            body["default_payment_method"] = defaultPaymentMethod
        }
        
        if let description {
            body["description"] = description
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let paymentBehavior {
            body["payment_behavior"] = paymentBehavior.rawValue
        }
        
        if let addInvoiceItems {
            body["add_invoice_items"] = addInvoiceItems
        }
        
        if let applicationFeePercent {
            body["application_fee_percent"] = applicationFeePercent
        }
        
        if let automaticTax {
            automaticTax.forEach { body["automatic_tax[\($0)]"] = $1 }
        }
        
        if let backdateStartDate {
            body["backdate_start_date"] = Int(backdateStartDate.timeIntervalSince1970)
        }
        
        if let billingCycleAnchor {
            body["billing_cycle_anchor"] = Int(billingCycleAnchor.timeIntervalSince1970)
        }
        
        if let billingThresholds {
            billingThresholds.forEach { body["billing_thresholds[\($0)]"] = $1 }
        }
        
        if let cancelAt {
            body["cancel_at"] = Int(cancelAt.timeIntervalSince1970)
        }
        
        if let collectionMethod {
            body["collection_method"] = collectionMethod.rawValue
        }
        
        if let coupon {
            body["coupon"] = coupon
        }
        
        if let daysUntilDue {
            body["days_until_due"] = daysUntilDue
        }
        
        if let defaultSource {
            body["default_source"] = defaultSource
        }
        
        if let defaultTaxRates {
            body["default_tax_rates"] = defaultTaxRates
        }
        
        if let offSession {
            body["off_session"] = offSession
        }
        
        if let onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }
        
        if let paymentSettings {
            paymentSettings.forEach { body["payment_settings[\($0)]"] = $1 }
        }
        
        if let pendingInvoiceItemInterval {
            pendingInvoiceItemInterval.forEach { body["pending_invoice_item_interval[\($0)]"] = $1 }
        }
        
        if let promotionCode {
            body["promotion_code"] = promotionCode
        }
        
        if let prorationBehavior {
            body["proration_behavior"] = prorationBehavior.rawValue
        }
        
        if let transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let trialEnd = trialEnd as? Date {
            body["trial_end"] = Int(trialEnd.timeIntervalSince1970)
        } else if let trialEnd = trialEnd as? String {
            body["trial_end"] = trialEnd
        }
        
        if let trialFromPlan {
            body["trial_from_plan"] = trialFromPlan
        }
        
        if let trialPeriodDays {
            body["trial_period_days"] = trialPeriodDays
        }
        
        if let trialSettings {
            trialSettings.forEach { body["trial_settings[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: subscriptions, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(id: String, expand: [String]? = nil) async throws -> Subscription {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        return try await apiHandler.send(method: .GET, path: "\(subscriptions)/\(id)", query: queryParams, headers: headers)
    }
    
    public func update(subscription: String,
                       cancelAtPeriodEnd: Bool? = nil,
                       defaultPaymentMethod: String? = nil,
                       description: String? = nil,
                       items: [[String: Any]]? = nil,
                       metadata: [String: String]? = nil,
                       paymentBehavior: SubscriptionPaymentBehavior? = nil,
                       prorationBehavior: SubscriptionProrationBehavior? = nil,
                       addInvoiceItems: [[String: Any]]? = nil,
                       applicationFeePercent: Decimal? = nil,
                       billingCycleAnchor: String? = nil,
                       billingThresholds: [String: Any]? = nil,
                       cancelAt: Date? = nil,
                       collectionMethod: SubscriptionCollectionMethod? = nil,
                       coupon: String? = nil,
                       daysUntilDue: Int? = nil,
                       defaultSource: String? = nil,
                       defaultTaxRates: [String]? = nil,
                       offSession: Bool? = nil,
                       onBehalfOf: String? = nil,
                       pauseCollection: [String: Any]? = nil,
                       paymentSettings: [String: Any]? = nil,
                       pendingInvoiceItemInterval: [String: Any]? = nil,
                       promotionCode: String? = nil,
                       prorationDate: Date? = nil,
                       transferData: [String: Any]? = nil,
                       trialEnd: Any? = nil,
                       trialFromPlan: Bool? = nil,
                       trialSettings: [String: Any]? = nil,
                       expand: [String]? = nil) async throws -> Subscription {
        var body: [String: Any] = [:]
                
        if let cancelAtPeriodEnd {
            body["cancel_at_period_end"] = cancelAtPeriodEnd
        }
                
        if let defaultPaymentMethod {
            body["default_payment_method"] = defaultPaymentMethod
        }
        
        if let description {
            body["description"] = description
        }
        
        if let items {
            body["items"] = items
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let paymentBehavior {
            body["payment_behavior"] = paymentBehavior.rawValue
        }
        
        if let prorationBehavior {
            body["proration_behavior"] = prorationBehavior.rawValue
        }
        
        if let addInvoiceItems {
            body["add_invoice_items"] = addInvoiceItems
        }
        
        if let applicationFeePercent {
            body["application_fee_percent"] = applicationFeePercent
        }
        
        if let billingCycleAnchor {
            body["billing_cycle_anchor"] = billingCycleAnchor
        }
        
        if let billingThresholds {
            billingThresholds.forEach { body["billing_thresholds[\($0)]"] = $1 }
        }
        
        if let cancelAt {
            body["cancel_at"] = Int(cancelAt.timeIntervalSince1970)
        }
        
        if let collectionMethod {
            body["collection_method"] = collectionMethod.rawValue
        }
        
        if let coupon {
            body["coupon"] = coupon
        }
        
        if let daysUntilDue {
            body["days_until_due"] = daysUntilDue
        }
        
        if let defaultSource {
            body["default_source"] = defaultSource
        }
        
        if let defaultTaxRates {
            body["default_tax_rates"] = defaultTaxRates
        }
        
        if let offSession {
            body["off_session"] = offSession
        }
        
        if let onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }
        
        if let pauseCollection {
            pauseCollection.forEach { body["pause_collection[\($0)]"] = $1 }
        }
        
        if let paymentSettings {
            paymentSettings.forEach { body["payment_settings[\($0)]"] = $1 }
        }
        
        if let pendingInvoiceItemInterval {
            pendingInvoiceItemInterval.forEach { body["pending_invoice_item_interval[\($0)]"] = $1 }
        }
        
        if let promotionCode {
            body["promotion_code"] = promotionCode
        }
        
        if let prorationDate {
            body["proration_date"] = Int(prorationDate.timeIntervalSince1970)
        }
        
        if let transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let trialEnd = trialEnd as? Date {
            body["trial_end"] = Int(trialEnd.timeIntervalSince1970)
        } else if let trialEnd = trialEnd as? String {
            body["trial_end"] = trialEnd
        }
        
        if let trialFromPlan {
            body["trial_from_plan"] = trialFromPlan
        }
        
        if let trialSettings {
            trialSettings.forEach { body["trial_settings[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(subscriptions)/\(subscription)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func resume(subscription: String,
                       billingCycleAnchor: String? = nil,
                       prorationBehavior: SubscriptionProrationBehavior? = nil,
                       prorationDate: Date? = nil,
                       expand: [String]? = nil) async throws -> Subscription {
        var body: [String: Any] = [:]
        
        if let billingCycleAnchor {
            body["billing_cycle_anchor"] = billingCycleAnchor
        }
        
        if let prorationBehavior {
            body["proration_behavior"] = prorationBehavior.rawValue
        }
        
        if let prorationDate {
            body["proration_date"] = Int(prorationDate.timeIntervalSince1970)
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(subscriptions)/\(subscription)/resume", body: .string(body.queryParameters), headers: headers)
    }
    
    public func cancel(subscription: String,
                       cancellationDetails: [String: Any]? = nil,
                       invoiceNow: Bool? = nil,
                       prorate: Bool? = nil,
                       expand: [String]? = nil) async throws -> Subscription {
        var body: [String: Any] = [:]
        
        if let cancellationDetails {
            cancellationDetails.forEach { body["cancellation_details[\($0)]"] = $1 }
        }
        if let invoiceNow {
            body["invoice_now"] = invoiceNow
        }
        
        if let prorate {
            body["prorate"] = prorate
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .DELETE, path: "\(subscriptions)/\(subscription)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String : Any]? = nil) async throws -> SubscriptionList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: subscriptions, query: queryParams, headers: headers)
    }
    
    public func search(query: String, limit: Int? = nil, page: String? = nil) async throws -> SubscriptionSearchResult {
        var queryParams: [String: Any] = ["query": query]
        if let limit {
            queryParams["limit"] = limit
        }
        
        if let page {
            queryParams["page"] = page
        }
        
        return try await apiHandler.send(method: .GET, path: search, query: queryParams.queryParameters, headers: headers)
    }
}
