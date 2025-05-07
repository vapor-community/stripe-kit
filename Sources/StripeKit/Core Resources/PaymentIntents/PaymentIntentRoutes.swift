//
//  PaymentIntentsRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/28/19.
//

import NIO
import NIOHTTP1

public protocol PaymentIntentRoutes: StripeAPIRoute {
    /// Creates a PaymentIntent object.
    ///
    /// After the PaymentIntent is created, attach a payment method and confirm to continue the payment. You can read more about the different payment flows available via the Payment Intents API here.
    ///
    /// When `confirm=true` is used during creation, it is equivalent to creating and confirming the PaymentIntent in the same call. You may use any parameters available in the confirm API when `confirm=true` is supplied.
    /// - Parameters:
    ///   - amount: Amount intended to be collected by this PaymentIntent. A positive integer representing how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or equivalent in charge currency. The amount value supports up to eight digits (e.g., a value of 99999999 for a USD charge of $999,999.99).
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - automaticPaymentMethods: When enabled, this PaymentIntent will accept payment methods that you have enabled in the Dashboard and are compatible with this PaymentIntent’s other parameters.
    ///   - confirm: Set to `true` to attempt to confirm this PaymentIntent immediately. This parameter defaults to `false`. When creating and confirming a PaymentIntent at the same time, parameters available in the confirm API may also be provided.
    ///   - customer: ID of the Customer this PaymentIntent belongs to, if one exists. Payment methods attached to other Customers cannot be used with this PaymentIntent. If present in combination with `setup_future_usage`, this PaymentIntent’s payment method will be attached to the Customer after the PaymentIntent has been confirmed and any required actions from the user are complete.
    ///   - description: An arbitrary string attached to the object. Often useful for displaying to users.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - offSession: Set to `true` to indicate that the customer is not in your checkout flow during this payment attempt, and therefore is unable to authenticate. This parameter is intended for scenarios where you collect card details and charge them later. This parameter can only be used with `confirm=true`.
    ///   - paymentMethod: ID of the payment method (a PaymentMethod, Card, or compatible Source object) to attach to this PaymentIntent. If this parameter is omitted with `confirm=true`, `customer.default_source` will be attached as this PaymentIntent’s payment instrument to improve the migration experience for users of the Charges API. We recommend that you explicitly provide the `payment_method` going forward.
    ///   - receiptEmail: Email address that the receipt for the resulting payment will be sent to. If `receipt_email` is specified for a payment in live mode, a receipt will be sent regardless of your email settings.
    ///   - setupFutureUsage: Indicates that you intend to make future payments with this PaymentIntent’s payment method. Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes. When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
    ///   - shipping: Shipping information for this PaymentIntent.
    ///   - statementDescriptor: For non-card charges, you can use this value as the complete description that appears on your customers’ statements. Must contain at least one letter, maximum 22 characters.
    ///   - statementDescriptorSuffix: Provides information about a card payment that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.
    ///   - applicationFeeAmount: The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the application owner’s Stripe account. The amount of the application fee collected will be capped at the total payment amount. For more information, see the PaymentIntents use case for connected accounts.
    ///   - captureMethod: Controls when the funds will be captured from the customer’s account.
    ///   - confirmationMethod: The confirmation method.
    ///   - errorOnRequiresAction: Set to `true` to fail the payment attempt if the PaymentIntent transitions into `requires_action`. This parameter is intended for simpler integrations that do not handle customer actions, like saving cards without authentication. This parameter can only be used with `confirm=true`.
    ///   - mandate: ID of the mandate to be used for this payment. This parameter can only be used with `confirm=true`.
    ///   - mandateData: This hash contains details about the Mandate to create. This parameter can only be used with `confirm=true`.
    ///   - onBehalfOf: The Stripe account ID for which these funds are intended. For details, see the PaymentIntents use case for connected accounts.
    ///   - paymentMethodData: If provided, this hash will be used to create a PaymentMethod. The new PaymentMethod will appear in the payment_method property on the PaymentIntent.
    ///   - paymentMethodOptions: Payment-method-specific configuration for this PaymentIntent.
    ///   - paymentMethodTypes: The list of payment method types that this PaymentIntent is allowed to use. If this is not provided, defaults to `[“card”]`. Valid payment method types include: `acss_debit`, `affirm`, `afterpay_clearpay`, `alipay`, `au_becs_debit`, `bacs_debit`, `bancontact`, `blik`, `boleto`, `card`, `card_present`, `eps`, `fpx`, `giropay`, `grabpay`, `ideal`, `klarna`, `konbini`, `link`, `oxxo`, `p24`, `paynow`, `pix`, `promptpay`, `sepa_debit`, `sofort`, `us_bank_account`, and `wechat_pay`.
    ///   - radarOptions: Options to configure Radar. See Radar Session for more information.
    ///   - returnUrl: The URL to redirect your customer back to after they authenticate or cancel their payment on the payment method’s app or site. If you’d prefer to redirect to a mobile application, you can alternatively supply an application URI scheme. This parameter can only be used with `confirm=true`.
    ///   - transferData: The parameters used to automatically create a Transfer when the payment succeeds. For more information, see the PaymentIntents use case for connected accounts.
    ///   - transferGroup: A string that identifies the resulting payment as part of a group. See the PaymentIntents use case for connected accounts for details.
    ///   - useStripeSDK: Set to true only when using manual confirmation and the iOS or Android SDKs to handle additional authentication steps.
    ///   - expand: An array of properties to expand
    /// - Returns: Returns a PaymentIntent object.
    func create(amount: Int,
                currency: Currency,
                automaticPaymentMethods: [String: Any]?,
                confirm: Bool?,
                customer: String?,
                description: String?,
                metadata: [String: String]?,
                offSession: Bool?,
                paymentMethod: String?,
                receiptEmail: String?,
                setupFutureUsage: PaymentIntentSetupFutureUsage?,
                shipping: [String: Any]?,
                statementDescriptor: String?,
                statementDescriptorSuffix: String?,
                applicationFeeAmount: Int?,
                captureMethod: PaymentIntentCaptureMethod?,
                confirmationMethod: PaymentIntentConfirmationMethod?,
                errorOnRequiresAction: Bool?,
                mandate: String?,
                mandateData: [String: Any]?,
                onBehalfOf: String?,
                paymentMethodData: [String: Any]?,
                paymentMethodOptions: [String: Any]?,
                paymentMethodTypes: [String]?,
                radarOptions: [String: Any]?,
                returnUrl: String?,
                transferData: [String: Any]?,
                transferGroup: String?,
                useStripeSDK: Bool?,
                expand: [String]?) async throws -> PaymentIntent
    
