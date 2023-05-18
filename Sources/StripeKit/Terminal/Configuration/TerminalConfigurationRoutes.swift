//
//  TerminalConfigurationRoutes.swift
//  
//
//  Created by Andrew Edwards on 5/17/23.
//

import Foundation
import NIO
import NIOHTTP1

public protocol TerminalConfigurationRoutes: StripeAPIRoute {
    /// Creates a new ``TerminalConfiguration`` object.
    /// - Parameters:
    ///   - bbposWiseposE: An object containing device type specific settings for BBPOS WisePOS E readers
    ///   - tipping: Tipping configurations for readers supporting on-reader tips
    ///   - verifoneP400: An object containing device type specific settings for Verifone P400 readers
    ///   - expand: An array of properties to expand
    /// - Returns: Returns a ``TerminalConfiguration`` object if creation succeeds.
    func create(bbposWiseposE: [String: Any]?,
                tipping: [String: Any]?,
                verifoneP400: [String: Any]?,
                expand: [String]?) async throws -> TerminalConfiguration
    
    /// Retrieves a ``TerminalConfiguration`` object.
    /// - Parameters:
    ///   - config: The id of the configuration.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns a ``TerminalConfiguration`` object if a valid identifier was provided.
    func retrieve(config: String, expand: [String]?) async throws -> TerminalConfiguration
    
    
    /// Updates a new ``TerminalConfiguration`` object.
    /// - Parameters:
    ///   - config: The id of the configuration.
    ///   - bbposWiseposE: An object containing device type specific settings for BBPOS WisePOS E readers
    ///   - tipping: Tipping configurations for readers supporting on-reader tips
    ///   - verifoneP400: An object containing device type specific settings for Verifone P400 readers
    ///   - expand: An array of properties to expand
    /// - Returns: Returns a ``TerminalConfiguration`` object if the update succeeds.
    func update(config: String,
                bbposWiseposE: [String: Any]?,
                tipping: [String: Any]?,
                verifoneP400: [String: Any]?,
                expand: [String]?) async throws -> TerminalConfiguration
    
    /// Deletes a ``TerminalConfiguration`` object.
    /// - Parameter config: The id of the configuration.
    /// - Returns: Returns the ``TerminalConfiguration`` object that was deleted.
    func delete(config: String) async throws -> DeletedObject
    
    /// Returns a list of ``TerminalConfiguration`` objects.
    /// - Parameter filter: A dictionary that will be used for query parameters.
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` configurations, starting after configurations `configurations`. Each entry in the array is a separate Terminal `configurations` object. If no more configurations are available, the resulting array will be empty.
    func listAll(filter: [String: Any]?) async throws -> TerminalConfigurationList
}

public struct StripeTerminalConfigurationRoutes: TerminalConfigurationRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let terminalconfigurations = APIBase + APIVersion + "terminal/configurations"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(bbposWiseposE: [String: Any]? = nil,
                       tipping: [String: Any]? = nil,
                       verifoneP400: [String: Any]? = nil,
                       expand: [String]? = nil) async throws -> TerminalConfiguration {
        var body: [String: Any] = [:]
        
        if let bbposWiseposE {
            bbposWiseposE.forEach { body["bbpos_wisepos_e[\($0)]"] = $1 }
        }
        
        if let tipping {
            tipping.forEach { body["tipping[\($0)]"] = $1 }
        }
        
        if let verifoneP400 {
            verifoneP400.forEach { body["verifone_p400[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: terminalconfigurations, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(config: String, expand: [String]? = nil) async throws -> TerminalConfiguration {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .GET, path: "\(terminalconfigurations)/\(config)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func update(config: String,
                       bbposWiseposE: [String: Any]? = nil,
                       tipping: [String: Any]? = nil,
                       verifoneP400: [String: Any]? = nil,
                       expand: [String]? = nil) async throws -> TerminalConfiguration {
        var body: [String: Any] = [:]
        
        if let bbposWiseposE {
            bbposWiseposE.forEach { body["bbpos_wisepos_e[\($0)]"] = $1 }
        }
        
        if let tipping {
            tipping.forEach { body["tipping[\($0)]"] = $1 }
        }
        
        if let verifoneP400 {
            verifoneP400.forEach { body["verifone_p400[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(terminalconfigurations)/\(config)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(config: String) async throws -> DeletedObject {
        try await apiHandler.send(method: .DELETE, path: "\(terminalconfigurations)/\(config)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> TerminalConfigurationList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: terminalconfigurations, query: queryParams, headers: headers)
    }
}
