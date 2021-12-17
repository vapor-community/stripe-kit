# Changelog

## 16.0.0 - 2021-12-17
* [#142](https://github.com/vapor-community/stripe-kit/pull/142) ⚠️ Breaking changes ⚠️ Multiple API updates.

## 15.0.1 - 2021-11-13
* [#141](https://github.com/vapor-community/stripe-kit/pull/141) Fixes exchange rate decoding type.

## 15.0.0 - 2021-10-08
* [#140](https://github.com/vapor-community/stripe-kit/pull/140) Makes `created` on `ConnectAccount` optional.

## 14.0.0 - 2021-09-23
* [#137](https://github.com/vapor-community/stripe-kit/pull/137) 
    * Fixes expandable properties not decoding properly on swift 5.5
    * Adds better CI for Tests.
* [#138](https://github.com/vapor-community/stripe-kit/pull/138)
    * Makes StripeSessionCustomerDetails.taxIds optional.

## 13.2.0 - 2021-08-27
* [#136](https://github.com/vapor-community/stripe-kit/pull/136)
    * Added expand parameter for cloning a payment method.

## 13.1.0 - 2021-08-17
* [#134](https://github.com/vapor-community/stripe-kit/pull/134)
    * Added support for cloning a payment method.

## 13.0.0 - 2021-08-01
* [#133](https://github.com/vapor-community/stripe-kit/pull/133) 
    * ⚠️ Breaking changes ⚠️ Multiple API updates.
    * Adds support for `Quotes` and `QuoteLineItems`
    * Adds support for `VerificationSessions` and `VerificationReports`

## 12.0.2 - 2021-04-29
* [#125](https://github.com/vapor-community/stripe-kit/pull/125) Added payment method models.

* [#126](https://github.com/vapor-community/stripe-kit/pull/126) Fixed file create crash.

* [#127](https://github.com/vapor-community/stripe-kit/pull/127) Fixed expandable null value encoding.

## 12.0.0 - 2021-04-07
* [#120](https://github.com/vapor-community/stripe-kit/pull/118) ⚠️ Breaking changes ⚠️ Multiple API updates.

## 11.0.0 - 2021-02-25
* [#118](https://github.com/vapor-community/stripe-kit/pull/118) ⚠️ Breaking changes ⚠️ Multiple API updates and new support for [Customer portal configuration](https://stripe.com/docs/billing/subscriptions/integrating-customer-portal)

## 10.1.0 - 2020-11-28
* [#113](https://github.com/vapor-community/stripe-kit/pull/113) Added support for [Customer Portal](https://stripe.com/docs/api/customer_portal) API.

## 10.0.0 - 2020-11-10
* [#112](https://github.com/vapor-community/stripe-kit/pull/112) Updated to latest 2020-08-27 API version.

## 8.0.0 - 2020-07-21
* [#98](https://github.com/vapor-community/stripe-kit/pull/98) Added support for the `Price`s API.

* [#97](https://github.com/vapor-community/stripe-kit/pull/97) Updated `Subscription`s.

* [#96](https://github.com/vapor-community/stripe-kit/pull/96) Updated `Invoice`s.

* [#95](https://github.com/vapor-community/stripe-kit/pull/95) Updated `Issuing` `Transactions`.

* [#94](https://github.com/vapor-community/stripe-kit/pull/94) Updated `PaymentIntent`s.

* [#93](https://github.com/vapor-community/stripe-kit/pull/93) Added new `PaymentMethod` types and updated `Charge`s.

* [#91](https://github.com/vapor-community/stripe-kit/pull/91) Added line items for checkout sessions.

* [#90](https://github.com/vapor-community/stripe-kit/pull/90) Updated `AccountLink`s.

* [#89](https://github.com/vapor-community/stripe-kit/pull/89) Updated `ConnectAccount` and `Person` entities.

* [#88](https://github.com/vapor-community/stripe-kit/pull/88) Mark `hasMore` properties on Lists as optional.

## 7.0.2 - 2020-04-30
* [#77](https://github.com/vapor-community/stripe-kit/pull/77) Add fix for missing field on `@Expandable` properties.

## 7.0.1 - 2020-04-28
* [#75](https://github.com/vapor-community/stripe-kit/pull/75) 
    * Made payout routes public.
    * Fixed `line_items` paramater type on checkout session routes.

## 7.0.0 - 2020-04-20
* [#73](https://github.com/vapor-community/stripe-kit/pull/73) Updated Issuing API and objects to latest spec.

* [#72](https://github.com/vapor-community/stripe-kit/pull/72) Added support for [Expandable objects](https://stripe.com/docs/api/expanding_objects).


## 6.1.0 - 2020-03-26

* [#68](https://github.com/vapor-community/stripe-kit/pull/68) Fixed type mispatch for `StripeSubscriptionProrationBehavior` on subscription update route.

* [#67](https://github.com/vapor-community/stripe-kit/pull/67) Added support for webhooks signature validation.

* [#65](https://github.com/vapor-community/stripe-kit/pull/65) 
    * Made `requestedCapabilities` `Optional` on connect accounts.
    * Added `StripePaymentIntentTransferData` type for `transferData` on `StripePaymentIntent`.

## 6.0.0 - 2020-03-07
Major version release for new API version `2020-03-02`

* [#63](https://github.com/vapor-community/stripe-kit/pull/63) Added metadata support for webhook endpoints.

* [#61](https://github.com/vapor-community/stripe-kit/pull/61) Added support for `expiry_check` in Issuing Authorization.

* [#59](https://github.com/vapor-community/stripe-kit/pull/59) Added `payment_intent.processing` webhook event.

* [#57](https://github.com/vapor-community/stripe-kit/pull/57) Added `next_invoice_sequence` for `Customer`.

* [#55](https://github.com/vapor-community/stripe-kit/pull/55) Added support for listing all `Checkout Sessions`.

* [#53](https://github.com/vapor-community/stripe-kit/pull/53) Added support for `proration_behavior` on `SubscriptionSchedule`.

* [#51](https://github.com/vapor-community/stripe-kit/pull/51) Added `timezone` to `RunReportParameters`.

* [#49](https://github.com/vapor-community/stripe-kit/pull/49) Added `additional_verification` to `File`'s `purpose`.

* [#47](https://github.com/vapor-community/stripe-kit/pull/47) Added `structure` enum to `Account`'s `Company`.

* [#46](https://github.com/vapor-community/stripe-kit/pull/46) Updated `carrier` enums for `CardIssuingShipping`. Added `speed` enum for `CardIssuingShipping`.

* [#43](https://github.com/vapor-community/stripe-kit/pull/43) Added support for `CreditNoteLineItem`. Added `out_of_band_amount` to `CreditNote`. Correctly append query paramaters for `list` API calls.

* [#41](https://github.com/vapor-community/stripe-kit/pull/41) Added `metadata` to `CheckoutSession`.

* [#39](https://github.com/vapor-community/stripe-kit/pull/39) Added `proration_behavior` for subscriptions.

* [#38](https://github.com/vapor-community/stripe-kit/pull/38) Adds support for `Subscription` pending updates.

* [#36](https://github.com/vapor-community/stripe-kit/pull/36) Fixed a typo in card routes. Return the correct type for listing all cards.
