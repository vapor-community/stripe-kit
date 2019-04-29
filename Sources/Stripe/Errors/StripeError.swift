//
//  StripeError.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Foundation
/**
 Error object
 https://stripe.com/docs/api#errors
 */

public enum StripeUploadError: Error {
    case unsupportedFileType
    
    public var localizedDescription: String {
        return "Unsupported file type used for file upload."
    }
    
    public var identifier: String {
        return "file-upload-error"
    }
    
    public var reason: String {
        return localizedDescription
    }
    
    public var possibleCauses: [String] {
        return ["Unsupported file type used for file upload."]
    }
    
    public var suggestedFixes: [String] {
        return ["Use one of the following supported filetypes for uploads.",
                "CSV",
                "DOCX",
                "GIF",
                "JPEG",
                "PDF",
                "PNG",
                "XLS",
                "XLSX"]
    }
}

public struct StripeError: StripeModel, Error {
    public var identifier: String {
        return self.error.type?.rawValue ?? "Unknown"
    }
    public var reason: String {
        return self.error.message ?? "An unknown error occured."
    }
    public var error: StripeAPIError
}

public final class StripeAPIError: StripeModel {
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
    // TODO: - paymentMethod.
    /// The source object for errors returned on a request involving a source.
    public var source: StripeSource?
}

// https://stripe.com/docs/api#errors-type
public enum StripeErrorType: String, StripeModel {
    case apiConnectionError = "api_connection_error"
    case apiError = "api_error"
    case authenticationError = "authentication_error"
    case cardError = "card_error"
    case idempotencyError = "idempotency_error"
    case invalidRequestError = "invalid_request_error"
    case rateLimitError = "rate_limit_error"
    case validationError = "validation_error"
}

// https://stripe.com/docs/api#errors-code
// https://stripe.com/docs/error-codes
public enum StripeErrorCode: String, StripeModel {
    case accountAlreadyExists = "account_already_exists"
    case accountCountryInvalidAddress = "account_country_invalid_address"
    case accountInvalid = "account_invalid"
    case accountNumberInvalid = "account_number_invalid"
    case alipayUpgradeRequired = "alipay_upgrade_required"
    case amountTooLarge = "amount_too_large"
    case amountTooSmall = "amount_too_small"
    case apiKeyExpired = "api_key_expired"
    case balanceInsufficient = "balance_insufficient"
    case bankAccountExists = "bank_account_exists"
    case bankAccountUnusable = "bank_account_unsuable"
    case bankAccountUnverified = "bank_account_unverified"
    case bitcoinUpgradeRequired = "bitcoin_upgrade_required"
    case cardDeclined = "card_declined"
    case chargeAlreadyCaptured = "charge_already_captured"
    case chargeAlreadyRefunded = "charge_already_refunded"
    case chargeDisputed = "charge_disputed"
    case chargeExpiredForCapture = "charge_expired_for_capture"
    case countryUnsupported = "country_unsupported"
    case couponExpired = "coupon_expired"
    case customerMaxSubscriptions = "customer_max_subscriptions"
    case emailInvalid = "email_invalid"
    case expiredCard = "expired_card"
    case incorrectAddress = "incorrect_address"
    case incorrectCVC = "incorrect_cvc"
    case incorrectNumber = "incorrect_number"
    case incorrectZip = "incorrect_zip"
    case instantPayoutUnsupported = "instant_payouts_unsupported"
    case invalidCardType = "invalid_card_type"
    case invalidChargeAmount = "invalid_charge_amount"
    case invalidCVC = "invalid_cvc"
    case invalidExpiryMonth = "invalid_expiry_month"
    case invalidExpiryYear = "invalid_expiry_year"
    case invalidNumber = "invalid_number"
    case invalidSourceUsage = "invalid_source_usage"
    case invoiceNoCustomerLineItems = "invoice_no_customer_line_items"
    case invoiceNoSubscriptionLineItems = "invoice_no_subscription_line_items"
    case invoiceUpcomingNone = "invoice_upcoming_none"
    case livemodeMismatch = "livemode_mismatch"
    case missing
    case orderCreationFailed = "order_creation_failed"
    case orderRequiredSettings = "order_required_settings"
    case orderStatusInvalid = "order_status_invalid"
    case orderUpstreamTimeout = "order_upstream_timeout"
    case outOfInventory = "out_of_inventory"
    case parameterInvalidEmpty = "parameter_invalid_empty"
    case parameterInvalidInteger = "parameter_invalid_integer"
    case parameterInvalidStringBlank = "parameter_invalid_string_blank"
    case parameterInvalidStringEmpty = "parameter_invalid_string_empty"
    case parameterMissing = "parameter_missing"
    case parameterUnknown = "parameter_unknown"
    case paymentMethodUnactivated = "payment_method_unactivated"
    case payoutsNotAllowed = "payouts_not_allowed"
    case platformApiKeyExpired = "platform_api_key_expired"
    case postalCodeInvalid = "postal_code_invalid"
    case processingError = "processing_error"
    case productInactive = "product_inactive"
    case rateLimit = "rate_limit"
    case resourceAlreadyExists = "resource_already_exists"
    case resourceMissing = "resource_missing"
    case routingNumberInvalid = "routing_number_invalid"
    case secretKeyRequired = "secret_key_required"
    case sepaUnsupportedAccount = "sepa_unsupported_account"
    case shippingCalculationFailed = "shipping_calculation_failed"
    case skuInactive = "sku_inactive"
    case stateUnsupported = "state_unsupported"
    case taxIdInvalid = "tax_id_invalid"
    case taxesCalculationFailed = "taxes_calculation_failed"
    case testmodeChargesOnly = "testmode_charges_only"
    case tlsVersionUnsupported = "tls_version_unsupported"
    case tokenAlreadyUsed = "token_already_used"
    case tokenInUse = "token_in_use"
    case transfersNotAllowed = "transfers_not_allowed"
    case upstreamOrderCreationFailed = "upstream_order_creation_failed"
    case urlInvalid = "url_invalid"
}

