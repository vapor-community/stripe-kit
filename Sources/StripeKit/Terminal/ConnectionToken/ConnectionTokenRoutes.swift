//
//  ConnectionTokenRoutes.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import NIO
import NIOHTTP1
import Baggage

public protocol ConnectionTokenRoutes {
    /// To connect to a reader the Stripe Terminal SDK needs to retrieve a short-lived connection token from Stripe, proxied through your server. On your backend, add an endpoint that creates and returns a connection token.
    ///
    /// - Parameter location: The id of the location that this connection token is scoped to. If specified the connection token will only be usable with readers assigned to that location, otherwise the connection token will be usable with all readers.
    /// - Returns: A `StripeConnectionToken`.
    func create(location: String?) -> EventLoopFuture<StripeConnectionToken>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension ConnectionTokenRoutes {
    func create(location: String? = nil) -> EventLoopFuture<StripeConnectionToken> {
        return create(location: location)
    }
}

public struct StripeConnectionTokenRoutes: ConnectionTokenRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let connectiontokens = APIBase + APIVersion + "terminal/connection_tokens"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(location: String?) -> EventLoopFuture<StripeConnectionToken> {
        return apiHandler.send(method: .POST, path: connectiontokens, headers: headers)
    }
}
