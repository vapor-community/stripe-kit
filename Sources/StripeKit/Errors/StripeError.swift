//
//  StripeError.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Foundation

/// Stripe uses conventional HTTP response codes to indicate the success or failure of an API request. In general: Codes in the `2xx` range indicate success. Codes in the `4xx` range indicate an error that failed given the information provided (e.g., a required parameter was omitted, a charge failed, etc.). Codes in the `5xx` range indicate an error with Stripe's servers (these are rare).
/// Some `4xx` errors that could be handled programmatically (e.g., a card is declined) include an error code that briefly explains the error reported.
public final class StripeError: StripeModel, Error {
    public var error: _StripeError?
}

public final class _StripeError: StripeModel {
    /// The type of error returned. One of `api_connection_error`, `api_error`, `authentication_error`, `card_error`, `idempotency_error`, `invalid_request_error`, or `rate_limit_error`
    public var type: StripeErrorType?
    /// For card errors, the ID of the failed charge.
    public var charge: String?
    /// For some errors that could be handled programmatically, a short string indicating the error code reported.
    public var code: StripeErrorCode?
    /// For card errors resulting from a card issuer decline, a short string indicating the [card issuer’s reason for the decline](https://stripe.com/docs/declines#issuer-declines) if they provide one.
    public var declineCode: StripeDeclineCode?
    /// A URL to more information about the error code reported.
    public var docUrl: String?
    /// A human-readable message providing more details about the error. For card errors, these messages can be shown to your users.
    public var message: String?
    /// If the error is parameter-specific, the parameter related to the error. For example, you can use this to display a message near the correct form field.
    public var param: String?
    /// The PaymentIntent object for errors returned on a request involving a PaymentIntent.
    public var paymentIntent: StripePaymentIntent?
    /// The PaymentMethod object for errors returned on a request involving a PaymentMethod.
    public var paymentMethod: StripePaymentMethod?
    /// The source object for errors returned on a request involving a source.
    public var source: StripeSource?
}

// https://stripe.com/docs/api#errors-type
public enum StripeErrorType: String, StripeModel {
    /// Failure to connect to Stripe's API.
    case apiConnectionError = "api_connection_error"
    /// API errors cover any other type of problem (e.g., a temporary problem with Stripe's servers), and are extremely uncommon
    case apiError = "api_error"
    /// Failure to properly authenticate yourself in the request.
    case authenticationError = "authentication_error"
    /// Card errors are the most common type of error you should expect to handle. They result when the user enters a card that can't be charged for some reason.
    case cardError = "card_error"
    /// Idempotency errors occur when an Idempotency-Key is re-used on a request that does not match the first request's API endpoint and parameters.
    case idempotencyError = "idempotency_error"
    /// Invalid request errors arise when your request has invalid parameters.
    case invalidRequestError = "invalid_request_error"
    /// Too many requests hit the API too quickly.
    case rateLimitError = "rate_limit_error"
    /// Errors triggered by our client-side libraries when failing to validate fields (e.g., when a card number or expiration date is invalid or incomplete).
    case validationError = "validation_error"
}

