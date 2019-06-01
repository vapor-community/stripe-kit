//
//  EphemeralKeyRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 10/17/17.
//

import NIO
import NIOHTTP1

public protocol EphemeralKeyRoutes {
    func create(customer: String, issuingCard: String?) throws -> EventLoopFuture<StripeEphemeralKey>
    func delete(ephemeralKey: String) throws -> EventLoopFuture<StripeEphemeralKey>
    
    var headers: HTTPHeaders { get set }
}

extension EphemeralKeyRoutes {
    public func create(customer: String, issuingCard: String? = nil) throws -> EventLoopFuture<StripeEphemeralKey> {
        return try create(customer: customer, issuingCard: issuingCard)
    }
    
    public func delete(ephemeralKey: String) throws -> EventLoopFuture<StripeEphemeralKey> {
        return try delete(ephemeralKey: ephemeralKey)
    }
}

public struct StripeEphemeralKeyRoutes: EphemeralKeyRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(customer: String, issuingCard: String?) throws -> EventLoopFuture<StripeEphemeralKey> {
        var body: [String: Any] = ["customer": customer]
        
        if let issuingCard = issuingCard {
            body["issuing_card"] = issuingCard
        }
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.ephemeralKeys.endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(ephemeralKey: String) throws -> EventLoopFuture<StripeEphemeralKey> {
        return try apiHandler.send(method: .DELETE, path: StripeAPIEndpoint.ephemeralKey(ephemeralKey).endpoint, headers: headers)
    }
}
