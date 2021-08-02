//
//  Quote.swift
//  StripeKit
//
//  Created by Andrew Edwards on 7/25/21.
//

import Foundation

/// A Quote is a way to model prices that you'd like to provide to a customer. Once accepted, it will automatically create an invoice, subscription or subscription schedule.
public struct StripeQuote: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// This field is not included by default. To include it in the response, expand the `line_items` field.
    public var lineItems: StripeQuoteLineItemList?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Total before any discounts or taxes are applied.
    public var amountSubtotal: Int?
    /// Total after discounts and taxes are applied.
    public var amountTotal: Int?
    /// The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the application owner’s Stripe account. Only applicable if there are no line items with recurring prices on the quote.
    public var applicationFeeAmount: Int?
    /// A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the application owner’s Stripe account. Only applicable if there are line items with recurring prices on the quote.
    public var applicationFeePercent: String?
    /// Settings for automatic tax lookup for this quote and resulting invoices and subscriptions.
    public var automaticTax: StripeQuoteAutomaticTax?
    /// Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay invoices at the end of the subscription cycle or on finalization using the default payment method attached to the subscription or customer. When sending an invoice, Stripe will email your customer an invoice with payment instructions. Defaults to `charge_automatically`.
    public var collectionMethod: String?
    /// The definitive totals and line items for the quote, computed based on your inputted line items as well as other configuration such as trials. Used for rendering the quote to your customer.
    public var computed: StripeQuoteComputed?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// The tax rates applied to this quote.
    public var defaultTaxRates: [String]?
    /// A description that will be displayed on the quote PDF.
    public var description: String?
    /// The discounts applied to this quote.
    public var discounts: [String]?
    /// The date on which the quote will be canceled if in `open` or `draft` status. Measured in seconds since the Unix epoch.
    public var expiresAt: Date?
    /// A footer that will be displayed on the quote PDF.
    public var footer: String?
    /// Details of the quote that was cloned. See the cloning documentation for more details.
    public var fromQuote: StripeQuoteFromQuote?
    /// A header that will be displayed on the quote PDF.
    public var header: String?
    @Expandable<StripeInvoice> public var invoice: String?
    /// All invoices will be billed using the specified settings.
    public var invoiceSettings: StripeQuoteInvoiceSettings?
    /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    public var livemode: Bool
    /// A unique number that identifies this particular quote. This number is assigned once the quote is finalized.
    public var number: String?
    /// The account on behalf of which to charge. See the Connect documentation for details.
    @Expandable<StripeConnectAccount> public var onBehalfOf: String?
    /// The status of the quote.
    public var status: StripeQuoteStatus?
    /// The timestamps of which the quote transitioned to a new status.
    public var statusTransitions: StripeQuoteStatusTransition?
    /// The subscription that was created or updated from this quote.
    @Expandable<StripeSubscription> public var subscription: String?
    /// When creating a subscription or subscription schedule, the specified configuration data will be used. There must be at least one line item with a recurring price for a subscription or subscription schedule to be created.
    public var subscriptionData: StripeQuoteSubscriptionData?
    /// The subscription schedule that was created or updated from this quote.
    @Expandable<StripeSubscriptionSchedule> public var subscriptionSchedule: String?
    /// Tax and discount details for the computed total amount.
    public var totalDetails: StripeQuoteTotalDetails?
    /// The account (if any) the payments will be attributed to for tax reporting, and where funds from each payment will be transferred to for each of the invoices.
    public var transferData: StripeQuoteTransferData?
}

public struct StripeQuoteAutomaticTax: StripeModel {
    /// Automatically calculate taxes
    public var enabled: Bool
    /// The status of the most recent automated tax calculation for this quote.
    public var status: StripeQuoteAutomaticTaxStatus?
}

public enum StripeQuoteAutomaticTaxStatus: String, StripeModel {
    /// The location details supplied on the customer aren’t valid or don’t provide enough location information to accurately determine tax rates for the customer.
    case requiresLocationInputs = "requires_location_inputs"
    /// Stripe successfully calculated tax automatically on this quote.
    case complete
    /// The Stripe Tax service failed, please try again later.
    case failed
}

