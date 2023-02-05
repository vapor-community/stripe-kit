//
//  DiscountRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/4/19.
//

import NIO
import NIOHTTP1

public protocol DiscountRoutes {
    /// Removes the currently applied discount on a customer.
    ///
    /// - Parameter customer: The id of the customer this discount belongs to.
    /// - Returns: A `StripeDeletedObject`.
    func delete(customer: String) -> EventLoopFuture<DeletedObject>
    
    /// Removes the currently applied discount on a subscription.
    ///
    /// - Parameter subscription: The id of the subscription this discount was applied to.
    /// - Returns: A `StripeDeletedObject`.
    func delete(subscription: String) -> EventLoopFuture<DeletedObject>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

public struct StripeDiscountRoutes: DiscountRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let customers = APIBase + APIVersion + "customers"
    private let subscriptions = APIBase + APIVersion + "subscriptions"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func delete(customer: String) -> EventLoopFuture<DeletedObject> {
        return apiHandler.send(method: .DELETE, path: "\(customers)/\(customer)/discount", headers: headers)
    }
    
    public func delete(subscription: String) -> EventLoopFuture<DeletedObject> {
        return apiHandler.send(method: .DELETE, path: "\(subscriptions)/\(subscription)/discount", headers: headers)
    }
}
