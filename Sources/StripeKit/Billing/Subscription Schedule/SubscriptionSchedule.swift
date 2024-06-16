//
//  SubscriptionSchedule.swift
//  
//
//  Created by Andrew Edwards on 1/2/20.
//

import Foundation

/// The [Schedule Object](https://stripe.com/docs/api/subscription_schedules/object)
public struct SubscriptionSchedule: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// Object representing the start and end dates for the current phase of the subscription schedule, if it is active.
    public var currentPhase: SubscriptionScheduleCurrentPhase?
    /// ID of the customer who owns the subscription schedule.
    @Expandable<Customer> public var customer: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Configuration for the subscription schedule’s phases.
    public var phases: [SubscriptionSchedulePhase]?
    /// The present status of the subscription schedule. Possible values are `not_started`, `active`, `completed`, `released`, and `canceled`. You can read more about the different states in our behavior guide.
    public var status: SubscriptionScheduleStatus?
    /// ID of the subscription managed by the subscription schedule.
    @Expandable<Subscription> public var subscription: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// ID of the Connect Application that created the schedule.
    public var application: String?
    /// Time at which the subscription schedule was canceled. Measured in seconds since the Unix epoch.
    public var canceledAt: Date?
    /// Time at which the subscription schedule was completed. Measured in seconds since the Unix epoch.
    public var completedAt: Date?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Object representing the subscription schedule’s default settings.
    public var defaultSettings: SubscriptionScheduleDefaultSettings?
    /// Behavior of the subscription schedule and underlying subscription when it ends.
    public var endBehavior: SubscriptionScheduleEndBehavior?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Time at which the subscription schedule was released. Measured in seconds since the Unix epoch.
    public var releasedAt: Date?
    /// ID of the subscription once managed by the subscription schedule (if it is released).
    public var releasedSubscription: String?
    /// ID of the test clock this subscription schedule belongs to.
    @Expandable<TestClock> public var testClock: String?
    
    public init(id: String,
                currentPhase: SubscriptionScheduleCurrentPhase? = nil,
                customer: String? = nil,
                metadata: [String : String]? = nil,
                phases: [SubscriptionSchedulePhase]? = nil,
                status: SubscriptionScheduleStatus? = nil,
                subscription: String? = nil,
                object: String,
                application: String? = nil,
                canceledAt: Date? = nil,
                completedAt: Date? = nil,
                created: Date,
                defaultSettings: SubscriptionScheduleDefaultSettings? = nil,
                endBehavior: SubscriptionScheduleEndBehavior? = nil,
                livemode: Bool? = nil,
                releasedAt: Date? = nil,
                releasedSubscription: String? = nil,
                testClock: String? = nil) {
        self.id = id
        self.currentPhase = currentPhase
        self._customer = Expandable(id: customer)
        self.metadata = metadata
        self.phases = phases
        self.status = status
        self._subscription = Expandable(id: subscription)
        self.object = object
        self.application = application
        self.canceledAt = canceledAt
        self.completedAt = completedAt
        self.created = created
        self.defaultSettings = defaultSettings
        self.endBehavior = endBehavior
        self.livemode = livemode
        self.releasedAt = releasedAt
        self.releasedSubscription = releasedSubscription
        self._testClock = Expandable(id: testClock)
    }
}

public struct SubscriptionScheduleCurrentPhase: Codable {
    /// The end of this phase of the subscription schedule.
    public var endDate: Date?
    /// The start of this phase of the subscription schedule.
    public var startDate: Date?
    
    public init(endDate: Date? = nil, startDate: Date? = nil) {
        self.endDate = endDate
        self.startDate = startDate
    }
}

