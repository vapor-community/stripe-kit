//
//  PortalSessionRoutes.swift
//  
//
//  Created by Andrew Edwards on 11/28/20.
//

import NIO
import NIOHTTP1
import Baggage

public protocol PortalSessionRoutes {
    /// Creates a session of the customer portal.
    /// - Parameters:
    ///   - customer: The ID of an existing customer.
    ///   - returnUrl: The default URL to redirect customers to when they click on the portal’s link to return to your website.
    ///  - configuration: The configuration to use for this session, describing its functionality and features. If not specified, the session uses the default configuration.
    ///  - onBehalfOf: The `on_behalf_of` account to use for this session. When specified, only subscriptions and invoices with this `on_behalf_of` account appear in the portal. For more information, see the docs. Use the Accounts API to modify the `on_behalf_of` account’s branding settings, which the portal displays.
    ///  - expand: An array of properties to expand.
    func create(customer: String,
                returnUrl: String?,
                configuration: [String: Any]?,
                onBehalfOf: String?,
                expand: [String]?,
                context: LoggingContext) -> EventLoopFuture<StripePortalSession>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension PortalSessionRoutes {
    public func create(customer: String,
                       returnUrl: String? = nil,
                       configuration: [String: Any]? = nil,
                       onBehalfOf: String? = nil,
                       expand: [String]? = nil,
                       context: LoggingContext) -> EventLoopFuture<StripePortalSession> {
        create(customer: customer,
               returnUrl: returnUrl,
               configuration: configuration,
               onBehalfOf: onBehalfOf,
               expand: expand)
    }
}

public struct StripePortalSessionRoutes: PortalSessionRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let sessions = APIBase + APIVersion + "billing_portal/sessions"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(customer: String,
                       returnUrl: String?,
                       configuration: [String: Any]?,
                       onBehalfOf: String?,
                       expand: [String]?,
                       context: LoggingContext) -> EventLoopFuture<StripePortalSession> {
        var body: [String: Any] = ["customer": customer]
        
        if let returnUrl = returnUrl {
            body["return_url"] = returnUrl
        }
        
        if let configuration = configuration {
            configuration.forEach { body["configuration[\($0)]"] = $1 }
        }
        
        if let onBehalfOf = onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: sessions, body: .string(body.queryParameters), headers: headers)
    }
}
