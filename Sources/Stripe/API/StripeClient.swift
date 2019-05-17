//
//  StripeClient.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/30/19.
//

import NIO
import NIOHTTPClient

public final class StripeClient {
    public var balance: BalanceRoutes
    public var charge: ChargeRoutes
    public var connectAccounts: AccountRoutes
    public var coupons: CouponRoutes
    public var customer: CustomerRoutes
    public var dispute: DisputeRoutes
    //    public var ephemeralKey: EphemeralKeyRoutes
    public var invoiceItems: InvoiceItemRoutes
    public var invoices: InvoiceRoutes
    //    public var orderReturn: OrderReturnRoutes
    //    public var order: OrderRoutes
    public var plans: PlanRoutes
    public var product: ProductRoutes
    public var refund: RefundRoutes
    //    public var sku: SKURoutes
    public var source: SourceRoutes
    public var subscriptionItems: SubscriptionItemRoutes
    public var subscriptions: SubscriptionRoutes
    public var token: TokenRoutes
    public var transfers: TransferRoutes
    public var transferReversals: TransferReversalRoutes
    public var payouts: PayoutRoutes
    public var fileLinks: FileLinkRoutes
    public var files: FileRoutes
    public var person: PersonRoutes
    public var applicationFee: ApplicationFeesRoutes
    public var applicationFeeRefunds: ApplicationFeeRefundRoutes
    //    public var externalAccounts: ExternalAccountsRoutes
    public var countrySpecs: CountrySpecRoutes
    public var topup: TopUpRoutes
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
    
    init(eventLoop: EventLoopGroup, apiKey: String) {
        let client = HTTPClient(eventLoopGroupProvider: .shared(eventLoop))
        let handler = StripeAPIHandler(httpClient: client, apiKey: apiKey)
        
        balance = StripeBalanceRoutes(apiHandler: handler)
        charge = StripeChargeRoutes(apiHandler: handler)
        connectAccounts = StripeConnectAccountRoutes(apiHandler: handler)
        coupons = StripeCouponRoutes(apiHandler: handler)
        customer = StripeCustomerRoutes(apiHandler: handler)
        dispute = StripeDisputeRoutes(apiHandler: handler)
        //        ephemeralKey = StripeEphemeralKeyRoutes(request: apiRequest)
        invoiceItems = StripeInvoiceItemRoutes(apiHandler: handler)
        invoices = StripeInvoiceRoutes(apiHandler: handler)
        //        orderReturn = StripeOrderReturnRoutes(request: apiRequest)
        //        order = StripeOrderRoutes(request: apiRequest)
        plans = StripePlanRoutes(apiHandler: handler)
        product = StripeProductRoutes(apiHandler: handler)
        refund = StripeRefundRoutes(apiHandler: handler)
        //        sku = StripeSKURoutes(request: apiRequest)
        source = StripeSourceRoutes(apiHandler: handler)
        subscriptionItems = StripeSubscriptionItemRoutes(apiHandler: handler)
        subscriptions = StripeSubscriptionRoutes(apiHandler: handler)
        token = StripeTokenRoutes(apiHandler: handler)
        transfers = StripeTransferRoutes(apiHandler: handler)
        transferReversals = StripeTransferReversalRoutes(apiHandler: handler)
        payouts = StripePayoutRoutes(apiHandler: handler)
        fileLinks = StripeFileLinkRoutes(apiHandler: handler)
        files = StripeFileRoutes(apiHandler: handler)
        person = StripePersonRoutes(apiHandler: handler)
        applicationFee = StripeApplicationFeeRoutes(apiHandler: handler)
        applicationFeeRefunds = StripeApplicationFeeRefundRoutes(apiHandler: handler)
        //        externalAccounts = StripeExternalAccountsRoutes(request: apiRequest)
        countrySpecs = StripeCountrySpecRoutes(apiHandler: handler)
        topup = StripeTopUpRoutes(apiHandler: handler)
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
    }
}
