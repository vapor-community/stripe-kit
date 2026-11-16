// MARK: - Coverage Exceptions
// Known, accepted deviations from the spec, each with the reason it's accepted.
// Keys are the coverage check's issue keys (see CoverageCheck.swift):
//   "missing METHOD /path", "duplicate METHOD /path", "name METHOD /path",
//   "return METHOD /path", "param ParentStem.field"
// Generation fails on any deviation not listed here, and on any entry here that no
// longer matches a deviation. The param entries are typing gaps still to close.

private enum ParamGap {
    static let intOrKeyword = "A timestamp/integer or a keyword (e.g. `now`, `inf`, `minimum`). Typed as String: pass either as text."
    static let boolOrKeyword = "`true`/`false` or a keyword (`one_off`, `recurring`). Typed as String: pass either as text (e.g. \"true\")."
    static let twoShapes = "Either of two object shapes. Typed as String, so only a string form (a token, where one exists) can be sent."
    static let objectOrID = "An inline object or an ID. Typed as String, so only the ID form can be sent."
    static let currencyMap = "A map of per-currency objects. [String: String] can't express the nested fields, so this can't be sent."
    static let untypedMap = "A map whose values the spec doesn't type. Typed as [String: String]."
}

let coverageExceptions: [String: String] = [
    // Operations
    "missing GET /v1/account":
        "Retrieves the API key's own account. Stripe names it `retrieve`, the same as GET /v1/accounts/{account}, and with no path param there's no parent to tell the two apart by.",
    "missing GET /v1/quotes/{quote}/pdf":
        "The response is a PDF; StripeAPIHandler only decodes JSON.",
    "name DELETE /v1/customers/{customer}/sources/{id}":
        "Owned by bank_account and card (`delete`) and source (`detach`), so the spec has no single name; keeps the path-derived `delete`.",
    "return POST /v1/customers/{customer}/sources/{id}":
        "The response is `card | bank_account | source`; PaymentSource decodes all three by `object`.",

    // Params: intOrKeyword
    "param AccountCreateSettingsPayoutsSchedule.delay_days": ParamGap.intOrKeyword,
    "param AccountUpdateSettingsPayoutsSchedule.delay_days": ParamGap.intOrKeyword,
    "param FileLinkUpdate.expires_at": ParamGap.intOrKeyword,
    "param InvoiceCreatePreviewScheduleDetailsPhases.end_date": ParamGap.intOrKeyword,
    "param InvoiceCreatePreviewScheduleDetailsPhases.start_date": ParamGap.intOrKeyword,
    "param InvoiceCreatePreviewScheduleDetailsPhases.trial_end": ParamGap.intOrKeyword,
    "param InvoiceCreatePreviewSubscriptionDetails.cancel_at": ParamGap.intOrKeyword,
    "param InvoiceCreatePreviewSubscriptionDetails.trial_end": ParamGap.intOrKeyword,
    "param PlanCreateTiers.up_to": ParamGap.intOrKeyword,
    "param PriceCreateTiers.up_to": ParamGap.intOrKeyword,
    "param QuoteCreateSubscriptionData.effective_date": ParamGap.intOrKeyword,
    "param QuoteUpdateSubscriptionData.effective_date": ParamGap.intOrKeyword,
    "param RegistrationCreate.active_from": ParamGap.intOrKeyword,
    "param RegistrationUpdate.active_from": ParamGap.intOrKeyword,
    "param RegistrationUpdate.expires_at": ParamGap.intOrKeyword,
    "param SubscriptionCreate.cancel_at": ParamGap.intOrKeyword,
    "param SubscriptionCreate.trial_end": ParamGap.intOrKeyword,
    "param SubscriptionScheduleCreate.start_date": ParamGap.intOrKeyword,
    "param SubscriptionScheduleUpdatePhases.end_date": ParamGap.intOrKeyword,
    "param SubscriptionScheduleUpdatePhases.start_date": ParamGap.intOrKeyword,
    "param SubscriptionScheduleUpdatePhases.trial_end": ParamGap.intOrKeyword,
    "param SubscriptionUpdate.cancel_at": ParamGap.intOrKeyword,
    "param SubscriptionUpdate.trial_end": ParamGap.intOrKeyword,

    // Params: boolOrKeyword
    "param PaymentIntentConfirm.off_session": ParamGap.boolOrKeyword,
    "param PaymentIntentCreate.off_session": ParamGap.boolOrKeyword,

    // Params: twoShapes
    "param AuthenticationCreatePaymentMethodData.card": ParamGap.twoShapes,
    "param PaymentIntentConfirm.mandate_data": ParamGap.twoShapes,
    "param PaymentMethodCreate.card": ParamGap.twoShapes,
    "param SetupIntentConfirm.mandate_data": ParamGap.twoShapes,

    // Params: objectOrID
    "param PlanCreate.product": ParamGap.objectOrID,
    "param TokenCreate.card": ParamGap.objectOrID,

    // Params: currencyMap
    "param CheckoutSessionCreateShippingOptionsShippingRateDataFixedAmount.currency_options": ParamGap.currencyMap,
    "param CheckoutSessionUpdateShippingOptionsShippingRateDataFixedAmount.currency_options": ParamGap.currencyMap,
    "param CouponCreate.currency_options": ParamGap.currencyMap,
    "param CouponUpdate.currency_options": ParamGap.currencyMap,
    "param InvoiceCreateShippingCostShippingRateDataFixedAmount.currency_options": ParamGap.currencyMap,
    "param InvoiceUpdateShippingCostShippingRateDataFixedAmount.currency_options": ParamGap.currencyMap,
    "param PriceCreate.currency_options": ParamGap.currencyMap,
    "param PriceUpdate.currency_options": ParamGap.currencyMap,
    "param ProductCreateDefaultPriceData.currency_options": ParamGap.currencyMap,
    "param PromotionCodeCreateRestrictions.currency_options": ParamGap.currencyMap,
    "param PromotionCodeUpdateRestrictions.currency_options": ParamGap.currencyMap,
    "param ShippingRateCreateFixedAmount.currency_options": ParamGap.currencyMap,
    "param ShippingRateUpdateFixedAmount.currency_options": ParamGap.currencyMap,

    // Params: untypedMap
    "param BalanceSettingsUpdatePaymentsPayouts.automatic_transfer_rules_by_currency": ParamGap.untypedMap,
    "param BalanceSettingsUpdatePaymentsPayouts.minimum_balance_by_currency": ParamGap.untypedMap,
]
