//
//  DiscountRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/4/19.
//

import NIO
import NIOHTTP1

public protocol DiscountRoutes: StripeAPIRoute {
    /// Removes the currently applied discount on a customer.
    ///
    /// - Parameter customer: The id of the customer this discount belongs to.
    /// - Returns: An object with a deleted flag set to true upon success. This call returns an error otherwise, such as if no discount exists on this customer.
    func delete(customer: String) async throws -> DeletedObject
    
    /// Removes the currently applied discount on a subscription.
    ///
    /// - Parameter subscription: The id of the subscription this discount was applied to.
    /// - Returns: An object with a deleted flag set to true upon success. This call returns an error otherwise, such as if no discount exists on this subscription.
    func delete(subscription: String) async throws -> DeletedObject
}

public struct StripeDiscountRoutes: DiscountRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let customers = APIBase + APIVersion + "customers"
    private let subscriptions = APIBase + APIVersion + "subscriptions"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func delete(customer: String) async throws -> DeletedObject {
        try await apiHandler.send(method: .DELETE, path: "\(customers)/\(customer)/discount", headers: headers)
    }
    
    public func delete(subscription: String) async throws -> DeletedObject {
        try await apiHandler.send(method: .DELETE, path: "\(subscriptions)/\(subscription)/discount", headers: headers)
    }
}
