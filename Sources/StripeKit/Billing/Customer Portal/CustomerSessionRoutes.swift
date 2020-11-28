//
//  CustomerSessionRoutes.swift
//  
//
//  Created by Andrew Edwards on 11/28/20.
//

import NIO
import NIOHTTP1

public protocol CustomerSessionRoutes {
    
    /// Creates a session of the customer portal.
    /// - Parameters:
    ///   - customer: The ID of an existing customer.
    ///   - returnUrl: The URL to which Stripe should send customers when they click on the link to return to your website. This field is required if a default return URL has not been configured for the portal.
    func create(customer: String, returnUrl: String?) -> EventLoopFuture<StripeCustomerSession>
}

extension CustomerSessionRoutes {
    public func create(customer: String, returnUrl: String? = nil) -> EventLoopFuture<StripeCustomerSession> {
        create(customer: customer, returnUrl: returnUrl)
    }
}

public struct StripeCustomerSessionRoutes: CustomerSessionRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let sessions = APIBase + APIVersion + "billing_portal/sessions"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(customer: String, returnUrl: String?) -> EventLoopFuture<StripeCustomerSession> {
        var body: [String: Any] = ["customer": customer]
        
        if let returnUrl = returnUrl {
            body["return_url"] = returnUrl
        }
        
        return apiHandler.send(method: .POST, path: sessions, body: .string(body.queryParameters))
    }
}
