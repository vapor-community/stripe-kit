//
//  FeatureRoutes.swift
//  stripe-kit
//
//  Created by TelemetryDeck on 25.01.25.
//

import Foundation
import NIO
import NIOHTTP1

public protocol FeatureRoutes: StripeAPIRoute {
    /// Creates a feature.
    ///
    /// - Parameters:
    ///  - lookupKey: A unique key you provide as your own system identifier. This may be up to 80 characters.
    ///  - name: The feature’s name, for your own purpose, not meant to be displayable to the customer.
    ///  - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    /// - Returns: Returns a feature
    func create(
        lookupKey: String,
        name: String,
        metadata: [String: String]?
    ) async throws -> Feature

    /// Retrieve a list of features
    ///
    /// - Parameters:
    ///  - archived: If set, filter results to only include features with the given archive status.
    ///  - lookupKey: If set, filter results to only include features with the given lookup_key.
    ///  - ending_before: A cursor for use in pagination. `ending_before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects,
    ///    starting with `obj_bar`, your subsequent call can include `ending_before=obj_bar` in order to fetch the previous page of the list.
    ///  - limit: A limit on the number of objects to be returned. Limit can range between 1 and 100 items and the default is 10.
    ///  - starting_after: A cursor for use in pagination. `starting_after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects,
    ///    ending with `obj_foo`, your subsequent call can include `starting_after=obj_foo` in order to fetch the next page of the list.
    /// - Returns: Returns a list of your features
    func listAll(filter: [String: Any]?) async throws -> FeatureList

    /// Update a feature’s metadata or permanently deactivate it.
    ///
    /// - Parameters:
    ///  - id: Unique identifier for the object.
    ///  - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    ///  - name: The feature’s name, for your own purpose, not meant to be displayable to the customer.
    ///  - active: Inactive features cannot be attached to new products and will not be returned from the features list endpoint.
    /// - Returns: The updated feature
    func update(
        id: String,
        metadata: [String: String]?,
        name: String?,
        active: Bool?
    ) async throws -> Feature
}

public struct StripeFeatureRoutes: FeatureRoutes {
    public var headers: HTTPHeaders = [:]

    private let apiHandler: StripeAPIHandler
    private let features = APIBase + APIVersion + "entitlements/features"

    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func create(
        lookupKey: String,
        name: String,
        metadata: [String: String]?
    ) async throws -> Feature {
        var body: [String: Any] = [
            "lookup_key": lookupKey,
            "name": name
        ]

        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        return try await apiHandler.send(method: .POST, path: features, body: .string(body.queryParameters), headers: headers)
    }

    public func listAll(filter: [String: Any]? = nil) async throws -> FeatureList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        return try await apiHandler.send(method: .GET, path: features, query: queryParams, headers: headers)
    }

    public func update(
        id: String,
        metadata: [String: String]?,
        name: String?,
        active: Bool?
    ) async throws -> Feature {
        var body: [String: Any] = [:]

        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        if let name {
            body["name"] = name
        }

        if let active {
            body["active"] = active
        }

        return try await apiHandler.send(method: .POST, path: "\(features)/\(id)", body: .string(body.queryParameters), headers: headers)
    }
}