// https://stripe.com/docs/api#errors-code
// https://stripe.com/docs/error-codes
public enum StripeErrorCode: String, StripeModel {
    /// The email address provided for the creation of a deferred account already has an account associated with it. Use the OAuth flow to connect the existing account to your platform.
    case accountAlreadyExists = "account_already_exists"
    /// The country of the business address provided does not match the country of the account. Businesses must be located in the same country as the account.
    case accountCountryInvalidAddress = "account_country_invalid_address"
    /// The account ID provided as a value for the Stripe-Account header is invalid. Check that your requests are specifying a valid account ID.
    case accountInvalid = "account_invalid"
    /// The bank account number provided is invalid (e.g., missing digits). Bank account information varies from country to country. We recommend creating validations in your entry forms based on the bank account formats we provide.
    case accountNumberInvalid = "account_number_invalid"
    /// This method for creating Alipay payments is not supported anymore. Please upgrade your integration to use Sources instead.
    case alipayUpgradeRequired = "alipay_upgrade_required"
    /// The specified amount is greater than the maximum amount allowed. Use a lower amount and try again.
    case amountTooLarge = "amount_too_large"
    /// The specified amount is less than the minimum amount allowed. Use a higher amount and try again
    case amountTooSmall = "amount_too_small"
    /// The API key provided has expired. Obtain your current API keys from the Dashboard and update your integration to use them.
    case apiKeyExpired = "api_key_expired"
    /// The latest authentication attempt for the AuthenticationIntent has failed. Check the `last_authentication_error` property on the AuthenticationIntent for more details, and provide a new payment method to attempt to authenticate again.
    case balanceInsufficient = "balance_insufficient"
    /// The transfer or payout could not be completed because the associated account does not have a sufficient balance available. Create a new transfer or payout using an amount less than or equal to the account’s available balance.
    case bankAccountExists = "bank_account_exists"
    /// The bank account provided already exists on the specified Customer object. If the bank account should also be attached to a different customer, include the correct customer ID when making the request again.
    case bankAccountUnusable = "bank_account_unsuable"
    /// The bank account provided cannot be used for payouts. A different bank account must be used.
    case bankAccountUnverified = "bank_account_unverified"
    /// This method for creating Bitcoin payments is not supported anymore. Please upgrade your integration to use Sources instead.
    case bitcoinUpgradeRequired = "bitcoin_upgrade_required"
    /// The card has been declined. When a card is declined, the error returned also includes the decline_code attribute with the reason why the card was declined. Refer to our decline codes documentation to learn more.
    case cardDeclined = "card_declined"
    /// The charge you’re attempting to capture has already been captured. Update the request with an uncaptured charge ID.
    case chargeAlreadyCaptured = "charge_already_captured"
    /// The charge you’re attempting to refund has already been refunded. Update the request to use the ID of a charge that has not been refunded.
    case chargeAlreadyRefunded = "charge_already_refunded"
    /// The charge you’re attempting to refund has been charged back. Check the disputes documentation to learn how to respond to the dispute.
    case chargeDisputed = "charge_disputed"
    /// This charge would cause you to exceed your rolling-window processing limit for this source type. Please retry the charge later, or contact us to request a higher processing limit.
    case chargeExceedsSourceLimit = "charge_exceeds_source_limit"
    /// The charge cannot be captured as the authorization has expired. Auth and capture charges must be captured within seven days.
    case chargeExpiredForCapture = "charge_expired_for_capture"
    /// Your platform attempted to create a custom account in a country that is not yet supported. Make sure that users can only sign up in countries supported by custom accounts.
    case countryUnsupported = "country_unsupported"
    /// The coupon provided for a subscription or order has expired. Either create a new coupon, or use an existing one that is valid.
    case couponExpired = "coupon_expired"
    /// The maximum number of subscriptions for a customer has been reached. Contact us if you are receiving this error.
    case customerMaxSubscriptions = "customer_max_subscriptions"
    /// The email address is invalid (e.g., not properly formatted). Check that the email address is properly formatted and only includes allowed characters.
    case emailInvalid = "email_invalid"
    /// The card has expired. Check the expiration date or use a different card.
    case expiredCard = "expired_card"
    /// The idempotency key provided is currently being used in another request. This occurs if your integration is making duplicate requests simultaneously.
    case idempotencyKeyInUse =  "idempotency_key_in_use"
    /// The card’s address is incorrect. Check the card’s address or use a different card.
    case incorrectAddress = "incorrect_address"
    /// The card’s security code is incorrect. Check the card’s security code or use a different card.
    case incorrectCVC = "incorrect_cvc"
    /// The card number is incorrect. Check the card’s number or use a different card.
    case incorrectNumber = "incorrect_number"
    /// The card’s ZIP code is incorrect. Check the card’s ZIP code or use a different card.
    case incorrectZip = "incorrect_zip"
    /// The debit card provided as an external account does not support instant payouts. Provide another debit card or use a bank account instead.
    case instantPayoutUnsupported = "instant_payouts_unsupported"
    /// The card provided as an external account is not a debit card. Provide a debit card or use a bank account instead.
    case invalidCardType = "invalid_card_type"
    /// The specified amount is invalid. The charge amount must be a positive integer in the smallest currency unit, and not exceed the minimum or maximum amount.
    case invalidChargeAmount = "invalid_charge_amount"
    /// The card’s security code is invalid. Check the card’s security code or use a different card.
    case invalidCVC = "invalid_cvc"
    /// The card’s expiration month is incorrect. Check the expiration date or use a different card.
    case invalidExpiryMonth = "invalid_expiry_month"
    /// The card’s expiration year is incorrect. Check the expiration date or use a different card.
    case invalidExpiryYear = "invalid_expiry_year"
    /// The card number is invalid. Check the card details or use a different card.
    case invalidNumber = "invalid_number"
    /// The source cannot be used because it is not in the correct state (e.g., a charge request is trying to use a source with a pending, failed, or consumed source). Check the status of the source you are attempting to use.
    case invalidSourceUsage = "invalid_source_usage"
    /// An invoice cannot be generated for the specified customer as there are no pending invoice items. Check that the correct customer is being specified or create any necessary invoice items first.
    case invoiceNoCustomerLineItems = "invoice_no_customer_line_items"
    /// An invoice cannot be generated for the specified subscription as there are no pending invoice items. Check that the correct subscription is being specified or create any necessary invoice items first.
    case invoiceNoSubscriptionLineItems = "invoice_no_subscription_line_items"
    /// The specified invoice can no longer be edited. Instead, consider creating additional invoice items that will be applied to the next invoice. You can either manually generate the next invoice or wait for it to be automatically generated at the end of the billing cycle.
    case invoiceNotEditable = "invoice_not_editable"
    /// There is no upcoming invoice on the specified customer to preview. Only customers with active subscriptions or pending invoice items have invoices that can be previewed.
    case invoiceUpcomingNone = "invoice_upcoming_none"
    /// Test and live mode API keys, requests, and objects are only available within the mode they are in.
    case livemodeMismatch = "livemode_mismatch"
    /// Both a customer and source ID have been provided, but the source has not been saved to the customer. To create a charge for a customer with a specified source, you must first save the card details.
    case missing
    /// Transfers and payouts on behalf of a Standard connected account are not allowed.
    case notAllowedOnStandardAccount = "not_allowed_on_standard_account"
    /// The order could not be created. Check the order details and then try again.
    case orderCreationFailed = "order_creation_failed"
    /// The order could not be processed as it is missing required information. Check the information provided and try again.
    case orderRequiredSettings = "order_required_settings"
    /// The order cannot be updated because the status provided is either invalid or does not follow the order lifecycle (e.g., an order cannot transition from created to fulfilled without first transitioning to paid).
    case orderStatusInvalid = "order_status_invalid"
    /// The request timed out. Try again later.
    case orderUpstreamTimeout = "order_upstream_timeout"
    /// The SKU is out of stock. If more stock is available, update the SKU’s inventory quantity and try again.
    case outOfInventory = "out_of_inventory"
    /// One or more required values were not provided. Make sure requests include all required parameters.
    case parameterInvalidEmpty = "parameter_invalid_empty"
    /// One or more of the parameters requires an integer, but the values provided were a different type. Make sure that only supported values are provided for each attribute. Refer to our API documentation to look up the type of data each attribute supports.
    case parameterInvalidInteger = "parameter_invalid_integer"
    /// One or more values provided only included whitespace. Check the values in your request and update any that contain only whitespace.
    case parameterInvalidStringBlank = "parameter_invalid_string_blank"
    /// One or more required string values is empty. Make sure that string values contain at least one character.
    case parameterInvalidStringEmpty = "parameter_invalid_string_empty"
    /// One or more required values are missing. Check our API documentation to see which values are required to create or modify the specified resource.
    case parameterMissing = "parameter_missing"
    /// The request contains one or more unexpected parameters. Remove these and try again.
    case parameterUnknown = "parameter_unknown"
    /// Two or more mutually exclusive parameters were provided. Check our API documentation or the returned error message to see which values are permitted when creating or modifying the specified resource.
    case parametersExclusive = "parameters_exclusive"
    /// The provided payment method has failed authentication. Provide a new payment method to attempt to fulfill this PaymentIntent again.
    case paymentIntentAuthenticationFailure = "payment_intent_authentication_failure"
    /// The PaymentIntent expected a payment method with different properties than what was provided.
    case paymentIntentIncompatiblePaymentMethod = "payment_intent_incompatible_payment_method"
    /// One or more provided parameters was not allowed for the given operation on the PaymentIntent. Check our API reference or the returned error message to see which values were not correct for that PaymentIntent.
    case paymentIntentInvalidParameter = "payment_intent_invalid_parameter"
    /// The latest payment attempt for the PaymentIntent has failed. Check the `last_payment_error` property on the PaymentIntent for more details, and provide source_data or a new source to attempt to fulfill this PaymentIntent again.
    case paymentIntentPaymentAttemptFailed = "payment_intent_payment_attempt_failed"
    /// The PaymentIntent’s state was incompatible with the operation you were trying to perform.
    case paymentIntentUnexpectedState = "payment_intent_unexpected_state"
    /// The charge cannot be created as the payment method used has not been activated. Activate the payment method in the Dashboard, then try again.
    case paymentMethodUnactivated = "payment_method_unactivated"
    /// The provided payment method’s state was incompatible with the operation you were trying to perform. Confirm that the payment method is in an allowed state for the given operation before attempting to perform it.
    case paymentMethodUnexpectedState = "payment_method_unexpected_state"
    /// Payouts have been disabled on the connected account. Check the connected account’s status to see if any additional information needs to be provided, or if payouts have been disabled for another reason.
    case payoutsNotAllowed = "payouts_not_allowed"
    /// The API key provided by your Connect platform has expired. This occurs if your platform has either generated a new key or the connected account has been disconnected from the platform. Obtain your current API keys from the Dashboard and update your integration, or reach out to the user and reconnect the account.
    case platformApiKeyExpired = "platform_api_key_expired"
    /// The ZIP code provided was incorrect.
    case postalCodeInvalid = "postal_code_invalid"
    /// An error occurred while processing the card. Check the card details are correct or use a different card.
    case processingError = "processing_error"
    /// The product this SKU belongs to is no longer available for purchase.
    case productInactive = "product_inactive"
    /// Too many requests hit the API too quickly. We recommend an exponential backoff of your requests.
    case rateLimit = "rate_limit"
    /// A resource with a user-specified ID (e.g., plan or coupon) already exists. Use a different, unique value for id and try again.
    case resourceAlreadyExists = "resource_already_exists"
    /// The ID provided is not valid. Either the resource does not exist, or an ID for a different resource has been provided.
    case resourceMissing = "resource_missing"
    /// The bank routing number provided is invalid.
    case routingNumberInvalid = "routing_number_invalid"
    /// The API key provided is a publishable key, but a secret key is required. Obtain your current API keys from the Dashboard and update your integration to use them.
    case secretKeyRequired = "secret_key_required"
    /// Your account does not support SEPA payments.
    case sepaUnsupportedAccount = "sepa_unsupported_account"
    /// Shipping calculation failed as the information provided was either incorrect or could not be verified.
    case shippingCalculationFailed = "shipping_calculation_failed"
    /// The SKU is inactive and no longer available for purchase. Use a different SKU, or make the current SKU active again.
    case skuInactive = "sku_inactive"
    /// Occurs when providing the `legal_entity` information for a U.S. custom account, if the provided state is not supported. (This is mostly associated states and territories.)
    case stateUnsupported = "state_unsupported"
    /// The tax ID number provided is invalid (e.g., missing digits). Tax ID information varies from country to country, but must be at least nine digits.
    case taxIdInvalid = "tax_id_invalid"
    /// Tax calculation for the order failed.
    case taxesCalculationFailed = "taxes_calculation_failed"
    /// Your account has not been activated and can only make test charges. Activate your account in the Dashboard to begin processing live charges.
    case testmodeChargesOnly = "testmode_charges_only"
    /// Your integration is using an older version of TLS that is unsupported. You must be using TLS 1.2 or above
    case tlsVersionUnsupported = "tls_version_unsupported"
    /// The token provided has already been used. You must create a new token before you can retry this request.
    case tokenAlreadyUsed = "token_already_used"
    /// The token provided is currently being used in another request. This occurs if your integration is making duplicate requests simultaneously.
    case tokenInUse = "token_in_use"
    /// The requested transfer cannot be created. Contact us if you are receiving this error.
    case transfersNotAllowed = "transfers_not_allowed"
    /// The order could not be created. Check the order details and then try again.
    case upstreamOrderCreationFailed = "upstream_order_creation_failed"
    /// The URL provided is invalid.
    case urlInvalid = "url_invalid"
}

