//
//  Subscription.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/6/17.
//
//

import Foundation

/// The [Subscription Object](https://stripe.com/docs/api/subscriptions/object)
public struct Subscription: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// If the subscription has been canceled with the `at_period_end` flag set to `true`, `cancel_at_period_end` on the subscription will be `true`. You can use this attribute to determine whether a subscription that has a status of active is scheduled to be canceled at the end of the current period.
    public var cancelAtPeriodEnd: Bool?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// End of the current period that the subscription has been invoiced for. At the end of this period, a new invoice will be created.
    public var currentPeriodEnd: Date?
    /// Start of the current period that the subscription has been invoiced for.
    public var currentPeriodStart: Date?
    /// ID of the customer who owns the subscription.
    @Expandable<Customer> public var customer: String?
    /// ID of the default payment method for the subscription. It must belong to the customer associated with the subscription. If not set, invoices will use the default payment method in the customer’s invoice settings.
    @Expandable<PaymentMethod> public var defaultPaymentMethod: String?
    /// The subscription’s description, meant to be displayable to the customer. Use this field to optionally store an explanation of the subscription for rendering in Stripe surfaces.
    public var description: String?
    /// List of subscription items, each with an attached plan.
    public var items: SubscriptionItemList?
    /// The most recent invoice this subscription has generated.
    @Expandable<Invoice> public var latestInvoice: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// You can use this SetupIntent to collect user authentication when creating a subscription without immediate payment or updating a subscription’s payment method, allowing you to optimize for off-session payments. Learn more in the SCA Migration Guide.
    @Expandable<SetupIntent> public var pendingSetupIntent: String?
    /// If specified, [pending updates](https://stripe.com/docs/billing/subscriptions/pending-updates) that will be applied to the subscription once the`latest_invoice` has been paid.
    public var pendingUpdate: SubscriptionPendingUpdate?
    /// Possible values are `incomplete`, `incomplete_expired`, `trialing`, `active`, `past_due`, `canceled`, or `unpaid`.
    ///
    /// For `collection_method=charge_automatically` a subscription moves into `incomplete` if the initial payment attempt fails. A subscription in this state can only have metadata and `default_source` updated. Once the first invoice is paid, the subscription moves into an active state. If the first invoice is not paid within 23 hours, the subscription transitions to `incomplete_expired`. This is a terminal state, the open invoice will be voided and no further invoices will be generated.
    ///
    /// A subscription that is currently in a trial period is `trialing` and moves to `active` when the trial period is over.
    ///
    /// If subscription `collection_method=charge_automatically` it becomes `past_due` when payment to renew it fails and `canceled` or `unpaid` (depending on your subscriptions settings) when Stripe has exhausted all payment retry attempts.
    ///
    /// If subscription `collection_method=send_invoice` it becomes `past_due` when its invoice is not paid by the due date, and `canceled` or `unpaid` if it is still not paid by an additional deadline after that. Note that when a subscription has a status of `unpaid`, no subsequent invoices will be attempted (invoices will be created, but then immediately automatically closed). After receiving updated payment information from a customer, you may choose to reopen and pay their closed invoices.
    public var status: SubscriptionStatus?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// ID of the Connect Application that created the subscription.
    public var application: String?
    /// A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the application owner’s Stripe account.
    public var applicationFeePercent: Decimal?
    /// Automatic tax settings for this subscription.
    public var automaticTax: SubscriptionAutomaticTax
    /// Determines the date of the first full invoice, and, for plans with `month` or `year` intervals, the day of the month for subsequent invoices.
    public var billingCycleAnchor: Date?
    /// Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period
    public var billingThresholds: SubscriptionBillingThresholds?
    /// A date in the future at which the subscription will automatically get canceled
    public var cancelAt: Date?
    /// If the subscription has been canceled, the date of that cancellation. If the subscription was canceled with `cancel_at_period_end`, `canceled_at` will still reflect the date of the initial cancellation request, not the end of the subscription period when the subscription is automatically moved to a canceled state.
    public var canceledAt: Date?
    /// Details about why this subscription was cancelled
    public var cancellationDetails: SubscriptionCancellationDetails?
    /// Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay this subscription at the end of the cycle using the default source attached to the customer. When sending an invoice, Stripe will email your customer an invoice with payment instructions.
    public var collectionMethod: SubscriptionCollectionMethod?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Number of days a customer has to pay invoices generated by this subscription. This value will be `null` for subscriptions where `billing=charge_automatically`.
    public var daysUntilDue: Int?
    /// ID of the default payment source for the subscription. It must belong to the customer associated with the subscription and be in a chargeable state. If not set, defaults to the customer’s default source.
    @DynamicExpandable<BankAccount, Card> public var defaultSource: String?
    /// The tax rates that will apply to any subscription item that does not have `tax_rates` set. Invoices created will have their `default_tax_rates` populated from the subscription.
    public var defaultTaxRates: [TaxRate]?
    /// Describes the current discount applied to this subscription, if there is one. When billing, a discount applied to a subscription overrides a discount applied on a customer-wide basis.
    public var discount: Discount?
    /// If the subscription has ended, the date the subscription ended.
    public var endedAt: Date?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Specifies the approximate timestamp on which any pending invoice items will be billed according to the schedule provided at `pending_invoice_item_interval`.
    public var nextPendingInvoiceItemInvoice: Date?
    /// The account (if any) the charge was made on behalf of for charges associated with this subscription. See the Connect documentation for details.
    @Expandable<StripeConnectAccount> public var onBehalfOf: String?
    /// If specified, payment collection for this subscription will be paused.
    public var pauseCollection: SubscriptionPauseCollection?
    /// Payment settings passed on to invoices created by the subscription.
    public var paymentSettings: SubscriptionPaymentSettings?
    /// Specifies an interval for how often to bill for any pending invoice items. It is analogous to calling Create an invoice for the given subscription at the specified interval.
    public var pendingInvoiceItemInterval: SubscriptionPendingInvoiceInterval?
    /// The schedule attached to the subscription
    @Expandable<StripeSubscriptionSchedule> public var schedule: String?
    /// Date when the subscription was first created. The date might differ from the `created` date due to backdating.
    public var startDate: Date?
    /// ID of the test clock this subscription belongs to.
    public var testClock: String?
    /// The account (if any) the subscription’s payments will be attributed to for tax reporting, and where funds from each payment will be transferred to for each of the subscription’s invoices.
    public var transferData: SubscriptionTransferData?
    /// If the subscription has a trial, the end of that trial.
    public var trialEnd: Date?
    /// Settings related to subscription trials.
    public var trialSettings: SubscriptionTrialSettings?
    /// If the subscription has a trial, the beginning of that trial.
    public var trialStart: Date?
    
    public init(id: String,
                cancelAtPeriodEnd: Bool? = nil,
                currency: Currency? = nil,
                currentPeriodEnd: Date? = nil,
                currentPeriodStart: Date? = nil,
                customer: String? = nil,
                defaultPaymentMethod: String? = nil,
                description: String? = nil,
                items: SubscriptionItemList? = nil,
                latestInvoice: String? = nil,
                metadata: [String : String]? = nil,
                pendingSetupIntent: String? = nil,
                pendingUpdate: SubscriptionPendingUpdate? = nil,
                status: SubscriptionStatus? = nil,
                object: String,
                application: String? = nil,
                applicationFeePercent: Decimal? = nil,
                automaticTax: SubscriptionAutomaticTax,
                billingCycleAnchor: Date? = nil,
                billingThresholds: SubscriptionBillingThresholds? = nil,
                cancelAt: Date? = nil,
                canceledAt: Date? = nil,
                cancellationDetails: SubscriptionCancellationDetails? = nil,
                collectionMethod: SubscriptionCollectionMethod? = nil,
                created: Date,
                daysUntilDue: Int? = nil,
                defaultSource: String? = nil,
                defaultTaxRates: [TaxRate]? = nil,
                discount: Discount? = nil,
                endedAt: Date? = nil,
                livemode: Bool? = nil,
                nextPendingInvoiceItemInvoice: Date? = nil,
                onBehalfOf: String? = nil,
                pauseCollection: SubscriptionPauseCollection? = nil,
                paymentSettings: SubscriptionPaymentSettings? = nil,
                pendingInvoiceItemInterval: SubscriptionPendingInvoiceInterval? = nil,
                schedule: String? = nil,
                startDate: Date? = nil,
                testClock: String? = nil,
                transferData: SubscriptionTransferData? = nil,
                trialEnd: Date? = nil,
                trialSettings: SubscriptionTrialSettings? = nil,
                trialStart: Date? = nil) {
        self.id = id
        self.cancelAtPeriodEnd = cancelAtPeriodEnd
        self.currency = currency
        self.currentPeriodEnd = currentPeriodEnd
        self.currentPeriodStart = currentPeriodStart
        self._customer = Expandable(id: customer)
        self._defaultPaymentMethod = Expandable(id: defaultPaymentMethod)
        self.description = description
        self.items = items
        self._latestInvoice = Expandable(id: latestInvoice)
        self.metadata = metadata
        self._pendingSetupIntent = Expandable(id: pendingSetupIntent)
        self.pendingUpdate = pendingUpdate
        self.status = status
        self.object = object
        self.application = application
        self.applicationFeePercent = applicationFeePercent
        self.automaticTax = automaticTax
        self.billingCycleAnchor = billingCycleAnchor
        self.billingThresholds = billingThresholds
        self.cancelAt = cancelAt
        self.canceledAt = canceledAt
        self.cancellationDetails = cancellationDetails
        self.collectionMethod = collectionMethod
        self.created = created
        self.daysUntilDue = daysUntilDue
        self._defaultSource = DynamicExpandable(id: defaultSource)
        self.defaultTaxRates = defaultTaxRates
        self.discount = discount
        self.endedAt = endedAt
        self.livemode = livemode
        self.nextPendingInvoiceItemInvoice = nextPendingInvoiceItemInvoice
        self._onBehalfOf = Expandable(id: onBehalfOf)
        self.pauseCollection = pauseCollection
        self.paymentSettings = paymentSettings
        self.pendingInvoiceItemInterval = pendingInvoiceItemInterval
        self._schedule = Expandable(id: schedule)
        self.startDate = startDate
        self.testClock = testClock
        self.transferData = transferData
        self.trialEnd = trialEnd
        self.trialSettings = trialSettings
        self.trialStart = trialStart
    }
}