public struct SubscriptionScheduleDefaultSettings: Codable {
    /// A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the application owner’s Stripe account during this phase of the schedule.
    public var applicationFeePercent: Float?
    /// Default settings for automatic tax computation.
    public var automaticTax: SubscriptionScheduleDefaultSettingsAutomaticTax?
    /// Possible values are `phase_start` or `automatic`. If `phase_start` then billing cycle anchor of the subscription is set to the start of the phase when entering the phase. If `automatic` then the billing cycle anchor is automatically modified as needed when entering the phase. For more information, see the billing cycle documentation.
    public var billingCycleAnchor: SubscriptionScheduleBillingCycleAnchor?
    /// Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period
    public var billingThresholds: SubscriptionScheduleDefaultSettingsBillingThresholds?
    /// Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay the underlying subscription at the end of each billing cycle using the default source attached to the customer. When sending an invoice, Stripe will email your customer an invoice with payment instructions.
    public var collectionMethod: SubscriptionScheduleCollectionMethod?
    /// ID of the default payment method for the subscription schedule. If not set, invoices will use the default payment method in the customer’s invoice settings.
    @Expandable<PaymentMethod> public var defaultPaymentMethod: String?
    /// Subscription description, meant to be displayable to the customer. Use this field to optionally store an explanation of the subscription.
    public var description: String?
    /// The subscription schedule’s default invoice settings.
    public var invoiceSettings: SubscriptionScheduleInvoiceSettings?
    /// The account (if any) the charge was made on behalf of for charges associated with the schedule’s subscription. See the Connect documentation for details.
    @Expandable<ConnectAccount> public var onBehalfOf: String?
    /// The account (if any) the subscription’s payments will be attributed to for tax reporting, and where funds from each payment will be transferred to for each of the subscription’s invoices.
    public var transferData: SubscriptionScheduleTransferData?
    
    public init(applicationFeePercent: Float? = nil,
                automaticTax: SubscriptionScheduleDefaultSettingsAutomaticTax? = nil,
                billingCycleAnchor: SubscriptionScheduleBillingCycleAnchor? = nil,
                billingThresholds: SubscriptionScheduleDefaultSettingsBillingThresholds? = nil,
                collectionMethod: SubscriptionScheduleCollectionMethod? = nil,
                defaultPaymentMethod: String? = nil,
                description: String? = nil,
                invoiceSettings: SubscriptionScheduleInvoiceSettings? = nil,
                onBehalfOf: String? = nil,
                transferData: SubscriptionScheduleTransferData? = nil) {
        self.applicationFeePercent = applicationFeePercent
        self.automaticTax = automaticTax
        self.billingCycleAnchor = billingCycleAnchor
        self.billingThresholds = billingThresholds
        self.collectionMethod = collectionMethod
        self._defaultPaymentMethod = Expandable(id: defaultPaymentMethod)
        self.description = description
        self.invoiceSettings = invoiceSettings
        self._onBehalfOf = Expandable(id: onBehalfOf)
        self.transferData = transferData
    }
}

public struct SubscriptionScheduleDefaultSettingsAutomaticTax: Codable {
    /// Whether Stripe automatically computes tax on invoices created during this phase.
    public var enabled: Bool?
    
    public init(enabled: Bool? = nil) {
        self.enabled = enabled
    }
}

public enum SubscriptionScheduleCollectionMethod: String, Codable {
    case chargeAutomatically = "charge_automatically"
    case sendInvoice = "send_invoice"
}

public enum SubscriptionScheduleEndBehavior: String, Codable {
    case release
    case cancel
}

public struct SubscriptionScheduleDefaultSettingsBillingThresholds: Codable {
    /// Monetary threshold that triggers the subscription to create an invoice
    public var amountGte: Int?
    /// Indicates if the `billing_cycle_anchor` should be reset when a threshold is reached. If true, `billing_cycle_anchor` will be updated to the date/time the threshold was last reached; otherwise, the value will remain unchanged. This value may not be `true` if the subscription contains items with plans that have `aggregate_usage=last_ever`.
    public var resetBillingCycleAnchor: Bool?
    
    public init(amountGte: Int? = nil, resetBillingCycleAnchor: Bool? = nil) {
        self.amountGte = amountGte
        self.resetBillingCycleAnchor = resetBillingCycleAnchor
    }
}

public struct SubscriptionScheduleInvoiceSettings: Codable {
    /// Number of days within which a customer must pay invoices generated by this subscription schedule. This value will be `null` for subscription schedules where `billing=charge_automatically`.
    public var daysUntilDue: Int?
    
    public init(daysUntilDue: Int? = nil) {
        self.daysUntilDue = daysUntilDue
    }
}

public struct SubscriptionScheduleTransferData: Codable {
    /// A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the destination account. By default, the entire amount is transferred to the destination.
    public var amountPercent: Int?
    /// The account where funds from the payment will be transferred to upon payment success.
    @Expandable<ConnectAccount> public var destination: String?
    
