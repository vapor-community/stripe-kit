# StripeKit
![](https://img.shields.io/badge/Swift-5-lightgrey.svg?style=svg)
![](https://img.shields.io/badge/SwiftNio-2-lightgrey.svg?style=svg)

### StripeKit is a Swift package used to communicate with the [Stripe](https://stripe.com) API for Server Side Swift Apps.

## Current supported version
Version **2.0.0** of StripeKit supports the Stripe API version of **[2019-11-05](https://stripe.com/docs/upgrades#2019-11-05)**. 
**You can check the releases page to use a version of StripeKit that meets your needs.**

## Installation
To start using StripeKit, in your `Package.swift`, add the following

~~~~swift
.package(url: "https://github.com/vapor-community/stripekit.git", from: "2.0.0")
~~~~

## Using the API
Initialize the `StripeClient`

~~~~swift
let elg = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
let stripe = StripeClient(eventLoop: elg, apiKey: "sk_12345")
~~~~

And now you have acess to the APIs via `stripe`.

The APIs you have available corrospond to what's implemented.

For example to use the `charges` API, the stripeclient has a property to access that API via routes.

~~~~swift
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
~~~~

## Nuances with parameters and type safety
Stripe has a habit of changing APIs and having dynamic paramters for alot of their APIs.
To accomadate for these changes, certain routes that take arguments that are `hash`s or `Dictionaries`, are represented by a swift dictionary `[String: Any]`.

For example consider the connect account api. 

~~~~swift
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
~~~~

## Authentication via the Stripe-Account header
The first, preferred, authentication option is to use your (the platform account’s) secret key and pass a `Stripe-Account` header identifying the connected account for which the request is being made. The example request performs a refund of a  charge on behalf of a connected account:
~~~swift
   stripe.refunds.headers.add(name: "Stripe-Account", value: "acc_12345")
   stripe.refunds.create(charge: "ch_12345", reason: .requestedByCustomer)
~~~
**NOTE:** The modified headers will remain on the route instance _(refunds in this case)_ of the `StripeClient` if a reference to it is held. If you're accessing the StripeClient in the scope of a function, the headers will not be retained.

## Error Handling
None of the API calls throw errors. Instead each route returns a successful `EventLoopFuture` or a failed `EventLoopFuture`.
~~~swift
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
~~~

## Whats Implemented

### Core Resources
* [x] Balance
* [x] Balance Transactions
* [x] Charges
* [x] Customers
* [x] Disputes  
* [ ] Events
* [x] Files
* [x] File Links
* [x] Mandates
* [x] PaymentIntents
* [x] SetupIntents
* [x] Payouts
* [x] Products
* [x] Refunds
* [x] Tokens
---
### Payment Methods
* [x] Payment Methods
* [x] Bank Accounts
* [x] Cards
* [x] Sources
---
### Checkout
* [x] Sessions
---
### Billing
* [x] Coupons
* [x] Credit Notes
* [x] Customer Balance Transactions
* [x] Customer Tax IDs
* [x] Discounts
* [x] Invoices
* [x] Invoice Items
* [x] Plans
* [x] Products
* [x] Subscriptions
* [x] Subscription items
* [x] Tax Rates
* [x] Usage Records
---
### Connect
* [x] Account
* [x] Account Links
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
* [x] Transactions
---
### Terminal
* [x] Connection Tokens
* [x] Locations
* [x] Readers
---
### Orders
* [x] Orders
* [x] Order Items
* [x] Returns
* [x] SKUs
* [x] Ephemeral Keys
---
### Sigma
* [x] Scheduled Queries
---
### Reporting
* [x] Report Runs
* [ ] Report Types
---
### Webhooks
* [ ] Webhook Endpoints


## TODO At some point
* [ ] [Object expansion](https://stripe.com/docs/api/expanding_objects)
* [ ] [Idempotent Requests](https://stripe.com/docs/api/idempotent_requests)

## License
StripeKit is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Want to help?
Feel free to submit a pull request whether it's a clean up, a new approach to handling things, adding a new part of the API, or even if it's just a typo. All help is welcomed! 😀