    /// Retrieves the details of a PaymentIntent that has previously been created.
    ///
    /// - Parameter id: The identifier of the paymentintent to be retrieved.
    /// - Parameter clientSecret: The client secret to use if required.
    /// - Returns: Returns a PaymentIntent if a valid identifier was provided.
    func retrieve(intent: String, clientSecret: String?) async throws -> PaymentIntent
    
    /// Updates properties on a PaymentIntent object without confirming.
    ///
    /// Depending on which properties you update, you may need to confirm the PaymentIntent again. For example, updating the `payment_method` will always require you to confirm the PaymentIntent again. If you prefer to update and confirm at the same time, we recommend updating properties via the [confirm API](https://stripe.com/docs/api/payment_intents/confirm) instead.
    /// - Parameters:
    ///   - intent: The identifier of the paymentintent to be updated.
    ///   - amount: A positive integer representing how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or equivalent in charge currency.
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - customer: ID of the customer this PaymentIntent is for if one exists.
    ///   - description: An arbitrary string attached to the object. Often useful for displaying to users. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - paymentMethod: ID of the payment method to attach to this PaymentIntent.
    ///   - receiptEmail: Email address that the receipt for the resulting payment will be sent to.
    ///   - setupFutureUsage: Indicates that you intend to make future payments with this PaymentIntent’s payment method. If present, the payment method used with this PaymentIntent can be attached to a Customer, even after the transaction completes. Use `on_session` if you intend to only reuse the payment method when your customer is present in your checkout flow. Use `off_session` if your customer may or may not be in your checkout flow. Stripe uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules. For example, if your customer is impacted by SCA, using `off_session` will ensure that they are authenticated while processing this PaymentIntent. You will then be able to collect off-session payments for this customer. If `setup_future_usage` is already set and you are performing a request using a publishable key, you may only update the value from `on_session` to `off_session`.
    ///   - shipping: Shipping information for this PaymentIntent.
    ///   - statementDescriptor: For non-card charges, you can use this value as the complete description that appears on your customers’ statements. Must contain at least one letter, maximum 22 characters.
    ///   - statementDescriptorSuffix: Provides information about a card payment that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.
    ///   - applicationFeeAmount: The amount of the application fee (if any) that will be applied to the payment and transferred to the application owner’s Stripe account. For more information, see the PaymentIntents Connect usage guide.
    ///   - captureMethod: Controls when the funds will be captured from the customer’s account.
    ///   - paymentMethodData: If provided, this hash will be used to create a PaymentMethod. The new PaymentMethod will appear in the `payment_method` property on the PaymentIntent.
    ///   - paymentMethodTypes: The list of payment method types that this PaymentIntent is allowed to use. If this is not provided, defaults to `[“card”]`. Valid payment method types include: `card` and `card_present`.
    ///   - transferData: The parameters used to automatically create a Transfer when the payment succeeds. For more information, see the PaymentIntents Connect usage guide.
    ///   - transferGroup: A string that identifies the resulting payment as part of a group. See the PaymentIntents Connect usage guide for details.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns a PaymentIntent object.
    func update(intent: String,
                amount: Int?,
                currency: Currency?,
                customer: String?,
                description: String?,
                metadata: [String: String]?,
                paymentMethod: String?,
                receiptEmail: String?,
                setupFutureUsage: PaymentIntentSetupFutureUsage?,
                shipping: [String: Any]?,
                statementDescriptor: String?,
                statementDescriptorSuffix: String?,
                applicationFeeAmount: Int?,
                captureMethod: PaymentIntentCaptureMethod?,
                paymentMethodData: [String: Any]?,
                paymentMethodTypes: [String]?,
                transferData: [String: Any]?,
                transferGroup: String?,
                expand: [String]?) async throws -> PaymentIntent
    
