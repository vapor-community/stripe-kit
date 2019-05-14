//
//  Endpoints.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Foundation

internal let APIBase = "https://api.stripe.com/"
internal let FilesAPIBase = "https://files.stripe.com/"
internal let APIVersion = "v1/"

internal enum StripeAPIEndpoint {
    
    // MARK: - BALANCE
    case balance
    case balanceHistory
    case balanceHistoryTransaction(String)
    
    // MARK: - CHARGES
    case charges
    case charge(String)
    case captureCharge(String)
    
    // MARK: - CUSTOMERS
    case customers
    case customer(String)
    
    // MARK: - TOKENS
    case tokens
    case token(String)
    
    // MARK: - REFUNDS
    case refunds
    case refund(String)
    
    // MARK: - COUPONS
    case coupons
    case coupon(String)
    
    // MARK: - PLANS
    case plan
    case plans(String)
    
    // MARK: - SOURCES
    case source
    case sources(String)
    case sourcesAttach(String)
    case sourcesDetach(String, String)
    
    // MARK: - SUBSCRIPTION ITEMS
    case subscriptionItem
    case subscriptionItems(String)
    
    // MARK: - SUBSCRIPTIONS
    case subscription
    case subscriptions(String)
    
    // MARK: - ACCOUNTS
    case account
    case accounts(String)
    case accountsReject(String)
    case accountsLoginLink(String)
    
    // MARK: - DISPUTES
    case dispute
    case disputes(String)
    case closeDispute(String)
    
    // MARK: - SKUS
    case sku
    case skus(String)
    
    // MARK: - PRODUCTS
    case product
    case products(String)
    
    // MARK: - ORDERS
    case order
    case orders(String)
    case ordersPay(String)
    case ordersReturn(String)
    
    // MARK: - RETURNS
    case orderReturn
    case orderReturns(String)
    
    // MARK: - INVOICES
    case invoice
    case invoices(String)
    case invoicesFinalize(String)
    case invoicesPay(String)
    case invoicesSend(String)
    case invoicesVoid(String)
    case invoicesMarkUncollectible(String)
    case invoicesLineItems(String)
    case invoicesUpcoming
    case invoicesUpcomingLineItems
    
    // MARK: - INVOICE ITEMS
    case invoiceItem
    case invoiceItems(String)
    
    // MARK: - EPHEMERAL KEYS
    case ephemeralKeys
    case ephemeralKey(String)
    
    // MARK: - TRANSFERS
    case transfer
    case transfers(String)
    case transferReversal(String)
    case transfersReversal(String,String)
    
    // MARK: - PAYOUTS
    case payout
    case payouts(String)
    case payoutsCancel(String)
    
    // MARK: - FILE LINKS
    case fileLink
    case fileLinks(String)
    
    // MARK: - FILE UPLOAD
    case file
    case files(String)
    
    // MARK: - PERSONS
    case person(String)
    case persons(String, String)
    
    case applicationFee
    case applicationFees(String)
    
    case applicationFeeRefund(String)
    case applicationFeeRefunds(String, String)
    
    case externalAccount(String)
    case externalAccounts(String, String)
    
    case countrySpec
    case countrySpecs(String)
    
    case topup
    case topups(String)
    case topupsCancel(String)
    
    case review
    case reviews(String)
    case reviewsApprove(String)
    
    case valueListItem
    case valueListItems(String)
    
    case valueList
    case valueLists(String)
    
    case paymentIntents
    case paymentIntent(String)
    case paymentIntentConfirm(String)
    case paymentIntentCapture(String)
    case paymentIntentCancel(String)
    
    case paymentMethod
    case paymentMethods(String)
    case paymentMethodsAttach(String)
    case paymentMethodsDetach(String)
    
    case bankAccount(String)
    case bankAccounts(String, String)
    case bankAccountVerify(String, String)
    
    case card(String)
    case cards(String, String)
    
    case session
    case sessions(String)
    
    case discountCustomer(String)
    case discountSubscription(String)
    
    case taxid(String)
    case taxids(String, String)
    
    case taxRate
    case taxRates(String)
    
    case creditNote
    case creditNotes(String)
    case creditNotesVoid(String)
    
    case usageRecords(String)
    case usageRecordSummaries(String)
    
