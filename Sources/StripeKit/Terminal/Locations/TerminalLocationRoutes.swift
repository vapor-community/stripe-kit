//
//  TerminalLocationRoutes.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import NIO
import NIOHTTP1

public protocol TerminalLocationRoutes: StripeAPIRoute {
    /// Creates a new TerminalLocation object.
    ///
    /// - Parameters:
    ///   - address: The full address of the location.
    ///   - displayName: A name for the location.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - configurationOverrides: The ID of a configuration that will be used to customize all readers in this location.
    /// - Returns: Returns a ``TerminalLocation`` object if creation succeeds.
    func create(address: [String: Any],
                displayName: String,
                metadata: [String: String]?,
                configurationOverrides: String?) async throws -> TerminalLocation
    
    /// Retrieves a TerminalLocation object.
    ///
    /// - Parameter location: The identifier of the location to be retrieved.
    /// - Returns: Returns a ``TerminalLocation`` object if a valid identifier was provided.
    func retrieve(location: String) async throws -> TerminalLocation
    
    /// Updates a TerminalLocation object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    ///
    /// - Parameters:
    ///   - location: The identifier of the location to be updated.
    ///   - address: The full address of the location.
    ///   - displayName: A name for the location.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///   - configurationOverrides: The ID of a configuration that will be used to customize all readers in this location.
    /// - Returns: A `StripeLocation`.
    func update(location: String,
                address: [String: Any]?,
                displayName: String?,
                metadata: [String: String]?,
                configurationOverrides: String?) async throws -> TerminalLocation
    
    /// Deletes a TerminalLocation object.
    ///
    /// - Parameter location: The identifier of the location to be deleted.
    /// - Returns: Returns the ``TerminalLocation`` object that was deleted.
    func delete(location: String) async throws -> DeletedObject
    
    /// Returns a list of TerminalLocation objects.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/terminal/locations/list)
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` locations, starting after location `starting_after`. Each entry in the array is a separate Terminal location object. If no more locations are available, the resulting array will be empty.
    func listAll(filter: [String: Any]?) async throws -> TerminalLocationList
}

public struct StripeTerminalLocationRoutes: TerminalLocationRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let terminallocations = APIBase + APIVersion + "terminal/locations"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(address: [String: Any],
                       displayName: String,
                       metadata: [String: String]? = nil,
                       configurationOverrides: String? = nil) async throws -> TerminalLocation {
        var body: [String: Any] = ["display_name": displayName]
        address.forEach { body["address[\($0)]"] = $1 }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let configurationOverrides {
            body["configuration_overrides"] = configurationOverrides
        }
        
        return try await apiHandler.send(method: .POST, path: terminallocations, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(location: String) async throws -> TerminalLocation {
        try await apiHandler.send(method: .GET, path: "\(terminallocations)/\(location)", headers: headers)
    }
    
    public func update(location: String,
                       address: [String: Any]? = nil,
                       displayName: String? = nil,
                       metadata: [String: String]? = nil,
                       configurationOverrides: String? = nil) async throws -> TerminalLocation {
        var body: [String: Any] = [:]
        if let address {
            address.forEach { body["address[\($0)]"] = $1 }
        }
        
        if let displayName {
            body["display_name"] = displayName
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let configurationOverrides {
            body["configuration_overrides"] = configurationOverrides
        }
        
        return try await apiHandler.send(method: .POST, path: "\(terminallocations)/\(location)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(location: String) async throws -> DeletedObject {
        try await apiHandler.send(method: .DELETE, path: "\(terminallocations)/\(location)", headers: headers)
    }
    
    public func listAll(filter: [String : Any]? = nil) async throws -> TerminalLocationList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: terminallocations, query: queryParams, headers: headers)
    }
}
