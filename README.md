# StripeKit
![](https://img.shields.io/badge/Swift-6.0-lightgrey.svg?style=svg)
![](https://img.shields.io/badge/SwiftNIO-2-lightgrey.svg?style=svg)
![](https://img.shields.io/badge/Stripe_API-2026--10--28.endive-lightgrey.svg?style=svg)
[![Test](https://github.com/vapor-community/stripe-kit/actions/workflows/test.yml/badge.svg)](https://github.com/vapor-community/stripe-kit/actions/workflows/test.yml)

### StripeKit is a Swift package used to communicate with the [Stripe](https://stripe.com) API for Server Side Swift Apps.

Its models, routes and params are generated from [Stripe's OpenAPI spec](https://github.com/stripe/openapi), so every API operation is available and fully typed.

## Version support

Each major version of StripeKit uses one Stripe API version, as Stripe's own SDKs do:

| Stripe API version | StripeKit |
|---|---|
| `2026-10-28.endive` | 27.x |
| `2022-11-15` | 26.x |

New Stripe API versions arrive as a new major version. Fixes and additions that don't break your code arrive as minor and patch versions, so `from: "27.0.0"` stays on this API version.

## Installation
To start using StripeKit, in your `Package.swift`, add the following

```swift
.package(url: "https://github.com/vapor-community/stripe-kit.git", from: "27.0.0")
```

and add it to your target:

```swift
.product(name: "StripeKit", package: "stripe-kit")
```

**Requirements:** Swift 6.0+; macOS 14+, iOS 15+, tvOS 15+, watchOS 8+ or Linux

## Using the API
Initialize the `StripeClient`

```swift
let stripe = StripeClient.live(httpClient: .shared, apiKey: "sk_12345")
```

And now you have access to the APIs via `stripe`. Each API has a property on the client, named like its path: `stripe.charges` for `/v1/charges`, `stripe.terminal.readers` for `/v1/terminal/readers`.

```swift
let charge = try await stripe.charges.create(.init(amount: 2500,
                                                   currency: "usd",
                                                   description: "A server written in swift.",
                                                   source: "tok_visa"))
if charge.status == .succeeded {
    print("New swift servers are on the way 🚀")
} else {
    print("Sorry you have to use Node.js 🤢")
}
```

### Calling routes
Each operation is a method with argument labels and defaults, following Stripe's SDKs (`retrieve(id, params, options)`).

The first path parameter is unlabeled, others are labeled:

```swift
let customer = try await stripe.customers.retrieve("cus_1234")
let paymentMethod = try await stripe.customers.retrievePaymentMethod("cus_1234", paymentMethod: "pm_1234")
```

Params are typed structs. When none of their fields are required, they can be left out:

```swift
let customer = try await stripe.customers.create()
let updated = try await stripe.customers.update("cus_1234", .init(email: "jane@example.com"))
```

Every method ends with `options:` for the [connected account](#connected-accounts-the-stripe-account-header) and [idempotency key](#idempotent-requests).

### Params
Nested params are typed too, named after the resource and field, and shared by every endpoint that takes the same shape (as in Stripe's own SDKs):

```swift
var params = CustomerCreateParams()
params.email = "jane@example.com"
params.metadata = ["source": "ios_app"]
params.invoiceSettings = CustomerInvoiceSettings(defaultPaymentMethod: "pm_1234")

let customer = try await stripe.customers.create(params)
```

Where endpoints take a field in different shapes, the type includes the action, e.g. `CustomerCreateTax`.

### Listing and searching
List params are typed as well. Range filters such as `created` take a `StripeRangeQuery`:

```swift
let customers = try await stripe.customers.list(.init(created: .range(gte: 1_700_000_000), limit: 10))
for customer in customers.data {
    print(customer.id)
}
```

```swift
let results = try await stripe.customers.search(.init(query: "email:'jane@example.com'"))
print(results.data.count, results.nextPage ?? "last page")
```

### Namespaced APIs
APIs under a namespace are grouped like their paths, and their types always carry the namespace in their name:

```swift
let readers: TerminalReaderList = try await stripe.terminal.readers.list()
let calculation: TaxCalculation = try await stripe.tax.calculations.retrieve("taxcalc_1234")
```

## Expandable objects

StripeKit supports [expandable objects](https://docs.stripe.com/api/expanding_objects) via 2 property wrappers:

`@Expandable` and `@ExpandableCollection`

A field's value (`paymentIntent.paymentMethod`) is the object's ID, and its projected value (`paymentIntent.$paymentMethod`) is the expanded object. Expand with Stripe's field names (`payment_method`, not `paymentMethod`): a params struct has an `expand` field, and routes without params take `expand:`.

### Usage with `@Expandable`:
1. Expanding a single field.
```swift
// Expanding the payment method when creating a `PaymentIntent`.
let paymentIntent = try await stripe.paymentIntents.create(.init(amount: 2500, currency: "usd", expand: ["payment_method"], paymentMethod: "pm_card_visa"))
// Accessing the expanded `PaymentMethod` object
paymentIntent.$paymentMethod?.card?.last4 // "4242"
```

2. Expanding multiple fields.
```swift
let paymentIntent = try await stripe.paymentIntents.retrieve("pi_1234", .init(expand: ["customer", "payment_method"]))
// Accessing the expanded `Customer` (it can be a deleted one, see below)
paymentIntent.$customer?.object?.email // "stripe@example.com"
// Accessing the expanded `PaymentMethod`
paymentIntent.$paymentMethod?.card?.last4 // "4242"
```

3. Expanding nested fields.
```swift
let paymentIntent = try await stripe.paymentIntents.retrieve("pi_1234", .init(expand: ["payment_method.customer"]))
// Accessing the nested expanded `Customer` object
paymentIntent.$paymentMethod?.$customer?.email // "stripe@example.com"
```

4. Usage with list all.
> Note: For list operations [expanded fields must start with `data`](https://docs.stripe.com/api/expanding_objects)
```swift
let list = try await stripe.paymentIntents.list(.init(expand: ["data.customer"]))
// Accessing the first `PaymentIntent`'s expanded `Customer`
list.data.first?.$customer?.object?.email // "stripe@example.com"
```

### Deleted objects
Where Stripe can expand a field to a deleted object (a customer that was deleted since), the expanded value is an `ObjectOrDeleted`:

```swift
let charge = try await stripe.charges.retrieve("ch_1234", expand: ["customer"])

switch charge.$customer {
case .object(let customer)?: print(customer.email ?? "")
case .deleted(let deleted)?: print("\(deleted.id) was deleted")
case nil: break  // not expanded
}
```

Routes do the same where the spec says they can return a deleted object:

```swift
switch try await stripe.customers.retrieve("cus_1234") {
case .object(let customer): print(customer.email ?? "")
case .deleted(let deleted): print("\(deleted.id) was deleted")
}
```

### Usage with `@ExpandableCollection`:
1. Expanding an array of `id`s

```swift
let invoice = try await stripe.invoices.retrieve("in_12345", expand: ["discounts"])

// Access the discounts array as `String`s (when not expanded)
invoice.discounts?.forEach { print($0) } // "di_1", "di_2", ...

// Access the array of expanded `Discount`s (a discount can be a deleted one)
invoice.$discounts?.compactMap(\.object?.id).forEach { print($0) } // "di_1", "di_2", ...
```

## Enums and values Stripe adds later
Stripe adds enum values, such as new payment method types and error codes, without a new API version. So StripeKit's enums are open: each holds its raw value, with a static member per value Stripe documents.

```swift
switch paymentMethod.type {
case .card: print("A card")
case .sepaDebit: print("A SEPA Direct Debit")
default: print("Another payment method type: \(paymentMethod.type.rawValue)")
}
```

A value this version of StripeKit doesn't list still decodes instead of failing the response, and you can send one with `.init(rawValue: "new_value")`.

## Clearing fields
Stripe clears a field you send empty, where its API allows it. Params structs with such fields have a `clear(_:)` listing exactly those fields:

```swift
var params = CustomerUpdateParams(name: "Jane")
params.clear(.shipping)    // shipping=
params.clear(.metadata)    // metadata=
let customer = try await stripe.customers.update("cus_1234", params)
```

## Connected accounts: the Stripe-Account header
To make a request as a connected account, pass its ID as the `Stripe-Account` header with the request. (This isn't the `on_behalf_of` param some endpoints take.)

```swift
let refund = try await stripe.refunds.create(.init(charge: "ch_12345", reason: .requestedByCustomer),
                                             options: .init(stripeAccount: "acct_12345"))
```

Or scope a whole client to the account:

```swift
let connected = stripe.onBehalfOf("acct_12345")
let balance = try await connected.balances.retrieve()
```

## Idempotent Requests
Pass a new [idempotency key](https://docs.stripe.com/api/idempotent_requests) with a request so it's safe to retry:

```swift
let key = UUID().uuidString
let refund = try await stripe.refunds.create(.init(charge: "ch_12345"), options: .init(idempotencyKey: key))
```

## Retries
Like Stripe's own SDKs, requests are retried up to 2 times, with exponential backoff (0.5s, doubling, up to 5s, with jitter), after a network error or a response Stripe marks retryable: its `Stripe-Should-Retry` header when present, otherwise a 409 or a 5xx. A `Retry-After` of up to 60 seconds is honoured. POSTs get a generated idempotency key unless you pass your own, so a retry can't perform one twice.

```swift
let stripe = StripeClient.live(httpClient: .shared, apiKey: "sk_12345", maxNetworkRetries: 3)  // 0 turns retries off
```

## File uploads

```swift
let file = try await stripe.files.create(file: imageData,
                                         fileName: "receipt.png",
                                         mimeType: "image/png",
                                         purpose: "dispute_evidence")
```

## Errors
API errors are thrown as a `StripeError`:

```swift
do {
    let charge = try await stripe.charges.create(.init(amount: 2500, currency: "usd", source: "tok_chargeDeclined"))
} catch let error as StripeError {
    switch error.error?.type {
    case .cardError:
        print("Card declined: \(error.error?.message ?? "")")
        print("Decline code: \(error.error?.declineCode ?? "")")
    case .invalidRequestError:
        print("Bad request: \(error.error?.param ?? ""), \(error.error?.message ?? "")")
    default:
        print("Stripe error: \(error.error?.code?.rawValue ?? ""), \(error.error?.message ?? "")")
    }
}
```

## Webhooks
`StripeEvent.verify` checks a webhook's signature and decodes the event. Here's an example of listening for the payment intent webhook with Vapor:

```swift
func handleStripeWebhooks(req: Request) async throws -> HTTPStatus {
    guard let signature = req.headers.first(name: "Stripe-Signature"),
          let body = req.body.data else {
        throw Abort(.badRequest)
    }

    let event = try StripeEvent.verify(payload: Data(body.readableBytesView), header: signature, secret: "whsec_1234")

    switch event.type {
    case .paymentIntentSucceeded:
        let paymentIntent = try event.data.object(as: PaymentIntent.self)
        print("Payment capture method: \(paymentIntent.captureMethod.rawValue)")
    case .customerUpdated:
        // Only the fields that changed, as raw JSON
        if let previousEmail = event.data.previousAttributes?["email"]?.stringValue {
            print("Changed email from \(previousEmail)")
        }
    default:
        break
    }
    return .ok
}
```

## Using with Vapor
StripeKit is pretty easy to use but to better integrate with Vapor these are some helpful extensions
```swift
import Vapor
import StripeKit

extension Application {
    private struct StripeKey: StorageKey {
        typealias Value = StripeClient
    }

    public var stripe: StripeClient {
        if let existing = storage[StripeKey.self] {
            return existing
        }
        guard let stripeKey = Environment.get("STRIPE_API_KEY") else {
            fatalError("STRIPE_API_KEY env var required")
        }
        let new = StripeClient.live(httpClient: http.client.shared, apiKey: stripeKey)
        storage[StripeKey.self] = new
        return new
    }
}

extension Request {
    public var stripe: StripeClient {
        application.stripe
    }
}

extension StripeSignatureError: AbortError {
    public var reason: String {
        switch self {
        case .noMatchingSignatureFound:
            return "No matching signature was found"
        case .timestampNotTolerated:
            return "Timestamp was not tolerated"
        case .unableToParseHeader:
            return "Unable to parse Stripe-Signature header"
        }
    }

    public var status: HTTPResponseStatus {
        .badRequest
    }
}
```

## Testing
Each route is a closure you can replace. `StripeClient.test` has a placeholder API key, so any route you don't replace fails rather than reaching Stripe:

```swift
var stripe = StripeClient.test

// Stub the customer create route by decoding a recorded response.
// Stripe sends dates as Unix seconds, so decode them that way.
stripe.customers.create = { params, options in
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    return try decoder.decode(Customer.self, from: customerJSON)
}
```

## Codegen

The `stripe-kit-codegen` CLI regenerates all files under `Generated/` from Stripe's OpenAPI spec. The hand-written files under `Infrastructure/` are never touched.

```bash
# Default: reads spec3.sdk.json, writes Sources/StripeKit/Generated/ and Tests/StripeKitTests/Generated/
swift run stripe-kit-codegen

# Custom paths
swift run stripe-kit-codegen --spec path/to/spec3.sdk.json --output Sources/StripeKit --tests-output Tests/StripeKitTests
```

### Updating to a new API version

```bash
# 1. Download the latest spec
curl -o spec3.sdk.json https://raw.githubusercontent.com/stripe/openapi/master/openapi/spec3.sdk.json

# 2. Regenerate
swift run stripe-kit-codegen

# 3. Test, review and commit
swift test
git diff Sources/StripeKit/Generated/
git add -A && git commit -m "Update to Stripe API vXXXX-XX-XX"
```

## License
StripeKit is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