    var endpoint: String {
        switch self {
        case .balance: return APIBase + APIVersion + "balance"
        case .balanceHistory: return APIBase + APIVersion + "balance/history"
        case .balanceHistoryTransaction(let id): return APIBase + APIVersion + "balance/history/\(id)"
        
        case .charges: return APIBase + APIVersion + "charges"
        case .charge(let id): return APIBase + APIVersion + "charges/\(id)"
        case .captureCharge(let id): return APIBase + APIVersion + "charges/\(id)/capture"
            
        case .customers: return APIBase + APIVersion + "customers"
        case .customer(let id): return APIBase + APIVersion + "customers/\(id)"
            
        case .tokens: return APIBase + APIVersion + "tokens"
        case .token(let id): return APIBase + APIVersion + "tokens/\(id)"
            
        case .refunds: return APIBase + APIVersion + "refunds"
        case .refund(let id): return APIBase + APIVersion + "refunds/\(id)"
            
        case .coupons: return APIBase + APIVersion + "coupons"
        case .coupon(let id): return APIBase + APIVersion + "coupons/\(id)"
            
        case .plan: return APIBase + APIVersion + "plans"
        case .plans(let id): return APIBase + APIVersion + "plans/\(id)"
            
        case .source: return APIBase + APIVersion + "sources"
        case .sources(let id): return APIBase + APIVersion + "sources/\(id)"
        case .sourcesAttach(let id): return APIBase + APIVersion + "customers/\(id)/sources"
        case .sourcesDetach(let customer, let source): return APIBase + APIVersion + "customers/\(customer)/sources/\(source)"
            
        case .subscriptionItem: return APIBase + APIVersion + "subscription_items"
        case .subscriptionItems(let id): return APIBase + APIVersion + "subscription_items/\(id)"
            
        case .subscription: return APIBase + APIVersion + "subscriptions"
        case .subscriptions(let id): return APIBase + APIVersion + "subscriptions/\(id)"
            
        case .account: return APIBase + APIVersion + "accounts"
        case .accounts(let id): return APIBase + APIVersion + "accounts/\(id)"
        case .accountsReject(let id): return APIBase + APIVersion + "accounts/\(id)/reject"
        case .accountsLoginLink(let id): return APIBase + APIVersion + "accounts/\(id)/login_links"
            
        case .dispute: return APIBase + APIVersion + "disputes"
        case .disputes(let id): return APIBase + APIVersion + "disputes/\(id)"
        case .closeDispute(let id): return APIBase + APIVersion + "disputes/\(id)/close"
            
        case .sku: return APIBase + APIVersion + "skus"
        case .skus(let id): return APIBase + APIVersion + "skus/\(id)"
            
        case .product: return APIBase + APIVersion + "products"
        case .products(let id): return APIBase + APIVersion + "products/\(id)"
            
        case .order: return APIBase + APIVersion + "orders"
        case .orders(let id): return APIBase + APIVersion + "orders/\(id)"
        case .ordersPay(let id): return APIBase + APIVersion + "orders/\(id)/pay"
        case .ordersReturn(let id): return APIBase + APIVersion + "orders/\(id)/returns"
            
        case .orderReturn: return APIBase + APIVersion + "order_returns"
        case .orderReturns(let id): return APIBase + APIVersion + "order_returns/\(id)"
            
        case .invoice: return APIBase + APIVersion + "invoices"
        case .invoices(let invoice): return APIBase + APIVersion + "invoices/\(invoice)"
        case .invoicesFinalize(let invoice): return APIBase + APIVersion + "invoices/\(invoice)/finalize"
        case .invoicesPay(let invoice): return APIBase + APIVersion + "invoices/\(invoice)/pay"
        case .invoicesSend(let invoice): return APIBase + APIVersion + "invoices/\(invoice)/send"
        case .invoicesVoid(let invoice): return APIBase + APIVersion + "invoices/\(invoice)/void"
        case .invoicesMarkUncollectible(let invoice): return APIBase + APIVersion + "invoices/\(invoice)/mark_uncollectible"
        case .invoicesLineItems(let invoice): return APIBase + APIVersion + "invoices/\(invoice)/lines"
        case .invoicesUpcoming: return APIBase + APIVersion + "invoices/upcoming"
        case .invoicesUpcomingLineItems: return APIBase + APIVersion + "invoices/upcoming/lines"
            
        case .invoiceItem: return APIBase + APIVersion + "invoiceitems"
        case .invoiceItems(let id): return APIBase + APIVersion + "invoiceitems/\(id)"
        
        case .ephemeralKeys: return APIBase + APIVersion + "ephemeral_keys"
        case .ephemeralKey(let id): return APIBase + APIVersion + "ephemeral_keys/\(id)"
            
        case .transfer: return APIBase + APIVersion + "transfers"
        case .transfers(let id): return APIBase + APIVersion + "transfers/\(id)"
        case .transferReversal(let id): return APIBase + APIVersion + "transfers/\(id)/reversals"
        case .transfersReversal(let transfer, let reversal): return APIBase + APIVersion + "transfers/\(transfer)/reversals/\(reversal)"
        
        case .payout: return APIBase + APIVersion + "payouts"
        case .payouts(let id): return APIBase + APIVersion + "payouts/\(id)"
        case .payoutsCancel(let id): return APIBase + APIVersion + "payouts/\(id)/cancel"
            
        case .fileLink: return APIBase + APIVersion + "file_links"
        case .fileLinks(let id): return APIBase + APIVersion + "file_links/\(id)"
        
        case .file: return FilesAPIBase + APIVersion + "files"
        case .files(let id): return FilesAPIBase + APIVersion + "files/\(id)"
        
        case .person(let account): return APIBase + APIVersion + "accounts/\(account)/persons"
        case .persons(let account, let person): return APIBase + APIVersion + "accounts/\(account)/persons/\(person)"
            
        case .applicationFee: return APIBase + APIVersion + "application_fees"
        case .applicationFees(let fee): return APIBase + APIVersion + "application_fees/\(fee)"
            
        case .applicationFeeRefund(let fee): return APIBase + APIVersion + "application_fees/\(fee)/refunds"
        case .applicationFeeRefunds(let fee, let refund): return APIBase + APIVersion + "application_fees/\(fee)/refunds/\(refund)"
            
        case .externalAccount(let account): return APIBase + APIVersion + "accounts/\(account)/external_accounts"
        case .externalAccounts(let account, let id): return APIBase + APIVersion + "accounts/\(account)/external_accounts/\(id)"
            
        case .countrySpec: return APIBase + APIVersion + "country_specs"
        case .countrySpecs(let country): return APIBase + APIVersion + "country_specs/\(country)"
            
        case .topup: return APIBase + APIVersion + "topups"
        case .topups(let id): return APIBase + APIVersion + "topups/\(id)"
        case .topupsCancel(let id): return APIBase + APIVersion + "topups/\(id)/cancel"
            
        case .review: return APIBase + APIVersion + "reviews"
        case .reviews(let id): return APIBase + APIVersion + "reviews/\(id)"
        case .reviewsApprove(let id): return APIBase + APIVersion + "reviews/\(id)/approve"
            
        case .valueListItem: return APIBase + APIVersion + "value_list_items"
        case .valueListItems(let id): return APIBase + APIVersion + "value_list_items/\(id)"
            
        case .valueList: return APIBase + APIVersion + "value_lists"
        case .valueLists(let id): return APIBase + APIVersion + "value_lists/\(id)"
            
        case .paymentIntents: return APIBase + APIVersion + "payment_intents"
        case .paymentIntent(let id): return APIBase + APIVersion + "payment_intents/\(id)"
        case .paymentIntentConfirm(let id): return APIBase + APIVersion + "payment_intents/\(id)/confirm"
        case .paymentIntentCapture(let id): return APIBase + APIVersion + "payment_intents/\(id)/capture"
        case .paymentIntentCancel(let id): return APIBase + APIVersion + "payment_intents/\(id)/cancel"
            
        case .paymentMethod: return APIBase + APIVersion + "payment_methods"
        case .paymentMethods(let id): return APIBase + APIVersion + "payment_method/\(id)"
        case .paymentMethodsAttach(let id): return APIBase + APIVersion + "payment_method/\(id)/attach"
        case .paymentMethodsDetach(let id): return APIBase + APIVersion + "payment_method/\(id)/detach"
            
        case .bankAccount(let customer): return APIBase + APIVersion + "customers/\(customer)/sources"
        case .bankAccounts(let customer, let bankAccount): return APIBase + APIVersion + "customers/\(customer)/sources/\(bankAccount)"
        case .bankAccountVerify(let customer, let bankAccount): return APIBase + APIVersion + "customers/\(customer)/sources/\(bankAccount)/verify"
            
        case .card(let customer): return APIBase + APIVersion + "customers/\(customer)/sources"
        case .cards(let card, let customer): return APIBase + APIVersion + "customers/\(customer)/sources/\(card)"
            
        case .session: return APIBase + APIVersion + "checkout/sessions"
        case .sessions(let session): return APIBase + APIVersion + "checkout/sessions/\(session)"
            
        case .discountCustomer(let customer): return APIBase + APIVersion + "customers/\(customer)/discount"
        case .discountSubscription(let subscription): return APIBase + APIVersion + "subscriptions/\(subscription)/discount"
            
        case .taxid(let customer): return APIBase + APIVersion + "customers/\(customer)/tax_ids"
        case .taxids(let customer, let taxid): return APIBase + APIVersion + "customers/\(customer)/tax_ids/\(taxid)"
            
        case .taxRate: return APIBase + APIVersion + "tax_rates"
        case .taxRates(let taxRate): return APIBase + APIVersion + "tax_rates/\(taxRate)"
            
        case .creditNote: return APIBase + APIVersion + "credit_notes"
        case .creditNotes(let id): return APIBase + APIVersion + "credit_notes/\(id)"
        case .creditNotesVoid(let id): return APIBase + APIVersion + "credit_notes/\(id)/void"
            
        case .usageRecords(let subscriptionItem): return APIBase + APIVersion + "subscription_items/\(subscriptionItem)/usage_records"
        case .usageRecordSummaries(let subscriptionItem): return APIBase + APIVersion + "subscription_items/\(subscriptionItem)/usage_record_summaries"
        }
    }
}
