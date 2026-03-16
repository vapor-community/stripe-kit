//
//  CustomerSessionRoutes.swift
//  stripe-kit
//
//  Created by Anatol Mayen on 11.11.24.
//


import NIO
import NIOHTTP1

public protocol CustomerSessionRoutes: StripeAPIRoute {
    
    func create(enable type: Components.ComponentsType, customer: String, expand: [String]?) async throws -> CustomerSession
}

public struct StripeCustomerSessionRoutes: CustomerSessionRoutes {
    
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let customerSessions = APIBase + APIVersion + "customer_sessions"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(enable type: Components.ComponentsType, customer: String, expand: [String]? = nil) async throws -> CustomerSession {
        
        var body = [String: Any]()
        let components = Components(enable: type)
        
        body["customer"] = customer
        body["components[buy_button][enabled]"] = components.buyButton.enabled
        body["components[payment_element][enabled]"] = components.paymentElement.enabled
        body["components[pricing_table][enabled]"] = components.pricingTable.enabled
        
        if let expand {
            body["expand"] = expand
        }

        return try await apiHandler.send(method: .POST, path: customerSessions, body: .string(body.queryParameters), headers: headers)
    }
}
