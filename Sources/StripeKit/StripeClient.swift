//
//  StripeClient.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/30/19.
//

import NIO
import AsyncHTTPClient

public final class StripeClient {
    // MARK: - CORE RESOURCES
    public var balances: BalanceRoutes
    public var balanceTransactions: BalanceTransactionRoutes
    public var charges: ChargeRoutes
    public var customers: CustomerRoutes
    public var disputes: DisputeRoutes
    public var events: EventRoutes
    public var files: FileRoutes
    public var fileLinks: FileLinkRoutes
    public var mandates: MandateRoutes
    public var paymentIntents: PaymentIntentsRoutes
    public var setupIntents: SetupIntentsRoutes
    public var setupAttempts: SetupAttemptRoutes
    public var payouts: PayoutRoutes
    public var products: ProductRoutes
    public var prices: PriceRoutes
    public var refunds: RefundRoutes
    public var tokens: TokenRoutes
    
    // MARK: - PAYMENT METHODS
    public var paymentMethods: PaymentMethodRoutes
    public var bankAccounts: BankAccountRoutes
    public var cards: CardRoutes
    public var sources: SourceRoutes
    
    // MARK: - CHECKOUT
    public var sessions: SessionRoutes
    
    // MARK: - BILLING
    public var coupons: CouponRoutes
    public var creditNotes: CreditNoteRoutes
    public var customerBalanceTransactions: CustomerBalanceTransactionRoutes
    public var portalSession: PortalSessionRoutes
    public var portalConfiguration: PortalConfigurationRoutes
    public var customerTaxIds: CustomerTaxIDRoutes
    public var discounts: DiscountRoutes
    public var invoices: InvoiceRoutes
    public var invoiceItems: InvoiceItemRoutes
    public var plans: PlanRoutes
    public var promotionCodes: PromotionCodesRoutes
    public var subscriptions: SubscriptionRoutes
    public var subscriptionItems: SubscriptionItemRoutes
    public var subscriptionSchedules: SubscriptionScheduleRoutes
    public var taxRates: TaxRateRoutes
    public var usageRecords: UsageRecordRoutes
    public var quoteLineItems: QuoteLineItemRoutes
    public var quotes: QuoteRoutes
    
    // MARK: - CONNECT
    public var connectAccounts: AccountRoutes
    public var accountLinks: AccountLinkRoutes
    public var applicationFees: ApplicationFeesRoutes
    public var applicationFeeRefunds: ApplicationFeeRefundRoutes
    public var capabilities: CapabilitiesRoutes
    public var countrySpecs: CountrySpecRoutes
    public var externalAccounts: ExternalAccountsRoutes
    public var persons: PersonRoutes
    public var topups: TopUpRoutes
    public var transfers: TransferRoutes
    public var transferReversals: TransferReversalRoutes
    
    // MARK: - FRAUD
    public var earlyFraudWarnings: EarlyFraudWarningRoutes
    public var reviews: ReviewRoutes
    public var valueLists: ValueListRoutes
    public var valueListItems: ValueListItemRoutes
    
    // MARK: - ISSUING
    public var authorizations: AuthorizationRoutes
    public var cardholders: CardholderRoutes
    public var issuingCards: IssuingCardRoutes
    public var issuingDisputes: IssuingDisputeRoutes
    public var transactions: TransactionRoutes
    
    // MARK: - TERMINAL
    public var connectionTokens: ConnectionTokenRoutes
    public var locations: LocationRoutes
    public var readers: ReaderRoutes
    
    // MARK: - ORDERS
    public var orders: OrderRoutes
    public var orderReturns: OrderReturnRoutes
    public var skus: SKURoutes
    public var ephemeralKeys: EphemeralKeyRoutes
    
    // MARK: - SIGMA
    public var scheduledQueryRuns: ScheduledQueryRunRoutes

    // MARK: - REPORTING
    public var reportRuns: ReportRunRoutes
    public var reportTypes: ReportTypeRoutes
    
    // MARK: - IDENTITY
    public var verificationSessions: VerificationSessionRoutes
    public var verificationReports: VerificationReportRoutes
    
    // MARK: - WEBHOOKS
    public var webhookEndpoints: WebhookEndpointRoutes
    
    var handler: StripeDefaultAPIHandler
    