public enum StripeQuoteCollectionMethod: String, StripeModel {
    case chargeAutomatically = "charge_automatically"
    case sendInvoice = "send_invoice"
}

public struct StripeQuoteComputed: StripeModel {
    /// The definitive totals and line items the customer will be charged on a recurring basis. Takes into account the line items with recurring prices and discounts with `duration=forever` coupons only. Defaults to null if no inputted line items with recurring prices.
    public var recurring: StripeQuoteComputedRecurring?
    /// The definitive upfront totals and line items the customer will be charged on the first invoice.
    public var upfront: StripeQuoteComputedUpfront?
}

public struct StripeQuoteComputedRecurring: StripeModel {
    /// Total before any discounts or taxes are applied.
    public var amountSubtotal: Int?
    /// Total after discounts and taxes are applied.
    public var amountTotal: Int?
    /// The frequency at which a subscription is billed. One of `day`, `week`, `month` or `year`.
    public var interval: StripePlanInterval?
    /// The number of intervals (specified in the `interval` attribute) between subscription billings. For example, `interval=month` and `interval_count=3` bills every 3 months.
    public var intervalCount: Int?
    /// Tax and discount details for the computed total amount.
    public var totalDetails: StripeQuoteComputedRecurringTotalDetails?
}

public struct StripeQuoteComputedRecurringTotalDetails: StripeModel {
    /// This is the sum of all the line item discounts.
    public var amountDiscount: Int?
    /// This is the sum of all the line item shipping amounts.
    public var amountShipping: Int?
    /// This is the sum of all the line item tax amounts.
    public var amountTax: Int?
    /// Breakdown of individual tax and discount amounts that add up to the totals.
    ///
    /// This field is not included by default. To include it in the response, expand the `breakdown` field.
    public var breakdown: StripeQuoteComputedRecurringTotalDetailsBreakdown?
}

public struct StripeQuoteComputedRecurringTotalDetailsBreakdown: StripeModel {
    /// The aggregated line item discounts.
    public var discounts: [StripeQuoteComputedRecurringTotalDetailsBreakdownDiscount]?
    /// The aggregated line item tax amounts by rate.
    public var taxes: [StripeQuoteComputedRecurringTotalDetailsBreakdownTax]?
}

public struct StripeQuoteComputedRecurringTotalDetailsBreakdownDiscount: StripeModel {
    /// The amount discounted.
    public var amount: Int?
    /// The discount applied.
    public var discount: StripeDiscount?
}

public struct StripeQuoteComputedRecurringTotalDetailsBreakdownTax: StripeModel {
    /// Amount of tax applied for this rate.
    public var amount: Int?
    /// The tax rate applied.
    public var rate: StripeTaxRate?
}

public struct StripeQuoteComputedUpfront: StripeModel {
    /// Total before any discounts or taxes are applied.
    public var amountSubtotal: Int?
    /// Total after discounts and taxes are applied.
    public var amountTotal: Int?
    /// The line items that will appear on the next invoice after this quote is accepted. This does not include pending invoice items that exist on the customer but may still be included in the next invoice.
    ///
    /// This field is not included by default. To include it in the response, expand the `line_items` field.
    public var lineItems: StripeQuoteLineItemList?
    /// Tax and discount details for the computed total amount.
    public var totalDetails: StripeQuoteComputedUpfrontTotalDetails?
}

public struct StripeQuoteComputedUpfrontTotalDetails: StripeModel {
    /// This is the sum of all the line item discounts.
    public var amountDiscount: Int?
    /// This is the sum of all the line item shipping amounts.
    public var amountShipping: Int?
    /// This is the sum of all the line item tax amounts.
    public var amountTax: Int?
    /// Breakdown of individual tax and discount amounts that add up to the totals.
    ///
    /// This field is not included by default. To include it in the response, expand the `breakdown` field.
    public var breakdown: StripeQuoteComputedUpfrontTotalDetailsBreakdown?
}