public struct SubscriptionAutomaticTax: Codable {
    /// Whether Stripe automatically computes tax on this subscription.
    public var enabled: Bool?
    
    public init(enabled: Bool? = nil) {
        self.enabled = enabled
    }
}

public struct SubscriptionBillingThresholds: Codable {
    /// Monetary threshold that triggers the subscription to create an invoice
    public var amountGte: Int?
    /// Indicates if the `billing_cycle_anchor` should be reset when a threshold is reached. If true, `billing_cycle_anchor` will be updated to the date/time the threshold was last reached; otherwise, the value will remain unchanged. This value may not be `true` if the subscription contains items with plans that have `aggregate_usage=last_ever`.
    public var resetBillingCycleAnchor: Bool?
    
    public init(amountGte: Int? = nil, resetBillingCycleAnchor: Bool? = nil) {
        self.amountGte = amountGte
        self.resetBillingCycleAnchor = resetBillingCycleAnchor
    }
}

public struct SubscriptionCancellationDetails: Codable {
    /// Additional comments about why the user canceled the subscription, if the subscription was cancelled explicitly by the user.
    public var comment: String?
    /// The customer submitted reason for why they cancelled, if the subscription was cancelled explicitly by the user.
    public var feedback: SubscriptionCancellationDetailsFeedback?
    