    /// Confirm that your customer intends to pay with current or provided payment method. Upon confirmation, the PaymentIntent will attempt to initiate a payment. If the selected payment method requires additional authentication steps, the PaymentIntent will transition to the `requires_action` status and suggest additional actions via `next_action`. If payment fails, the PaymentIntent will transition to the `requires_payment_method` status. If payment succeeds, the PaymentIntent will transition to the `succeeded` status (or `requires_capture`, if `capture_method` is set to `manual`). If the `confirmation_method` is `automatic`, payment may be attempted using our client SDKs and the PaymentIntent’s `client_secret`. After `next_actions` are handled by the client, no additional confirmation is required to complete the payment. If the `confirmation_method` is `manual`, all payment attempts must be initiated using a secret key. If any actions are required for the payment, the PaymentIntent will return to the `requires_confirmation` state after those actions are completed. Your server needs to then explicitly re-confirm the PaymentIntent to initiate the next payment attempt. Read the expanded documentation to learn more about manual confirmation.
    /// - Parameters:
    ///   - intent: The id of the payment intent
    ///   - paymentMethod: ID of the payment method (a PaymentMethod, Card, or compatible Source object) to attach to this PaymentIntent.
    ///   - receiptEmail: Email address that the receipt for the resulting payment will be sent to. If `receipt_email` is specified for a payment in live mode, a receipt will be sent regardless of your email settings.
    ///   - setupFutureUsage: Indicates that you intend to make future payments with this PaymentIntent’s payment method. Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes. When processing card payments, Stripe also uses `setup_future_usage` to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA. If `setup_future_usage` is already set and you are performing a request using a publishable key, you may only update the value from `on_session` to `off_session`.
    ///   - shipping: Shipping information for this PaymentIntent.
    ///   - captureMethod: Controls when the funds will be captured from the customer’s account.
    ///   - errorOnRequiresAction: Set to `true` to fail the payment attempt if the PaymentIntent transitions into `requires_action`. This parameter is intended for simpler integrations that do not handle customer actions, like saving cards without authentication.
    ///   - mandate: ID of the mandate to be used for this payment.
    ///   - mandateData: This hash contains details about the Mandate to create
    ///   - offSession: Set to`true` to indicate that the customer is not in your checkout flow during this payment attempt, and therefore is unable to authenticate. This parameter is intended for scenarios where you collect card details and charge them later.
    ///   - paymentMethodData: If provided, this hash will be used to create a PaymentMethod. The new PaymentMethod will appear in the `payment_method` property on the PaymentIntent.
    ///   - paymentMethodOptions: Payment-method-specific configuration for this PaymentIntent.
    ///   - paymentMethodTypes: The list of payment method types (e.g. card) that this PaymentIntent is allowed to use. Use `automatic_payment_methods` to manage payment methods from the Stripe Dashboard.
    ///   - radarOptions: Options to configure Radar. See Radar Session for more information.
    ///   - returnUrl: The URL to redirect your customer back to after they authenticate or cancel their payment on the payment method’s app or site. If you’d prefer to redirect to a mobile application, you can alternatively supply an application URI scheme. This parameter is only used for cards and other redirect-based payment methods.
    ///   - useStripeSDK: Set to true only when using manual confirmation and the iOS or Android SDKs to handle additional authentication steps.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns the resulting PaymentIntent after all possible transitions are applied.
    func confirm(intent: String,
                 paymentMethod: String?,
                 receiptEmail: String?,
                 setupFutureUsage: PaymentIntentSetupFutureUsage?,
                 shipping: [String: Any]?,
                 captureMethod: PaymentIntentCaptureMethod?,
                 errorOnRequiresAction: Bool?,
                 mandate: String?,
                 mandateData: [String: Any]?,
                 offSession: Bool?,
                 paymentMethodData: [String: Any]?,
                 paymentMethodOptions: [String: Any]?,
                 paymentMethodTypes: [String]?,
                 radarOptions: [String: Any]?,
                 returnUrl: String?,
                 useStripeSDK: Bool?,
                 expand: [String]?) async throws -> PaymentIntent
    
