//
//  BalanceRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import NIO
import NIOHTTP1
import Baggage

public protocol BalanceRoutes {
    /// Retrieves the current account balance, based on the authentication that was used to make the request. For a sample request, see [Accounting for negative balances](https://stripe.com/docs/connect/account-balances#accounting-for-negative-balances).
    ///
    /// - Returns: A `StripeBalance`.
    func retrieve(context: LoggingContext) -> EventLoopFuture<StripeBalance>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension BalanceRoutes {
    public func retrieve(context: LoggingContext) -> EventLoopFuture<StripeBalance> {
        return retrieve(context: context)
    }
}

public struct StripeBalanceRoutes: BalanceRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let balance = APIBase + APIVersion + "balance"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(context: LoggingContext) -> EventLoopFuture<StripeBalance> {
        return apiHandler.send(method: .GET, path: balance, headers: headers, context: context)
    }
}
