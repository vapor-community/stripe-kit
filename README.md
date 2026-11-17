# StripeKit

A fully-typed, spec-generated Swift SDK for the [Stripe API](https://docs.stripe.com/api).
**API Version:** `2026-10-28.endive`

## Overview

StripeKit is split into two parts:

| Layer | Description |
|-------|-------------|
| **Generated** (`Sources/StripeKit/Generated/`) | 1,500+ Swift types generated from Stripe's OpenAPI spec. Models, routes, params, and inline types. Regenerated on every API version bump. |
| **Infrastructure** (`Sources/StripeKit/Infrastructure/`) | Hand-written transport, error types, webhook verification, and property wrappers. Stable across regeneration cycles. |

```
Sources/StripeKit/
├── Generated/
│   ├── Models/           
│   ├── Routes/           
│   ├── Params/           
│   ├── Types/
│   ├── StripeClient.swift
│   ├── StripeEventType.swift
│   └── StripeEvent.swift
└── Infrastructure/
    ├── StripeAPIHandler.swift
    ├── StripeClient+Scoping.swift
    ├── StripeError.swift
    ├── StripeExpandable.swift
    ├── StripeParams.swift
    ├── StripeRangeQuery.swift
    ├── StripeSearchResult.swift
    └── ObjectOrDeleted.swift
```

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/anthropics/stripe-kit.git", from: "2026.1.0")
]
```

```swift
.target(name: "MyApp", dependencies: [
    .product(name: "StripeKit", package: "stripe-kit")
])
```

**Requirements:** Swift 6.0+, macOS 14+ / Linux

## Quick Start

```swift
import StripeKit
import AsyncHTTPClient

let httpClient = HTTPClient.shared
let stripe = StripeClient.live(
    httpClient: httpClient,
    apiKey: "sk_test_..."
)

// Create a customer
var params = CustomerCreateParams()
params.email = "jane@example.com"
params.name = "Jane Doe"
let customer = try await stripe.customers.create(params)

// Retrieve with expanded fields (nil if the customer was deleted)
let full = try await stripe.customers.retrieve(customer.id, expand: ["default_source"]).object

// Create a payment intent
var piParams = PaymentIntentCreateParams()
piParams.amount = 2000
piParams.currency = "usd"
piParams.customer = customer.id
let intent = try await stripe.paymentIntents.create(piParams)

// List all charges
let charges = try await stripe.charges.list()
for charge in charges.data {
    print("\(charge.id): \(charge.amount)")
}

// List with filters (query params are typed too)
let recent = try await stripe.customers.list(.init(
    created: .range(gte: 1_700_000_000),
    email: "jane@example.com",
    limit: 10
))

// Search
let results = try await stripe.customers.search(.init(query: "email:'jane@example.com'"))
print(results.data.count, results.nextPage ?? "last page")

// Namespaced APIs are grouped like their paths: /v1/terminal/readers → stripe.terminal.readers
let readers: TerminalReaderList = try await stripe.terminal.readers.list()
let calculation: TaxCalculation = try await stripe.tax.calculations.create(taxParams)
```

Types in a namespace always carry it in their name (`TerminalReader`, `TaxCalculation`, `BillingPortalSession`), as in stripe-go and async-stripe, so a resource Stripe adds later can never rename an existing type.

## API Design

### Routes

Each operation is a method with argument labels and defaults, following Stripe's SDKs (`retrieve(id, params, options)`):

```swift
try await stripe.customers.create()                                    // params default to .init()
try await stripe.customers.update("cus_1", .init(email: "jane@example.com"))
try await stripe.customers.retrieve("cus_1", expand: ["default_source"])
try await stripe.customers.retrievePaymentMethod("cus_1", paymentMethod: "pm_1")
try await stripe.customers.create(params, options: .init(idempotencyKey: key))
```

- The first path parameter is unlabeled; any others are labeled.
- A params struct is unlabeled. It defaults to `.init()` unless it has required fields.
- Routes without a params struct take `expand:`; a params struct has its own `expand`.
- Every method ends with `options: RequestOptions` (connected account, idempotency key).

Each method calls a `@Sendable` closure stored on the route struct, which you can replace, e.g. to stub a route in tests:

```swift
public struct CustomerRoutes: Sendable {
    public var create:   @Sendable (_ params: CustomerCreateParams, _ options: RequestOptions) async throws -> Customer
    public var retrieve: @Sendable (_ customer: String, _ expand: [String]?, _ options: RequestOptions) async throws -> ObjectOrDeleted<Customer, DeletedCustomer>
    …
}
```

### Enums and Values Stripe Adds Later

Stripe adds enum values, such as new payment method types and error codes, without a new API version. So the spec's enums are extensible: each is a struct holding its raw value, with a static member per value Stripe documents.

```swift
if paymentMethod.type == .card { … }

