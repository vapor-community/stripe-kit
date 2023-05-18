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
    public var paymentIntents: PaymentIntentRoutes
    public var setupIntents: SetupIntentsRoutes
    public var setupAttempts: SetupAttemptRoutes
    public var payouts: PayoutRoutes
    public var refunds: RefundRoutes
    public var tokens: TokenRoutes
    
    // MARK: - PAYMENT METHODS
    public var paymentMethods: PaymentMethodRoutes
    public var bankAccounts: BankAccountRoutes
    public var cashBalances: CashBalanceRoutes
    public var cards: CardRoutes
    public var sources: SourceRoutes
    
    // MARK: - CHECKOUT
    public var sessions: SessionRoutes
    
    // MARK: - PaymentLink
    public var paymentLinks: PaymentLinkRoutes
    
    // MARK: - Products
    public var products: ProductRoutes
    public var prices: PriceRoutes
    public var coupons: CouponRoutes
    public var promotionCodes: PromotionCodesRoutes
    public var discounts: DiscountRoutes
    public var taxCodes: TaxCodeRoutes
    public var taxRates: TaxRateRoutes
    public var shippingRates: ShippingRateRoutes
    
    // MARK: - BILLING
    public var creditNotes: CreditNoteRoutes
    public var customerBalanceTransactions: CustomerBalanceTransactionRoutes
    public var portalSession: PortalSessionRoutes
    public var portalConfiguration: PortalConfigurationRoutes
    public var customerTaxIds: CustomerTaxIDRoutes
    public var invoices: InvoiceRoutes
    public var invoiceItems: InvoiceItemRoutes
    public var plans: PlanRoutes
    public var subscriptions: SubscriptionRoutes
    public var subscriptionItems: SubscriptionItemRoutes
    public var subscriptionSchedules: SubscriptionScheduleRoutes
    public var usageRecords: UsageRecordRoutes
    public var quoteLineItems: QuoteLineItemRoutes
    public var quotes: QuoteRoutes
    public var testClocks: TestClockRoutes
    
    // MARK: - CONNECT
    public var connectAccounts: AccountRoutes
    public var accountSessions: AccountSessionRoutes
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
    public var fundingInstructions: FundingInstructionsRoutes
    public var transactions: TransactionRoutes
    
    // MARK: - TERMINAL
    public var terminalConnectionTokens: TerminalConnectionTokenRoutes
    public var terminalLocations: TerminalLocationRoutes
    public var terminalReaders: TerminalReaderRoutes
    public var terminalHardwareOrders: TerminalHardwareOrderRoutes
    public var terminalHardwareProducts: TerminalHardwareProductRoutes
    public var terminalHardwareSkus: TerminalHardwareSKURoutes
    public var terminalHardwareShippingMethods: TerminalHardwareShippingMethodRoutes
    public var terminalConfiguration: TerminalConfigurationRoutes
    
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
    
    var handler: StripeAPIHandler
    
    /// Returns a StripeClient used to interact with the Stripe APIs.
    /// - Parameter httpClient: An `HTTPClient`used to communicate wiith the Stripe API
    /// - Parameter eventLoop: An `EventLoop` used to return an `EventLoopFuture` on.
    /// - Parameter apiKey: A Stripe API key.
    public init(httpClient: HTTPClient, eventLoop: EventLoop, apiKey: String) {
        handler = StripeAPIHandler(httpClient: httpClient, eventLoop: eventLoop, apiKey: apiKey)
        
        balances = StripeBalanceRoutes(apiHandler: handler)
        balanceTransactions = StripeBalanceTransactionRoutes(apiHandler: handler)
        charges = StripeChargeRoutes(apiHandler: handler)
        customers = StripeCustomerRoutes(apiHandler: handler)
        disputes = StripeDisputeRoutes(apiHandler: handler)
        events = StripeEventRoutes(apiHandler: handler)
        files = StripeFileRoutes(apiHandler: handler)
        fileLinks = StripeFileLinkRoutes(apiHandler: handler)
        mandates = StripeMandateRoutes(apiHandler: handler)
        paymentIntents = StripePaymentIntentRoutes(apiHandler: handler)
        setupIntents = StripeSetupIntentsRoutes(apiHandler: handler)
        setupAttempts = StripeSetupAttemptRoutes(apiHandler: handler)
        payouts = StripePayoutRoutes(apiHandler: handler)
        refunds = StripeRefundRoutes(apiHandler: handler)
        tokens = StripeTokenRoutes(apiHandler: handler)
        
        paymentMethods = StripePaymentMethodRoutes(apiHandler: handler)
        bankAccounts = StripeBankAccountRoutes(apiHandler: handler)
        cashBalances = StripeCashBalanceRoutes(apiHandler: handler)
        cards = StripeCardRoutes(apiHandler: handler)
        sources = StripeSourceRoutes(apiHandler: handler)
        
        sessions = StripeSessionRoutes(apiHandler: handler)
        
        paymentLinks = StripePaymentLinkRoutes(apiHandler: handler)
        
        products = StripeProductRoutes(apiHandler: handler)
        prices = StripePriceRoutes(apiHandler: handler)
        coupons = StripeCouponRoutes(apiHandler: handler)
        promotionCodes = StripePromotionCodesRoutes(apiHandler: handler)
        discounts = StripeDiscountRoutes(apiHandler: handler)
        taxCodes = StripeTaxCodeRoutes(apiHandler: handler)
        taxRates = StripeTaxRateRoutes(apiHandler: handler)
        shippingRates = StripeShippingRateRoutes(apiHandler: handler)
        
        creditNotes = StripeCreditNoteRoutes(apiHandler: handler)
        customerBalanceTransactions = StripeCustomerBalanceTransactionRoutes(apiHandler: handler)
        portalSession = StripePortalSessionRoutes(apiHandler: handler)
        portalConfiguration = StripePortalConfigurationRoutes(apiHandler: handler)
        customerTaxIds = StripeCustomerTaxIDRoutes(apiHandler: handler)
        invoices = StripeInvoiceRoutes(apiHandler: handler)
        invoiceItems = StripeInvoiceItemRoutes(apiHandler: handler)
        plans = StripePlanRoutes(apiHandler: handler)
        subscriptions = StripeSubscriptionRoutes(apiHandler: handler)
        subscriptionItems = StripeSubscriptionItemRoutes(apiHandler: handler)
        subscriptionSchedules = StripeSubscriptionScheduleRoutes(apiHandler: handler)
        usageRecords = StripeUsageRecordRoutes(apiHandler: handler)
        quoteLineItems = StripeQuoteLineItemRoutes(apiHandler: handler)
        quotes = StripeQuoteRoutes(apiHandler: handler)
        testClocks = StripeTestClockRoutes(apiHandler: handler)
        
        connectAccounts = StripeConnectAccountRoutes(apiHandler: handler)
        accountSessions =  StripeAccountSessionsRoutes(apiHandler: handler)
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
        fundingInstructions = StripeFundingInstructionsRoutes(apiHandler: handler)
        transactions = StripeTransactionRoutes(apiHandler: handler)
        
        terminalConnectionTokens = StripeTerminalConnectionTokenRoutes(apiHandler: handler)
        terminalLocations = StripeTerminalLocationRoutes(apiHandler: handler)
        terminalReaders = StripeTerminalReaderRoutes(apiHandler: handler)
        terminalHardwareOrders = StripeTerminalHardwareOrderRoutes(apiHandler: handler)
        terminalHardwareProducts = StripeTerminalHardwareProductRoutes(apiHandler: handler)
        terminalHardwareSkus = StripeTerminalHardwareSKURoutes(apiHandler: handler)
        terminalHardwareShippingMethods = StripeTerminalHardwareShippingMethodRoutes(apiHandler: handler)
        terminalConfiguration = StripeTerminalConfigurationRoutes(apiHandler: handler)
        
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
}
