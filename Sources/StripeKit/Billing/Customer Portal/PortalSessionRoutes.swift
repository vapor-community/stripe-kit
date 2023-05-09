//
//  PortalSessionRoutes.swift
//  
//
//  Created by Andrew Edwards on 11/28/20.
//

import NIO
import NIOHTTP1

public protocol PortalSessionRoutes: StripeAPIRoute {
    /// Creates a session of the customer portal.
    /// - Parameters:
    ///   - customer: The ID of an existing customer.
    ///   - configuration: The configuration to use for this session, describing its functionality and features. If not specified, the session uses the default configuration.
    ///   - flowData: Information about a specific flow for the customer to go through. See the docs to learn more about using customer portal deep links and flows.
    ///   - locale: The IETF language tag of the locale Customer Portal is displayed in. If blank or auto, the customer’s `preferred_locales` or browser’s locale is used.
    ///   - onBehalfOf: The `on_behalf_of` account to use for this session. When specified, only subscriptions and invoices with this `on_behalf_of` account appear in the portal. For more information, see the docs. Use the Accounts API to modify the `on_behalf_of` account’s branding settings, which the portal displays.
    ///   - returnUrl: The default URL to redirect customers to when they click on the portal’s link to return to your website.
    ///   - expand: An array of properties to expand.
    func create(customer: String,
                configuration: [String: Any]?,
                flowData: [String: Any]?,
                locale: String?,
                onBehalfOf: String?,
                returnUrl: String?,
                expand: [String]?) async throws -> PortalSession
}

public struct StripePortalSessionRoutes: PortalSessionRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let sessions = APIBase + APIVersion + "billing_portal/sessions"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(customer: String,
                       configuration: [String: Any]? = nil,
                       flowData: [String: Any]? = nil,
                       locale: String? = nil,
                       onBehalfOf: String? = nil,
                       returnUrl: String? = nil,
                       expand: [String]? = nil) async throws -> PortalSession {
        var body: [String: Any] = ["customer": customer]
        
        if let configuration {
            configuration.forEach { body["configuration[\($0)]"] = $1 }
        }
        
        if let flowData {
            flowData.forEach { body["flow_data[\($0)]"] = $1 }
        }
        
        if let locale {
            body["locale"] = locale
        }
        
        if let onBehalfOf {
            body["on_behalf_of"] = onBehalfOf
        }
        
        if let returnUrl {
            body["return_url"] = returnUrl
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: sessions, body: .string(body.queryParameters), headers: headers)
    }
}
