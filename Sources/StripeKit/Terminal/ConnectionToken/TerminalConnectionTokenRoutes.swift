//
//  TerminalConnectionTokenRoutes.swift
//  StripeKit
//
//  Created by Andrew Edwards on 6/1/19.
//

import NIO
import NIOHTTP1

public protocol TerminalConnectionTokenRoutes: StripeAPIRoute {
    /// To connect to a reader the Stripe Terminal SDK needs to retrieve a short-lived connection token from Stripe, proxied through your server. On your backend, add an endpoint that creates and returns a connection token.
    ///
    /// - Parameter location: The id of the location that this connection token is scoped to. If specified the connection token will only be usable with readers assigned to that location, otherwise the connection token will be usable with all readers.
    /// - Returns: A `StripeConnectionToken`.
    func create(location: String?) async throws -> TerminalConnectionToken
}

public struct StripeTerminalConnectionTokenRoutes: TerminalConnectionTokenRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let connectiontokens = APIBase + APIVersion + "terminal/connection_tokens"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(location: String?) async throws -> TerminalConnectionToken {
        var body: [String: Any] = [:]
        if let location {
            body["location"] = location
        }
        
        return try await apiHandler.send(method: .POST, path: connectiontokens, body: .string(body.queryParameters), headers: headers)
    }
}
