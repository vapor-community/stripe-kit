//
//  LocationRoutes.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import NIO
import NIOHTTP1

public protocol LocationRoutes {
    /// Creates a new Location object.
    ///
    /// - Parameters:
    ///   - address: The full address of the location.
    ///   - displayName: A name for the location.
    /// - Returns: A `StripeLocation`.
    /// - Throws: A `StripeError`.
    func create(address: [String: Any], displayName: String) throws -> EventLoopFuture<StripeLocation>
    
    /// Retrieves a Location object.
    ///
    /// - Parameter location: The identifier of the location to be retrieved.
    /// - Returns: A `StripeLocation`.
    /// - Throws: A `StripeError`.
    func retrieve(location: String) throws -> EventLoopFuture<StripeLocation>
    
    /// Updates a Location object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    ///
    /// - Parameters:
    ///   - location: The identifier of the location to be updated.
    ///   - address: The full address of the location.
    ///   - displayName: A name for the location.
    /// - Returns: A `StripeLocation`.
    /// - Throws: A `StripeError`.
    func update(location: String, address: [String: Any]?, displayName: String?) throws -> EventLoopFuture<StripeLocation>
    
    /// Deletes a Location object.
    ///
    /// - Parameter location: The identifier of the location to be deleted.
    /// - Returns: A `StripeLocation`.
    /// - Throws: A `StripeError`.
    func delete(location: String) throws -> EventLoopFuture<StripeLocation>
    
    /// Returns a list of Location objects.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/terminal/locations/list)
    /// - Returns: A `StripeLocationList`.
    /// - Throws: A `StripeError`.
    func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeLocationList>
    
    var headers: HTTPHeaders { get set }
}

extension LocationRoutes {
    func create(address: [String: Any], displayName: String) throws -> EventLoopFuture<StripeLocation> {
        return try create(address: address, displayName: displayName)
    }
    
    func retrieve(location: String) throws -> EventLoopFuture<StripeLocation> {
        return try retrieve(location: location)
    }
    
    func update(location: String, address: [String: Any]? = nil, displayName: String? = nil) throws -> EventLoopFuture<StripeLocation> {
        return try update(location: location, address: address, displayName: displayName)
    }
    
    func delete(location: String) throws -> EventLoopFuture<StripeLocation> {
        return try delete(location: location)
    }
    
    func listAll(filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeLocationList> {
        return try listAll(filter: filter)
    }
}

public struct StripeLocationRoutes: LocationRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(address: [String: Any], displayName: String) throws -> EventLoopFuture<StripeLocation> {
        var body: [String: Any] = ["display_name": displayName]
        address.forEach { body["address[\($0)]"] = $1 }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.location.endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(location: String) throws -> EventLoopFuture<StripeLocation> {
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.locations(location).endpoint, headers: headers)
    }
    
    public func update(location: String, address: [String: Any]?, displayName: String?) throws -> EventLoopFuture<StripeLocation> {
        var body: [String: Any] = [:]
        if let address = address {
            address.forEach { body["address[\($0)]"] = $1 }
        }
        
        if let displayName = displayName {
            body["display_name"] = displayName
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.locations(location).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(location: String) throws -> EventLoopFuture<StripeLocation> {
        return try apiHandler.send(method: .DELETE, path: StripeAPIEndpoint.locations(location).endpoint, headers: headers)
    }
    
    public func listAll(filter: [String : Any]? = nil) throws -> EventLoopFuture<StripeLocationList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.location.endpoint, query: queryParams, headers: headers)
    }
}
