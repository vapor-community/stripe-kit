//
//  EphemeralKeyRoutes.swift
//  
//
//  Created by Andrew Edwards on 7/31/23.
//

import NIO
import NIOHTTP1

public protocol EphemeralKeyRoutes: StripeAPIRoute {
    /// Creates a short-lived API key for a given resource
    /// - Parameters:
    ///   - customer: The ID of the Customer you'd like to modify using the resulting ephemeral key.
    ///   - issuingCard: The ID of the Issuing Card you'd like to access using the resulting ephemeral key.
    ///   - verificationSession: The ID of the Identity VerificationSession you'd like to access using the resulting ephemeral key
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: An ``EphemeralKey``.
    func create(customer: String?,
                issuingCard: String?,
                verificationSession: String?,
                expand: [String]?) async throws -> EphemeralKey
    
    /// Invalidates a short-lived API key for a given resource.
    /// - Parameters:
    ///   - id: The ID of the ephemeral key to delete.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: An ``EphemeralKey``.
    func delete(id: String, expand: [String]?) async throws -> EphemeralKey
}


public struct StripeEphemeralKeyRoutes: EphemeralKeyRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let ephemeralkeys = APIBase + APIVersion + "ephemeral_keys"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(customer: String? = nil,
                       issuingCard: String? = nil,
                       verificationSession: String? = nil,
                       expand: [String]? = nil) async throws -> EphemeralKey {
        var body: [String: Any] = [:]
        
        if let customer {
            body["customer"] = customer
        }
        
        if let issuingCard {
            body["issuing_card"] = issuingCard
        }
        
        if let verificationSession {
            body["verification_session"] = verificationSession
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: ephemeralkeys, body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(id: String, expand: [String]? = nil) async throws -> EphemeralKey {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .DELETE, path: "\(ephemeralkeys)/\(id)/close", body: .string(body.queryParameters), headers: headers)
    }
}
