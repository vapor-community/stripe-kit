//
//  SetupIntentRoutes.swift
//  
//
//  Created by Andrew Edwards on 11/28/19.
//

import NIO
import NIOHTTP1

public protocol SetupIntentsRoutes: StripeAPIRoute {    
    /// Creates a SetupIntent Object. After the SetupIntent is created, attach a payment method and confirm to collect any required permissions to charge the payment method later.
    /// - Parameters:
    ///   - confirm: Set to `true` to attempt to confirm this SetupIntent immediately. This parameter defaults to `false`. If the payment method attached is a card, a `return_url` may be provided in case additional authentication is required.
    ///   - customer: ID of the Customer this SetupIntent belongs to, if one exists. If present, the SetupIntent’s payment method will be attached to the Customer on successful setup. Payment methods attached to other Customers cannot be used with this SetupIntent.
    ///   - description: An arbitrary string attached to the object. Often useful for displaying to users.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - paymentMethod: ID of the payment method (a PaymentMethod, Card, or saved Source object) to attach to this SetupIntent.
    ///   - paymentMethodTypes: The list of payment method types that this SetupIntent is allowed to set up. If this is not provided, defaults to `[“card”]`. Valid payment method types include: `acss_debit`, `au_becs_debit`, `bacs_debit`, `bancontact`, `blik`, `boleto`, `card`, `card_present`, `cashapp`, `ideal`, `link`, `sepa_debit`, `sofort`, and `us_bank_account`.
    ///   - usage: Indicates how the payment method is intended to be used in the future. If not provided, this value defaults to `off_session`.
    ///   - attachToSelf: If present, the SetupIntent’s payment method will be attached to the in-context Stripe Account. It can only be used for this Stripe Account’s own money movement flows like InboundTransfer and OutboundTransfers. It cannot be set to true when setting up a PaymentMethod for a Customer, and defaults to false when attaching a PaymentMethod to a Customer.
    ///   - automaticPaymentMethods: When enabled, this SetupIntent will accept payment methods that you have enabled in the Dashboard and are compatible with this SetupIntent’s other parameters.
    ///   - flowDirections: Indicates the directions of money movement for which this payment method is intended to be used. Include `inbound` if you intend to use the payment method as the origin to pull funds from. Include `outbound` if you intend to use the payment method as the destination to send funds to. You can include both if you intend to use the payment method for both purposes.
    ///   - mandateData: This hash contains details about the Mandate to create. This parameter can only be used with `confirm=true`.
    ///   - onBehalfOf: The Stripe account ID for which this SetupIntent is created.
    ///   - paymentMethodData: When included, this hash creates a PaymentMethod that is set as the `payment_method` value in the SetupIntent.
    ///   - paymentMethodOptions: Payment-method-specific configuration for this SetupIntent.
    ///   - returnUrl: The URL to redirect your customer back to after they authenticate or cancel their payment on the payment method’s app or site. If you’d prefer to redirect to a mobile application, you can alternatively supply an application URI scheme. This parameter can only be used with `confirm=true`.
    ///   - singleUse: If this hash is populated, this SetupIntent will generate a `single_use` Mandate on success.
    ///   - expand: An array of properties to expand.
    func create(confirm: Bool?,
                customer: String?,
                description: String?,
                metadata: [String: String]?,
                paymentMethod: String?,
                paymentMethodTypes: [String]?,
                usage: String?,
                attachToSelf: Bool?,
                automaticPaymentMethods: [String: Any]?,
                flowDirections: String?,
                mandateData: [String: Any]?,
                onBehalfOf: String?,
                paymentMethodData: [String: Any]?,
                paymentMethodOptions: [String: Any]?,
                returnUrl: String?,
                singleUse: [String: Any]?,
                expand: [String]?) async throws -> SetupIntent
    
    /// Retrieves the details of a SetupIntent that has previously been created.
    /// - Parameter intent: ID of the SetupIntent to retrieve.
    /// - Parameter clientSecret: The client secret of the SetupIntent. Required if a publishable key is used to retrieve the SetupIntent.
    /// - Parameter expand: An array of properties to expand.
    func retrieve(intent: String, clientSecret: String?, expand: [String]?) async throws -> SetupIntent
    
