//
//  CapabilitiesRoutes.swift
//  
//
//  Created by Andrew Edwards on 11/29/19.
//

import NIO
import NIOHTTP1

public protocol CapabilitiesRoutes: StripeAPIRoute {
    
    /// Retrieves information about the specified Account Capability.
    /// - Parameters:
    ///   - capability: The ID of an account capability to retrieve.
    ///   - expand: An array of properties to expand.
    func retrieve(capability: String, expand: [String]?) async throws -> Capability
    
    /// Updates an existing Account Capability.
    /// - Parameter capability: The ID of an account capability to update.
    /// - Parameter requested: Passing true requests the capability for the account, if it is not already requested. A requested capability may not immediately become active. Any requirements to activate the capability are returned in the `requirements` arrays.
    /// - Parameter expand: An array of properties to expand.
    func update(capability: String, requested: Bool?, expand: [String]?) async throws -> Capability
    
    /// Returns a list of capabilities associated with the account. The capabilities are returned sorted by creation date, with the most recent capability appearing first.
    /// - Parameter account: The ID of the connect account.
    func listAll(account: String) async throws -> CapabilitiesList
}

public struct StripeCapabilitiesRoutes: CapabilitiesRoutes {
    public var headers: HTTPHeaders = [:]

    private let apiHandler: StripeAPIHandler
    private let capabilities = APIBase + APIVersion + "accounts"

    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func retrieve(capability: String, expand: [String]? = nil) async throws -> Capability {
        var queryParams = ""
        
        if let expand {
            queryParams += ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(capabilities)/\(capability)/capabilities/card_payments", query: queryParams, headers: headers)
    }
    
    public func update(capability: String,
                       requested: Bool? = nil,
                       expand: [String]? = nil) async throws -> Capability {
        var body: [String: Any] = [:]
        
        if let requested {
            body["requested"] = requested
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(capabilities)/\(capability)/capabilities/card_payments", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(account: String) async throws -> CapabilitiesList {
        try await apiHandler.send(method: .GET, path: "\(capabilities)/\(account)/capabilities", headers: headers)
    }
}
