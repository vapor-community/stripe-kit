//
//  Event.swift
//  
//
//  Created by Andrew Edwards on 12/8/19.
//

import Foundation
/// The [Event Object](https://stripe.com/docs/api/events/object)
public struct Event: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// The Stripe API version used to render data. Note: This property is populated only for events on or after October 31, 2014.
    public var apiVersion: String?
    /// Object containing data associated with the event.
    public var data: EventData?
    /// Information on the API request that instigated the event.
    public var request: EventRequest?
    /// Description of the event (e.g., invoice.created or charge.refunded).
    public var type: EventType?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The connected account that originated the event.
    public var account: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Number of webhooks that have yet to be successfully delivered (i.e., to return a 20x response) to the URLs you’ve specified.
    public var pendingWebhooks: Int?
    
    public init(id: String,
                apiVersion: String? = nil,
                data: EventData? = nil,
                request: EventRequest? = nil,
                type: EventType? = nil,
                object: String,
                account: String? = nil,
                created: Date? = nil,
                livemode: Bool? = nil,
                pendingWebhooks: Int? = nil) {
        self.id = id
        self.apiVersion = apiVersion
        self.data = data
        self.request = request
        self.type = type
        self.object = object
        self.account = account
        self.created = created
        self.livemode = livemode
        self.pendingWebhooks = pendingWebhooks
    }
}

public struct EventData: Codable {
    /// Object containing the API resource relevant to the event. For example, an `invoice.created` event will have a full [invoice object](https://stripe.com/docs/api/events/object#invoice_object) as the value of the object key.
    public var object: EventObject
    
    // TODO: - Figure out how to decode this.
    /// Object containing the names of the attributes that have changed, and their previous values (sent along only with *.updated events).
    //public var previousAttributes: [String: Any]?
    
    public init(object: EventObject) {
        self.object = object
    }
}

public enum EventObject: Codable {
    case account(ConnectAccount)
    case application(ConnectApplication)
    case card(Card)
    case cashBalance(CashBalance)
    case bankAccount(BankAccount)
    case applicationFee(ApplicationFee)
    case applicationFeeRefund(ApplicationFeeRefund)
    case balance(Balance)
    case capability(Capability)
    case charge(Charge)
    case dispute(Dispute)
    case refund(Refund)
    case checkoutSession(Session)
    case configuration(PortalConfiguration)
    case coupon(Coupon)
    case creditNote(CreditNote)
    case customer(Customer)
    case discount(Discount)
    case subscription(Subscription)
    case taxId(TaxID)
    case file(File)
    case invoice(Invoice)
    case invoiceItem(InvoiceItem)
    case issuingAuthorization(Authorization)
    case issuingCard(IssuingCard)
    case issuingCardHolder(Cardholder)
    case issuingDispute(IssuingDispute)
    case issuingTransaction(Transaction)
    case mandate(Mandate)
    case paymentIntent(PaymentIntent)
    case paymentLink(PaymentLink)
    case paymentMethod(PaymentMethod)
    case payout(Payout)
    case person(Person)
    case plan(Plan)
    case price(Price)
    case product(Product)
    case promotionCode(PromotionCode)
    case earlyFraudWarniing(EarlyFraudWarning)
    case quote(Quote)
    case reportRun(ReportRun)
    case reportType(ReportType)
    case review(Review)
    case setupIntent(SetupIntent)
    case scheduledQueryRun(ScheduledQueryRun)
    case subscriptionSchedule(SubscriptionSchedule)
    case taxRate(TaxRate)
    case topup(TopUp)
    case transfer(Transfer)
    case testClock(TestClock)
    case reader(TerminalReader)
    case verificationSession(VerificationSession)
    
