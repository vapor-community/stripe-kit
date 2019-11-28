//
//  EphemeralKeyRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 10/17/17.
//

import NIO
import NIOHTTP1

public protocol EphemeralKeyRoutes {
    func create(customer: String, issuingCard: String?) -> EventLoopFuture<StripeEphemeralKey>
    func delete(ephemeralKey: String) -> EventLoopFuture<StripeEphemeralKey>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension EphemeralKeyRoutes {
    public func create(customer: String, issuingCard: String? = nil) -> EventLoopFuture<StripeEphemeralKey> {
        return create(customer: customer, issuingCard: issuingCard)
    }
    
    public func delete(ephemeralKey: String) -> EventLoopFuture<StripeEphemeralKey> {
        return delete(ephemeralKey: ephemeralKey)
    }
}

public struct StripeEphemeralKeyRoutes: EphemeralKeyRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(customer: String, issuingCard: String?) -> EventLoopFuture<StripeEphemeralKey> {
        var body: [String: Any] = ["customer": customer]
        
        if let issuingCard = issuingCard {
            body["issuing_card"] = issuingCard
        }
        
        return apiHandler.send(method: .POST, path: StripeAPIEndpoint.ephemeralKeys.endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(ephemeralKey: String) -> EventLoopFuture<StripeEphemeralKey> {
        return apiHandler.send(method: .DELETE, path: StripeAPIEndpoint.ephemeralKey(ephemeralKey).endpoint, headers: headers)
    }
}