    public init(amountPercent: Int? = nil, destination: String? = nil) {
        self.amountPercent = amountPercent
        self._destination = Expandable(id: destination)
    }
}

public struct SubscriptionSchedulePhase: Codable {
    /// A list of prices and quantities that will generate invoice items appended to the first invoice for this phase.
    public var addInvoiceItems: [SubscriptionSchedulePhaseAddInvoiceItem]?
    /// A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the application owner’s Stripe account during this phase of the schedule.
    public var applicationFeePercent: Float?
    /// Automatic tax settings for this phase.
    public var automaticTax: SubscriptionSchedulePhaseAutomaticTax?
    /// Possible values are `phase_start` or `automatic`. If `phase_start` then billing cycle anchor of the subscription is set to the start of the phase when entering the phase. If automatic then the billing cycle anchor is automatically modified as needed when entering the phase. For more information, see the billing cycle documentation.
    public var billingCycleAnchor: SubscriptionScheduleBillingCycleAnchor?
    /// Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period
    public var billingThresholds: SubscriptionScheduleDefaultSettingsBillingThresholds?
    /// Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay the underlying subscription at the end of each billing cycle using the default source attached to the customer. When sending an invoice, Stripe will email your customer an invoice with payment instructions.
    public var collectionMethod: SubscriptionScheduleCollectionMethod?
    /// ID of the coupon to use during this phase of the subscription schedule.
    @Expandable<Coupon> public var coupon: String?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Currency?
    /// ID of the default payment method for the subscription schedule. It must belong to the customer associated with the subscription schedule. If not set, invoices will use the default payment method in the customer’s invoice settings.
    @Expandable<PaymentMethod> public var defaultPaymentMethod: String?
    /// The default tax rates to apply to the subscription during this phase of the subscription schedule.
    public var defaultTaxRates: [TaxRate]?
    /// Subscription description, meant to be displayable to the customer. Use this field to optionally store an explanation of the subscription.
    public var description: String?
    /// The end of this phase of the subscription schedule.
    public var endDate: Date?
    /// The subscription schedule’s default invoice settings.
    public var invoiceSettings: SubscriptionScheduleInvoiceSettings?
    /// Subscription items to configure the subscription to during this phase of the subscription schedule.
    public var items: [SubscriptionSchedulePhaseItem]?
    /// Set of key-value pairs that you can attach to a phase. Metadata on a schedule’s phase will update the underlying subscription’s metadata when the phase is entered. Updating the underlying subscription’s metadata directly will not affect the current phase’s metadata.
    public var metadata: [String: String]?
    /// The account (if any) the charge was made on behalf of for charges associated with the schedule’s subscription. See the Connect documentation for details.
    @Expandable<ConnectAccount> public var onBehalfOf: String?
    /// Controls whether or not the subscription schedule will prorate when transitioning to this phase. Values are `create_prorations` and `none`.
    public var prorationBehavior: SubscriptionSchedulePhaseProrationBehavior?
    /// The start of this phase of the subscription schedule.
    public var startDate: Date?
    /// The account (if any) the subscription’s payments will be attributed to for tax reporting, and where funds from each payment will be transferred to for each of the subscription’s invoices.
    public var transferData: SubscriptionSchedulePhaseTransferData?
    /// When the trial ends within the phase.
    public var trialEnd: Date?
    
    public init(addInvoiceItems: [SubscriptionSchedulePhaseAddInvoiceItem]? = nil,
                applicationFeePercent: Float? = nil,
                automaticTax: SubscriptionSchedulePhaseAutomaticTax? = nil,
                billingCycleAnchor: SubscriptionScheduleBillingCycleAnchor? = nil,
                billingThresholds: SubscriptionScheduleDefaultSettingsBillingThresholds? = nil,
                collectionMethod: SubscriptionScheduleCollectionMethod? = nil,
                coupon: String? = nil,
                currency: Currency? = nil,
                defaultPaymentMethod: String? = nil,
                defaultTaxRates: [TaxRate]? = nil,
                description: String? = nil,
                endDate: Date? = nil,
                invoiceSettings: SubscriptionScheduleInvoiceSettings? = nil,
                items: [SubscriptionSchedulePhaseItem]? = nil,
                metadata: [String: String]? = nil,
                onBehalfOf: String? = nil,
                prorationBehavior: SubscriptionSchedulePhaseProrationBehavior? = nil,
                startDate: Date? = nil,
                transferData: SubscriptionSchedulePhaseTransferData? = nil,
                trialEnd: Date? = nil) {
        self.addInvoiceItems = addInvoiceItems
        self.applicationFeePercent = applicationFeePercent
        self.automaticTax = automaticTax
        self.billingCycleAnchor = billingCycleAnchor
        self.billingThresholds = billingThresholds
        self.collectionMethod = collectionMethod
        self._coupon = Expandable(id: coupon)
        self.currency = currency
        self._defaultPaymentMethod = Expandable(id: defaultPaymentMethod)
        self.defaultTaxRates = defaultTaxRates
        self.description = description
        self.endDate = endDate
        self.invoiceSettings = invoiceSettings
        self.items = items
        self.metadata = metadata
        self._onBehalfOf = Expandable(id: onBehalfOf)
        self.prorationBehavior = prorationBehavior
        self.startDate = startDate
        self.transferData = transferData
        self.trialEnd = trialEnd
    }
}

