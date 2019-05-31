//
//  Stripe.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import NIO
//
//public struct StripeConfig: Service {
//    public let apiKey: String
//    public let testApiKey: String? 
//
//    public init(apiKey: String) {
//        self.apiKey = apiKey
//        self.testApiKey = nil
//    }
//
//    public init(productionKey: String, testKey: String) {
//        self.apiKey = productionKey
//        self.testApiKey = testKey
//    }
//}
//
//public final class StripeProvider: Provider {
//    public static let repositoryName = "stripe-provider"
//
//    public init() { }
//
//    public func boot(_ worker: Container) throws { }
//
//    public func didBoot(_ worker: Container) throws -> EventLoopFuture<Void> {
//        return .done(on: worker)
//    }
//
//    public func register(_ services: inout Services) throws {
//        services.register { (container) -> StripeClient in
//            let httpClient = try container.make(Client.self)
//            let config = try container.make(StripeConfig.self)
//            return StripeClient(apiKey: config.apiKey, testKey: config.testApiKey, client: httpClient)
//        }
//    }
//}
//
