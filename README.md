# StripeKit
![](https://img.shields.io/badge/Swift-5.7-lightgrey.svg?style=svg)
![](https://img.shields.io/badge/SwiftNio-2-lightgrey.svg?style=svg)
![Test](https://github.com/vapor-community/stripe-kit/workflows/Test/badge.svg)

### StripeKit is a Swift package used to communicate with the [Stripe](https://stripe.com) API for Server Side Swift Apps.

## Version support

Stripe API version `2022-11-15` -> StripeKit: 19.0.0

## Installation
To start using StripeKit, in your `Package.swift`, add the following

```swift
.package(url: "https://github.com/vapor-community/stripe-kit.git", from: "19.0.0")
```

## Using the API
Initialize the `StripeClient`

```swift
let httpClient = HTTPClient(..)
let stripe = StripeClient(httpClient: httpClient, apiKey: "sk_12345")
```

And now you have acess to the APIs via `stripe`.

The APIs you have available correspond to what's implemented.

For example to use the `charges` API, the stripeclient has a property to access that API via routes.

```swift
do {
    let charge = try await stripe.charges.create(amount: 2500,
                                                 currency: .usd,
                                                 description: "A server written in swift.",
                                                 source: "tok_visa")
    if charge.status == .succeeded {
        print("New swift servers are on the way 🚀")
    } else {
        print("Sorry you have to use Node.js 🤢")
    }
} catch {
    // Handle error
}
```

## Expandable objects

StripeKit supports [expandable objects](https://stripe.com/docs/api/expanding_objects) via 3 property wrappers:

`@Expandable`, `@DynamicExpandable` and `@ExpandableCollection`

All API routes that can return expanded objects have an extra parameter `expand: [String]?` that allows specifying which objects to expand. 

### Usage with `@Expandable`:
1. Expanding a single field.
```swift
// Expanding a customer from creating a `PaymentIntent`.
     let paymentIntent = try await stripeclient.paymentIntents.create(amount: 2500, currency: .usd, expand: ["customer"])
     // Accessing the expanded `Customer` object
     paymentIntent.$customer.email
```

2. Expanding multiple fields.
```swift
// Expanding a customer and payment method from creating a `PaymentIntent`.
let paymentIntent = try await stripeclient.paymentIntents.create(amount: 2500, currency: .usd, expand: ["customer", "paymentMethod"])
// Accessing the expanded `StripeCustomer` object   
 paymentIntent.$customer?.email // "stripe@example.com"
// Accessing the expanded `StripePaymentMethod` object
 paymentIntent.$paymentMethod?.card?.last4 // "1234"
```

3. Expanding nested fields.
```swift
// Expanding a payment method and its nested customer from creating a `PaymentIntent`.
let paymentIntent = try await stripeclient.paymentIntents.create(amount: 2500, currency: .usd, expand: ["paymentMethod.customer"])
// Accessing the expanded `PaymentMethod` object
 paymentIntent.$paymentMethod?.card?.last4 // "1234"
// Accessing the nested expanded `Customer` object   
 paymentIntent.$paymentMethod?.$customer?.email // "stripe@example.com"
```

4. Usage with list all. 
> Note: For list operations [expanded fields must start with `data`](https://stripe.com/docs/api/expanding_objects?lang=curl)
```swift
// Expanding a customer from listing all `PaymentIntent`s.
let list = try await stripeclient.paymentIntents.listAll(filter: ["expand": ["data.customer"...]])
// Accessing the first `StripePaymentIntent`'s expanded `Customer` property
list.data?.first?.$customer?.email // "stripe@example.com"

```

### Usage with `@DynamicExpandable`:

Some objects in stripe can be expanded into different objects.
For example:

An `ApplicationFee` has an `originatingTransaction` property that can be expanded into either a [charge or a transfer](https://stripe.com/docs/api/application_fees/object#application_fee_object-originating_transaction).

When expanding it you can specify which object you expect by doing the following:

```swift
let applicationfee = try await stripeclient.applicationFees.retrieve(fee: "fee_1234", expand: ["originatingTransaction"])
// Access the originatingTransaction as a Charge
applicationfee.$originatingTransaction(as: Charge.self)?.amount // 2500
...
// Access the originatingTransaction as a Transfer
applicationfee.$originatingTransaction(as: Transfer.self)?.destination // acc_1234
```

### Usage with `@ExpandableCollection`:
1. Expanding an array of `id`s 

```swift
let invoice = try await stripeClient.retrieve(invoice: "in_12345", expand: ["discounts"])

// Access the discounts array as `String`s
invoice.discounts.map { print($0) } // "","","",..

// Access the array of `Discount`s
invoice.$discounts.compactMap(\.id).map { print($0) } // "di_1","di_2","di_3",...  
```

## Nuances with parameters and type safety
Stripe has a habit of changing APIs and having dynamic parameters for a lot of their APIs.
To accomadate for these changes, certain routes that take arguments that are `hash`s or `Dictionaries`, are represented by a Swift dictionary `[String: Any]`.

For example consider the Connect account API. 

```swift
// We define a custom dictionary to represent the paramaters stripe requires.
// This allows us to avoid having to add updates to the library when a paramater or structure changes.
let individual: [String: Any] = ["address": ["city": "New York",
					     "country": "US",
                                             "line1": "1551 Broadway",
                                             "postal_code": "10036",
	                  	             "state": "NY"],
				 "first_name": "Taylor",
			         "last_name": "Swift",
                                 "ssn_last_4": "0000",
				 "dob": ["day": "13",
					 "month": "12",
					 "year": "1989"]] 
												 
let businessSettings: [String: Any] = ["payouts": ["statement_descriptor": "SWIFTFORALL"]]

let tosDictionary: [String: Any] = ["date": Int(Date().timeIntervalSince1970), "ip": "127.0.0.1"]

let connectAccount = try await stripe.connectAccounts.create(type: .custom,									
                                  country: "US",
				  email: "a@example.com",
				  businessType: .individual,
			          defaultCurrency: .usd,
				  externalAccount: "bank_token",
			          individual: individual,
				  requestedCapabilities: ["platform_payments"],
				  settings: businessSettings,
				  tosAcceptance: tosDictionary)
print("New Stripe Connect account ID: \(connectAccount.id)")
```

## Authentication via the Stripe-Account header
The first, preferred, authentication option is to use your (the platform account’s) secret key and pass a `Stripe-Account` header identifying the connected account for which the request is being made. The example request performs a refund of a  charge on behalf of a connected account using a builder style API:
```swift
   stripe.refunds
    .addHeaders(["Stripe-Account": "acc_12345",
             "Authorization": "Bearer different_api_key",
             "Stripe-Version": "older-api-version"])
    .create(charge: "ch_12345", reason: .requestedByCustomer)
```
**NOTE:** The modified headers will remain on the route instance _(refunds in this case)_ of the `StripeClient` if a reference to it is held. If you're accessing the StripeClient in the scope of a function, the headers will not be retained.

## Idempotent Requests
Similar to the account header, you can use the same builder style API to attach Idempotency Keys to your requests.

```swift
    let key = UUID().uuidString
    stripe.refunds
    .addHeaders(["Idempotency-Key": key])
    .create(charge: "ch_12345", reason: .requestedByCustomer)
```

## Webhooks
The webhooks API is available to use in a typesafe way to pull out entities. Here's an example of listening for the payment intent webhook.
```swift
func handleStripeWebhooks(req: Request) async throws -> HTTPResponse {

    let signature = req.headers["Stripe-Signature"]

    try StripeClient.verifySignature(payload: req.body, header: signature, secret: "whsec_1234") 
    // Stripe dates come back from the Stripe API as epoch and the StripeModels convert these into swift `Date` types.
    // Use a date and key decoding strategy to successfully parse out the `created` property and snake case strpe properties. 
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    let event = try decoder.decode(StripeEvent.self, from: req.bodyData)
    
    switch (event.type, event.data?.object) {
    case (.paymentIntentSucceeded, .paymentIntent(let paymentIntent)):
        print("Payment capture method: \(paymentIntent.captureMethod?.rawValue)")
        return HTTPResponse(status: .ok)
        
    default: return HTTPResponse(status: .ok)
    }
}
```

## Using with Vapor
StripeKit is pretty easy to use but to better integrate with Vapor these are some helpful extensions
```swift
import Vapor
import StripeKit

extension Application {
    public var stripe: StripeClient {
        guard let stripeKey = Environment.get("STRIPE_API_KEY") else {
            fatalError("STRIPE_API_KEY env var required")
        }
        return .init(httpClient: self.http.client.shared, apiKey: stripeKey)
    }
}

extension Request {
    private struct StripeKey: StorageKey {
        typealias Value = StripeClient
    }
    
    public var stripe: StripeClient {
        if let existing = application.storage[StripeKey.self] {
            return existing
        } else {
            guard let stripeKey = Environment.get("STRIPE_API_KEY") else {
                fatalError("STRIPE_API_KEY env var required")
            }
            let new = StripeClient(httpClient: self.application.http.client.shared, apiKey: stripeKey)
            self.application.storage[StripeKey.self] = new
            return new
        }
    }
}

extension StripeClient {
    /// Verifies a Stripe signature for a given `Request`. This automatically looks for the header in the headers of the request and the body.
    /// - Parameters:
    ///     - req: The `Request` object to check header and body for
    ///     - secret: The webhook secret used to verify the signature
    ///     - tolerance: In seconds the time difference tolerance to prevent replay attacks: Default 300 seconds
    /// - Throws: `StripeSignatureError`
    public static func verifySignature(for req: Request, secret: String, tolerance: Double = 300) throws {
        guard let header = req.headers.first(name: "Stripe-Signature") else {
            throw StripeSignatureError.unableToParseHeader
        }
        
        guard let data = req.body.data else {
            throw StripeSignatureError.noMatchingSignatureFound
        }
        
        try StripeClient.verifySignature(payload: Data(data.readableBytesView), header: header, secret: secret, tolerance: tolerance)
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

## Whats Implemented

### Core Resources
* [x] Balance
* [x] Balance Transactions
* [x] Charges
* [x] Customers
* [x] Disputes  
* [x] Events
* [x] Files
* [x] File Links
* [x] Mandates
* [x] PaymentIntents
* [x] SetupIntents
* [x] SetupAttempts
* [x] Payouts
* [x] Refunds
* [x] Tokens
---
### Payment Methods
* [x] Payment Methods
* [x] Bank Accounts
* [x] Cash Balance
* [x] Cards
* [x] Sources
---
### Products
* [x] Products
* [x] Prices
* [x] Coupons
* [x] Promotion Codes
* [x] Discounts
* [x] Tax Codes
* [x] Tax Rates
* [x] Shipping Rates
---
### Checkout
* [x] Sessions
---
### Payment Links
* [x] Payment Links
---
### Billing
* [x] Credit Notes
* [x] Customer Balance Transactions
* [x] Customer Portal
* [x] Customer Tax IDs
* [x] Invoices
* [x] Invoice Items
* [x] Plans
* [x] Quotes
* [x] Quote Line Items
* [x] Subscriptions
* [x] Subscription items
* [x] Subscription Schedule
* [x] Test Clocks
* [x] Usage Records
---
### Connect
* [x] Account
* [x] Account Links
* [x] Account Sessions
* [x] Application Fees
* [x] Application Fee Refunds
* [x] Capabilities
* [x] Country Specs
* [x] External Accounts
* [x] Persons
* [x] Top-ups
* [x] Transfers
* [x] Transfer Reversals
* [x] Secret Management
---
### Fraud
* [x] Early Fraud Warnings
* [x] Reviews
* [x] Value Lists
* [x] Value List Items
---
### Issuing
* [x] Authorizations
* [x] Cardholders
* [x] Cards
* [x] Disputes
* [x] Funding Instructions
* [x] Transactions
---
### Terminal
* [x] Connection Tokens
* [x] Locations
* [x] Readers
* [x] Hardware Orders
* [x] Hardware Products
* [x] Hardware SKUs
* [x] Hardware Shipping Methods
* [x] Configurations
---
### Sigma
* [x] Scheduled Queries
---
### Reporting
* [x] Report Runs
* [x] Report Types
---
### Identity
* [x] VerificationSessions
* [x] VerificationReports
---
### Webhooks
* [x] Webhook Endpoints
* [x] Signature Verification

## Idempotent Requests
* [x] [Idempotent Requests](https://stripe.com/docs/api/idempotent_requests)

## License
StripeKit is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
