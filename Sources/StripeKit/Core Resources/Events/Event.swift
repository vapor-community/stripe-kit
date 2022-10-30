//
//  Event.swift
//  
//
//  Created by Andrew Edwards on 12/8/19.
//

import Foundation
/// The [Event Object](https://stripe.com/docs/api/events/object)
public struct StripeEvent: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The connected account that originated the event.
    public var account: String?
    /// The Stripe API version used to render data. Note: This property is populated only for events on or after October 31, 2014.
    public var apiVersion: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// Object containing data associated with the event.
    public var data: StripeEventData?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Number of webhooks that have yet to be successfully delivered (i.e., to return a 20x response) to the URLs you’ve specified.
    public var pendingWebhooks: Int?
    /// Information on the API request that instigated the event.
    public var request: StripeEventRequest?
    /// Description of the event (e.g., invoice.created or charge.refunded).
    public var type: StripeEventType?
}

public struct StripeEventData: StripeModel {
    /// Object containing the API resource relevant to the event. For example, an `invoice.created` event will have a full [invoice object](https://stripe.com/docs/api/events/object#invoice_object) as the value of the object key.
    public var object: StripeEventObject
}

public enum StripeEventObject: StripeModel {
    case account(StripeConnectAccount)
    case card(StripeCard)
    case bankAccount(StripeBankAccount)
    case applicationFee(StripeApplicationFee)
    case applicationFeeRefund(StripeApplicationFeeRefund)
    case balance(Balance)
    case capability(StripeCapability)
    case charge(StripeCharge)
    case dispute(StripeDispute)
    case refund(StripeRefund)
    case checkoutSession(StripeSession)
    case configuration(StripePortalConfiguration)
    case coupon(StripeCoupon)
    case creditNote(StripeCreditNote)
    case customer(StripeCustomer)
    case discount(StripeDiscount)
    case subscription(StripeSubscription)
    case taxId(StripeTaxID)
    case file(StripeFile)
    case invoice(StripeInvoice)
    case invoiceItem(StripeInvoiceItem)
    case issuingAuthorization(StripeAuthorization)
    case issuingCard(StripeIssuingCard)
    case issuingCardHolder(StripeCardholder)
    case issuingDispute(StripeIssuingDispute)
    case issuingTransaction(StripeTransaction)
    case mandate(StripeMandate)
    case order(StripeOrder)
    case orderReturn(StripeOrderReturn)
    case paymentIntent(StripePaymentIntent)
    case paymentMethod(StripePaymentMethod)
    case payout(StripePayout)
    case person(StripePerson)
    case plan(StripePlan)
    case price(StripePrice)
    case product(StripeProduct)
    case promotionCode(StripePromotionCode)
    case earlyFraudWarniing(StripeEarlyFraudWarning)
    case quote(StripeQuote)
    case reportRun(StripeReportRun)
    case reportType(StripeReportType)
    case review(StripeReview)
    case setupIntent(StripeSetupIntent)
    case scheduledQueryRun(StripeScheduledQueryRun)
    case sku(StripeSKU)
    case subscriptionSchedule(StripeSubscriptionSchedule)
    case taxRate(StripeTaxRate)
    case topup(StripeTopUp)
    case transfer(StripeTransfer)
    case verificationSession(StripeVerificationSession)
    
