//
//  SecretRoutes.swift
//  
//
//  Created by Andrew Edwards on 5/18/23.
//

import NIO
import NIOHTTP1
import Foundation

public protocol SecretRoutes: StripeAPIRoute {
    /// Create or replace a secret in the secret store.
    /// - Parameters:
    ///   - name: A  name for the secret that’s unique within the scope.
    ///   - payload: The plaintext secret value to be stored.
    ///   - scope: Specifies the scoping of the secret. Requests originating from UI extensions can only access account-scoped secrets or secrets scoped to their own user.
    ///   - expiresAt: The Unix timestamp for the expiry time of the secret, after which the secret deletes.
    ///   - expand: An Array of properties to expand.
    /// - Returns: Returns a secret object.
    func setSecret(name: String,
                   payload: String,
                   scope: [String: Any],
                   expiresAt: Date?,
                   expand: [String]?) async throws -> Secret
    
    /// Finds a secret in the secret store by name and scope.
    /// - Parameters:
    ///   - name: A name for the secret that’s unique within the scope.
    ///   - scope: Specifies the scoping of the secret. Requests originating from UI extensions can only access account-scoped secrets or secrets scoped to their own user.
    ///   - expand: An Array of properties to expand.
    /// - Returns: Returns a secret object.
    func find(name: String,
              scope: [String: Any],
              expand: [String]?) async throws -> Secret
    
    /// Deletes a secret from the secret store by name and scope.
    /// - Parameters:
    ///   - name: A name for the secret that’s unique within the scope.
    ///   - scope: Specifies the scoping of the secret. Requests originating from UI extensions can only access account-scoped secrets or secrets scoped to their own user.
    ///   - expand: An Array of properties to expand.
    /// - Returns: Returns the deleted secret object.
    func delete(name: String, scope: [String: Any], expand: [String]?) async throws -> Secret
    
    /// List all secrets stored on the given scope.
    /// - Parameters:
    ///   - scope: Specifies the scoping of the secret. Requests originating from UI extensions can only access account-scoped secrets or secrets scoped to their own user.
    ///   - filter: A dictionary used for query parameters.
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` Secrets, starting after Secret `starting_after`. Each entry in the array is a separate Secret object. If no more Secrets are available, the resulting array will be empty.
    func listAll(scope: [String: Any], filter: [String: Any]?) async throws -> SecretList
}

public struct StripeSecretRoutes: SecretRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let secrets = APIBase + APIVersion + "secrets"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func setSecret(name: String,
                          payload: String,
                          scope: [String: Any],
                          expiresAt: Date? = nil,
                          expand: [String]? = nil) async throws -> Secret {
        var body: [String: Any] = ["name" : name,
                                   "payload": payload,
                                   "scope" : scope]
        if let expiresAt {
            body["expires_at"] = Int(expiresAt.timeIntervalSince1970)
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: secrets, body: .string(body.queryParameters), headers: headers)
    }
    
    public func find(name: String,
                     scope: [String: Any],
                     expand: [String]? = nil) async throws -> Secret {
        var body: [String: Any] = ["name" : name,
                                   "scope" : scope]
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .GET, path: "\(secrets)/find", body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(name: String,
                       scope: [String: Any],
                       expand: [String]? = nil) async throws -> Secret {
        var body: [String: Any] = ["name" : name,
                                   "scope" : scope]
        if let expand {
            body["expand"] = expand
        }
        return try await apiHandler.send(method: .POST, path: "\(secrets)/delete", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(scope: [String: Any],
                        filter: [String: Any]? = nil) async throws -> SecretList {
        var queryParams = scope.queryParameters
        if let filter {
            queryParams += "&" + filter.queryParameters
        }
        return try await apiHandler.send(method: .GET, path: secrets, query: queryParams, headers: headers)
    }
}
