//
//  StripeRequest.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Foundation
import NIO
import NIOFoundationCompat
import NIOHTTP1
import NIOHTTPClient

public struct APIError: Error {}

public struct StripeAPIHandler {
    private let httpClient: HTTPClient
    private let apiKey: String
    private let decoder = JSONDecoder()

    init(httpClient: HTTPClient, apiKey: String) {
        self.httpClient = httpClient
        self.apiKey = apiKey
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func send<SM: StripeModel>(method: HTTPMethod,
                               path: String,
                               query: String = "",
                               body: HTTPClient.Body = .string(""),
                               headers: HTTPHeaders = [:]) throws -> EventLoopFuture<SM> {
        
        var _headers: HTTPHeaders = ["Stripe-Version": "2019-03-14",
                                     "Authorization": "Bearer \(apiKey)"]
        headers.forEach { _headers.replaceOrAdd(name: $0.name, value: $0.value) }
        
        let request = try HTTPClient.Request(url: "\(path)?\(query)", method: method, headers: headers, body: body)
        
        return httpClient.execute(request: request).flatMapThrowing { response in
            guard var byteBuffer = response.body else {
                throw APIError()
            }
            let responseData = byteBuffer.readData(length: byteBuffer.readableBytes)!
            
            guard response.status == .ok else {
                let stripeError = try self.decoder.decode(StripeError.self, from: responseData)
                return self.httpClient.eventLoopGroup.next().makeSucceededFuture(stripeError) as! SM
            }
            let stripeResponse = try self.decoder.decode(SM.self, from: responseData)
            return self.httpClient.eventLoopGroup.next().makeSucceededFuture(stripeResponse) as! SM
        }
    }
}
