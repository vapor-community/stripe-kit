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
    func delete(customer: String) -> EventLoopFuture<StripeDeletedObject>
    
    /// Removes the currently applied discount on a subscription.
    ///
    /// - Parameter subscription: The id of the subscription this discount was applied to.
    /// - Returns: A `StripeDeletedObject`.
    func delete(subscription: String) -> EventLoopFuture<StripeDeletedObject>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

public struct StripeDiscountRoutes: DiscountRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func delete(customer: String) -> EventLoopFuture<StripeDeletedObject> {
        return apiHandler.send(method: .DELETE, path: StripeAPIEndpoint.discountCustomer(customer).endpoint, headers: headers)
    }
    
    public func delete(subscription: String) -> EventLoopFuture<StripeDeletedObject> {
        return apiHandler.send(method: .DELETE, path: StripeAPIEndpoint.discountSubscription(subscription).endpoint, headers: headers)
    }
}