// https://stripe.com/docs/api#errors-decline-code
// https://stripe.com/docs/declines/codes
public enum StripeDeclineCode: String, StripeModel {
    /// The payment cannot be authorized.
    case approveWithId = "approve_with_id"
    /// The card has been declined for an unknown reason.
    case callIssuer = "call_issuer"
    /// The card does not support this type of purchase.
    case cardNotSupported = "card_not_supported"
    /// The customer has exceeded the balance or credit limit available on their card.
    case cardVelocityExceeded = "card_velocity_exceeded"
    /// The card does not support the specified currency.
    case currencyNotSupported = "currency_not_supported"
    /// The card has been declined for an unknown reason.
    case doNotHonor = "do_not_honor"
    /// The card has been declined for an unknown reason.
    case doNotTryAgain = "do_not_try_again"
    /// A transaction with identical amount and credit card information was submitted very recently.
    case duplicateTransaction = "duplicate_transaction"
    /// The card has expired.
    case expiredCard = "expired_card"
    /// The payment has been declined as Stripe suspects it is fraudulent.
    case fradulent
    /// The card has been declined for an unknown reason.
    case genericDecline = "generic_decline"
    /// The card number is incorrect.
    case incorrectNumber = "incorrect_number"
    /// The CVC number is incorrect.
    case incorrectCVC = "incorrect_cvc"
    /// The PIN entered is incorrect. This decline code only applies to payments made with a card reader.
    case incorrectPin = "incorrect_pin"
    /// The ZIP/postal code is incorrect.
    case incorrectZip = "incorrect_zip"
    /// The card has insufficient funds to complete the purchase.
    case insufficientFunds = "insufficient_funds"
    /// The card, or account the card is connected to, is invalid.
    case invalidAccount = "invalid_account"
    /// The payment amount is invalid, or exceeds the amount that is allowed.
    case invalidAmount = "invalid_amount"
    /// The CVC number is incorrect.
    case invalidCVC = "invalid_cvc"
    /// The expiration year invalid.
    case invalidExpiryYear = "invalid_expiry_year"
    /// The card number is incorrect.
    case invalidNumber = "invalid_number"
    /// The PIN entered is incorrect. This decline code only applies to payments made with a card reader.
    case invalidPin = "invalid_pin"
    /// The card issuer could not be reached, so the payment could not be authorized.
    case issuerNotAvailable = "issuer_not_available"
    /// The payment has been declined because the card is reported lost.
    case lostCard = "lost_card"
    /// The payment has been declined because it matches a value on the Stripe user's blocklist.
    case merchantBlacklist = "merchant_blacklist"
    /// The card, or account the card is connected to, is invalid.
    case newAccountInformationAvailable = "new_account_information_available"
    /// The card has been declined for an unknown reason.
    case noActionTaken = "no_action_taken"
    /// The payment is not permitted.
    case notPermitted = "not_permitted"
    /// The card cannot be used to make this payment (it is possible it has been reported lost or stolen).
    case pickupCard = "pickup_card"
    /// The allowable number of PIN tries has been exceeded.
    case pinTryExceeded = "pin_try_exceeded"
    /// An error occurred while processing the card.
    case processingError = "processing_error"
    /// The payment could not be processed by the issuer for an unknown reason.
    case reenterTransaction = "reenter_transaction"
    /// The card cannot be used to make this payment (it is possible it has been reported lost or stolen).
    case restrictedCard = "restricted_card"
    /// The card has been declined for an unknown reason.
    case revocationOfAllAuthorizations = "revocation_of_all_authorizations"
    /// The card has been declined for an unknown reason.
    case revocationOfAuthorization = "revocation_of_authorization"
    /// The card has been declined for an unknown reason.
    case securityViolation = "security_violation"
    /// The card has been declined for an unknown reason.
    case serviceNotAllowed = "service_not_allowed"
    /// The payment has been declined because the card is reported stolen.
    case stolenCard = "stolen_card"
    /// The card has been declined for an unknown reason.
    case stopPaymentOrder = "stop_payment_order"
    /// A Stripe test card number was used.
    case testmodeDecline = "testmode_decline"
    /// The card has been declined for an unknown reason.
    case transactionNotAllowed = "transaction_not_allowed"
    /// The card has been declined for an unknown reason.
    case tryAgainLater = "try_again_later"
    /// The customer has exceeded the balance or credit limit available on their card.
    case withdrawalCountLimitExceeded = "withdrawal_count_limit_exceeded"
    