    /// Returns a StripeClient used to interact with the Stripe APIs.
    /// - Parameter httpClient: An `HTTPClient`used to communicate wiith the Stripe API
    /// - Parameter eventLoop: An `EventLoop` used to return an `EventLoopFuture` on.
    /// - Parameter apiKey: A Stripe API key.
    public init(httpClient: HTTPClient, eventLoop: EventLoop, apiKey: String) {
        handler = StripeDefaultAPIHandler(httpClient: httpClient, eventLoop: eventLoop, apiKey: apiKey)
        
        balances = StripeBalanceRoutes(apiHandler: handler)
        balanceTransactions = StripeBalanceTransactionRoutes(apiHandler: handler)
        charges = StripeChargeRoutes(apiHandler: handler)
        customers = StripeCustomerRoutes(apiHandler: handler)
        disputes = StripeDisputeRoutes(apiHandler: handler)
        events = StripeEventRoutes(apiHandler: handler)
        files = StripeFileRoutes(apiHandler: handler)
        fileLinks = StripeFileLinkRoutes(apiHandler: handler)
        mandates = StripeMandateRoutes(apiHandler: handler)
        paymentIntents = StripePaymentIntentsRoutes(apiHandler: handler)
        setupIntents = StripeSetupIntentsRoutes(apiHandler: handler)
        setupAttempts = StripeSetupAttemptRoutes(apiHandler: handler)
        payouts = StripePayoutRoutes(apiHandler: handler)
        products = StripeProductRoutes(apiHandler: handler)
        prices = StripePriceRoutes(apiHandler: handler)
        refunds = StripeRefundRoutes(apiHandler: handler)
        tokens = StripeTokenRoutes(apiHandler: handler)
        
        paymentMethods = StripePaymentMethodRoutes(apiHandler: handler)
        bankAccounts = StripeBankAccountRoutes(apiHandler: handler)
        cards = StripeCardRoutes(apiHandler: handler)
        sources = StripeSourceRoutes(apiHandler: handler)
        
        sessions = StripeSessionRoutes(apiHandler: handler)
        
        coupons = StripeCouponRoutes(apiHandler: handler)
        creditNotes = StripeCreditNoteRoutes(apiHandler: handler)
        customerBalanceTransactions = StripeCustomerBalanceTransactionRoutes(apiHandler: handler)
        portalSession = StripePortalSessionRoutes(apiHandler: handler)
        portalConfiguration = StripePortalConfigurationRoutes(apiHandler: handler)
        customerTaxIds = StripeCustomerTaxIDRoutes(apiHandler: handler)
        discounts = StripeDiscountRoutes(apiHandler: handler)
        invoices = StripeInvoiceRoutes(apiHandler: handler)
        invoiceItems = StripeInvoiceItemRoutes(apiHandler: handler)
        plans = StripePlanRoutes(apiHandler: handler)
        promotionCodes = StripePromotionCodesRoutes(apiHandler: handler)
        subscriptions = StripeSubscriptionRoutes(apiHandler: handler)
        subscriptionItems = StripeSubscriptionItemRoutes(apiHandler: handler)
        subscriptionSchedules = StripeSubscriptionScheduleRoutes(apiHandler: handler)
        taxRates = StripeTaxRateRoutes(apiHandler: handler)
        usageRecords = StripeUsageRecordRoutes(apiHandler: handler)
        quoteLineItems = StripeQuoteLineItemRoutes(apiHandler: handler)
        quotes = StripeQuoteRoutes(apiHandler: handler)
        
        connectAccounts = StripeConnectAccountRoutes(apiHandler: handler)
        accountLinks = StripeAccountLinkRoutes(apiHandler: handler)
        applicationFees = StripeApplicationFeeRoutes(apiHandler: handler)
        applicationFeeRefunds = StripeApplicationFeeRefundRoutes(apiHandler: handler)
        capabilities = StripeCapabilitiesRoutes(apiHandler: handler)
        countrySpecs = StripeCountrySpecRoutes(apiHandler: handler)
        externalAccounts = StripeExternalAccountsRoutes(apiHandler: handler)
        persons = StripePersonRoutes(apiHandler: handler)
        topups = StripeTopUpRoutes(apiHandler: handler)
        transfers = StripeTransferRoutes(apiHandler: handler)
        transferReversals = StripeTransferReversalRoutes(apiHandler: handler)
        
        earlyFraudWarnings = StripeEarlyFraudWarningRoutes(apiHandler: handler)
        reviews = StripeReviewRoutes(apiHandler: handler)
        valueLists = StripeValueListRoutes(apiHandler: handler)
        valueListItems = StripeValueListItemRoutes(apiHandler: handler)
        
        authorizations = StripeAuthorizationRoutes(apiHandler: handler)
        cardholders = StripeCardholderRoutes(apiHandler: handler)
        issuingCards = StripeIssuingCardRoutes(apiHandler: handler)
        issuingDisputes = StripeIssuingDisputeRoutes(apiHandler: handler)
        transactions = StripeTransactionRoutes(apiHandler: handler)
        
        connectionTokens = StripeConnectionTokenRoutes(apiHandler: handler)
        locations = StripeLocationRoutes(apiHandler: handler)
        readers = StripeReaderRoutes(apiHandler: handler)
        
        orders = StripeOrderRoutes(apiHandler: handler)
        orderReturns = StripeOrderReturnRoutes(apiHandler: handler)
        skus = StripeSKURoutes(apiHandler: handler)
        ephemeralKeys = StripeEphemeralKeyRoutes(apiHandler: handler)
        
        scheduledQueryRuns = StripeScheduledQueryRunRoutes(apiHandler: handler)
        
        reportRuns = StripeReportRunRoutes(apiHandler: handler)
        reportTypes = StripeReportTypeRoutes(apiHandler: handler)
        
        verificationSessions = StripeVerificationSessionRoutes(apiHandler: handler)
        verificationReports = StripeVerificationReportRoutes(apiHandler: handler)
        
        webhookEndpoints = StripeWebhookEndpointRoutes(apiHandler: handler)
    }
    
    /// Hop to a new eventloop to execute requests on.
    /// - Parameter eventLoop: The eventloop to execute requests on.
    public func hopped(to eventLoop: EventLoop) -> StripeClient {
        handler.eventLoop = eventLoop
        return self
    }
}