    public init(comment: String? = nil, feedback: SubscriptionCancellationDetailsFeedback? = nil) {
        self.comment = comment
        self.feedback = feedback
    }
}

public enum SubscriptionCancellationDetailsFeedback: String, Codable {
    /// It’s too expensive
    case tooExpensive = "too_expensive"
    /// Some features are missing
    case missingFeatures = "missing_features"
    /// I’m switching to a different service
    case switchService = "switch_service"
    /// I don’t use the service enough
    case unused
    /// Customer service was less than expected
    case customerService = "customer_service"
    /// Ease of use was less than expected
    case tooComplex = "too_complex"
    /// Quality was less than expected
    case lowQuality = "low_quality"
    /// Other reason
    case other
}

public enum SubscriptionCollectionMethod: String, Codable {
    case chargeAutomatically = "charge_automatically"
    case sendInvoice = "send_invoice"
}

public struct SubscriptionPaymentSettings: Codable {
    /// Payment-method-specific configuration to provide to invoices created by the subscription.
    public var paymentMethodOptions: SubscriptionPaymentSettingsPaymentMethodOptions?
    /// The list of payment method types to provide to every invoice created by the subscription. If not set, Stripe attempts to automatically determine the types to use by looking at the invoice’s default payment method, the subscription’s default payment method, the customer’s default payment method, and your invoice template settings.
    public var paymentMethodTypes: [PaymentMethodType]?
    /// Either `off`, or `on_subscription`. With `on_subscription` Stripe updates `subscription.default_payment_method` when a subscription payment succeeds.
    public var saveDefaultPaymentMethod: SubscriptionPaymentSettingsSaveDefaultPaymentMethod?
}

