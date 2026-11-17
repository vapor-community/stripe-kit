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
    let apiVersion = "2026-10-28.endive"
    let baseURL = "https://api.stripe.com"

    public init(httpClient: HTTPClient, apiKey: String, stripeAccount: String? = nil, idempotencyKey: String? = nil) {
        self.httpClient = httpClient
        self.apiKey = apiKey
        self.stripeAccount = stripeAccount
        self.idempotencyKey = idempotencyKey
    }

    /// Send a request to the Stripe API.
    @discardableResult
    public func send<T: Codable>(
        method: HTTPMethod,
        path: String,
        body: HTTPClientRequest.Body? = nil,
        headers: [String: String] = [:]
    ) async throws -> T {
        var request = HTTPClientRequest(url: baseURL + path)
        request.method = method

        // Standard headers
        request.headers.add(name: "Authorization", value: "Bearer \(apiKey)")
        request.headers.add(name: "Stripe-Version", value: apiVersion)
        request.headers.add(name: "Content-Type", value: "application/x-www-form-urlencoded")

        // Stripe-Account header: act as a connected account (set via onBehalfOf(_:))
        if let account = stripeAccount {
            request.headers.add(name: "Stripe-Account", value: account)
        }
        // Idempotency-Key header for safe retries (set via idempotent(_:))
        if let key = idempotencyKey {
            request.headers.add(name: "Idempotency-Key", value: key)
        }
        for (key, value) in headers {
            request.headers.add(name: key, value: value)
        }

        if let body = body {
            request.body = body
        }

        let response = try await httpClient.execute(request, timeout: .seconds(60))
        let responseBody = try await response.body.collect(upTo: 1024 * 1024 * 10)
        let data = Data(responseBody.readableBytesView)

        guard (200..<300).contains(response.status.code) else {
            let decoder = JSONDecoder()
            if let stripeError = try? decoder.decode(StripeError.self, from: data) {
                throw stripeError
            }
            throw StripeError(error: StripeAPIError(
                type: .apiError,
                message: "HTTP \(response.status.code)"
            ))
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        // Note: NOT using .convertFromSnakeCase — all models have explicit CodingKeys
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("[StripeKit DEBUG] Decode error for \(T.self): \(error)")
            throw error
        }
    }

    let filesBaseURL = "https://files.stripe.com"

    /// Send a request whose response is a file, such as a quote PDF, and return its bytes.
    /// `baseURL` overrides the API host for endpoints served elsewhere (files.stripe.com).
    public func sendForData(
        method: HTTPMethod,
        path: String,
        baseURL: String? = nil
    ) async throws -> Data {
        var request = HTTPClientRequest(url: (baseURL ?? self.baseURL) + path)
        request.method = method
        request.headers.add(name: "Authorization", value: "Bearer \(apiKey)")
        request.headers.add(name: "Stripe-Version", value: apiVersion)
        if let account = stripeAccount {
            request.headers.add(name: "Stripe-Account", value: account)
        }

        let response = try await httpClient.execute(request, timeout: .seconds(120))
        let responseBody = try await response.body.collect(upTo: 1024 * 1024 * 50)
        let data = Data(responseBody.readableBytesView)

        guard (200..<300).contains(response.status.code) else {
            // Errors are JSON even when the success response is a file
            if let stripeError = try? JSONDecoder().decode(StripeError.self, from: data) {
                throw stripeError
            }
            throw StripeError(error: StripeAPIError(
                type: .apiError,
                message: "HTTP \(response.status.code)"
            ))
        }
        return data
    }

    /// Send a multipart file upload to the Stripe Files API.
    @discardableResult
    public func sendMultipart<T: Codable>(
        fileData: Data,
        fileName: String,
        mimeType: String,
        purpose: String,
        path: String = "/v1/files"
    ) async throws -> T {
        let boundary = "StripeKit-\(UUID().uuidString)"

        var body = Data()
        // Purpose field
        body.appendUTF8("--\(boundary)\r\n")
        body.appendUTF8("Content-Disposition: form-data; name=\"purpose\"\r\n\r\n")
        body.appendUTF8("\(purpose)\r\n")
        // File field
        body.appendUTF8("--\(boundary)\r\n")
        body.appendUTF8("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n")
        body.appendUTF8("Content-Type: \(mimeType)\r\n\r\n")
        body.append(fileData)
        body.appendUTF8("\r\n--\(boundary)--\r\n")

        var request = HTTPClientRequest(url: filesBaseURL + path)
        request.method = .POST
        request.headers.add(name: "Authorization", value: "Bearer \(apiKey)")
        request.headers.add(name: "Stripe-Version", value: apiVersion)
        request.headers.add(name: "Content-Type", value: "multipart/form-data; boundary=\(boundary)")

        if let account = stripeAccount {
            request.headers.add(name: "Stripe-Account", value: account)
        }

        request.body = .bytes(ByteBuffer(bytes: body))

        let response = try await httpClient.execute(request, timeout: .seconds(120))
        let responseBody = try await response.body.collect(upTo: 1024 * 1024 * 50)
        let data = Data(responseBody.readableBytesView)

        guard (200..<300).contains(response.status.code) else {
            let decoder = JSONDecoder()
            if let stripeError = try? decoder.decode(StripeError.self, from: data) {
                throw stripeError
            }
            throw StripeError(error: StripeAPIError(
                type: .apiError,
                message: "HTTP \(response.status.code)"
            ))
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("[StripeKit DEBUG] Multipart decode error for \(T.self): \(error)")
            throw error
        }
    }
}

extension Data {
    mutating func appendUTF8(_ string: String) {
        append(contentsOf: Array(string.utf8))
    }
}
