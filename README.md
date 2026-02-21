# StripeKit

A fully-typed, spec-generated Swift SDK for the [Stripe API](https://docs.stripe.com/api).
**API Version:** `2026-01-28.clover`

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
│   └── StripeClient.swift  
└── Infrastructure/
    ├── StripeAPIHandler.swift    
    ├── StripeClient.swift        
    ├── StripeError.swift          
    ├── StripeEvent.swift          
    ├── StripeExpandable.swift     
    ├── StripeParams.swift         
    └── Helpers.swift              
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

// Retrieve with expanded fields
let full = try await stripe.customers.retrieve(customer.id, ["default_source"])

// Create a payment intent
var piParams = PaymentIntentCreateParams()
piParams.amount = 2000
piParams.currency = "usd"
piParams.customer = customer.id
let intent = try await stripe.paymentIntents.create(piParams)

// List all charges
let charges = try await stripe.charges.list(nil)
for charge in charges.data ?? [] {
    print("\(charge.id): \(charge.amount ?? 0)")
}
```

## API Design

### Routes (Closure-Based)

Every route struct uses `@Sendable` closures:

```swift
public struct CustomerRoutes: Sendable {
    public var create:   @Sendable (_ params: CustomerCreateParams?) async throws -> Customer
    public var retrieve: @Sendable (_ customer: String, _ expand: [String]?) async throws -> Customer
    public var update:   @Sendable (_ customer: String, _ params: CustomerUpdateParams?) async throws -> Customer
    public var list:     @Sendable (_ expand: [String]?) async throws -> CustomerList
    public var delete:   @Sendable (_ customer: String, _ expand: [String]?) async throws -> Customer
}
```

### Params (Typed + Form-Encoded)

All POST bodies are typed structs conforming to `StripeParams`, which auto-encodes to `application/x-www-form-urlencoded`:

```swift
var params = CustomerCreateParams()
params.email = "jane@example.com"
params.metadata = ["source": "ios_app"]
params.invoiceSettings = CustomerCreateParamsInvoiceSettings()
params.invoiceSettings?.defaultPaymentMethod = "pm_..."

let customer = try await stripe.customers.create(params)
```

### Expandable Fields

Stripe returns IDs by default but can expand nested objects on request. StripeKit handles this transparently with property wrappers:

#### `@Expandable<T>` — Single ID ↔ Object

The most common pattern. A field is either a string ID or a fully expanded object:

```swift
let customer = try await stripe.customers.retrieve("cus_xxx", ["default_source"])

// wrappedValue → the ID (always available)
let sourceId: String? = customer.defaultSource

// projectedValue ($) → the expanded object (only when requested)
let source: PaymentSource? = customer.$defaultSource
```

#### `@ExpandableCollection<T>` — Array of IDs ↔ Objects

For fields like `discounts`, `tax_rates`, or `balances` where the API returns an array that can be either string IDs or expanded objects:

```swift
let invoice = try await stripe.invoices.retrieve("in_xxx", ["discounts", "default_tax_rates"])

// wrappedValue → array of IDs
let discountIds: [String]? = invoice.discounts

// projectedValue ($) → array of expanded objects
let discounts: [DiscountsResourceDiscountAmount]? = invoice.$discounts
let taxRates: [TaxRate]? = invoice.$defaultTaxRates
```

#### `@DynamicExpandable<A, B>` — Polymorphic Expansion

For fields that can expand to one of multiple concrete types (e.g., a source that could be a `BankAccount` or `Card`):

```swift
// wrappedValue → the ID
let externalAccountId: String? = account.externalAccount

// projectedValue ($) → use callAsFunction to cast
let bankAccount: BankAccount? = account.$externalAccount(as: BankAccount.self)
let card: Card? = account.$externalAccount(as: Card.self)
```

### Idempotency

Stripe supports [idempotency keys](https://docs.stripe.com/api/idempotent_requests) to safely retry requests:

```swift
let customer = try await stripe.idempotent("unique-key-\(UUID())").customers.create(params)
```

### Stripe Connect (`onBehalfOf`)

Scope requests to a connected account:

```swift
let payout = try await stripe.onBehalfOf("acct_connected_123").payouts.create(payoutParams)
```

### File Uploads

Upload files to the Stripe Files API using multipart form data:

```swift
let file = try await stripe.files.create(
    fileData: imageData,
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
case "payment_intent.succeeded":
    let intent = try event.data.object(as: PaymentIntent.self)
    print("Payment succeeded: \(intent.id)")

case "payment_intent.payment_failed":
    let intent = try event.data.object(as: PaymentIntent.self)
    print("Payment failed: \(intent.lastPaymentError?.message ?? "unknown")")

case "customer.subscription.created",
     "customer.subscription.updated":
    let sub = try event.data.object(as: Subscription.self)
    print("Subscription \(sub.id) status: \(sub.status)")

case "customer.updated":
    let customer = try event.data.object(as: Customer.self)
    let previous = try event.data.previousAttributes(as: Customer.self)
    print("Customer \(customer.id) updated")

case "invoice.paid":
    let invoice = try event.data.object(as: Invoice.self)
    print("Invoice \(invoice.id) paid: \(invoice.amountPaid ?? 0)")

default:
    print("Unhandled event: \(event.type)")
}
```

## Testing

Every route struct includes a `.test` stub with unimplemented closures. Override only what your tests need:

```swift
var client = StripeClient.test

// Override the customer create route
client.customers.create = { params in
    return Customer(created: 0, id: "cus_test_123", livemode: false, object: .customer)
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
| `Models/` | `Codable` structs per resource, organized by Stripe domain | 137 |
| `Routes/` | `@Sendable` closure-based route structs + `.live()` implementations | 136 |
| `Params/` | Typed `StripeParams` structs for create/update/action operations | 102 |
| `Types/` | Inline schemas (shared sub-types referenced across resources) | 1,415 |
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
5. **InfraGenerator** wires all route structs into `StripeClient` with `.live()` and `.test` factories

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