    public init(from decoder: Decoder) throws {
        let object = try decoder
            .container(keyedBy: CodingKeys.self)
            .decode(String.self, forKey: .object)
        switch object {
        case "account":
            self = try .account(ConnectAccount(from: decoder))
        case "application":
            self = try .application(ConnectApplication(from: decoder))
        case "application_fee":
            self = try .applicationFee(ApplicationFee(from: decoder))
        case "card":
            self = try .card(Card(from: decoder))
        case "cash_balance":
            self = try .cashBalance(CashBalance(from: decoder))
        case "bank_account":
            self = try .bankAccount(BankAccount(from: decoder))
        case "billing_portal.configuration":
            self = try .configuration(PortalConfiguration(from: decoder))
        case "fee_refund":
            self = try .applicationFeeRefund(ApplicationFeeRefund(from: decoder))
        case "balance":
            self = try .balance(Balance(from: decoder))
        case "capability":
            self = try .capability(Capability(from: decoder))
        case "charge":
            self = try .charge(Charge(from: decoder))
        case "dispute":
            self = try .dispute(Dispute(from: decoder))
        case "refund":
            self = try .refund(Refund(from: decoder))
        case "checkout.session":
            self = try .checkoutSession(Session(from: decoder))
        case "coupon":
            self = try .coupon(Coupon(from: decoder))
        case "credit_note":
            self = try .creditNote(CreditNote(from: decoder))
        case "customer":
            self = try .customer(Customer(from: decoder))
        case "discount":
            self = try .discount(Discount(from: decoder))
        case "subscription":
            self = try .subscription(Subscription(from: decoder))
        case "tax_id":
            self = try .taxId(TaxID(from: decoder))
        case "file":
            self = try .file(File(from: decoder))
        case "identity.verification_session":
            self = try .verificationSession(VerificationSession(from: decoder))
        case "invoice":
            self = try .invoice(Invoice(from: decoder))
        case "invoiceitem":
            self = try .invoiceItem(InvoiceItem(from: decoder))
        case "issuing.authorization":
            self = try .issuingAuthorization(Authorization(from: decoder))
        case "issuing.card":
            self = try .issuingCard(IssuingCard(from: decoder))
        case "issuing.cardholder":
            self = try .issuingCardHolder(Cardholder(from: decoder))
        case "issuing.dispute":
            self = try .issuingDispute(IssuingDispute(from: decoder))
        case "issuing.transaction":
            self = try .issuingTransaction(Transaction(from: decoder))
        case "mandate":
            self = try .mandate(Mandate(from: decoder))
        case "payment_intent":
            self = try .paymentIntent(PaymentIntent(from: decoder))
        case "payment_link":
            self = try .paymentLink(PaymentLink(from: decoder))
        case "payment_method":
            self = try .paymentMethod(PaymentMethod(from: decoder))
        case "payout":
            self = try .payout(Payout(from: decoder))
        case "person":
            self = try .person(Person(from: decoder))
        case "plan":
            self = try .plan(Plan(from: decoder))
        case "price":
            self = try .price(Price(from: decoder))
        case "product":
            self = try .product(Product(from: decoder))
        case "promotion_code":
            self = try .promotionCode(PromotionCode(from: decoder))
        case "radar.early_fraud_warning":
            self = try .earlyFraudWarniing(EarlyFraudWarning(from: decoder))
        case "quote":
            self = try .quote(Quote(from: decoder))
        case "reporting.report_run":
            self = try .reportRun(ReportRun(from: decoder))
        case "reporting.report_type":
            self = try .reportType(ReportType(from: decoder))
        case "review":
            self = try .review(Review(from: decoder))
        case "setup_intent":
            self = try .setupIntent(SetupIntent(from: decoder))
        case "scheduled_query_run":
            self = try .scheduledQueryRun(ScheduledQueryRun(from: decoder))
        case "subscription_schedule":
            self = try .subscriptionSchedule(SubscriptionSchedule(from: decoder))
        case "tax_rate":
            self = try .taxRate(TaxRate(from: decoder))
        case "test_helpers.test_clock":
            self = try .testClock(TestClock(from: decoder))
        case "terminal.reader":
            self = try .reader(TerminalReader(from: decoder))
        case "topup":
            self = try .topup(TopUp(from: decoder))
        case "transfer":
            self = try .transfer(Transfer(from: decoder))
        default:
            throw DecodingError.keyNotFound(CodingKeys.object,
                                            DecodingError.Context(codingPath: [CodingKeys.object],
                                                                  debugDescription: "Missing type '\(object)' cannot be decoded."))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .account(let connectAccount):
            try connectAccount.encode(to: encoder)
        case .application(let connectApplication):
            try connectApplication.encode(to: encoder)
        case .card(let card):
            try card.encode(to: encoder)
        case .cashBalance(let cashBalance):
            try cashBalance.encode(to: encoder)
        case .bankAccount(let bankAccount):
            try bankAccount.encode(to: encoder)
        case .applicationFee(let applicationFee):
            try applicationFee.encode(to: encoder)
        case .applicationFeeRefund(let applicationFeeRefund):
            try applicationFeeRefund.encode(to: encoder)
        case .balance(let balance):
            try balance.encode(to: encoder)
        case .capability(let capability):
            try capability.encode(to: encoder)
        case .charge(let charge):
            try charge.encode(to: encoder)
        case .dispute(let dispute):
            try dispute.encode(to: encoder)
        case .refund(let refund):
            try refund.encode(to: encoder)
        case .checkoutSession(let session):
            try session.encode(to: encoder)
        case .configuration(let portalConfiguration):
            try portalConfiguration.encode(to: encoder)
        case .coupon(let coupon):
            try coupon.encode(to: encoder)
        case .creditNote(let creditNote):
            try creditNote.encode(to: encoder)
        case .customer(let customer):
            try customer.encode(to: encoder)
        case .discount(let discount):
            try discount.encode(to: encoder)
        case .subscription(let subscription):
            try subscription.encode(to: encoder)
        case .taxId(let taxID):
            try taxID.encode(to: encoder)
        case .file(let file):
            try file.encode(to: encoder)
        case .invoice(let invoice):
            try invoice.encode(to: encoder)
        case .invoiceItem(let invoiceItem):
            try invoiceItem.encode(to: encoder)
        case .issuingAuthorization(let authorization):
            try authorization.encode(to: encoder)
        case .issuingCard(let issuingCard):
            try issuingCard.encode(to: encoder)
        case .issuingCardHolder(let cardholder):
            try cardholder.encode(to: encoder)
        case .issuingDispute(let issuingDispute):
            try issuingDispute.encode(to: encoder)
        case .issuingTransaction(let transaction):
            try transaction.encode(to: encoder)
        case .mandate(let mandate):
            try mandate.encode(to: encoder)
        case .paymentIntent(let paymentIntent):
            try paymentIntent.encode(to: encoder)
        case .paymentLink(let paymentLink):
            try paymentLink.encode(to: encoder)
        case .paymentMethod(let paymentMethod):
            try paymentMethod.encode(to: encoder)
        case .payout(let payout):
            try payout.encode(to: encoder)
        case .person(let person):
            try person.encode(to: encoder)
        case .plan(let plan):
            try plan.encode(to: encoder)
        case .price(let price):
            try price.encode(to: encoder)
        case .product(let product):
            try product.encode(to: encoder)
        case .promotionCode(let promotionCode):
            try promotionCode.encode(to: encoder)
        case .earlyFraudWarniing(let earlyFraudWarning):
            try earlyFraudWarning.encode(to: encoder)
        case .quote(let quote):
            try quote.encode(to: encoder)
        case .reportRun(let reportRun):
            try reportRun.encode(to: encoder)
        case .reportType(let reportType):
            try reportType.encode(to: encoder)
        case .review(let review):
            try review.encode(to: encoder)
        case .setupIntent(let setupIntent):
            try setupIntent.encode(to: encoder)
        case .scheduledQueryRun(let scheduledQueryRun):
            try scheduledQueryRun.encode(to: encoder)
        case .subscriptionSchedule(let subscriptionSchedule):
            try subscriptionSchedule.encode(to: encoder)
        case .taxRate(let taxRate):
            try taxRate.encode(to: encoder)
        case .topup(let topUp):
            try topUp.encode(to: encoder)
        case .transfer(let transfer):
            try transfer.encode(to: encoder)
        case .testClock(let testClock):
            try testClock.encode(to: encoder)
        case .reader(let terminalReader):
            try terminalReader.encode(to: encoder)
        case .verificationSession(let verificationSession):
            try verificationSession.encode(to: encoder)
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case object
    }
}

public struct EventRequest: Codable {
    /// ID of the API request that caused the event. If null, the event was automatic (e.g., Stripe’s automatic subscription handling). Request logs are available in the dashboard, but currently not in the API.
    public var id: String?
    /// The idempotency key transmitted during the request, if any. Note: This property is populated only for events on or after May 23, 2017.
    public var idempotencyKey: String?
    
