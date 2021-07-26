//
//  CapabiliitiesRoutes.swift
//  
//
//  Created by Andrew Edwards on 11/29/19.
//

import NIO
import NIOHTTP1
import Baggage

public protocol CapabilitiesRoutes {
    
    /// Retrieves information about the specified Account Capability.
    /// - Parameters:
    ///   - capability: The ID of an account capability to retrieve.
    ///   - expand: An array of properties to expand.
    func retrieve(capability: String, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeCapability>
    
    /// Updates an existing Account Capability.
    /// - Parameter capability: The ID of an account capability to update.
    /// - Parameter requested: Passing true requests the capability for the account, if it is not already requested. A requested capability may not immediately become active. Any requirements to activate the capability are returned in the `requirements` arrays.
    /// - Parameter expand: An array of properties to expand.
    func update(capability: String, requested: Bool?, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeCapability>
    
    /// Returns a list of capabilities associated with the account. The capabilities are returned sorted by creation date, with the most recent capability appearing first.
    /// - Parameter account: The ID of the connect account.
    func listAll(account: String, context: LoggingContext) -> EventLoopFuture<StripeCapabilitiesList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension CapabilitiesRoutes {
    public func retrieve(capability: String, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeCapability> {
        return retrieve(capability: capability, expand: expand, context: context)
    }
    
    public func update(capability: String, requested: Bool? = nil, expand: [String]? = nil, context: LoggingContext) -> EventLoopFuture<StripeCapability> {
        return update(capability: capability, requested: requested, expand: expand, context: context)
    }
    
    public func listAll(account: String, context: LoggingContext) -> EventLoopFuture<StripeCapabilitiesList> {
        return listAll(account: account, context: context)
    }
}

public struct StripeCapabilitiesRoutes: CapabilitiesRoutes {
    public var headers: HTTPHeaders = [:]

    private let apiHandler: StripeAPIHandler
    private let capabilities = APIBase + APIVersion + "accounts"

    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func retrieve(capability: String, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeCapability> {
        var queryParams = ""
        
        if let expand = expand {
            queryParams += ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(capabilities)/\(capability)/capabilities/card_payments", query: queryParams, headers: headers, context: context)
    }
    
    public func update(capability: String, requested: Bool?, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeCapability> {
        var body: [String: Any] = [:]
        
        if let requested = requested {
            body["requested"] = requested
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(capabilities)/\(capability)/capabilities/card_payments", body: .string(body.queryParameters), headers: headers, context: context)
    }
    
    public func listAll(account: String, context: LoggingContext) -> EventLoopFuture<StripeCapabilitiesList> {
        return apiHandler.send(method: .GET, path: "\(capabilities)/\(account)/capabilities", headers: headers, context: context)
    }
}
