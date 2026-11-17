//
//  StripeAPIHandler.swift
//  StripeKit
//
//  Hand-written infrastructure (not emitted by stripe-kit-codegen).
//

import Foundation
import AsyncHTTPClient
import NIO
import NIOHTTP1

/// Handles sending requests to the Stripe API.
public struct StripeAPIHandler: Sendable {
    let httpClient: HTTPClient
    let apiKey: String
    let stripeAccount: String?
    let idempotencyKey: String?
    /// Generated from the spec, so it always matches the models (see `StripeClient.apiVersion`)
    var apiVersion: String { StripeClient.apiVersion }
    let baseURL = "https://api.stripe.com"

    public init(httpClient: HTTPClient, apiKey: String, stripeAccount: String? = nil, idempotencyKey: String? = nil) {
        self.httpClient = httpClient
        self.apiKey = apiKey
        self.stripeAccount = stripeAccount
        self.idempotencyKey = idempotencyKey
    }

    // MARK: - Requests

    /// Send a request and decode its JSON response.
    /// - Parameters:
    ///   - params: Form-encoded as the body of a POST, or as the query string otherwise.
    ///   - expand: `expand[]` values, sent in the query string. (A params struct has its own
    ///     `expand`, encoded with the rest of its fields.)
    public func send<T: Decodable>(
        _ method: HTTPMethod,
        _ path: String,
        params: (any StripeParams)? = nil,
        expand: [String]? = nil
    ) async throws -> T {
        let data = try await execute(request(method, path, params: params, expand: expand), timeout: .seconds(60), maxBytes: 10 << 20)
        return try Self.decoder.decode(T.self, from: data)
    }

    /// Send a request whose response is a file, such as a quote PDF, and return its bytes.
    /// - Parameter baseURL: The host to send it to, when it isn't the API host (files.stripe.com).
    public func sendForData(
        _ method: HTTPMethod,
        _ path: String,
        params: (any StripeParams)? = nil,
        expand: [String]? = nil,
        baseURL: String? = nil
    ) async throws -> Data {
        let request = self.request(method, path, params: params, expand: expand, baseURL: baseURL)
        return try await execute(request, timeout: .seconds(120), maxBytes: 50 << 20)
    }

    /// Upload a file as `multipart/form-data` and decode the JSON response.
    /// - Parameter baseURL: The host to send it to, when it isn't the API host (files.stripe.com).
    public func sendMultipart<T: Decodable>(
        _ path: String,
        baseURL: String? = nil,
        fileData: Data,
        fileName: String,
        mimeType: String,
        purpose: String
    ) async throws -> T {
        let boundary = "StripeKit-\(UUID().uuidString)"
        var body = Data()
        body.appendUTF8("--\(boundary)\r\n")
        body.appendUTF8("Content-Disposition: form-data; name=\"purpose\"\r\n\r\n")
        body.appendUTF8("\(purpose)\r\n")
        body.appendUTF8("--\(boundary)\r\n")
        body.appendUTF8("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n")
        body.appendUTF8("Content-Type: \(mimeType)\r\n\r\n")
        body.append(fileData)
        body.appendUTF8("\r\n--\(boundary)--\r\n")

        var request = self.request(.POST, path, baseURL: baseURL)
        request.headers.replaceOrAdd(name: "Content-Type", value: "multipart/form-data; boundary=\(boundary)")
        request.body = .bytes(ByteBuffer(bytes: body))
        let data = try await execute(request, timeout: .seconds(120), maxBytes: 50 << 20)
        return try Self.decoder.decode(T.self, from: data)
    }

    // MARK: - Core

    /// Responses are decoded with explicit CodingKeys; dates are Unix seconds.
    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }

    /// A request with Stripe's headers, and `params` and `expand` encoded as `send` describes.
    /// Internal rather than private so tests can check what gets sent.
    func request(
        _ method: HTTPMethod,
        _ path: String,
        params: (any StripeParams)? = nil,
        expand: [String]? = nil,
        baseURL: String? = nil
    ) -> HTTPClientRequest {
        let form = params?.toFormBody() ?? ""
        var query: [String] = []
        if method != .POST, !form.isEmpty {
            query.append(form)
        }
        for value in expand ?? [] {
            query.append("expand[]=\(value.addingPercentEncoding(withAllowedCharacters: .stripeQueryAllowed) ?? value)")
        }

        var url = (baseURL ?? self.baseURL) + path
        if !query.isEmpty {
            url += "?" + query.joined(separator: "&")
        }

        var request = HTTPClientRequest(url: url)
        request.method = method
        request.headers.add(name: "Authorization", value: "Bearer \(apiKey)")
        request.headers.add(name: "Stripe-Version", value: apiVersion)
        // Stripe-Account: act as a connected account (set via onBehalfOf(_:))
        if let stripeAccount {
            request.headers.add(name: "Stripe-Account", value: stripeAccount)
        }
        // Idempotency-Key: safe retries (set via idempotent(_:))
        if let idempotencyKey {
            request.headers.add(name: "Idempotency-Key", value: idempotencyKey)
        }
        if method == .POST {
            request.headers.add(name: "Content-Type", value: "application/x-www-form-urlencoded")
            request.body = .bytes(ByteBuffer(string: form))
        }
        return request
    }

    /// Send `request` and return the response body, or throw the `StripeError` it describes.
    private func execute(_ request: HTTPClientRequest, timeout: TimeAmount, maxBytes: Int) async throws -> Data {
        let response = try await httpClient.execute(request, timeout: timeout)
        let data = Data(try await response.body.collect(upTo: maxBytes).readableBytesView)

        guard (200..<300).contains(response.status.code) else {
            // Errors are JSON, even from endpoints whose success response is a file
            if let stripeError = try? JSONDecoder().decode(StripeError.self, from: data) {
                throw stripeError
            }
            throw StripeError(error: StripeAPIError(type: .apiError, message: "HTTP \(response.status.code)"))
        }
        return data
    }
}

extension Data {
    mutating func appendUTF8(_ string: String) {
        append(contentsOf: Array(string.utf8))
    }
}
