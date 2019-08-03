//
//  StripeClient.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/30/19.
//

import NIO
import AsyncHTTPClient

public final class StripeClient {
    public var balances: BalanceRoutes
    public var charges: ChargeRoutes
    public var connectAccounts: AccountRoutes
    public var coupons: CouponRoutes
    public var customers: CustomerRoutes
    public var disputes: DisputeRoutes
    public var ephemeralKeys: EphemeralKeyRoutes
    public var invoiceItems: InvoiceItemRoutes
    public var invoices: InvoiceRoutes
    public var orderReturns: OrderReturnRoutes
    public var orders: OrderRoutes
    public var plans: PlanRoutes
    public var products: ProductRoutes
    public var refunds: RefundRoutes
    public var skus: SKURoutes
    public var sources: SourceRoutes
    public var subscriptionItems: SubscriptionItemRoutes
    public var subscriptions: SubscriptionRoutes
    public var tokens: TokenRoutes
    public var transfers: TransferRoutes
    public var transferReversals: TransferReversalRoutes
    public var payouts: PayoutRoutes
    public var fileLinks: FileLinkRoutes
    public var files: FileRoutes
    public var persons: PersonRoutes
    public var applicationFees: ApplicationFeesRoutes
    public var applicationFeeRefunds: ApplicationFeeRefundRoutes
    public var externalAccounts: ExternalAccountsRoutes
    public var countrySpecs: CountrySpecRoutes
    public var topups: TopUpRoutes
    public var valueListItems: ValueListItemRoutes
    public var valueList: ValueListRoutes
    public var paymentMethods: PaymentMethodRoutes
    public var bankAccounts: BankAccountRoutes
    public var cards: CardRoutes
    public var sessions: SessionRoutes
    public var discounts: DiscountRoutes
    public var taxids: TaxIDRoutes
    public var taxRates: TaxRateRoutes
    public var creditNotes: CreditNoteRoutes
    public var usageRecords: UsageRecordRoutes
    public var reviews: ReviewRoutes
    public var authorizations: AuthorizationRoutes
    public var cardholders: CardholderRoutes
    public var issuingCards: IssuingCardRoutes
    public var issuingDisputes: IssuingDisputeRoutes
    public var transactions: TransactionRoutes
    public var connectionTokens: ConnectionTokenRoutes
    public var locations: LocationRoutes
    public var readers: ReaderRoutes
    public var scheduledQueryRuns: ScheduledQueryRunRoutes
    
    public init(eventLoop: EventLoopGroup, apiKey: String) {
        let client = HTTPClient(eventLoopGroupProvider: .shared(eventLoop))
        let handler = StripeDefaultAPIHandler(httpClient: client, apiKey: apiKey)
        
        balances = StripeBalanceRoutes(apiHandler: handler)
        charges = StripeChargeRoutes(apiHandler: handler)
        connectAccounts = StripeConnectAccountRoutes(apiHandler: handler)
        coupons = StripeCouponRoutes(apiHandler: handler)
        customers = StripeCustomerRoutes(apiHandler: handler)
        disputes = StripeDisputeRoutes(apiHandler: handler)
        ephemeralKeys = StripeEphemeralKeyRoutes(apiHandler: handler)
        invoiceItems = StripeInvoiceItemRoutes(apiHandler: handler)
        invoices = StripeInvoiceRoutes(apiHandler: handler)
        orderReturns = StripeOrderReturnRoutes(apiHandler: handler)
        orders = StripeOrderRoutes(apiHandler: handler)
        plans = StripePlanRoutes(apiHandler: handler)
        products = StripeProductRoutes(apiHandler: handler)
        refunds = StripeRefundRoutes(apiHandler: handler)
        skus = StripeSKURoutes(apiHandler: handler)
        sources = StripeSourceRoutes(apiHandler: handler)
        subscriptionItems = StripeSubscriptionItemRoutes(apiHandler: handler)
        subscriptions = StripeSubscriptionRoutes(apiHandler: handler)
        tokens = StripeTokenRoutes(apiHandler: handler)
        transfers = StripeTransferRoutes(apiHandler: handler)
        transferReversals = StripeTransferReversalRoutes(apiHandler: handler)
        payouts = StripePayoutRoutes(apiHandler: handler)
        fileLinks = StripeFileLinkRoutes(apiHandler: handler)
        files = StripeFileRoutes(apiHandler: handler)
        persons = StripePersonRoutes(apiHandler: handler)
        applicationFees = StripeApplicationFeeRoutes(apiHandler: handler)
        applicationFeeRefunds = StripeApplicationFeeRefundRoutes(apiHandler: handler)
        externalAccounts = StripeExternalAccountsRoutes(apiHandler: handler)
        countrySpecs = StripeCountrySpecRoutes(apiHandler: handler)
        topups = StripeTopUpRoutes(apiHandler: handler)
        valueListItems = StripeValueListItemRoutes(apiHandler: handler)
        valueList = StripeValueListRoutes(apiHandler: handler)
        paymentMethods = StripePaymentMethodRoutes(apiHandler: handler)
        bankAccounts = StripeBankAccountRoutes(apiHandler: handler)
        cards = StripeCardRoutes(apiHandler: handler)
        sessions = StripeSessionRoutes(apiHandler: handler)
        discounts = StripeDiscountRoutes(apiHandler: handler)
        taxids = StripeTaxIDRoutes(apiHandler: handler)
        taxRates = StripeTaxRateRoutes(apiHandler: handler)
        creditNotes = StripeCreditNoteRoutes(apiHandler: handler)
        usageRecords = StripeUsageRecordRoutes(apiHandler: handler)
        reviews = StripeReviewRoutes(apiHandler: handler)
        authorizations = StripeAuthorizationRoutes(apiHandler: handler)
        cardholders = StripeCardholderRoutes(apiHandler: handler)
        issuingCards = StripeIssuingCardRoutes(apiHandler: handler)
        issuingDisputes = StripeIssuingDisputeRoutes(apiHandler: handler)
        transactions = StripeTransactionRoutes(apiHandler: handler)
        connectionTokens = StripeConnectionTokenRoutes(apiHandler: handler)
        locations = StripeLocationRoutes(apiHandler: handler)
        readers = StripeReaderRoutes(apiHandler: handler)
        scheduledQueryRuns = StripeScheduledQueryRunRoutes(apiHandler: handler)
    }
}