    /// Capture the funds of an existing uncaptured PaymentIntent when its status is `requires_capture`.
    ///
    /// Uncaptured PaymentIntents will be canceled a set number of days after they are created (7 by default).
    ///
    /// Learn more about [separate authorization and capture](https://stripe.com/docs/payments/capture-later).
    ///
    /// - Parameters:
    ///   - intent: ID of the paymentintent to capture.
    ///   - amountToCapture: The amount to capture from the PaymentIntent, which must be less than or equal to the original amount. Any additional amount will be automatically refunded. Defaults to the full `amount_capturable` if not provided.
    ///   - applicationfeeAmount: The amount of the application fee (if any) that will be applied to the payment and transferred to the application owner’s Stripe account. For more information, see the PaymentIntents Connect usage guide.
    ///   - statementDescriptor: For non-card charges, you can use this value as the complete description that appears on your customers’ statements. Must contain at least one letter, maximum 22 characters.
    ///   - statementDescriptorSuffix: Provides information about a card payment that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.
    ///   - transferData: The parameters used to automatically create a Transfer when the payment is captured. For more information, see the PaymentIntents use case for connected accounts.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: A `PaymentIntent`.
    func capture(intent: String,
                 amountToCapture: Int?,
                 applicationFeeAmount: Int?,
                 statementDescriptor: String?,
                 statementDescriptorSuffix: String?,
                 transferData: [String: Any]?,
                 expand: [String]?) async throws -> PaymentIntent
    
    /// A PaymentIntent object can be canceled when it is in one of these statuses: `requires_payment_method`, `requires_capture`, `requires_confirmation`, `requires_action` or, [in rare cases](https://stripe.com/docs/payments/intents), `processing`.
    ///
    /// Once canceled, no additional charges will be made by the PaymentIntent and any operations on the PaymentIntent will fail with an error. For PaymentIntents with `status=’requires_capture’`, the remaining `amount_capturable` will automatically be refunded.
    ///
    /// You cannot cancel the PaymentIntent for a Checkout Session. [Expire the Checkout Session instead](https://stripe.com/docs/api/checkout/sessions/expire).
    /// - Parameters:
    ///   - intent: ID of the paymentintent to cancel.
    ///   - cancellationReason: Reason for canceling this PaymentIntent. If set, possible values are `duplicate`, `fraudulent`, `requested_by_customer`, or `failed_invoice`.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns a PaymentIntent object if the cancellation succeeded. Returns an error if the PaymentIntent has already been canceled or is not in a cancelable state.
    func cancel(intent: String, cancellationReason: PaymentIntentCancellationReason?, expand: [String]?) async throws -> PaymentIntent
    
