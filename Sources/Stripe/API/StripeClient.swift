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
    //    public var connectAccount: AccountRoutes
    //    public var coupon: CouponRoutes
    public var customer: CustomerRoutes
    public var dispute: DisputeRoutes
    //    public var ephemeralKey: EphemeralKeyRoutes
    //    public var invoiceItem: InvoiceItemRoutes
    //    public var invoice: InvoiceRoutes
    //    public var orderReturn: OrderReturnRoutes
    //    public var order: OrderRoutes
    //    public var plan: PlanRoutes
    public var product: ProductRoutes
    public var refund: RefundRoutes
    //    public var sku: SKURoutes
    //    public var source: SourceRoutes
    //    public var subscriptionItem: SubscriptionItemRoutes
    //    public var subscription: SubscriptionRoutes
    public var token: TokenRoutes
    //    public var transfer: TransferRoutes
    //    public var transferReversals: TransferReversalRoutes
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
    
    init(eventLoop: EventLoopGroup, apiKey: String) {
        let client = HTTPClient(eventLoopGroupProvider: .shared(eventLoop))
        let handler = StripeAPIHandler(httpClient: client, apiKey: apiKey)
        
        balance = StripeBalanceRoutes(apiHandler: handler)
        charge = StripeChargeRoutes(apiHandler: handler)
        //        connectAccount = StripeConnectAccountRoutes(request: apiRequest)
        //        coupon = StripeCouponRoutes(request: apiRequest)
        customer = StripeCustomerRoutes(apiHandler: handler)
        dispute = StripeDisputeRoutes(apiHandler: handler)
        //        ephemeralKey = StripeEphemeralKeyRoutes(request: apiRequest)
        //        invoiceItem = StripeInvoiceItemRoutes(request: apiRequest)
        //        invoice = StripeInvoiceRoutes(request: apiRequest)
        //        orderReturn = StripeOrderReturnRoutes(request: apiRequest)
        //        order = StripeOrderRoutes(request: apiRequest)
        //        plan = StripePlanRoutes(request: apiRequest)
        product = StripeProductRoutes(apiHandler: handler)
        refund = StripeRefundRoutes(apiHandler: handler)
        //        sku = StripeSKURoutes(request: apiRequest)
        //        source = StripeSourceRoutes(request: apiRequest)
        //        subscriptionItem = StripeSubscriptionItemRoutes(request: apiRequest)
        //        subscription = StripeSubscriptionRoutes(request: apiRequest)
        token = StripeTokenRoutes(apiHandler: handler)
        //        transfer = StripeTransferRoutes(request: apiRequest)
        //        transferReversals = StripeTransferReversalRoutes(request: apiRequest)
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
    }
}