public struct StripeQuoteComputedUpfrontTotalDetailsBreakdown: StripeModel {
    /// The aggregated line item discounts.
    public var discounts: [StripeQuoteComputedUpfrontTotalDetailsBreakdownDiscount]?
    /// The aggregated line item tax amounts by rate.
    public var taxes: [StripeQuoteComputedUpfrontTotalDetailsBreakdownTax]?
}

public struct StripeQuoteComputedUpfrontTotalDetailsBreakdownDiscount: StripeModel {
    /// The amount discounted.
    public var amount: Int?
    /// The discount applied.
    public var discount: StripeDiscount?
}

public struct StripeQuoteComputedUpfrontTotalDetailsBreakdownTax: StripeModel {
    /// Amount of tax applied for this rate.
    public var amount: Int?
    /// The tax rate applied.
    public var rate: StripeTaxRate?
}

public struct StripeQuoteFromQuote: StripeModel {
    /// Whether this quote is a revision of a different quote.
    public var isRevision: Bool?
    /// The quote that was cloned.
    @Expandable<StripeQuote> public var quote: String?
}

public struct StripeQuoteInvoiceSettings: StripeModel {
    /// Number of days within which a customer must pay invoices generated by this quote. This value will be null for quotes where `collection_method=charge_automatically`.
    public var daysUntilDue: Int?
}

public enum StripeQuoteStatus: String, StripeModel {
    /// The quote can be edited while in this status and has not been sent to the customer.
    case draft
    /// The quote has been finalized and is awaiting action from the customer.
    case open
    /// The customer has accepted the quote and invoice, subscription or subscription schedule has been created.
    case accepted
    /// The quote has been canceled and is no longer valid.
    case canceled
}

public struct StripeQuoteStatusTransition: StripeModel {
    /// The time that the quote was accepted. Measured in seconds since Unix epoch.
    public var acceptedAt: Date?
    /// The time that the quote was canceled. Measured in seconds since Unix epoch.
    public var canceledAt: Date?
    /// The time that the quote was finalized. Measured in seconds since Unix epoch.
    public var finalizedAt: Date?
}

public struct StripeQuoteSubscriptionData: StripeModel {
    /// When creating a new subscription, the date of which the subscription schedule will start after the quote is accepted. This date is ignored if it is in the past when the quote is accepted. Measured in seconds since the Unix epoch.
    public var effectiveDate: Date?
    /// Integer representing the number of trial period days before the customer is charged for the first time.
    public var trialPeriodDays: Int?
}

public struct StripeQuoteTotalDetails: StripeModel {
    /// This is the sum of all the line item discounts.
    public var amountDiscount: Int?
    /// This is the sum of all the line item shipping amounts.
    public var amountShipping: Int?
    /// This is the sum of all the line item tax amounts.
    public var amountTax: Int?
    /// Breakdown of individual tax and discount amounts that add up to the totals.
    ///
    /// This field is not included by default. To include it in the response, expand the `breakdown` field.
    public var breakdown: StripeQuoteTotalDetailsBreakdown?
}

public struct StripeQuoteTotalDetailsBreakdown: StripeModel {
    /// The aggregated line item discounts.
    public var discounts: [StripeQuoteTotalDetailsBreakdownDiscount]?
    /// The aggregated line item tax amounts by rate.
    public var taxes: [StripeQuoteTotalDetailsBreakdownTax]?
}

public struct StripeQuoteTotalDetailsBreakdownDiscount: StripeModel {
    /// The amount discounted.
    public var amount: Int?
    /// The discount applied.
    public var discount: StripeDiscount?
}

public struct StripeQuoteTotalDetailsBreakdownTax: StripeModel {
    /// Amount of tax applied for this rate.
    public var amount: Int?
    /// The tax rate applied.
    public var rate: StripeTaxRate?
}

public struct StripeQuoteTransferData: StripeModel {
    /// The amount in cents that will be transferred to the destination account when the invoice is paid. By default, the entire amount is transferred to the destination.
    public var amount: Int?
    /// A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the destination account. By default, the entire amount will be transferred to the destination.
    public var amountPercent: String?
    /// The account where funds from the payment will be transferred to upon payment success.
    @Expandable<StripeConnectAccount> public var destination: String?
}

public struct StripeQuoteList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeQuoteLineItem]?
}