    /// Returns a list of PaymentIntents.
    ///
    /// - Parameter filter: A dictionary that contains the filters. More info [here](https://stripe.com/docs/api/payment_intents/list).
    /// - Returns: A `StripePaymentIntentsList`.
    func listAll(filter: [String: Any]?) async throws -> PaymentIntentList
    
    
    /// Perform an incremental authorization on an eligible [PaymentIntent](https://stripe.com/docs/api/payment_intents/object). To be eligible, the PaymentIntent’s status must be `requires_capture` and [incremental_authorization_supported](https://stripe.com/docs/api/charges/object#charge_object-payment_method_details-card_present-incremental_authorization_supported) must be `true`.
    ///
    /// Incremental authorizations attempt to increase the authorized `amount` on your customer’s card to the new, higher amount provided. As with the initial authorization, incremental authorizations may be declined. A single PaymentIntent can call this endpoint multiple times to further increase the authorized amount.
    ///
    /// If the incremental authorization succeeds, the PaymentIntent object is returned with the updated [amount](https://stripe.com/docs/api/payment_intents/object#payment_intent_object-amount). If the incremental authorization fails, a [card_declined](https://stripe.com/docs/error-codes#card-declined) error is returned, and no fields on the PaymentIntent or Charge are updated. The PaymentIntent object remains capturable for the previously authorized amount.
    ///
    /// Each PaymentIntent can have a maximum of 10 incremental authorization attempts, including declines. Once captured, a PaymentIntent can no longer be incremented.
    ///
    /// Learn more about [incremental authorizations](https://stripe.com/docs/terminal/features/incremental-authorizations).
    ///
    /// - Parameters:
    ///   - intent: The id of the payment intent.
    ///   - amount: The updated total amount you intend to collect from the cardholder. This amount must be greater than the currently authorized amount.
    ///   - description: An arbitrary string attached to the object. Often useful for displaying to users.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - statementDescription: For non-card charges, you can use this value as the complete description that appears on your customers’ statements. Must contain at least one letter, maximum 22 characters.
    ///   - applicationFeeAmount: The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the application owner’s Stripe account. The amount of the application fee collected will be capped at the total payment amount. For more information, see the PaymentIntents use case for connected accounts.
    ///   - transferdata: The parameters used to automatically create a Transfer when the payment is captured. For more information, see the PaymentIntents use case for connected accounts.
    /// - Returns: Returns a PaymentIntent object with the updated amount if the incremental authorization succeeded. Returns an error if the incremental authorization failed or the PaymentIntent isn’t eligible for incremental authorizations.
    func incrementAuthorization(intent: String,
                                amount: Int,
                                description: String?,
                                metadata: [String: String]?,
                                statementDescription: String?,
                                applicationFeeAmount: Int?,
                                transferdata: [String: Any]?) async throws -> PaymentIntent
    
    /// Search for PaymentIntents you’ve previously created using Stripe’s Search Query Language. Don’t use search in read-after-write flows where strict consistency is necessary. Under normal operating conditions, data is searchable in less than a minute. Occasionally, propagation of new or updated data can be up to an hour behind during outages. Search functionality is not available to merchants in India.
    /// - Parameters:
    ///   - query: The search query string. See search query language and the list of supported query fields for payment intents.
    ///   - limit: A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
    ///   - page: A cursor for pagination across multiple pages of results. Don’t include this parameter on the first call. Use the `next_page` value returned in a previous response to request subsequent results.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: A dictionary with a data property that contains an array of up to limit PaymentIntents. If no objects match the query, the resulting array will be empty. See the related guide on expanding properties in lists.
    func search(query: String, limit: Int?, page: String?) async throws -> PaymentIntentSearchResult
    
    /// Search for PaymentIntents you’ve previously created using Stripe’s Search Query Language. Don’t use search in read-after-write flows where strict consistency is necessary. Under normal operating conditions, data is searchable in less than a minute. Occasionally, propagation of new or updated data can be up to an hour behind during outages. Search functionality is not available to merchants in India.
    /// - Parameters:
    ///   - query: The search query string. See search query language and the list of supported query fields for payment intents.
    ///   - limit: A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
    ///   - page: A cursor for pagination across multiple pages of results. Don’t include this parameter on the first call. Use the `next_page` value returned in a previous response to request subsequent results.
    /// - Returns: A dictionary with a data property that contains an array of up to limit PaymentIntents. If no objects match the query, the resulting array will be empty. See the related guide on expanding properties in lists.
    func search(query: String, limit: Int?, page: String?, expand:[String]?) async throws -> PaymentIntentSearchResult
    
    
    /// Verifies microdeposits on a PaymentIntent object.
    /// - Parameters:
    ///   - intent: The id of the intent.
    ///   - amounts: Two positive integers, in cents, equal to the values of the microdeposits sent to the bank account.
    ///   - descriptorCode: A six-character code starting with SM present in the microdeposit sent to the bank account.
    /// - Returns: Returns a PaymentIntent object.
    func verifyMicroDeposits(intent: String, amounts: [Int]?, descriptorCode: String?) async throws -> PaymentIntent
    