    /// Updates a SetupIntent object.
    /// - Parameters:
    ///   - intent: ID of the SetupIntent to retrieve.
    ///   - customer: ID of the Customer this SetupIntent belongs to, if one exists. If present, payment methods used with this SetupIntent can only be attached to this Customer, and payment methods attached to other Customers cannot be used with this SetupIntent.
    ///   - description: An arbitrary string attached to the object. Often useful for displaying to users.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - paymentMethod: ID of the payment method (a PaymentMethod, Card, or saved Source object) to attach to this SetupIntent.
    ///   - paymentMethodTypes: The list of payment method types (e.g. card) that this SetupIntent is allowed to set up. If this is not provided, defaults to [“card”].
    ///   - attachToSelf: If present, the SetupIntent’s payment method will be attached to the in-context Stripe Account. It can only be used for this Stripe Account’s own money movement flows like InboundTransfer and OutboundTransfers. It cannot be set to true when setting up a PaymentMethod for a Customer, and defaults to false when attaching a PaymentMethod to a Customer.
    ///   - flowDirections: Indicates the directions of money movement for which this payment method is intended to be used. Include inbound if you intend to use the payment method as the origin to pull funds from. Include outbound if you intend to use the payment method as the destination to send funds to. You can include both if you intend to use the payment method for both purposes.
    ///   - paymentMethodData: When included, this hash creates a PaymentMethod that is set as the payment_method value in the SetupIntent.
    ///   - paymentMethodOptions: Payment-method-specific configuration for this SetupIntent.
    ///   - expand: An array of properties to expand.
    func update(intent: String,
                customer: String?,
                description: String?,
                metadata: [String: String]?,
                paymentMethod: String?,
                paymentMethodTypes: [String]?,
                attachToSelf: Bool?,
                flowDirections: String?,
                paymentMethodData: [String: Any]?,
                paymentMethodOptions: [String: Any]?,
                expand: [String]?) async throws -> SetupIntent
    
    /// Confirm that your customer intends to set up the current or provided payment method. For example, you would confirm a SetupIntent when a customer hits the “Save” button on a payment method management page on your website.
    /// If the selected payment method does not require any additional steps from the customer, the SetupIntent will transition to the succeeded status.
    /// Otherwise, it will transition to the `requires_action` status and suggest additional actions via `next_action`. If setup fails, the SetupIntent will transition to the `requires_payment_method` status.
    /// - Parameters:
    ///   - intent: ID of the SetupIntent to retrieve.
    ///   - paymentMethod: ID of the payment method (a PaymentMethod, Card, or saved Source object) to attach to this SetupIntent.
    ///   - paymentMethodData: When included, this hash creates a PaymentMethod that is set as the payment_method value in the SetupIntent.
    ///   - mandateData: This hash contains details about the Mandate to create
    ///   - paymentMethodOptions: Payment-method-specific configuration for this SetupIntent.
    ///   - returnUrl: The URL to redirect your customer back to after they authenticate on the payment method’s app or site. If you’d prefer to redirect to a mobile application, you can alternatively supply an application URI scheme. This parameter is only used for cards and other redirect-based payment methods.
    ///   - expand: An array of properties to expand.
    func confirm(intent: String,
                 paymentMethod: String?,
                 mandateData: [String: Any]?,
                 paymentMethodData: [String: Any]?,
                 paymentMethodOptions: [String: Any]?,
                 returnUrl: String?,
                 expand: [String]?) async throws -> SetupIntent
    
    /// A SetupIntent object can be canceled when it is in one of these statuses: `requires_payment_method`, `requires_capture`, `requires_confirmation`, `requires_action`.
    /// Once canceled, setup is abandoned and any operations on the SetupIntent will fail with an error.
    /// - Parameter intent: ID of the SetupIntent to retrieve.
    /// - Parameter cancellationReason: Reason for canceling this SetupIntent. Possible values are `abandoned`, `requested_by_customer`, or `duplicate`.
    /// - Parameter expand: An array of properties to expand.
    func cancel(intent: String, cancellationReason: SetupIntentCancellationReason?, expand: [String]?) async throws -> SetupIntent
    
    /// Returns a list of SetupIntents.
    /// - Parameter filter: A dictionary that contains the filters. More info [here](https://stripe.com/docs/api/setup_intents/list)
    func listAll(filter: [String: Any]?) async throws -> SetupIntentsList
    
    
    /// Verifies microdeposits on a SetupIntent object.
    /// - Parameters:
    ///   - intent: Id of the setup intent
    ///   - amounts: Two positive integers, in cents, equal to the values of the microdeposits sent to the bank account.
    ///   - descriptorCode: A six-character code starting with SM present in the microdeposit sent to the bank account.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns a SetupIntent object.
    func verifyMicrodeposits(intent: String,
                             amounts: [Int]?,
                             descriptorCode: String?,
                             expand: [String]?) async throws -> SetupIntent
}

