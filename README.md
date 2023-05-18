# StripeKit
![](https://img.shields.io/badge/Swift-5.2-lightgrey.svg?style=svg)
![](https://img.shields.io/badge/SwiftNio-2-lightgrey.svg?style=svg)
![Test](https://github.com/vapor-community/stripe-kit/workflows/Test/badge.svg)

### StripeKit is a Swift package used to communicate with the [Stripe](https://stripe.com) API for Server Side Swift Apps.

## Version support
**You can check the [CHANGELOG](https://github.com/vapor-community/stripe-kit/blob/master/CHANGELOG.md) to see which version of StripeKit meets your needs.**

## Installation
To start using StripeKit, in your `Package.swift`, add the following

```swift
.package(url: "https://github.com/vapor-community/stripe-kit.git", from: "16.0.0")
```

## Using the API
Initialize the `StripeClient`

```swift
let httpClient = HTTPClient(..)
let stripe = StripeClient(httpClient: httpClient, eventLoop: eventLoop, apiKey: "sk_12345")
```

And now you have acess to the APIs via `stripe`.

The APIs you have available correspond to what's implemented.

For example to use the `charges` API, the stripeclient has a property to access that API via routes.

```swift
 stripe.charges.create(amount: 2500,
                       currency: .usd,
		               description: "A server written in swift.",
                       source: "tok_visa").flatMap { (charge) -> EventLoopFuture<Void> in
                          if charge.status == .succeeded {
                              print("New servers are on the way 🚀")
                          } else {
                              print("Sorry you have to use Node.js 🤢")
                          }
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
stripeclient.paymentIntents.create(amount: 2500, currency: .usd, expand: ["customer"])
.flatMap { paymentIntent in
// Accessing the expanded `StripeCustomer` object   
 paymentIntent.$customer.email
...
}
```

2. Expanding multiple fields.
```swift
// Expanding a customer and payment method from creating a `PaymentIntent`.
stripeclient.paymentIntents.create(amount: 2500, currency: .usd, expand: ["customer", "paymentMethod"])
.flatMap { paymentIntent in
// Accessing the expanded `StripeCustomer` object   
 paymentIntent.$customer?.email // "stripe@example.com"
// Accessing the expanded `StripePaymentMethod` object
 paymentIntent.$paymentMethod?.card?.last4 // "1234"
 ...
}
```

3. Expanding nested fields.
```swift
// Expanding a payment method and its nested customer from creating a `PaymentIntent`.
stripeclient.paymentIntents.create(amount: 2500, currency: .usd, expand: ["paymentMethod.customer"])
.flatMap { paymentIntent in
// Accessing the expanded `StripePaymentMethod` object
 paymentIntent.$paymentMethod?.card?.last4 // "1234"
// Accessing the nested expanded `StripeCustomer` object   
 paymentIntent.$paymentMethod?.$customer?.email // "stripe@example.com"
 ...
}
```

4. Usage with list all. 
> Note: For list operations [expanded fields must start with `data`](https://stripe.com/docs/api/expanding_objects?lang=curl)
```swift
// Expanding a customer from listing all `PaymentIntent`s.
stripeclient.paymentIntents.listAll(filter: ["expand": ["data.customer"...]])
.flatMap { list in
 // Accessing the first `StripePaymentIntent`'s expanded `StripeCustomer` property
  list.data?.first?.$customer?.email // "stripe@example.com"
}
```

### Usage with `@DynamicExpandable`:

Some objects in stripe can be expanded into different objects.
For example:

A `StripeApplicationFee` has an `originatingTransaction` property that can be expanded into either a [charge or a transfer](https://stripe.com/docs/api/application_fees/object#application_fee_object-originating_transaction).

When expanding it you can specify which object you expect by doing the following:

```swift
stripeclient.applicationFees.retrieve(fee: "fee_1234", expand: ["originatingTransaction"])
.flatMap { applicationfee in 
    // Access the originatingTransaction as a StripeCharge
    applicationfee.$originatingTransaction(as: StripeCharge.self)?.amount // 2500
    ...
    // Access the originatingTransaction as a StripeTransfer
    applicationfee.$originatingTransaction(as: StripeTransfer.self)?.destination // acc_1234
}
```

### Usage with `@ExpandableCollection`:
1. Expanding an array of `id`s 

```swift
stripeClient.retrieve(invoice: "in_12345", expand: ["discounts"])
.flatMap { invoice in
    // Access the discounts array as `String`s
    invoice.discounts.map { print($0) } // "","","",..
    
    // Access the array of `StripeDiscount`s
    invoice.$discounts.compactMap(\.id).map { print($0) } // "di_1","di_2","di_3",...  
}
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

    stripe.connectAccounts.create(type: .custom,									
                                  country: "US",
				  email: "a@example.com",
				  businessType: .individual,
			          defaultCurrency: .usd,
				  externalAccount: "bank_token",
			          individual: individual,
				  requestedCapabilities: ["platform_payments"],
				  settings: businessSettings,
				  tosAcceptance: tosDictionary).flatMap { connectAccount in
					print("New Stripe Connect account ID: \(connectAccount.id)")			
				}
```

## Authentication via the Stripe-Account header
The first, preferred, authentication option is to use your (the platform account’s) secret key and pass a `Stripe-Account` header identifying the connected account for which the request is being made. The example request performs a refund of a  charge on behalf of a connected account:
```swift
   stripe.refunds.headers.add(name: "Stripe-Account", value: "acc_12345")
   stripe.refunds.create(charge: "ch_12345", reason: .requestedByCustomer)
```
**NOTE:** The modified headers will remain on the route instance _(refunds in this case)_ of the `StripeClient` if a reference to it is held. If you're accessing the StripeClient in the scope of a function, the headers will not be retained.

## Error Handling
None of the API calls throw errors. Instead each route returns a successful `EventLoopFuture` or a failed `EventLoopFuture`.
```swift
 stripe.charges.create(amount: 2500,
                       currency: .usd,
		       description: "A server written in swift.",
                       source: "tok_visa")
 .flatMap { (charge) -> EventLoopFuture<Void> in
	  if charge.status == .succeeded {
	      print("New servers are on the way 🚀")
	  } else {
	      print("Sorry you have to use Node.js 🤢")
	  }
  }
  .flatMapError { error in
     print("Stripe error \(error.message)")
  }
```

## Webhooks
The webhooks API is available to use in a typesafe way to pull out entities. Here's an example of listening for the payment intent webhook.
```swift
func handleStripeWebhooks(req: Request) throws -> EventLoopFuture<HTTPResponse> {

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
        return eventLoop.makeSucceededFuture(HTTPResponse(status: .ok))
        
    default: return eventLoop.makeSucceededFuture(HTTPResponse(status: .ok))
    }
}
```

## Vapor Integration
See the [Vapor helper library](https://github.com/vapor-community/stripe) to use StripeKit with Vapor.

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

## TODO At some point
* [ ] [Idempotent Requests](https://stripe.com/docs/api/idempotent_requests)

## License
StripeKit is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Want to help?
Feel free to submit a pull request whether it's a clean up, a new approach to handling things, adding a new part of the API, or even if it's just a typo. All help is welcomed! 😀