    /// Manually reconcile the remaining amount for a `customer_balance` PaymentIntent.
    /// - Parameters:
    ///   - intent: The id of the intent.
    ///   - amount: Amount intended to be applied to this PaymentIntent from the customer’s cash balance. A positive integer representing how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The maximum amount is the amount of the PaymentIntent. When omitted, the amount defaults to the remaining amount requested on the PaymentIntent.
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    /// - Returns: Returns a PaymentIntent object.
    func reconcileCustomerBalance(intent: String, amount: Int?, currency: Currency?) async throws -> PaymentIntent
}

public struct StripePaymentIntentRoutes: PaymentIntentRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let paymentintents = APIBase + APIVersion + "payment_intents"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(amount: Int,
                       currency: Currency,
                       automaticPaymentMethods: [String: Any]? = nil,
                       confirm: Bool? = nil,
                       customer: String? = nil,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       offSession: Bool? = nil,
                       paymentMethod: String? = nil,
                       receiptEmail: String? = nil,
                       setupFutureUsage: PaymentIntentSetupFutureUsage? = nil,
                       shipping: [String: Any]? = nil,
                       statementDescriptor: String? = nil,
                       statementDescriptorSuffix: String? = nil,
                       applicationFeeAmount: Int? = nil,
                       captureMethod: PaymentIntentCaptureMethod? = nil,
                       confirmationMethod: PaymentIntentConfirmationMethod? = nil,
                       errorOnRequiresAction: Bool? = nil,
                       mandate: String? = nil,
                       mandateData: [String: Any]? = nil,
                       onBehalfOf: String? = nil,
                       paymentMethodData: [String: Any]? = nil,
                       paymentMethodOptions: [String: Any]? = nil,
                       paymentMethodTypes: [String]? = nil,
                       radarOptions: [String: Any]? = nil,
                       returnUrl: String? = nil,
                       transferData: [String: Any]? = nil,
                       transferGroup: String? = nil,
                       useStripeSDK: Bool? = nil,
                       expand: [String]? = nil) async throws -> PaymentIntent {
        var body: [String: Any] = ["amount": amount,
                                   "currency": currency.rawValue]
        
        if let automaticPaymentMethods {
            automaticPaymentMethods.forEach { body["automatic_payment_methods[\($0)]"] = $1 }
        }
        
        if let confirm {
            body["confirm"] = confirm
        }
        
        if let customer {
            body["customer"] = customer
        }
        
        if let description {
            body["description"] = description
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let offSession {
            body["off_session"] = offSession
        }
        
        if let paymentMethod {
            body["payment_method"] = paymentMethod
        }
        
        if let receiptEmail = receiptEmail {
            body["receipt_email"] = receiptEmail
        }
        
        if let setupFutureUsage {
            body["setup_future_usage"] = setupFutureUsage.rawValue
        }
        
        if let shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let statementDescriptorSuffix {
            body["statement_descriptor_suffix"] = statementDescriptorSuffix
        }
        
        if let applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }
        
        if let captureMethod {
            body["capture_method"] = captureMethod.rawValue
        }

        if let confirmationMethod  {
            body["confirmation_method"] = confirmationMethod.rawValue
        }

        if let errorOnRequiresAction {
            body["error_on_requires_action"] = errorOnRequiresAction
        }
        
        if let mandate {
            body["mandate"] = mandate
        }
        
        if let mandateData {
            mandateData.forEach { body["mandate_data[\($0)]"] = $1 }
        }
        
        if let onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }
        
        if let paymentMethodData {
            paymentMethodData.forEach { body["payment_method_data[\($0)]"] = $1 }
        }
        
        if let paymentMethodOptions {
            paymentMethodOptions.forEach { body["payment_method_options[\($0)]"] = $1 }
        }
        
        if let paymentMethodTypes {
            body["payment_method_types"] = paymentMethodTypes
        }
        
        if let radarOptions {
            radarOptions.forEach { body["radar_options[\($0)]"] = $1 }
        }
        
        if let returnUrl {
            body["return_url"] = returnUrl
        }
        
        if let transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let transferGroup {
            body["transfer_group"] = transferGroup
        }
        
        if let useStripeSDK {
            body["use_stripe_sdk"] = useStripeSDK
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: paymentintents, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(intent: String, clientSecret: String?) async throws -> PaymentIntent {
        var query = ""
        if let clientSecret {
            query += "client_secret=\(clientSecret)"
        }
        return try await apiHandler.send(method: .GET, path: "\(paymentintents)/\(intent)", query: query, headers: headers)
    }
    
    public func update(intent: String,
                       amount: Int? = nil,
                       currency: Currency? = nil,
                       customer: String? = nil,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       paymentMethod: String? = nil,
                       receiptEmail: String? = nil,
                       setupFutureUsage: PaymentIntentSetupFutureUsage? = nil,
                       shipping: [String: Any]? = nil,
                       statementDescriptor: String? = nil,
                       statementDescriptorSuffix: String? = nil,
                       applicationFeeAmount: Int? = nil,
                       captureMethod: PaymentIntentCaptureMethod? = nil,
                       paymentMethodData: [String: Any]? = nil,
                       paymentMethodTypes: [String]? = nil,
                       transferData: [String: Any]? = nil,
                       transferGroup: String? = nil,
                       expand: [String]? = nil) async throws -> PaymentIntent {
        
        var body: [String: Any] = [:]
        
        if let amount {
            body["amount"] = amount
        }
        
        if let currency {
            body["currency"] = currency.rawValue
        }
        
        if let customer {
            body["customer"] = customer
        }
        
        if let description {
            body["description"] = description
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let paymentMethod {
            body["payment_method"] = paymentMethod
        }
        
        if let receiptEmail {
            body["receipt_email"] = receiptEmail
        }
                
        if let setupFutureUsage {
            body["setup_future_usage"] = setupFutureUsage.rawValue
        }
        
        if let shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let statementDescriptorSuffix {
            body["statement_descriptor_suffix"] = statementDescriptorSuffix
        }
        
        if let applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }
        
        if let captureMethod {
            body["capture_method"] = captureMethod.rawValue
        }
        
        if let paymentMethodData {
            paymentMethodData.forEach { body["payment_method_data[\($0)]"] = $1 }
        }
        
        if let paymentMethodTypes {
            body["payment_method_types"] = paymentMethodTypes
        }
        
        if let transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let transferGroup {
            body["transfer_group"] = transferGroup
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(paymentintents)/\(intent)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func confirm(intent: String,
                        paymentMethod: String? = nil,
                        receiptEmail: String? = nil,
                        setupFutureUsage: PaymentIntentSetupFutureUsage? = nil,
                        shipping: [String: Any]? = nil,
                        captureMethod: PaymentIntentCaptureMethod? = nil,
                        errorOnRequiresAction: Bool? = nil,
                        mandate: String? = nil,
                        mandateData: [String: Any]? = nil,
                        offSession: Bool? = nil,
                        paymentMethodData: [String: Any]? = nil,
                        paymentMethodOptions: [String: Any]? = nil,
                        paymentMethodTypes: [String]? = nil,
                        radarOptions: [String: Any]? = nil,
                        returnUrl: String? = nil,
                        useStripeSDK: Bool? = nil,
                        expand: [String]? = nil) async throws -> PaymentIntent {
        var body: [String: Any] = [:]
        
        if let paymentMethod {
            body["payment_method"] = paymentMethod
        }
        
        if let receiptEmail {
            body["receipt_email"] = receiptEmail
        }
        
        if let setupFutureUsage {
            body["setup_future_usage"] = setupFutureUsage.rawValue
        }
        
        if let shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let captureMethod {
            body["capture_method"] = captureMethod.rawValue
        }
        
        if let errorOnRequiresAction {
            body["error_on_requires_action"] = errorOnRequiresAction
        }
        
        if let mandate {
            body["mandate"] = mandate
        }
        
        if let mandateData {
            mandateData.forEach { body["mandate_data[\($0)]"] = $1 }
        }
        
        if let offSession {
            body["off_session"] = offSession
        }
        
        if let paymentMethodData {
            paymentMethodData.forEach { body["payment_method_data[\($0)]"] = $1 }
        }
        
        if let paymentMethodOptions {
            paymentMethodOptions.forEach { body["payment_method_options[\($0)]"] = $1 }
        }
        
        if let paymentMethodTypes {
            body["payment_method_types"] = paymentMethodTypes
        }
        
        if let radarOptions {
            radarOptions.forEach { body["radar_options[\($0)]"] = $1 }
        }
        
        if let returnUrl {
            body["return_url"] = returnUrl
        }
                                
        if let useStripeSDK {
            body["use_stripe_sdk"] = useStripeSDK
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(paymentintents)/\(intent)/confirm", body: .string(body.queryParameters), headers: headers)
    }
    
    public func capture(intent: String,
                        amountToCapture: Int? = nil,
                        applicationFeeAmount: Int? = nil,
                        statementDescriptor: String? = nil,
                        statementDescriptorSuffix: String? = nil,
                        transferData: [String: Any]? = nil,
                        expand: [String]? = nil) async throws -> PaymentIntent {
        var body: [String: Any] = [:]
        
        if let amountToCapture {
            body["amount_to_capture"] = amountToCapture
        }
        
        if let applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }

        if let statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let statementDescriptorSuffix {
            body["statement_descriptor_suffix"] = statementDescriptorSuffix
        }
        
        if let transferData {
            transferData.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(paymentintents)/\(intent)/capture", body: .string(body.queryParameters), headers: headers)
    }
    
    public func cancel(intent: String,
                       cancellationReason: PaymentIntentCancellationReason? = nil,
                       expand: [String]? = nil) async throws -> PaymentIntent {
        var body: [String: Any] = [:]
        
        if let cancellationReason {
            body["cancellation_reason"] = cancellationReason.rawValue
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(paymentintents)/\(intent)/cancel", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> PaymentIntentList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: paymentintents, query: queryParams, headers: headers)
    }
    
    public func incrementAuthorization(intent: String,
                                       amount: Int,
                                       description: String? = nil,
                                       metadata: [String : String]? = nil,
                                       statementDescription: String? = nil,
                                       applicationFeeAmount: Int? = nil,
                                       transferdata: [String: Any]? = nil) async throws -> PaymentIntent {
        var body: [String: Any] = ["amount": amount]
                
        if let description {
            body["description"] = description
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let statementDescription {
            body["statement_description"] = statementDescription
        }
        
        if let applicationFeeAmount {
            body["application_fee_amount"] = applicationFeeAmount
        }
        
        if let transferdata {
            transferdata.forEach { body["transfer_data[\($0)]"] = $1 }
        }
        
        return try await apiHandler.send(method: .POST,
                                         path: "\(paymentintents)/\(intent)/increment_authorization",
                                         body: .string(body.queryParameters),
                                         headers: headers)
    }
    
    public func search(query: String,
                       limit: Int? = nil,
                       page: String? = nil) async throws -> PaymentIntentSearchResult {
        return try await self.search(query: query, limit:limit, page:page, expand:nil)
    }
    
    public func search(query: String,
                       limit: Int? = nil,
                       page: String? = nil,
                       expand:[String]? = nil) async throws -> PaymentIntentSearchResult {
        var queryParams: [String: Any] = ["query": query]
        
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        if let limit {
            queryParams["limit"] = limit
        }
        
        if let page {
            queryParams["page"] = page
        }
        
        return try await apiHandler.send(method: .GET, path: "\(paymentintents)/search", query: queryParams.queryParameters, body: .string(body.queryParameters), headers: headers)
    }
    
    public func verifyMicroDeposits(intent: String,
                                    amounts: [Int]? = nil,
                                    descriptorCode: String? = nil) async throws -> PaymentIntent {
        var body: [String: Any] = [:]
        
        if let amounts {
            body["amounts"] = amounts
        }
        
        if let descriptorCode {
            body["descriptor_code"] = descriptorCode
        }
        
        return try await apiHandler.send(method: .POST,
                                         path: "\(paymentintents)/\(intent)/verify_microdeposits",
                                         body: .string(body.queryParameters),
                                         headers: headers)
    }
    
    public func reconcileCustomerBalance(intent: String, amount: Int? = nil, currency: Currency? = nil) async throws -> PaymentIntent {
        var body: [String: Any] = [:]
        
        if let amount {
            body["amount"] = amount
        }
        
        if let currency {
            body["currency"] = currency.rawValue
        }
        
        return try await apiHandler.send(method: .POST,
                                         path: "\(paymentintents)/\(intent)/apply_customer_balance",
                                         body: .string(body.queryParameters),
                                         headers: headers)
    }
}
