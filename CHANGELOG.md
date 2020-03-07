# Changelog

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