// https://stripe.com/docs/api#errors-decline-code
// https://stripe.com/docs/declines/codes
public enum StripeDeclineCode: String, StripeModel {
    case approveWithId = "approve_with_id"
    case callIssuer = "call_issuer"
    case cardNotSupported = "card_not_supported"
    case cardVelocityExceeded = "card_velocity_exceeded"
    case currencyNotSupported = "currency_not_supported"
    case doNotHonor = "do_not_honor"
    case doNotTryAgain = "do_not_try_again"
    case duplicateTransaction = "duplicate_transaction"
    case expiredCard = "expired_card"
    case fradulent
    case genericDecline = "generic_decline"
    case incorrectNumber = "incorrect_number"
    case incorrectCVC = "incorrect_cvc"
    case incorrectPin = "incorrect_pin"
    case incorrectZip = "incorrect_zip"
    case insufficientFunds = "insufficient_funds"
    case invalidAccount = "invalid_account"
    case invalidAmount = "invalid_amount"
    case invalidCVC = "invalid_cvc"
    case invalidExpiryYear = "invalid_expiry_year"
    case invalidNumber = "invalid_number"
    case invalidPin = "invalid_pin"
    case issuerNotAvailable = "issuer_not_available"
    case lostCard = "lost_card"
    case newAccountInformationAvailable = "new_account_information_available"
    case noActionTaken = "no_action_taken"
    case notPermitted = "not_permitted"
    case pickupCard = "pickup_card"
    case pinTryExceeded = "pin_try_exceeded"
    case processingError = "processing_error"
    case reenterTransaction = "reenter_transaction"
    case restrictedCard = "restricted_card"
    case revocationOfAllAuthorizations = "revocation_of_all_authorizations"
    case revocationOfAuthorization = "revocation_of_authorization"
    case securityViolation = "security_violation"
    case serviceNotAllowed = "service_not_allowed"
    case stolenCard = "stolen_card"
    case stopPaymentOrder = "stop_payment_order"
    case testmodeDecline = "testmode_decline"
    case testModeLiveCard = "test_mode_live_card"
    case transactionNotAllowed = "transaction_not_allowed"
    case tryAgainLater = "try_again_later"
    case withdrawalCountLimitExceeded = "withdrawal_count_limit_exceeded"
}