switch paymentMethod.type {
case .card: …
case .sepaDebit: …
default: print("Another payment method type: \(paymentMethod.type.rawValue)")
}
```

- Any value decodes, including one this version of StripeKit doesn't list, instead of failing the response. Send one in params with `.init(rawValue: "new_value")`.
- An object of an unknown type in a list of several types (`ExternalAccount`, `PaymentSource`) decodes as `.undocumented` with its raw `JSONValue`.

### Deleted Objects

Delete endpoints return a `Deleted*` type (`id`, `object`, `deleted: true`), not the full object.
Where Stripe can return either one, such as retrieving a customer that may have been deleted,
the route returns `ObjectOrDeleted`:

```swift
switch try await stripe.customers.retrieve("cus_123") {
case .object(let customer): print(customer.email ?? "")
case .deleted(let deleted): print("\(deleted.id) was deleted")
}
```

Return types follow Stripe's API spec, the same approach as the async-stripe Rust SDK.
Expandable fields expand to the live object only.

### Params (Typed + Form-Encoded)

All POST bodies are typed structs conforming to `StripeParams`, which auto-encodes to `application/x-www-form-urlencoded`.
GET routes with query params (list, search, …) take a `StripeParams` struct too, sent as the query string with the same
encoding. Integer range filters such as `created` use `StripeRangeQuery` (`.equals(_)` or `.range(gt:gte:lt:lte:)`).

```swift
var params = CustomerCreateParams()
params.email = "jane@example.com"
params.metadata = ["source": "ios_app"]
params.invoiceSettings = CustomerInvoiceSettings(defaultPaymentMethod: "pm_...")

let customer = try await stripe.customers.create(params)
```

Nested params are named after the resource and field (`CustomerInvoiceSettings`, `PaymentIntentPaymentMethodData`) and shared by every endpoint that takes the same shape, as in Stripe's own SDKs. Where endpoints differ, the type includes the action: `CustomerCreateTax`.

### Expandable Fields

Stripe returns IDs by default but can expand nested objects on request. StripeKit handles this transparently with property wrappers:

#### `@Expandable<T>` — Single ID ↔ Object

The most common pattern. A field is either a string ID or a fully expanded object:

```swift
guard let customer = try await stripe.customers.retrieve("cus_xxx", expand: ["default_source"]).object else { return }

// wrappedValue → the ID (when not expanded)
let sourceId: String? = customer.defaultSource

// projectedValue ($) → the expanded object (only when requested)
let source: PaymentSource? = customer.$defaultSource
```

Where Stripe can expand a field to a deleted object (a charge's `customer` after the customer was deleted), the expanded value is an `ObjectOrDeleted`, the same type retrieve routes return:

```swift
let charge = try await stripe.charges.retrieve("ch_xxx", expand: ["customer"])

switch charge.$customer {
case .object(let customer)?: print(customer.email ?? "")
case .deleted(let deleted)?: print("\(deleted.id) was deleted")
case nil: break  // not expanded
}
```

#### `@ExpandableCollection<T>` — Array of IDs ↔ Objects

For fields like an invoice's `discounts`, where the API returns an array that can be either string IDs or expanded objects:

```swift
let invoice = try await stripe.invoices.retrieve("in_xxx", expand: ["discounts"])

// wrappedValue → array of IDs (when not expanded)
let discountIds: [String]? = invoice.discounts

