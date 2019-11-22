//
//  ConnectionTokenRoutes.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import NIO
import NIOHTTP1

public protocol ConnectionTokenRoutes {
    /// To connect to a reader the Stripe Terminal SDK needs to retrieve a short-lived connection token from Stripe, proxied through your server. On your backend, add an endpoint that creates and returns a connection token.
    ///
    /// - Parameter location: The id of the location that this connection token is scoped to. If specified the connection token will only be usable with readers assigned to that location, otherwise the connection token will be usable with all readers.
    /// - Returns: A `StripeConnectionToken`.
    func create(location: String?) -> EventLoopFuture<StripeConnectionToken>
    
    var headers: HTTPHeaders { get set }
}

extension ConnectionTokenRoutes {
    func create(location: String? = nil) -> EventLoopFuture<StripeConnectionToken> {
        return create(location: location)
    }
}

public struct StripeConnectionTokenRoutes: ConnectionTokenRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(location: String?) -> EventLoopFuture<StripeConnectionToken> {
        return apiHandler.send(method: .POST, path: StripeAPIEndpoint.connectionToken.endpoint, headers: headers)
    }
}