public struct StripeSetupIntentsRoutes: SetupIntentsRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let setupintents = APIBase + APIVersion + "setup_intents"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(confirm: Bool? = nil,
                       customer: String? = nil,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       paymentMethod: String? = nil,
                       paymentMethodTypes: [String]? = nil,
                       usage: String? = nil,
                       attachToSelf: Bool? = nil,
                       automaticPaymentMethods: [String: Any]? = nil,
                       flowDirections: String? = nil,
                       mandateData: [String: Any]? = nil,
                       onBehalfOf: String? = nil,
                       paymentMethodData: [String: Any]? = nil,
                       paymentMethodOptions: [String: Any]? = nil,
                       returnUrl: String? = nil,
                       singleUse: [String: Any]? = nil,
                       expand: [String]? = nil) async throws -> SetupIntent {
        var body: [String: Any] = [:]
        
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
        
        if let paymentMethod {
            body["payment_method"] = paymentMethod
        }
        
        if let paymentMethodTypes {
            body["payment_method_types"] = paymentMethodTypes
        }
        
        if let usage {
            body["usage"] = usage
        }
        
        if let attachToSelf {
            body["attach_to_self"] = attachToSelf
        }
        
        if let automaticPaymentMethods {
            automaticPaymentMethods.forEach { body["automatic_payment_methods[\($0)]"] = $1 }
        }
        
        if let flowDirections {
            body["flow_directions"] = flowDirections
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
        
        if let returnUrl {
            body["return_url"] = returnUrl
        }
        
        if let singleUse {
            singleUse.forEach { body["single_use[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: setupintents, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(intent: String,
                         clientSecret: String? = nil,
                         expand: [String]? = nil) async throws -> SetupIntent {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(setupintents)/\(intent)", query: queryParams, headers: headers)
    }
    
    public func update(intent: String,
                       customer: String? = nil,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       paymentMethod: String? = nil,
                       paymentMethodTypes: [String]? = nil,
                       attachToSelf: Bool? = nil,
                       flowDirections: String? = nil,
                       paymentMethodData: [String: Any]? = nil,
                       paymentMethodOptions: [String: Any]? = nil,
                       expand: [String]? = nil) async throws -> SetupIntent {
        
        var body: [String: Any] = [:]
        
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
        
        if let paymentMethodTypes {
            body["payment_method_types"] = paymentMethodTypes
        }
        
        if let attachToSelf {
            body["attach_to_self"] = attachToSelf
        }
        
        if let flowDirections {
            body["flow_directions"] = flowDirections
        }
        
        if let paymentMethodData {
            paymentMethodData.forEach { body["payment_method_data[\($0)]"] = $1 }
        }
        
        if let paymentMethodOptions {
            paymentMethodOptions.forEach { body["payment_method_options[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(setupintents)/\(intent)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func confirm(intent: String,
                        paymentMethod: String? = nil,
                        mandateData: [String: Any]? = nil,
                        paymentMethodData: [String: Any]? = nil,
                        paymentMethodOptions: [String: Any]? = nil,
                        returnUrl: String? = nil,
                        expand: [String]? = nil) async throws -> SetupIntent {
        var body: [String: Any] = [:]
        
        if let paymentMethod {
            body["payment_method"] = paymentMethod
        }
        
        if let mandateData {
            mandateData.forEach { body["mandate_data[\($0)]"] = $1 }
        }
        
        if let paymentMethodData {
            paymentMethodData.forEach { body["payment_method_data[\($0)]"] = $1 }
        }
        
        if let paymentMethodOptions {
            paymentMethodOptions.forEach { body["payment_method_options[\($0)]"] = $1 }
        }
        
        if let returnUrl {
            body["return_url"] = returnUrl
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(setupintents)/\(intent)/confirm", body: .string(body.queryParameters), headers: headers)
    }
    
    public func cancel(intent: String,
                       cancellationReason: SetupIntentCancellationReason? = nil,
                       expand: [String]? = nil) async throws -> SetupIntent {
        var body: [String: Any] = [:]
        
        if let cancellationReason {
            body["cancellation_reason"] = cancellationReason.rawValue
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(setupintents)/\(intent)/cancel", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> SetupIntentsList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: setupintents, query: queryParams, headers: headers)
    }
    
    public func verifyMicrodeposits(intent: String,
                                    amounts: [Int]? = nil,
                                    descriptorCode: String? = nil,
                                    expand: [String]? = nil) async throws -> SetupIntent {
        
        var body: [String: Any] = [:]
        
        if let amounts {
            body["amounts"] = amounts
        }
        
        if let descriptorCode {
            body["descriptor_code"] = descriptorCode
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(setupintents)/\(intent)/verify_microdeposits", body: .string(body.queryParameters), headers: headers)
    }
}