// projectedValue ($) → array of expanded objects (a discount can be a deleted one)
let discounts: [ObjectOrDeleted<Discount, DeletedDiscount>]? = invoice.$discounts
```

### Idempotency

Stripe supports [idempotency keys](https://docs.stripe.com/api/idempotent_requests) to safely retry requests. Pass a new key with each request:

```swift
let customer = try await stripe.customers.create(params, options: .init(idempotencyKey: UUID().uuidString))
```

### Clearing Fields

Stripe clears a field you send empty, where its API allows it (`metadata`, `shipping`, `discounts`, …). Params structs with such fields have a `clear(_:)` listing exactly those fields:

```swift
var params = CustomerUpdateParams(name: "Jane")
params.clear(.shipping)    // shipping=
params.clear(.metadata)    // metadata=
try await stripe.customers.update("cus_1", params)
```

Nested params work the same way: `invoiceSettings.clear(.customFields)` sends `invoice_settings[custom_fields]=`.

### Retries

Like Stripe's own SDKs, requests are retried up to 2 times, with exponential backoff (0.5s, doubling, up to 5s, with jitter), after a network error or a response Stripe marks retryable: its `Stripe-Should-Retry` header when present, otherwise a 409 or a 5xx. A `Retry-After` of up to 60 seconds is honoured. POSTs get a generated idempotency key unless you pass your own, so a retry can't perform one twice.

```swift
let stripe = StripeClient.live(httpClient: .shared, apiKey: key, maxNetworkRetries: 3)  // 0 turns retries off
```

### Stripe Connect (`onBehalfOf`)

Make requests as a connected account (sends the `Stripe-Account` header; unrelated to the `on_behalf_of` param), for one request or a whole client:

```swift
let payout = try await stripe.payouts.create(payoutParams, options: .init(stripeAccount: "acct_connected_123"))

let connected = stripe.onBehalfOf("acct_connected_123")
let balance = try await connected.balances.retrieve()
```

### File Uploads

Upload files to the Stripe Files API using multipart form data:

```swift
let file = try await stripe.files.create(
    file: imageData,
    fileName: "receipt.png",
    mimeType: "image/png",
    purpose: "dispute_evidence"
)
```

## Webhook Verification

Verify and decode webhook events with HMAC-SHA256 signature checking:

```swift
let event = try StripeEvent.verify(
    payload: requestBody,
    header: request.headers["Stripe-Signature"],
    secret: "whsec_...",
    tolerance: 300  // seconds
)

switch event.type {
case .paymentIntentSucceeded:
    let intent = try event.data.object(as: PaymentIntent.self)
    print("Payment succeeded: \(intent.id)")

case .paymentIntentPaymentFailed:
    let intent = try event.data.object(as: PaymentIntent.self)
    print("Payment failed: \(intent.lastPaymentError?.message ?? "unknown")")

case .customerSubscriptionCreated, .customerSubscriptionUpdated:
    let sub = try event.data.object(as: Subscription.self)
    print("Subscription \(sub.id) status: \(sub.status.rawValue)")

case .customerUpdated:
    let customer = try event.data.object(as: Customer.self)
    // Only the changed fields, as raw JSON
    if let previousEmail = event.data.previousAttributes?["email"]?.stringValue {
        print("Customer \(customer.id) changed email from \(previousEmail)")
    }

case .invoicePaid:
    let invoice = try event.data.object(as: Invoice.self)
    print("Invoice \(invoice.id ?? "") paid: \(invoice.amountPaid)")

default:
    print("Unhandled event: \(event.type.rawValue)")  // includes event types newer than StripeKit
}
```

## Testing

Replace the closures of the routes your code uses. `StripeClient.test` has a placeholder API key, so any route you don't replace fails rather than reaching Stripe:

```swift
var client = StripeClient.test

// Stub the customer create route (models are Decodable; decode a recorded response)
client.customers.create = { params, options in
    try JSONDecoder().decode(Customer.self, from: customerJSON)
}