public struct SubscriptionSchedulePhaseAddInvoiceItem: Codable {
    /// ID of the price used to generate the invoice item.
    @Expandable<Price> public var price: String?
    /// The quantity of the invoice item.
    public var quantity: Int?
    /// The tax rates which apply to the item. When set, the `default_tax_rates` do not apply to this item.
    public var taxRates: [TaxRate]?
    
    public init(price: String? = nil,
                quantity: Int? = nil,
                taxRates: [TaxRate]? = nil) {
        self._price = Expandable(id: price)
        self.quantity = quantity
        self.taxRates = taxRates
    }
}

public struct SubscriptionSchedulePhaseAutomaticTax: Codable {
    /// Whether Stripe automatically computes tax on invoices created during this phase.
    public var enabled: Bool?
    
    public init(enabled: Bool? = nil) {
        self.enabled = enabled
    }
}

public struct SubscriptionSchedulePhaseItem: Codable {
    /// Define thresholds at which an invoice will be sent, and the related subscription advanced to a new billing period.
    public var billingThresholds: SubscriptionSchedulePhaseItemBillingThresholds?
    /// Set of key-value pairs that you can attach to an item. Metadata on this item will update the underlying subscription item’s metadata when the phase is entered.
    public var metadata: [String: String]?
    /// ID of the price to which the customer should be subscribed.
    @Expandable<Price> public var price: String?
    /// Quantity of the plan to which the customer should be subscribed.
    public var quantity: Int?
    /// The tax rates which apply to this `phase_item`. When set, the `default_tax_rates` on the phase do not apply to this `phase_item`.
    public var taxRates: [TaxRate]?
    
    public init(billingThresholds: SubscriptionSchedulePhaseItemBillingThresholds? = nil,
                metadata: [String : String]? = nil,
                price: String? = nil,
                quantity: Int? = nil,
                taxRates: [TaxRate]? = nil) {
        self.billingThresholds = billingThresholds
        self.metadata = metadata
        self._price = Expandable(id: price)
        self.quantity = quantity
        self.taxRates = taxRates
    }
}

public struct SubscriptionSchedulePhaseItemBillingThresholds: Codable {
    /// Usage threshold that triggers the subscription to create an invoice
    public var usageGte: Int?
    
    public init(usageGte: Int? = nil) {
        self.usageGte = usageGte
    }
}

public struct SubscriptionSchedulePhaseTransferData: Codable {
    /// A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the destination account. By default, the entire amount is transferred to the destination.
    public var amountPercent: Int?
    /// The account where funds from the payment will be transferred to upon payment success.
    @Expandable<ConnectAccount> public var destination: String?
    
    public init(amountPercent: Int? = nil, destination: String? = nil) {
        self.amountPercent = amountPercent
        self._destination = Expandable(id: destination)
    }
}

public enum SubscriptionScheduleBillingCycleAnchor: String, Codable {
    case phaseStart = "phase_start"
    case automatic
}

public enum SubscriptionScheduleStatus: String, Codable {
    case notStarted = "not_started"
    case active
    case completed
    case released
    case canceled
}

public enum SubscriptionSchedulePhaseProrationBehavior: String, Codable {
    case createProrations = "create_prorations"
    case alwaysInvoice = "always_invoice"
    case none
}

public struct SubscriptionScheduleList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [SubscriptionSchedule]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [SubscriptionSchedule]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
