//
//  SetupIntentRoutes.swift
//  
//
//  Created by Andrew Edwards on 11/28/19.
//

import NIO
import NIOHTTP1
import Baggage

public protocol SetupIntentsRoutes {
    
    /// Creates a SetupIntent Object. After the SetupIntent is created, attach a payment method and confirm to collect any required permissions to charge the payment method later.
    /// - Parameter confirm: Set to true to attempt to confirm this SetupIntent immediately. This parameter defaults to false. If the payment method attached is a card, a return_url may be provided in case additional authentication is required.
    /// - Parameter customer: ID of the Customer this SetupIntent belongs to, if one exists. If present, payment methods used with this SetupIntent can only be attached to this Customer, and payment methods
    /// - Parameter description: An arbitrary string attached to the object. Often useful for displaying to users.
    /// - Parameter mandateData: This hash contains details about the Mandate to create. This parameter can only be used with `confirm=true`.
    /// - Parameter metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    /// - Parameter onBehalfOf: The Stripe account ID for which this SetupIntent is created.
    /// - Parameter paymentMethod: ID of the payment method (a PaymentMethod, Card, or saved Source object) to attach to this SetupIntent.
    /// - Parameter paymentMethodOptions: Payment-method-specific configuration for this SetupIntent.
    /// - Parameter paymentMethodTypes: The list of payment method types that this SetupIntent is allowed to set up. If this is not provided, defaults to `[“card”]`. Valid payment method types include: `card` and `ideal`.
    /// - Parameter returnUrl: The URL to redirect your customer back to after they authenticate or cancel their payment on the payment method’s app or site. If you’d prefer to redirect to a mobile application, you can alternatively supply an application URI scheme. This parameter can only be used with `confirm=true`.
    /// - Parameter singleUse: If this hash is populated, this SetupIntent will generate a single_use Mandate on success.
    /// - Parameter usage: Indicates how the payment method is intended to be used in the future. If not provided, this value defaults to `off_session`.
    /// - Parameter expand: An array of properties to expand.
    func create(confirm: Bool?,
                customer: String?,
                description: String?,
                mandateData: [String: Any]?,
                metadata: [String: String]?,
                onBehalfOf: String?,
                paymentMethod: String?,
                paymentMethodOptions: [String: Any]?,
                paymentMethodTypes: [String]?,
                returnUrl: String?,
                singleUse: [String: Any]?,
                usage: String?,
                expand: [String]?,
                context: LoggingContext) -> EventLoopFuture<StripeSetupIntent>
    