    public var nextSteps: String {
        switch self {
        case .approveWithId: return "The payment should be attempted again. If it still cannot be processed, the customer needs to contact their card issuer."
        case .callIssuer:  return "The customer needs to contact their card issuer for more information."
        case .cardNotSupported: return "The customer needs to contact their card issuer to make sure their card can be used to make this type of purchase."
        case .cardVelocityExceeded: return "The customer should contact their card issuer for more information"
        case .currencyNotSupported: return "The customer needs to check with the issuer whether the card can be used for the type of currency specified."
        case .doNotHonor: return "The customer needs to contact their card issuer for more information."
        case .doNotTryAgain: return "The customer needs to contact their card issuer for more information."
        case .duplicateTransaction: return "Check to see if a recent payment already exists."
        case .expiredCard: return "The customer should use another card."
        case .fradulent: return "Do not report more detailed information to your customer. Instead, present as you would the `generic_decline` described below."
        case .genericDecline: return "The customer needs to contact their card issuer for more information."
        case .incorrectNumber: return "The customer should try again using the correct card number."
        case .incorrectCVC: return "The customer should try again using the correct CVC."
        case .incorrectPin: return "The customer should try again using the correct PIN."
        case .incorrectZip: return "The customer should try again using the correct billing ZIP/postal code."
        case .insufficientFunds: return "The customer should use an alternative payment method."
        case .invalidAccount: return "The customer needs to contact their card issuer to check that the card is working correctly."
        case .invalidAmount: return "If the amount appears to be correct, the customer needs to check with their card issuer that they can make purchases of that amount."
        case .invalidCVC: return "The customer should try again using the correct CVC."
        case .invalidExpiryYear: return "The customer should try again using the correct expiration date."
        case .invalidNumber: return "The customer should try again using the correct card number."
        case .invalidPin: return "The customer should try again using the correct PIN."
        case .issuerNotAvailable: return "The payment should be attempted again. If it still cannot be processed, the customer needs to contact their card issuer."
        case .lostCard: return "The specific reason for the decline should not be reported to the customer. Instead, it needs to be presented as a generic decline."
        case .merchantBlacklist: return "Do not report more detailed information to your customer. Instead, present as you would the generic_decline described above."
        case .newAccountInformationAvailable: return "The customer needs to contact their card issuer for more information."
        case .noActionTaken: return "The customer should contact their card issuer for more information."
        case .notPermitted: return "The customer needs to contact their card issuer for more information."
        case .pickupCard: return "The customer needs to contact their card issuer for more information."
        case .pinTryExceeded: return "The customer must use another card or method of payment."
        case .processingError: return "The payment should be attempted again. If it still cannot be processed, try again later."
        case .reenterTransaction: return "The payment should be attempted again. If it still cannot be processed, the customer needs to contact their card issuer."
        case .restrictedCard: return "The customer needs to contact their card issuer for more information."
        case .revocationOfAllAuthorizations: return "The customer should contact their card issuer for more information."
        case .revocationOfAuthorization: return "The customer should contact their card issuer for more information."
        case .securityViolation: return "The customer should contact their card issuer for more information."
        case .serviceNotAllowed: return "The customer should contact their card issuer for more information."
        case .stolenCard: return "The specific reason for the decline should not be reported to the customer. Instead, it needs to be presented as a generic decline."
        case .stopPaymentOrder: return "The customer should contact their card issuer for more information."
        case .testmodeDecline: return "A genuine card must be used to make a payment."
        case .transactionNotAllowed: return "The customer needs to contact their card issuer for more information."
        case .tryAgainLater: return "Ask the customer to attempt the payment again. If subsequent payments are declined, the customer should contact their card issuer for more information."
        case .withdrawalCountLimitExceeded: return "The customer should use an alternative payment method."
        }
    }
}
