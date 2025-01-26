//
//  ProductFeatureRoutes.swift
//  stripe-kit
//
//  Created by TelemetryDeck on 26.01.25.
//

import Foundation
import NIO
import NIOHTTP1

public protocol ProductFeatureRoutes: StripeAPIRoute {
    /// List all features attached to a product
    ///
    /// Retrieve a list of features for a product
    ///
    /// - Parameters:
    ///  - product: The ID of the product whose features will be retrieved
    ///  - ending_before: A cursor for use in pagination. `ending_before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects,
    ///    starting with `obj_bar`, your subsequent call can include `ending_before=obj_bar` in order to fetch the previous page of the list.
    ///  - limit: A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
    ///  - starting_after: A cursor for use in pagination. `starting_after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects,
    ///    ending with `obj_foo`, your subsequent call can include `starting_after=obj_foo` in order to fetch the next page of the list.
    ///
    /// - Returns: Returns a list of features for a product
    func listAll(product: String, filter: [String: Any]?) async throws -> ProductFeatureList

    /// Attach a feature to a product
    ///
    /// Creates a product_feature, which represents a feature attachment to a product
    ///
    /// - Parameters:
    ///  - product: The ID of the product to which the feature will be attached
    ///  - entitlementFeature: The ID of the Feature object attached to this product.
    ///
    /// - Returns: Returns a product_feature
    func attachFeatureToProduct(
        product: String,
        entitlementFeature: String
    ) async throws -> ProductFeature

    /// Remove a feature from a product
    ///
    /// Deletes the feature attachment to a product
    ///
    /// - Returns: Returns an object with a deleted parameter on success. If the product feature ID does not exist, this call raises an error.
    func removeFeatureFromProduct(
        product: String,
        entitlementFeature: String
    ) async throws -> DeletedObject
}

public struct StripeProductFeatureRoutes: ProductFeatureRoutes {
    public var headers: HTTPHeaders = [:]

    private let apiHandler: StripeAPIHandler
    private let products = APIBase + APIVersion + "products"

    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func listAll(product: String, filter: [String: Any]?) async throws -> ProductFeatureList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        return try await apiHandler.send(method: .GET, path: "\(products)/\(product)/features", query: queryParams, headers: headers)
    }

    public func attachFeatureToProduct(product: String, entitlementFeature: String) async throws -> ProductFeature {
        let body: [String: Any] = [
            "entitlement_feature": entitlementFeature
        ]

        return try await apiHandler.send(method: .POST, path: "\(products)/\(product)/features", body: .string(body.queryParameters), headers: headers)
    }

    public func removeFeatureFromProduct(product: String, entitlementFeature: String) async throws -> DeletedObject {
        try await apiHandler.send(method: .DELETE, path: "\(products)/\(product)/features/\(entitlementFeature)", headers: headers)
    }
}