// Inject into your service
let service = PaymentService(stripe: client)
```

## Error Handling

All API errors decode into typed `StripeError` with structured codes:

```swift
do {
    let charge = try await stripe.charges.create(params)
} catch let error as StripeError {
    switch error.error?.type {
    case .cardError:
        print("Card declined: \(error.error?.message ?? "")")
        print("Decline code: \(error.error?.declineCode ?? "")")
        print("Error code: \(error.error?.code?.rawValue ?? "")")
    case .invalidRequestError:
        print("Bad request: \(error.error?.param ?? "")")
        print("Details: \(error.error?.message ?? "")")
    case .apiError, .idempotencyError:
        print("Stripe error: \(error.error?.message ?? "")")
    default:
        print("Unknown error: \(error.error?.message ?? "")")
    }
}
```

---

## Codegen

The `stripe-kit-codegen` CLI regenerates all files under `Generated/` from Stripe's OpenAPI spec. Infrastructure files are never touched.

### Running

```bash
# Default: reads spec3.sdk.json, outputs to Sources/StripeKit/
swift run stripe-kit-codegen

# Custom paths
swift run stripe-kit-codegen --spec path/to/spec3.sdk.json --output Sources/StripeKit
```

### What Gets Generated

| Directory | Contents | Count |
|-----------|----------|-------|
| `Models/` | `Codable` structs per resource, organized by Stripe domain | 142 |
| `Routes/` | `@Sendable` closure-based route structs + `.live()` implementations | 141 |
| `Params/` | Typed `StripeParams` structs for create/update/action operations | 107 |
| `Types/` | Inline schemas (shared sub-types referenced across resources) | 1,699 |
| `StripeClient.swift` | Auto-wired client connecting all route structs | 1 |

### How It Works

The codegen pipeline is fully deterministic — no heuristics, no pluralization guessing:

```
spec3.sdk.json
     │
     ▼
┌─────────────┐     ┌──────────────────┐
│  SpecParser │────▶│ buildPathMapping │  Scans response $refs
│             │     │schemaName → paths│  (direct + list-wrapped)
└──────┬──────┘     └──────────────────┘
       │
       ▼
┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌───────────────┐
│ ModelGenerator│  │ RouteGenerator│  │ ParamGenerator│  │ InfraGenerator│
│  (models)    │  │  (routes)    │  │  (params)    │  │ (client wire) │
└──────────────┘  └──────────────┘  └──────────────┘  └───────────────┘
```

1. **SpecParser** parses the OpenAPI spec into `StripeResource` structs and builds a deterministic `pathMapping` by scanning response `$ref`s
2. **ModelGenerator** emits `Codable` structs from schema properties, handling enums, nested objects, and `@Expandable` fields
3. **RouteGenerator** uses the `pathMapping` to find all API operations for each resource
4. **ParamGenerator** extracts `requestBody` schemas from POST operations and generates typed param structs
5. **InfraGenerator** wires all route structs into `StripeClient` with a `.live()` factory

### Updating to a New API Version

```bash
# 1. Download the latest spec
curl -o spec3.sdk.json https://raw.githubusercontent.com/stripe/openapi/master/openapi/spec3.sdk.json

# 2. Regenerate
swift run stripe-kit-codegen

# 3. Review and commit
git diff Sources/StripeKit/Generated/
git add -A && git commit -m "Update to Stripe API vXXXX-XX-XX"
```

---

## Versioning

StripeKit uses **calendar-based semver** tied to the Stripe API version:

```
{YEAR}.{QUARTER}.{PATCH}
```

| Component | Meaning | Example |
|-----------|---------|---------|
| `YEAR` | Stripe API year | `2026` |
| `QUARTER` | Sequential release within the year | `1`, `2`, `3` |
| `PATCH` | Bug fixes, infra improvements (no spec change) | `0`, `1`, `2` |

### Examples

| Tag | What Changed |
|-----|-------------|
| `2026.1.0` | Initial release, Stripe API `2026-01-28.clover` |
| `2026.1.1` | Bug fix in route codegen, no API version change |
| `2026.2.0` | Regenerated from a new Stripe API version |

### SwiftPM Compatibility

SwiftPM fully supports semver ranges, so consumers get bug fixes automatically:

```swift
// Gets 2026.1.x bug fixes, won't jump to 2026.2.0
.package(url: "...", from: "2026.1.0")

// Pin to exact version
.package(url: "...", exact: "2026.1.0")
```