    public init(id: String? = nil,
                idempotencyKey: String? = nil) {
        self.id = id
        self.idempotencyKey = idempotencyKey
    }
}

public enum EventType: String, Codable {
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
    /// Occurs whenever an account status or property has changed.
    case accountUpdated = "account.updated"
    /// Occurs whenever an application fee is created on a charge.
    case applicationFeeCreated = "application_fee.created"
    /// Occurs whenever an application fee refund is updated.
    case applicationFeeRefundUpdated = "application_fee.refund.updated"
    /// Occurs whenever an application fee is refunded, whether from refunding a charge or from refunding the application fee directly. This includes partial refunds.
    case applicationFeeRefunded = "application_fee.refunded"
    /// Occurs whenever your Stripe balance has been updated (e.g., when a charge is available to be paid out). By default, Stripe automatically transfers funds in your balance to your bank account on a daily basis.
    case balanceAvailable = "balance.available"
    /// Occurs whenever a portal configuration is created.
    case billingPortalConfigurationCreated = "billing_portal.configuration.created"
    /// Occurs whenever a portal configuration is updated.
    case billingPortalConfigurationUpdated = "billing_portal.configuration.updated"
    /// Occurs whenever a portal session is created.
    case billingPortalSessionCreated = "billing_portal.session.created"
    /// Occurs whenever a capability has new requirements or a new status.
    case capabilityUpdated = "capability.updated"
    /// Occurs whenever a capability has new requirements or a new status.
    case cashBalanceFundsAvailable = "cash_balance.funds_available"
    /// Occurs whenever a previously uncaptured charge is captured.
    case chargeCaptured = "charge.captured"
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
    /// Occurs whenever an uncaptured charge expires.
    case chargeExpired = "charge.expired"
    /// Occurs whenever a failed charge attempt occurs.
    case chargeFailed = "charge.failed"
    /// Occurs whenever a pending charge is created.
    case chargePending = "charge.pending"
    /// Occurs whenever a refund is updated, on selected payment methods.
    case chargeRefundUpdated = "charge.refund.updated"
    /// Occurs whenever a charge is refunded, including partial refunds.
    case chargeRefunded = "charge.refunded"
    /// Occurs whenever a new charge is created and is successful.
    case chargeSucceeded = "charge.succeeded"
    /// Occurs whenever a charge description or metadata is updated.
    case chargeUpdated = "charge.updated"
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
    /// Occurs whenever a new customer cash balance transactions is created.
    case customerCashBalanceTransactionCreated = "customer_cash_balance_transaction.created"
    /// Occurs whenever a new customer is created.
    case customerCreated = "customer.created"
    /// Occurs whenever a customer is deleted.
    case customerDeleted = "customer.deleted"
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
    /// Occurs whenever a customer’s subscription is paused. Only applies when subscriptions enter `status=paused`, not when payment collection is paused.
    case customerSubscriptionPaused = "customer.subscription.paused"
    /// Occurs whenever a customer's subscription's pending update is applied, and the subscription is updated.
    case customerSubscriptionPendingUpdateApplied = "customer.subscription.pending_update_applied"
    /// Occurs whenever a customer's subscription's pending update expires before the related invoice is paid.
    case customerSubscriptionPendingUpdateExpired = "customer.subscription.pending_update_expired"
    /// Occurs whenever a customer’s subscription is no longer paused. Only applies when a `status=paused` subscription is resumed, not when payment collection is resumed.
    case customerSubscriptionResumed = "customer.subscription.resumed"
    /// Occurs three days before a subscription's trial period is scheduled to end, or when a trial is ended immediately (using `trial_end=now`).
    case customerSubscriptionTrialWillEnd = "customer.subscription.trial_will_end"
    /// Occurs whenever a subscription changes (e.g., switching from one plan to another, or changing the status from trial to active).
    case customerSubscriptionUpdated = "customer.subscription.updated"
    /// Occurs whenever a tax ID is created for a customer.
    case customerTaxIdCreated = "customer.tax_id.created"
    /// Occurs whenever a tax ID is deleted from a customer.
    case customerTaxIdDeleted = "customer.tax_id.deleted"
    /// Occurs whenever a customer's tax ID is updated.
    case customerTaxIdUpdated = "customer.tax_id.updated"
    /// Occurs whenever any property of a customer changes.
    case customerUpdated = "customer.updated"
    /// Occurs whenever a new Stripe-generated file is available for your account.
    case fileCreated = "file.created"
    /// Occurs when a new Financial Connections account is created.
    case financialConnectionsAccountCreated = "financial_connections.account.created"
    /// Occurs when a Financial Connections account’s status is updated from `active` to `inactive`.
    case financialConnectionsAccountDeactivated = "financial_connections.account.deactivated"
    /// Occurs when a Financial Connections account is disconnected.
    case financialConnectionsAccountDisconnected = "financial_connections.account.disconnected"
    /// Occurs when a Financial Connections account’s status is updated from `inactive` to `active`.
    case financialConnectionsAccountReactivated = "financial_connections.account.reactivated"
    /// Occurs when an Account’s `balance_refresh` status transitions from `pending` to either `succeeded` or `failed`.
    case financialConnectionsAccountRefreshedBalance = "financial_connections.account.refreshed_balance"
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
    /// Occurs whenever an invoice payment attempt succeeds or an invoice is marked as paid out-of-band.
    case invoicePaid = "invoice.paid"
    /// Occurs whenever an invoice payment attempt requires further user action to complete.
    case invoicePaymentActionRequired = "invoice.payment_action_required"
    /// Occurs whenever an invoice payment attempt fails, due either to a declined payment or to the lack of a stored payment method.
    case invoicePaymentFailed = "invoice.payment_failed"
    /// Occurs whenever an invoice payment attempt succeeds.
    case invoicePaymentSucceeded = "invoice.payment_succeeded"
    /// Occurs whenever an invoice email is sent out.
    case invoiceSent = "invoice.sent"
    /// Occurs X number of days before a subscription is scheduled to create an invoice that is automatically charged—where X is determined by your subscriptions settings. Note: The received `Invoice` object will not have an invoice ID.
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
    /// Represents a synchronous request for authorization, see Using your integration to handle authorization requests. You must create a webhook endpoint which explicitly subscribes to this event type to access it. Webhook endpoints which subscribe to all events will not include this event type.
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
    /// Occurs when a PaymentIntent has funds to be captured. Check the `amount_capturable` property on the PaymentIntent to determine the amount that can be captured. You may capture the PaymentIntent with an `amount_to_capture` value up to the specified amount. Learn more about capturing PaymentIntents.
    case paymentIntentAmountCapturableUpdated = "payment_intent.amount_capturable_updated"
    /// Occurs when a PaymentIntent is canceled.
    case paymentIntentCanceled = "payment_intent.canceled"
    /// Occurs when a new PaymentIntent is created.
    case paymentIntentCreated = "payment_intent.created"
    /// Occurs when funds are applied to a `customer_balance` PaymentIntent and the `‘amount_remaining’` changes.
    case paymentIntentPartiallyFunded = "payment_intent.partially_funded"
    /// Occurs when a PaymentIntent has failed the attempt to create a source or a payment.
    case paymentIntentPaymentFailed = "payment_intent.payment_failed"
    /// Occurs when a PaymentIntent has started processing.
    case paymentIntentProcessing = "payment_intent.processing"
    /// Occurs when a PaymentIntent transitions to `requires_action` state
    case paymentIntentRequiresAction = "payment_intent.requires_action"
    /// Occurs when a PaymentIntent has been successfully fulfilled.
    case paymentIntentSucceeded = "payment_intent.succeeded"
    /// Occurs when a payment link is created.
    case paymentLinkCreated = "payment_link.created"
    /// Occurs when a payment link is updated.
    case paymentLinkUpdated = "payment_link.updated"
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
    /// Occurs whenever balance transactions paid out in an automatic payout can be queried.
    case payoutReconciliationCompleted = "payout.reconciliation_completed"
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
    /// Occurs whenever a refund from a customer’s cash balance is created.
    case refundCreated = "refund.created"
    /// Occurs whenever a refund from a customer’s cash balance is updated.
    case refundUpdated = "refund.updated"
    /// Occurs whenever a requested `ReportRun` failed to complete.
    case reportingReportRunFailed = "reporting.report_run.failed"
    /// Occurs whenever a requested `ReportRun` completed succesfully.
    case reportingReportRunSucceeded = "reporting.report_run.succeeded"
    /// Occurs whenever a `ReportType` is updated (typically to indicate that a new day's data has come available). You must create a webhook endpoint which explicitly subscribes to this event type to access it. Webhook endpoints which subscribe to all events will not include this event type.
    case reportingReportTypeUpdated = "reporting.report_type.updated"
    /// Occurs whenever a review is closed. The review's reason field indicates why: `approved`, `disputed`, `refunded`, or `refunded_as_fraud`.
    case reviewClosed = "review.closed"
    /// Occurs whenever a review is opened.
    case reviewOpened = "review.opened"
    /// Occurs when a SetupIntent is canceled.
    case setupIntentCanceled = "setup_intent.canceled"
    /// Occurs when a new SetupIntent is created.
    case setupIntentCreated = "setup_intent.created"
    /// Occurs when a SetupIntent is in `requires_action` state.
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
    /// Occurs whenever an action sent to a Terminal reader failed.
    case terminalReaderActionFailed = "terminal.reader.action_failed"
    /// Occurs whenever an action sent to a Terminal reader was successful.
    case terminalReaderActionSucceeded = "terminal.reader.action_succeeded"
    /// Occurs whenever a test clock starts advancing.
    case testHelpersTestClockAdvancing = "test_helpers.test_clock.advancing"
    /// Occurs whenever a test clock is created.
    case testHelpersTestClockCreated = "test_helpers.test_clock.created"
    /// Occurs whenever a test clock is deleted.
    case testHelpersTestClockDeleted = "test_helpers.test_clock.deleted"
    /// Occurs whenever a test clock fails to advance its frozen time.
    case testHelpersTestClockInternalFailure = "test_helpers.test_clock.internal_failure"
    /// Occurs whenever a test clock transitions to a ready status.
    case testHelpersTestClockReady = "test_helpers.test_clock.ready"
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
    /// Occurs whenever a transfer is reversed, including partial reversals.
    case transferReversed = "transfer.reversed"
    /// Occurs whenever a transfer's description or metadata is updated.
    case transferUpdated = "transfer.updated"
    /// An event not supported by the event type
    case unknownEvent = "unknown"
}

public struct EventList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [Event]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [Event]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