    public init(from decoder: Decoder) throws {
        let object = try decoder
            .container(keyedBy: CodingKeys.self)
            .decode(String.self, forKey: .object)
        switch object {
        case "account":
            self = try .account(StripeConnectAccount(from: decoder))
        case "application_fee":
            self = try .applicationFee(StripeApplicationFee(from: decoder))
        case "card":
            self = try .card(StripeCard(from: decoder))
        case "bank_account":
            self = try .bankAccount(StripeBankAccount(from: decoder))
        case "billing_portal.configuration":
            self = try .configuration(StripePortalConfiguration(from: decoder))
        case "fee_refund":
            self = try .applicationFeeRefund(StripeApplicationFeeRefund(from: decoder))
        case "balance":
            self = try .balance(Balance(from: decoder))
        case "capability":
            self = try .capability(StripeCapability(from: decoder))
        case "charge":
            self = try .charge(StripeCharge(from: decoder))
        case "dispute":
            self = try .dispute(StripeDispute(from: decoder))
        case "refund":
            self = try .refund(StripeRefund(from: decoder))
        case "checkout.session":
            self = try .checkoutSession(StripeSession(from: decoder))
        case "coupon":
            self = try .coupon(StripeCoupon(from: decoder))
        case "credit_note":
            self = try .creditNote(StripeCreditNote(from: decoder))
        case "customer":
            self = try .customer(StripeCustomer(from: decoder))
        case "discount":
            self = try .discount(StripeDiscount(from: decoder))
        case "subscription":
            self = try .subscription(StripeSubscription(from: decoder))
        case "tax_id":
            self = try .taxId(StripeTaxID(from: decoder))
        case "file":
            self = try .file(StripeFile(from: decoder))
        case "identity.verification_session":
            self = try .verificationSession(StripeVerificationSession(from: decoder))
        case "invoice":
            self = try .invoice(StripeInvoice(from: decoder))
        case "invoiceitem":
            self = try .invoiceItem(StripeInvoiceItem(from: decoder))
        case "issuing.authorization":
            self = try .issuingAuthorization(StripeAuthorization(from: decoder))
        case "issuing.card":
            self = try .issuingCard(StripeIssuingCard(from: decoder))
        case "issuing.cardholder":
            self = try .issuingCardHolder(StripeCardholder(from: decoder))
        case "issuing.dispute":
            self = try .issuingDispute(StripeIssuingDispute(from: decoder))
        case "issuing.transaction":
            self = try .issuingTransaction(StripeTransaction(from: decoder))
        case "mandate":
            self = try .mandate(StripeMandate(from: decoder))
        case "order":
            self = try .order(StripeOrder(from: decoder))
        case "order_return":
            self = try .orderReturn(StripeOrderReturn(from: decoder))
        case "payment_intent":
            self = try .paymentIntent(StripePaymentIntent(from: decoder))
        case "payment_method":
            self = try .paymentMethod(StripePaymentMethod(from: decoder))
        case "payout":
            self = try .payout(StripePayout(from: decoder))
        case "person":
            self = try .person(StripePerson(from: decoder))
        case "plan":
            self = try .plan(StripePlan(from: decoder))
        case "price":
            self = try .price(StripePrice(from: decoder))
        case "product":
            self = try .product(StripeProduct(from: decoder))
        case "promotion_code":
            self = try .promotionCode(StripePromotionCode(from: decoder))
        case "radar.early_fraud_warning":
            self = try .earlyFraudWarniing(StripeEarlyFraudWarning(from: decoder))
        case "quote":
            self = try .quote(StripeQuote(from: decoder))
        case "reporting.report_run":
            self = try .reportRun(StripeReportRun(from: decoder))
        case "reporting.report_type":
            self = try .reportType(StripeReportType(from: decoder))
        case "review":
            self = try .review(StripeReview(from: decoder))
        case "setup_intent":
            self = try .setupIntent(StripeSetupIntent(from: decoder))
        case "scheduled_query_run":
            self = try .scheduledQueryRun(StripeScheduledQueryRun(from: decoder))
        case "sku":
            self = try .sku(StripeSKU(from: decoder))
        case "subscription_schedule":
            self = try .subscriptionSchedule(StripeSubscriptionSchedule(from: decoder))
        case "tax_rate":
            self = try .taxRate(StripeTaxRate(from: decoder))
        case "topup":
            self = try .topup(StripeTopUp(from: decoder))
        case "transfer":
            self = try .transfer(StripeTransfer(from: decoder))
        default:
            throw DecodingError.keyNotFound(CodingKeys.object,
                                            DecodingError.Context(codingPath: [CodingKeys.object],
                                                                  debugDescription: "Missing type '\(object)' cannot be decoded."))
        }
    }
    
    public func encode(to encoder: Encoder) throws { }
    
    private enum CodingKeys: String, CodingKey {
        case object
    }
}

public struct StripeEventRequest: StripeModel {
    /// ID of the API request that caused the event. If null, the event was automatic (e.g., Stripe’s automatic subscription handling). Request logs are available in the dashboard, but currently not in the API.
    public var id: String?
    /// The idempotency key transmitted during the request, if any. Note: This property is populated only for events on or after May 23, 2017.
    public var idempotencyKey: String?
}

