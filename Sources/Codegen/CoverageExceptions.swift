// MARK: - Coverage Exceptions
// Known, accepted deviations from the spec, each with the reason it's accepted.
// Keys are the coverage check's issue keys (see CoverageCheck.swift):
//   "missing METHOD /path", "duplicate METHOD /path", "name METHOD /path",
//   "return METHOD /path", "param ParentStem.field"
// Generation fails on any deviation not listed here, and on any entry here that no
// longer matches a deviation.

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
]
