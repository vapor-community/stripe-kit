//
//  PortalConfigurationRoutes.swift
//  
//
//  Created by Andrew Edwards on 2/25/21.
//

import NIO
import NIOHTTP1

public protocol PortalConfigurationRoutes: StripeAPIRoute {
    /// Creates a configuration that describes the functionality and behavior of a PortalSession
    /// - Parameters:
    ///   - businessProfile: The business information shown to customers in the portal.
    ///   - features: Information about the features available in the portal.
    ///   - defaultReturnUrl: The default URL to redirect customers to when they click on the portal’s link to return to your website. This can be overriden when creating the session.
    ///   - loginPage: The hosted login page for this configuration. Learn more about the portal login page in our integration docs.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    func create(businessProfile: [String: Any],
                features: [String: Any],
                defaultReturnUrl: String?,
                loginPage: [String: Any]?,
                metadata: [String: String]?) async throws -> PortalConfiguration
    
    /// Updates a configuration that describes the functionality of the customer portal.
    /// - Parameters:
    ///   - configuration: The identifier of the configuration to update.
    ///   - active: Whether the configuration is active and can be used to create portal sessions.
    ///   - businessProfile: The business information shown to customers in the portal.
    ///   - defaultReturnUrl: The default URL to redirect customers to when they click on the portal’s link to return to your website. This can be overriden when creating the session.
    ///   - features: Information about the features available in the portal.
    ///   - loginPage: The hosted login page for this configuration. Learn more about the portal login page in our integration docs.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    func update(configuration: String,
                active: Bool?,
                businessProfile: [String: Any]?,
                defaultReturnUrl: String?,
                features: [String: Any]?,
                loginPage: [String: Any]?,
                metadata: [String: String]?) async throws -> PortalConfiguration
    
    /// Retrieves a configuration that describes the functionality of the customer portal.
    /// - Parameter configuration: The identifier of the configuration to retrieve.
    func retrieve(configuration: String) async throws -> PortalConfiguration
    
    /// Returns a list of tax IDs for a customer.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters.
    /// - Returns: A `StripePortalConfigurationList`.
    func listAll(filter: [String: Any]?) async throws -> PortalConfigurationList
}

public struct StripePortalConfigurationRoutes: PortalConfigurationRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let portalconfiguration = APIBase + APIVersion + "billing_portal/configurations"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(businessProfile: [String: Any],
                       features: [String: Any],
                       defaultReturnUrl: String? = nil,
                       loginPage: [String: Any]? = nil,
                       metadata: [String: String]? = nil) async throws -> PortalConfiguration {
        var body: [String: Any] = [:]
        
        businessProfile.forEach { body["business_profile[\($0)]"] = $1 }
        
        features.forEach { body["features[\($0)]"] = $1 }
        
        if let defaultReturnUrl {
            body["default_return_url"] = defaultReturnUrl
        }
        
        if let loginPage {
            loginPage.forEach { body["login_page[\($0)]"] = $1 }
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try await apiHandler.send(method: .POST, path: portalconfiguration, body: .string(body.queryParameters), headers: headers)
    }
    
    public func update(configuration: String,
                       active: Bool? = nil,
                       businessProfile: [String: Any]? = nil,
                       defaultReturnUrl: String? = nil,
                       features: [String: Any]? = nil,
                       loginPage: [String: Any]? = nil,
                       metadata: [String: String]? = nil) async throws -> PortalConfiguration {
        var body: [String: Any] = [:]
        
        if let active {
            body["active"] = active
        }
        
        if let businessProfile {
            businessProfile.forEach { body["business_profile[\($0)]"] = $1 }
        }
        
        if let features {
            features.forEach { body["features[\($0)]"] = $1 }
        }
        
        if let defaultReturnUrl {
            body["default_return_url"] = defaultReturnUrl
        }
        
        if let loginPage {
            loginPage.forEach { body["login_page[\($0)]"] = $1 }
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try await apiHandler.send(method: .POST, path: "\(portalconfiguration)/\(configuration)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(configuration: String) async throws -> PortalConfiguration {
        try await apiHandler.send(method: .GET, path: "\(portalconfiguration)/\(configuration)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> PortalConfigurationList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: portalconfiguration, query: queryParams, headers: headers)
    }
}
