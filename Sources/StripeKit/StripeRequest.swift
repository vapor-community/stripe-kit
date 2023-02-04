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
import AsyncHTTPClient

internal let APIBase = "https://api.stripe.com/"
internal let FilesAPIBase = "https://files.stripe.com/"
internal let APIVersion = "v1/"

extension HTTPClientRequest.Body {
    public static func string(_ string: String) -> Self {
        .bytes(.init(string: string))
    }
}

struct StripeAPIHandler {
    private let httpClient: HTTPClient
    private let apiKey: String
    private let decoder = JSONDecoder()
    var eventLoop: EventLoop

    init(httpClient: HTTPClient, eventLoop: EventLoop, apiKey: String) {
        self.httpClient = httpClient
        self.eventLoop = eventLoop
        self.apiKey = apiKey
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    @available(*, deprecated, message: "Migrate to async await")
    public func send<SM: Codable>(method: HTTPMethod,
                                      path: String,
                                      query: String = "",
                                      body: HTTPClient.Body = .string(""),
                                      headers: HTTPHeaders = [:]) -> EventLoopFuture<SM> {
        
        var _headers: HTTPHeaders = ["Stripe-Version": "2020-08-27",
                                     "Authorization": "Bearer \(apiKey)",
                                     "Content-Type": "application/x-www-form-urlencoded"]
        headers.forEach { _headers.replaceOrAdd(name: $0.name, value: $0.value) }
        
        do {
            let request = try HTTPClient.Request(url: "\(path)?\(query)", method: method, headers: _headers, body: body)
            
            return httpClient.execute(request: request, eventLoop: .delegate(on: self.eventLoop)).flatMap { response in
                guard let byteBuffer = response.body else {
                    fatalError("Response body from Stripe is missing! This should never happen.")
                }
                let responseData = Data(byteBuffer.readableBytesView)

                do {
                    guard response.status == .ok else {
                        return self.eventLoop.makeFailedFuture(try self.decoder.decode(StripeError.self, from: responseData))
                    }
                    return self.eventLoop.makeSucceededFuture(try self.decoder.decode(SM.self, from: responseData))

                } catch {
                    return self.eventLoop.makeFailedFuture(error)
                }
            }
        } catch {
            return self.eventLoop.makeFailedFuture(error)
        }
    }
    
    func send<T: Codable>(method: HTTPMethod,
                          path: String,
                          query: String = "",
                          body: HTTPClientRequest.Body = .bytes(.init(string: "")),
                          headers: HTTPHeaders) async throws -> T {
                
        var _headers: HTTPHeaders = ["Stripe-Version": "2022-08-01",
                                     "Authorization": "Bearer \(apiKey)",
                                     "Content-Type": "application/x-www-form-urlencoded"]
        headers.forEach { _headers.replaceOrAdd(name: $0.name, value: $0.value) }
            
        var request = HTTPClientRequest(url: "\(path)?\(query)")
        request.headers = _headers
        request.method = method
        request.body = body
        
        let response = try await httpClient.execute(request, timeout: .seconds(60))
        let responseData = try await response.body.collect(upTo: 1024 * 1024 * 100) // 500mb to account for data downloads.
        
        guard response.status == .ok else {
            let error = try self.decoder.decode(StripeError.self, from: responseData)
            throw error
        }
        return try self.decoder.decode(T.self, from: responseData)
    }
}