public enum SubscriptionPaymentSettingsSaveDefaultPaymentMethod: String, Codable {
    /// Stripe never sets `subscription.default_payment_method`.
    case off
    /// Stripe sets `subscription.default_payment_method` when a subscription payment succeeds.
    case onSubscription = "on_subscription"
}

public struct SubscriptionPendingInvoiceInterval: Codable {
    /// Specifies invoicing frequency. Either `day`, `week`, `month` or `year`.
    public var interval: SubscriptionInterval?
    /// The number of intervals between invoices. For example, `interval=month` and `interval_count=3` bills every 3 months. Maximum of one year interval allowed (1 year, 12 months, or 52 weeks).
    public var intervalCount: Int?
    
    public init(interval: SubscriptionInterval? = nil, intervalCount: Int? = nil) {
        self.interval = interval
        self.intervalCount = intervalCount
    }
}

public enum SubscriptionInterval: String, Codable {
    case day
    case week
    case month
    case year
}

public enum SubscriptionStatus: String, Codable {
    case active
    case pastDue = "past_due"
    case unpaid
    case canceled
    case incomplete
    case incompleteExpired = "incomplete_expired"
    case trialing
    case paused
}

public struct SubscriptionList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [Subscription]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [Subscription]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}

public enum SubscriptionPaymentBehavior: String, Codable {
    /// Use `allow_incomplete` to transition the subscription to `status=past_due` if a payment is required but cannot be paid.
    case allowIncomplete = "allow_incomplete"
    /// Use `error_if_incomplete` if you want Stripe to return an HTTP 402 status code if a subscription’s first invoice cannot be paid.
    case errorIfIncomplete = "error_if_incomplete"
    /// Use `pending_if_incomplete` to update the subscription using pending updates. When you use `pending_if_incomplete` you can only pass the parameters supported by pending updates.
    case pendingIfIncomplete = "pending_if_incomplete"
    /// Use `default_incomplete` to create Subscriptions with `status=incomplete` when the first invoice requires payment, otherwise start as active. Subscriptions transition to `status=active` when successfully confirming the payment intent on the first invoice. This allows simpler management of scenarios where additional user actions are needed to pay a subscription’s invoice. Such as failed payments, SCA regulation, or collecting a mandate for a bank debit payment method. If the payment intent is not confirmed within 23 hours subscriptions transition to `status=incomplete_expired`, which is a terminal state.
    case defaultIncomplete = "default_incomplete"
}

public enum SubscriptionProrationBehavior: String, Codable {
    case createProrations = "create_prorations"
    case none
    case alwaysInvoice = "always_invoice"
}

