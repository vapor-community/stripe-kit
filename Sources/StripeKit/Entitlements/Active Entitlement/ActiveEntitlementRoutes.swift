//
//  ActiveEntitlementRoutes.swift
//  stripe-kit
//
//  Created by TelemetryDeck on 26.01.25.
//

import Foundation
import NIO
import NIOHTTP1

public protocol ActiveEntitlementRoutes: StripeAPIRoute {
    /// Retrieve an active entitlement.
    ///
    /// - Parameters:
    ///  - id: The ID of the entitlement.
    ///
    ///  - Returns: Returns an active entitlement
    func retrieve(id: String) async throws -> ActiveEntitlement

    /// List all active entitlements.
    ///
    /// Retrieve a list of active entitlements for a customer
    ///
    /// - Parameters:
    ///  - customer: The ID of the customer.
    ///  - endingBefore: A cursor for use in pagination. `ending_before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects,
    ///    starting with `obj_bar`, your subsequent call can include `ending_before=obj_bar` in order to fetch the previous page of the list.
    ///  - limit: A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
    ///  - startingAfter: A cursor for use in pagination. `starting_after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects,
    ///    ending with `obj_foo`, your subsequent call can include `starting_after=obj_foo` in order to fetch the next page of the list.
    ///
    ///  - Returns: Returns a list of active entitlements for a customer

    func listAll(customer: String, filter: [String: Any]?) async throws -> ActiveEntitlementList
}

public struct StripeActiveEntitlementRoutes: ActiveEntitlementRoutes {
    public var headers: HTTPHeaders = [:]

    private let apiHandler: StripeAPIHandler
    private let activeEntitlements = APIBase + APIVersion + "entitlements/active_entitlements"

    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func retrieve(id: String) async throws -> ActiveEntitlement {
        try await apiHandler.send(method: .GET, path: "\(activeEntitlements)/\(id)", headers: headers)
    }

    public func listAll(customer: String, filter: [String: Any]?) async throws -> ActiveEntitlementList {
        var queryParams = ""
        var combinedFilter = filter ?? [:]
        combinedFilter["customer"] = customer
        queryParams = combinedFilter.queryParameters

        return try await apiHandler.send(method: .GET, path: activeEntitlements, query: queryParams, headers: headers)
    }
}