    /// Retrieves the details of a SetupIntent that has previously been created.
    /// - Parameter intent: ID of the SetupIntent to retrieve.
    /// - Parameter clientSecret: The client secret of the SetupIntent. Required if a publishable key is used to retrieve the SetupIntent.
    /// - Parameter expand: An array of properties to expand.
    func retrieve(intent: String, clientSecret: String?, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeSetupIntent>
    
    /// Updates a SetupIntent object.
    /// - Parameter intent: ID of the SetupIntent to retrieve.
    /// - Parameter customer: ID of the Customer this SetupIntent belongs to, if one exists. If present, payment methods used with this SetupIntent can only be attached to this Customer, and payment methods attached to other Customers cannot be used with this SetupIntent.
    /// - Parameter description: An arbitrary string attached to the object. Often useful for displaying to users.
    /// - Parameter metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    /// - Parameter paymentMethod: ID of the payment method (a PaymentMethod, Card, or saved Source object) to attach to this SetupIntent.
    /// - Parameter paymentMethodTypes: The list of payment method types (e.g. card) that this SetupIntent is allowed to set up. If this is not provided, defaults to [“card”].
    /// - Parameter expand: An array of properties to expand.
    func update(intent: String,
                customer: String?,
                description: String?,
                metadata: [String: String]?,
                paymentMethod: String?,
                paymentMethodTypes: [String]?,
                expand: [String]?,
                context: LoggingContext) -> EventLoopFuture<StripeSetupIntent>
    
    /// Confirm that your customer intends to set up the current or provided payment method. For example, you would confirm a SetupIntent when a customer hits the “Save” button on a payment method management page on your website.
    /// If the selected payment method does not require any additional steps from the customer, the SetupIntent will transition to the succeeded status.
    /// Otherwise, it will transition to the `requires_action` status and suggest additional actions via `next_action`. If setup fails, the SetupIntent will transition to the `requires_payment_method` status.
    /// - Parameter intent: ID of the SetupIntent to retrieve.
    /// - Parameter mandateData: This hash contains details about the Mandate to create
    /// - Parameter paymentMethod: ID of the payment method (a PaymentMethod, Card, or saved Source object) to attach to this SetupIntent.
    /// - Parameter paymentMethodOptions: Payment-method-specific configuration for this SetupIntent.
    /// - Parameter returnUrl: The URL to redirect your customer back to after they authenticate on the payment method’s app or site. If you’d prefer to redirect to a mobile application, you can alternatively supply an application URI scheme. This parameter is only used for cards and other redirect-based payment methods.
    /// - Parameter expand: An array of properties to expand.
    func confirm(intent: String,
                 mandateData: [String: Any]?,
                 paymentMethod: String?,
                 paymentMethodOptions: [String: Any]?,
                 returnUrl: String?,
                 expand: [String]?,
                 context: LoggingContext) -> EventLoopFuture<StripeSetupIntent>
    
    /// A SetupIntent object can be canceled when it is in one of these statuses: `requires_payment_method`, `requires_capture`, `requires_confirmation`, `requires_action`.
    /// Once canceled, setup is abandoned and any operations on the SetupIntent will fail with an error.
    /// - Parameter intent: ID of the SetupIntent to retrieve.
    /// - Parameter cancellationReason: Reason for canceling this SetupIntent. Possible values are `abandoned`, `requested_by_customer`, or `duplicate`.
    /// - Parameter expand: An array of properties to expand.
    func cancel(intent: String, cancellationReason: StripeSetupIntentCancellationReason?, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeSetupIntent>
    
    /// Returns a list of SetupIntents.
    /// - Parameter filter: A dictionary that contains the filters. More info [here](https://stripe.com/docs/api/setup_intents/list).
    func listAll(filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeSetupIntentsList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension SetupIntentsRoutes {
    public func create(confirm: Bool? = nil,
                       customer: String? = nil,
                       description: String? = nil,
                       mandateData: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       onBehalfOf: String? = nil,
                       paymentMethod: String? = nil,
                       paymentMethodOptions: [String: Any]? = nil,
                       paymentMethodTypes: [String]? = nil,
                       returnUrl: String? = nil,
                       singleUse: [String: Any]? = nil,
                       usage: String? = nil,
                       expand: [String]? = nil,
                       context: LoggingContext) -> EventLoopFuture<StripeSetupIntent> {
        return create(confirm: confirm,
                      customer: customer,
                      description: description,
                      mandateData: mandateData,
                      metadata: metadata,
                      onBehalfOf: onBehalfOf,
                      paymentMethod: paymentMethod,
                      paymentMethodOptions: paymentMethodOptions,
                      paymentMethodTypes: paymentMethodTypes,
                      returnUrl: returnUrl,
                      singleUse: singleUse,
                      usage: usage,
                      expand: expand,
                      context: context)
    }
    
    public func retrieve(intent: String, clientSecret: String? = nil, expand: [String]? = nil, context: LoggingContext) -> EventLoopFuture<StripeSetupIntent> {
        retrieve(intent: intent, clientSecret: clientSecret, expand: expand, context: context)
    }
    
    public func update(intent: String,
                       customer: String? = nil,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       paymentMethod: String? = nil,
                       paymentMethodTypes: [String]? = nil,
                       expand: [String]? = nil,
                       context: LoggingContext) -> EventLoopFuture<StripeSetupIntent> {
        return update(intent: intent,
                      customer: customer,
                      description: description,
                      metadata: metadata,
                      paymentMethod: paymentMethod,
                      paymentMethodTypes: paymentMethodTypes,
                      expand: expand,
                      context: context)
    }
    
    public func confirm(intent: String,
                        mandateData: [String: Any]? = nil,
                        paymentMethod: String? = nil,
                        paymentMethodOptions: [String: Any]? = nil,
                        returnUrl: String? = nil,
                        expand: [String]? = nil,
                        context: LoggingContext) -> EventLoopFuture<StripeSetupIntent> {
        return confirm(intent: intent,
                       mandateData: mandateData,
                       paymentMethod: paymentMethod,
                       paymentMethodOptions: paymentMethodOptions,
                       returnUrl: returnUrl,
                       expand: expand,
                       context: context)
    }
    
    public func cancel(intent: String,
                       cancellationReason: StripeSetupIntentCancellationReason? = nil,
                       expand: [String]? = nil,
                       context: LoggingContext) -> EventLoopFuture<StripeSetupIntent> {
        return cancel(intent: intent, cancellationReason: cancellationReason, expand: expand, context: context)
    }
    
    public func listAll(filter: [String: Any]? = nil, context: LoggingContext) -> EventLoopFuture<StripeSetupIntentsList> {
        return listAll(filter: filter, context: context)
    }
}

public struct StripeSetupIntentsRoutes: SetupIntentsRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let setupintents = APIBase + APIVersion + "setup_intents"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(confirm: Bool?,
                       customer: String?,
                       description: String?,
                       mandateData: [String: Any]?,
                       metadata: [String: String]?,
                       onBehalfOf: String?,
                       paymentMethod: String?,
                       paymentMethodOptions: [String: Any]?,
                       paymentMethodTypes: [String]?,
                       returnUrl: String?,
                       singleUse: [String: Any]?,
                       usage: String?,
                       expand: [String]?,
                       context: LoggingContext) -> EventLoopFuture<StripeSetupIntent> {
        var body: [String: Any] = [:]
        
        if let confirm = confirm {
            body["confirm"] = confirm
        }
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let mandateData = mandateData {
            mandateData.forEach { body["mandate_data[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let onBehalfOf = onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }
        
        if let paymentMethod = paymentMethod {
            body["payment_method"] = paymentMethod
        }
        
        if let paymentMethodOptions = paymentMethodOptions {
            paymentMethodOptions.forEach { body["payment_method_options[\($0)]"] = $1 }
        }
        
        if let paymentMethodTypes = paymentMethodTypes {
            body["payment_method_types"] = paymentMethodTypes
        }
        
        if let returnUrl = returnUrl {
            body["return_url"] = returnUrl
        }
        
        if let singleUse = singleUse {
            singleUse.forEach { body["single_use[\($0)]"] = $1 }
        }
        
        if let usage = usage {
            body["usage"] = usage
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: setupintents, body: .string(body.queryParameters), headers: headers, context: context)
    }
    
    public func retrieve(intent: String, clientSecret: String?, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeSetupIntent> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(setupintents)/\(intent)", query: queryParams, headers: headers, context: context)
    }
    
    public func update(intent: String,
                       customer: String?,
                       description: String?,
                       metadata: [String: String]?,
                       paymentMethod: String?,
                       paymentMethodTypes: [String]?,
                       expand: [String]?,
                       context: LoggingContext) -> EventLoopFuture<StripeSetupIntent> {
        var body: [String: Any] = [:]
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let paymentMethod = paymentMethod {
            body["payment_method"] = paymentMethod
        }
        
        if let paymentMethodTypes = paymentMethodTypes {
            body["payment_method_types"] = paymentMethodTypes
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(setupintents)/\(intent)", body: .string(body.queryParameters), headers: headers, context: context)
    }
    
    public func confirm(intent: String,
                        mandateData: [String: Any]?,
                        paymentMethod: String?,
                        paymentMethodOptions: [String: Any]?,
                        returnUrl: String?,
                        expand: [String]?,
                        context: LoggingContext) -> EventLoopFuture<StripeSetupIntent> {
        var body: [String: Any] = [:]
        
        if let mandateData = mandateData {
            mandateData.forEach { body["mandate_data[\($0)]"] = $1 }
        }
        
        if let paymentMethod = paymentMethod {
            body["payment_method"] = paymentMethod
        }
        
        if let paymentMethodOptions = paymentMethodOptions {
            paymentMethodOptions.forEach { body["payment_method_options[\($0)]"] = $1 }
        }
        
        if let returnUrl = returnUrl {
            body["return_url"] = returnUrl
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(setupintents)/\(intent)/confirm", body: .string(body.queryParameters), headers: headers, context: context)
    }
    
    public func cancel(intent: String, cancellationReason: StripeSetupIntentCancellationReason?, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeSetupIntent> {
        var body: [String: Any] = [:]
        
        if let cancellationReason = cancellationReason {
            body["cancellation_reason"] = cancellationReason.rawValue
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(setupintents)/\(intent)/cancel", body: .string(body.queryParameters), headers: headers, context: context)
    }
    
    public func listAll(filter: [String: Any]? = nil, context: LoggingContext) -> EventLoopFuture<StripeSetupIntentsList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: setupintents, query: queryParams, headers: headers, context: context)
    }
}


