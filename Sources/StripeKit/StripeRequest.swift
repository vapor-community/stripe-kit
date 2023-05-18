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
    
    public static func data(_ data: Data) -> Self {
        .bytes(.init(data: data))
    }
}

struct StripeAPIHandler {
    private let httpClient: HTTPClient
    private let apiKey: String
    private let decoder = JSONDecoder()

    init(httpClient: HTTPClient, apiKey: String) {
        self.httpClient = httpClient
        self.apiKey = apiKey
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func send<T: Codable>(method: HTTPMethod,
                          path: String,
                          query: String = "",
                          body: HTTPClientRequest.Body = .bytes(.init(string: "")),
                          headers: HTTPHeaders) async throws -> T {
                
        var _headers: HTTPHeaders = ["Stripe-Version": "2022-11-15",
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