public struct SubscriptionPendingUpdate: Codable {
    /// If the update is applied, determines the date of the first full invoice, and, for plans with `month` or `year` intervals, the day of the month for subsequent invoices.
    public var billingCycleAnchor: Date?
    /// The point after which the changes reflected by this update will be discarded and no longer applied.
    public var expiresAt: Date?
    /// List of subscription items, each with an attached plan, that will be set if the update is applied.
    public var subscriptionItems: [SubscriptionItem]?
    /// Unix timestamp representing the end of the trial period the customer will get before being charged for the first time, if the update is applied.
    public var trialEnd: Date?
    /// Indicates if a plan’s `trial_period_days` should be applied to the subscription. Setting `trial_end` per subscription is preferred, and this defaults to `false`. Setting this flag to `true` together with `trial_end` is not allowed. See [Using trial periods on subscriptions](https://stripe.com/docs/billing/subscriptions/trials) to learn more.
    public var trialFromPlan: Bool?
    
    public init(billingCycleAnchor: Date? = nil,
                expiresAt: Date? = nil,
                subscriptionItems: [SubscriptionItem]? = nil,
                trialEnd: Date? = nil,
                trialFromPlan: Bool? = nil) {
        self.billingCycleAnchor = billingCycleAnchor
        self.expiresAt = expiresAt
        self.subscriptionItems = subscriptionItems
        self.trialEnd = trialEnd
        self.trialFromPlan = trialFromPlan
    }
}

public struct SubscriptionPauseCollection: Codable {
    /// The payment collection behavior for this subscription while paused. One of `keep_as_draft`, `mark_uncollectible`, or `void`.
    public var behavior: SubscriptionPauseCollectionBehavior?
    /// The time after which the subscription will resume collecting payments.
    public var resumesAt: Date?
    
    public init(behavior: SubscriptionPauseCollectionBehavior? = nil, resumesAt: Date? = nil) {
        self.behavior = behavior
        self.resumesAt = resumesAt
    }
}

public enum SubscriptionPauseCollectionBehavior: String, Codable {
    case keepAsDraft = "keep_as_draft"
    case markUncollectible = "mark_uncollectible"
    case void
}

public struct SubscriptionTrialSettings: Codable {
    /// SubscriptionTrialSettingsEndBehavior?
    public var endBehavior: SubscriptionTrialSettingsEndBehavior?
    
    public init(endBehavior: SubscriptionTrialSettingsEndBehavior? = nil) {
        self.endBehavior = endBehavior
    }
}
public struct SubscriptionTrialSettingsEndBehavior: Codable {
    /// Indicates how the subscription should change when the trial ends if the user did not provide a payment method.
    public var missingPaymentMethod: SubscriptionTrialSettingsEndBehaviorMissingPaymentMethod?
    
    public init(missingPaymentMethod: SubscriptionTrialSettingsEndBehaviorMissingPaymentMethod? = nil) {
        self.missingPaymentMethod = missingPaymentMethod
    }
}
public enum SubscriptionTrialSettingsEndBehaviorMissingPaymentMethod: String, Codable {
    /// Cancel the subscription if a payment method is not attached when the trial ends.
    case cancel
    /// Pause the subscription if a payment method is not attached when the trial ends.
    case pause
    /// Create an invoice when the trial ends, even if the user did not set up a payment method.
    case createInvoice = "create_invoice"
}

public struct SubscriptionTransferData: Codable {
    /// A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the destination account. By default, the entire amount is transferred to the destination.
    public var amountPercent: Int?
    /// The account where funds from the payment will be transferred to upon payment success.
    @Expandable<StripeConnectAccount> public var destination: String?
    
    public init(amountPercent: Int? = nil, destination: String? = nil) {
        self.amountPercent = amountPercent
        self._destination = Expandable(id: destination)
    }
}

public struct SubscriptionSearchResult: Codable {
    /// A string describing the object type returned.
    public var object: String
    /// A list of subscription, paginated by any request parameters.
    public var data: [Subscription]?
    /// Whether or not there are more elements available after this set.
    public var hasMore: Bool?
    /// The URL for accessing this list.
    public var url: String?
    /// The URL for accessing the next page in search results.
    public var nextPage: String?
    /// The total count of entries in the search result, not just the current page.
    public var totalCount: Int?
    
    public init(object: String,
                data: [Subscription]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil,
                nextPage: String? = nil,
                totalCount: Int? = nil) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
        self.nextPage = nextPage
        self.totalCount = totalCount
    }
}