public enum StripeEventType: String, StripeModel {
    /// Occurs whenever an account status or property has changed.
    case accountUpdated = "account.updated"
    /// Occurs whenever a user authorizes an application. Sent to the related application only.
    case accountApplicationAuthorized = "account.application.authorized"
    /// Occurs whenever a user deauthorizes an application. Sent to the related application only.
    case accountApplicationDeauthorized = "account.application.deauthorized"
    /// Occurs whenever an external account is created.
    case accountExternalAccountCreated = "account.external_account.created"
    /// Occurs whenever an external account is deleted.
    case accountExternalAccountDeleted = "account.external_account.deleted"
    /// Occurs whenever an external account is updated.
    case accountExternalAccountUpdated = "account.external_account.updated"
    /// Occurs whenever an application fee is created on a charge.
    case applicationFeeCreated = "application_fee.created"
    /// Occurs whenever an application fee is refunded, whether from refunding a charge or from refunding the application fee directly. This includes partial refunds.
    case applicationFeeRefunded = "application_fee.refunded"
    /// Occurs whenever an application fee refund is updated.
    case applicationFeeRefundUpdated = "application_fee.refund.updated"
    /// Occurs whenever your Stripe balance has been updated (e.g., when a charge is available to be paid out). By default, Stripe automatically transfers funds in your balance to your bank account on a daily basis.
    case balanceAvailable = "balance.available"
    /// Occurs whenever a portal configuration is created.
    case billingPortalConfigurationCreated = "billing_portal.configuration.created"
    /// Occurs whenever a portal configuration is updated.
    case billingPortalConfigurationUpdated = "billing_portal.configuration.updated"
    /// Occurs whenever a capability has new requirements or a new status.
    case capabilityUpdated = "capability.updated"
    /// Occurs whenever a previously uncaptured charge is captured.
    case chargeCaptured = "charge.captured"
    /// Occurs whenever an uncaptured charge expires.
    case chargeExpired = "charge.expired"
    /// Occurs whenever a failed charge attempt occurs.
    case chargeFailed = "charge.failed"
    /// Occurs whenever a pending charge is created.
    case chargePending = "charge.pending"
    /// Occurs whenever a charge is refunded, including partial refunds.
    case chargeRefunded = "charge.refunded"
    /// Occurs whenever a new charge is created and is successful.
    case chargeSucceeded = "charge.succeeded"
    /// Occurs whenever a charge description or metadata is updated.
    case chargeUpdated = "charge.updated"
    /// Occurs when a dispute is closed and the dispute status changes to lost, warning_closed, or won.
    case chargeDisputeClosed = "charge.dispute.closed"
    /// Occurs whenever a customer disputes a charge with their bank.
    case chargeDisputeCreated = "charge.dispute.created"
    /// Occurs when funds are reinstated to your account after a dispute is closed. This includes partially refunded payments.
    case chargeDisputeFundsReinstated = "charge.dispute.funds_reinstated"
    /// Occurs when funds are removed from your account due to a dispute.
    case chargeDisputeFundsWithdrawn = "charge.dispute.funds_withdrawn"
    /// Occurs when the dispute is updated (usually with evidence).
    case chargeDisputeUpdated = "charge.dispute.updated"
    /// Occurs whenever a refund is updated, on selected payment methods.
    case chargeRefundUpdated = "charge.refund.updated"
    /// Occurs when a payment intent using a delayed payment method fails.
    case checkoutSessionAsyncPaymentFailed = "checkout.session.async_payment_failed"
    /// Occurs when a payment intent using a delayed payment method finally succeeds.
    case checkoutSessionAsyncPaymentSucceeded = "checkout.session.async_payment_succeeded"
    /// Occurs when a Checkout Session has been successfully completed.
    case checkoutSessionCompleted = "checkout.session.completed"
    /// Occurs when a Checkout Session is expired.
    case checkoutSessionExpired = "checkout.session.expired"
    /// Occurs whenever a coupon is created.
    case couponCreated = "coupon.created"
    /// Occurs whenever a coupon is deleted.
    case couponDeleted = "coupon.deleted"
    /// Occurs whenever a coupon is updated.
    case couponUpdated = "coupon.updated"
    /// Occurs whenever a credit note is created.
    case creditNoteCreated = "credit_note.created"
    /// Occurs whenever a credit note is updated.
    case creditNoteUpdated = "credit_note.updated"
    /// Occurs whenever a credit note is voided.
    case creditNoteVoided = "credit_note.voided"
    /// Occurs whenever a new customer is created.
    case customerCreated = "customer.created"
    /// Occurs whenever a customer is deleted.
    case customerDeleted = "customer.deleted"
    /// Occurs whenever any property of a customer changes.
    case customerUpdated = "customer.updated"
    /// Occurs whenever a coupon is attached to a customer.
    case customerDiscountCreated = "customer.discount.created"
    /// Occurs whenever a coupon is removed from a customer.
    case customerDiscountDeleted = "customer.discount.deleted"
    /// Occurs whenever a customer is switched from one coupon to another.
    case customerDiscountUpdated = "customer.discount.updated"
    /// Occurs whenever a new source is created for a customer.
    case customerSourceCreated = "customer.source.created"
    /// Occurs whenever a source is removed from a customer.
    case customerSourceDeleted = "customer.source.deleted"
    /// Occurs whenever a card or source will expire at the end of the month.
    case customerSourceExpiring = "customer.source.expiring"
    /// Occurs whenever a source's details are changed.
    case customerSourceUpdated = "customer.source.updated"
    /// Occurs whenever a customer is signed up for a new plan.
    case customerSubscriptionCreated = "customer.subscription.created"
    /// Occurs whenever a customer's subscription ends.
    case customerSubscriptionDeleted = "customer.subscription.deleted"
    /// Occurs whenever a customer's subscription's pending update is applied, and the subscription is updated.
    case customerSubscriptionPendingUpdateApplied = "customer.subscription.pending_update_applied"
    /// Occurs whenever a customer's subscription's pending update expires before the related invoice is paid.
    case customerSubscriptionPendingUpdateExpired = "customer.subscription.pending_update_expired"
    /// Occurs three days before a subscription's trial period is scheduled to end, or when a trial is ended immediately (using trial_end=now).
    case customerSubscriptionTrialWillEnd = "customer.subscription.trial_will_end"
    /// Occurs whenever a subscription changes (e.g., switching from one plan to another, or changing the status from trial to active).
    case customerSubscriptionUpdated = "customer.subscription.updated"
    /// Occurs whenever a tax ID is created for a customer.
    case customerTaxIdCreated = "customer.tax_id.created"
    /// Occurs whenever a tax ID is deleted from a customer.
    case customerTaxIdDeleted = "customer.tax_id.deleted"
    /// Occurs whenever a customer's tax ID is updated.
    case customerTaxIdUpdated = "customer.tax_id.updated"
    /// Occurs whenever a new Stripe-generated file is available for your account.
    case fileCreated = "file.created"
    /// Occurs whenever a VerificationSession is canceled
    case identityVerificationSessionCanceled = "identity.verification_session.canceled"
    /// Occurs whenever a VerificationSession is created
    case identityVerificationSessionCreated = "identity.verification_session.created"
    /// Occurs whenever a VerificationSession transitions to processing
    case identityVerificationSessionProcessing = "identity.verification_session.processing"
    /// Occurs whenever a VerificationSession is redacted. You must create a webhook endpoint which explicitly subscribes to this event type to access it. Webhook endpoints which subscribe to all events will not include this event type.
    case identityVerificationSessionRedacted = "identity.verification_session.redacted"
    /// Occurs whenever a VerificationSession transitions to require user input
    case identityVerificationSessionRequiresInput = "identity.verification_session.requires_input"
    /// Occurs whenever a VerificationSession transitions to verified
    case identityVerificationSessionVerified = "identity.verification_session.verified"
    /// Occurs whenever a new invoice is created. To learn how webhooks can be used with this event, and how they can affect it, see Using Webhooks with Subscriptions.
    case invoiceCreated = "invoice.created"
    /// Occurs whenever a draft invoice is deleted.
    case invoiceDeleted = "invoice.deleted"
    /// Occurs whenever a draft invoice cannot be finalized. See the invoice’s last finalization error for details.
    case invoiceFinalizationFailed = "invoice.finalization_failed"
    /// Occurs whenever a draft invoice is finalized and updated to be an open invoice.
    case invoiceFinalized = "invoice.finalized"
    /// Occurs whenever an invoice is marked uncollectible.
    case invoiceMarkedUncollectible = "invoice.marked_uncollectible"
    /// Occurs whenever an invoice payment attempt requires further user action to complete.
    case invoicePaymentActionRequired = "invoice.payment_action_required"
    /// Occurs whenever an invoice payment attempt fails, due either to a declined payment or to the lack of a stored payment method.
    case invoicePaymentFailed = "invoice.payment_failed"
    /// Occurs whenever an invoice payment attempt succeeds.
    case invoicePaymentSucceeded = "invoice.payment_succeeded"
    /// Occurs whenever an invoice payment attempt succeeds or an invoice is marked as paid out-of-band.
    case invoicePaid = "invoice.paid"
    /// Occurs whenever an invoice email is sent out.
    case invoiceSent = "invoice.sent"
    /// Occurs X number of days before a subscription is scheduled to create an invoice that is automatically charged—where X is determined by your subscriptions settings. Note: The received Invoice object will not have an invoice ID.
    case invoiceUpcoming = "invoice.upcoming"
    /// Occurs whenever an invoice changes (e.g., the invoice amount).
    case invoiceUpdated = "invoice.updated"
    /// Occurs whenever an invoice is voided.
    case invoiceVoided = "invoice.voided"
    /// Occurs whenever an invoice item is created.
    case invoiceitemCreated = "invoiceitem.created"
    /// Occurs whenever an invoice item is deleted.
    case invoiceitemDeleted = "invoiceitem.deleted"
    /// Occurs whenever an invoice item is updated.
    case invoiceitemUpdated = "invoiceitem.updated"
    /// Occurs whenever an authorization is created.
    case issuingAuthorizationCreated = "issuing_authorization.created"
    /// Represents a synchronous request for authorization, see Using your integration to handle authorization requests.
    case issuingAuthorizationRequest = "issuing_authorization.request"
    /// Occurs whenever an authorization is updated.
    case issuingAuthorizationUpdated = "issuing_authorization.updated"
    /// Occurs whenever a card is created.
    case issuingCardCreated = "issuing_card.created"
    /// Occurs whenever a card is updated.
    case issuingCardUpdated = "issuing_card.updated"
    /// Occurs whenever a cardholder is created.
    case issuingCardholderCreated = "issuing_cardholder.created"
    /// Occurs whenever a cardholder is updated.
    case issuingCardholderUpdated = "issuing_cardholder.updated"
    /// Occurs whenever a dispute is won, lost or expired.
    case issuingDisputeClosed = "issuing_dispute.closed"
    /// Occurs whenever a dispute is created.
    case issuingDisputeCreated = "issuing_dispute.created"
    /// Occurs whenever funds are reinstated to your account for an Issuing dispute.
    case issuingDisputeFundsReinstated = "issuing_dispute.funds_reinstated"
    /// Occurs whenever a dispute is submitted.
    case issuingDisputeSubmitted = "issuing_dispute.submitted"
    /// Occurs whenever a dispute is updated.
    case issuingDisputeUpdated = "issuing_dispute.updated"
    /// Occurs whenever an issuing transaction is created.
    case issuingTransactionCreated = "issuing_transaction.created"
    /// Occurs whenever an issuing transaction is updated.
    case issuingTransactionUpdated = "issuing_transaction.updated"
    /// Occurs whenever a Mandate is updated.
    case mandateUpdated = "mandate.updated"
    /// Occurs whenever an order is created.
    case orderCreated = "order.created"
    /// Occurs whenever an order payment attempt fails.
    case orderPaymentFailed = "order.payment_failed"
    /// Occurs whenever an order payment attempt succeeds.
    case orderPaymentSucceeded = "order.payment_succeeded"
    /// Occurs whenever an order is updated.
    case orderUpdated = "order.updated"
    /// Occurs whenever an order return is created.
    case orderReturnCreated = "order_return.created"
    /// Occurs when a PaymentIntent has funds to be captured. Check the `amount_capturable` property on the PaymentIntent to determine the amount that can be captured. You may capture the PaymentIntent with an `amount_to_capture` value up to the specified amount. Learn more about capturing PaymentIntents.
    case paymentIntentAmountCapturableUpdated = "payment_intent.amount_capturable_updated"
    /// Occurs when a PaymentIntent is canceled.
    case paymentIntentCanceled = "payment_intent.canceled"
    /// Occurs when a new PaymentIntent is created.
    case paymentIntentCreated = "payment_intent.created"
    /// Occurs when a PaymentIntent has failed the attempt to create a source or a payment.
    case paymentIntentPaymentFailed = "payment_intent.payment_failed"
    /// Occurs when a PaymentIntent has started processing.
    case paymentIntentProcessing = "payment_intent.processing"
    /// Occurs when a PaymentIntent transitions to requires_action state
    case paymentIntentRequiresAction = "payment_intent.requires_action"
    /// Occurs when a PaymentIntent has been successfully fulfilled.
    case paymentIntentSucceeded = "payment_intent.succeeded"
    /// Occurs whenever a new payment method is attached to a customer.
    case paymentMethodAttached = "payment_method.attached"
    /// Occurs whenever a card payment method's details are automatically updated by the network.
    case paymentMethodAutomaticallyUpdated = "payment_method.automatically_updated"
    /// Occurs whenever a payment method is detached from a customer.
    case paymentMethodDetached = "payment_method.detached"
    /// Occurs whenever a payment method is updated via the PaymentMethod update API.
    case paymentMethodUpdated = "payment_method.updated"
    /// Occurs whenever a payout is canceled.
    case payoutCanceled = "payout.canceled"
    /// Occurs whenever a payout is created.
    case payoutCreated = "payout.created"
    /// Occurs whenever a payout attempt fails.
    case payoutFailed = "payout.failed"
    /// Occurs whenever a payout is expected to be available in the destination account. If the payout fails, a payout.failed notification is also sent, at a later time.
    case payoutPaid = "payout.paid"
    /// Occurs whenever a payout's metadata is updated.
    case payoutUpdated = "payout.updated"
    /// Occurs whenever a person associated with an account is created.
    case personCreated = "person.created"
    /// Occurs whenever a person associated with an account is deleted.
    case personDeleted = "person.deleted"
    /// Occurs whenever a person associated with an account is updated.
    case personUpdated = "person.updated"
    /// Occurs whenever a plan is created.
    case planCreated = "plan.created"
    /// Occurs whenever a plan is deleted.
    case planDeleted = "plan.deleted"
    /// Occurs whenever a plan is updated.
    case planUpdated = "plan.updated"
    /// Occurs whenever a price is created.
    case priceCreated = "price.created"
    /// Occurs whenever a price is deleted.
    case priceDeleted = "price.deleted"
    /// Occurs whenever a price is updated.
    case priceUpdated = "price.updated"
    /// Occurs whenever a product is created.
    case productCreated = "product.created"
    /// Occurs whenever a product is deleted.
    case productDeleted = "product.deleted"
    /// Occurs whenever a product is updated.
    case productUpdated = "product.updated"
    /// Occurs whenever a promotion code is created.
    case promotionCodeCreated = "promotion_code.created"
    /// Occurs whenever a promotion code is updated.
    case promotionCodeUpdated = "promotion_code.updated"
    /// Occurs whenever a quote is accepted.
    case quoteAccepted = "quote.accepted"
    /// Occurs whenever a quote is canceled.
    case quoteCanceled = "quote.canceled"
    /// Occurs whenever a quote is created.
    case quoteCreated = "quote.created"
    /// Occurs whenever a quote is finalized.
    case quoteFinalized = "quote.finalized"
    /// Occurs whenever an early fraud warning is created.
    case radarEarlyFraudWarningCreated = "radar.early_fraud_warning.created"
    /// Occurs whenever an early fraud warning is updated.
    case radarEarlyFraudWarningUpdated = "radar.early_fraud_warning.updated"
    /// Occurs whenever a recipient is created.
    case recipientCreated = "recipient.created"
    /// Occurs whenever a recipient is deleted.
    case recipientDeleted = "recipient.deleted"
    /// Occurs whenever a recipient is updated.
    case recipientUpdated = "recipient.updated"
    /// Occurs whenever a requested **ReportRun** failed to complete.
    case reportingReportRunFailed = "reporting.report_run.failed"
    /// Occurs whenever a requested **ReportRun** completed succesfully.
    case reportingReportRunSucceeded = "reporting.report_run.succeeded"
    /// Occurs whenever a **ReportType** is updated (typically to indicate that a new day's data has come available).
    case reportingReportTypeUpdated = "reporting.report_type.updated"
    /// Occurs whenever a review is closed. The review's reason field indicates why: approved, disputed, refunded, or refunded_as_fraud.
    case reviewClosed = "review.closed"
    /// Occurs whenever a review is opened.
    case reviewOpened = "review.opened"
    /// Occurs when a SetupIntent is canceled.
    case setupAttemptCanceled = "setup_intent.canceled"
    /// Occurs when a new SetupIntent is created.
    case setupIntentCreated = "setup_intent.created"
    /// Occurs when a SetupIntent is in requires_action state.
    case setupIntentRequiresAction = "setup_intent.requires_action"
    /// Occurs when a SetupIntent has failed the attempt to setup a payment method.
    case setupIntentSetupFailed = "setup_intent.setup_failed"
    /// Occurs when an SetupIntent has successfully setup a payment method.
    case setupIntentSucceeded = "setup_intent.succeeded"
    /// Occurs whenever a Sigma scheduled query run finishes.
    case sigmaScheduledQueryRunCreated = "sigma.scheduled_query_run.created"
    /// Occurs whenever a SKU is created.
    case skuCreated = "sku.created"
    /// Occurs whenever a SKU is deleted.
    case skuDeleted = "sku.deleted"
    /// Occurs whenever a SKU is updated.
    case skuUpdated = "sku.updated"
    /// Occurs whenever a source is canceled.
    case sourceCanceled = "source.canceled"
    /// Occurs whenever a source transitions to chargeable.
    case sourceChargeable = "source.chargeable"
    /// Occurs whenever a source fails.
    case sourceFailed = "source.failed"
    /// Occurs whenever a source mandate notification method is set to manual.
    case sourceMandateNotification = "source.mandate_notification"
    /// Occurs whenever the refund attributes are required on a receiver source to process a refund or a mispayment.
    case sourceRefundAttributesRequired = "source.refund_attributes_required"
    /// Occurs whenever a source transaction is created.
    case sourceTransactionCreated = "source.transaction.created"
    /// Occurs whenever a source transaction is updated.
    case sourceTransactionUpdated = "source.transaction.updated"
    /// Occurs whenever a subscription schedule is canceled due to the underlying subscription being canceled because of delinquency.
    case subscriptionScheduleAborted = "subscription_schedule.aborted"
    /// Occurs whenever a subscription schedule is canceled.
    case subscriptionScheduleCanceled = "subscription_schedule.canceled"
    /// Occurs whenever a subscription schedule is completed.
    case subscriptionScheduleCompleted = "subscription_schedule.completed"
    /// Occurs whenever a subscription schedule is created.
    case subscriptionScheduleCreated = "subscription_schedule.created"
    /// Occurs whenever a subscription schedule is expiring.
    case subscriptionScheduleExpiring = "subscription_schedule.expiring"
    /// Occurs whenever a subscription schedule is released.
    case subscriptionScheduleReleased = "subscription_schedule.released"
    /// Occurs whenever a subscription schedule is updated.
    case subscriptionScheduleUpdated = "subscription_schedule.updated"
    /// Occurs whenever a new tax rate is created.
    case taxRateCreated = "tax_rate.created"
    /// Occurs whenever a tax rate is updated.
    case taxRateUpdated = "tax_rate.updated"
    /// Occurs whenever a top-up is canceled.
    case topupCanceled = "topup.canceled"
    /// Occurs whenever a top-up is created.
    case topupCreated = "topup.created"
    /// Occurs whenever a top-up fails.
    case topupFailed = "topup.failed"
    /// Occurs whenever a top-up is reversed.
    case topupReversed = "topup.reversed"
    /// Occurs whenever a top-up succeeds.
    case topupSucceeded = "topup.succeeded"
    /// Occurs whenever a transfer is created.
    case transferCreated = "transfer.created"
    /// Occurs whenever a transfer failed.
    case transferFailed = "transfer.failed"
    /// Occurs after a transfer is paid. For Instant Payouts, the event will be sent on the next business day, although the funds should be received well beforehand.
    case transferPaid = "transfer.paid"
    /// Occurs whenever a transfer is reversed, including partial reversals.
    case transferReversed = "transfer.reversed"
    /// Occurs whenever a transfer's description or metadata is updated.
    case transferUpdated = "transfer.updated"
    /// An event not supported by the event type
    case unknownEvent = "unknown"
}

public struct StripeEventList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeEvent]?
}
