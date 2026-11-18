//
//  StripeAPIHandler.swift
//  StripeKit
//
//  Hand-written infrastructure (not emitted by stripe-kit-codegen).
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import AsyncHTTPClient
import NIO
import NIOHTTP1
import StripeKitCore
import StripeKitModels

/// Handles sending requests to the Stripe API.
public struct StripeAPIHandler: Sendable {
    let httpClient: HTTPClient
    let apiKey: String
    /// The connected account every request is made as, unless its options name another
    let stripeAccount: String?
    /// How many times a request is retried after a network error or a response Stripe marks
    /// retryable (see `shouldRetry`). 0 turns retries off.
    public let maxNetworkRetries: Int
    /// Generated from the spec, so it always matches the models (see `StripeClient.apiVersion`)
    var apiVersion: String { StripeClient.apiVersion }
    let baseURL = "https://api.stripe.com"

    /// - Parameter maxNetworkRetries: Retries after a network error or a retryable response,
    ///   2 by default, as in Stripe's own SDKs.
    public init(httpClient: HTTPClient, apiKey: String, stripeAccount: String? = nil, maxNetworkRetries: Int = 2) {
        self.httpClient = httpClient
        self.apiKey = apiKey
        self.stripeAccount = stripeAccount
        self.maxNetworkRetries = max(0, maxNetworkRetries)
    }

    // MARK: - Requests

    /// Send a request and decode its JSON response.
    /// - Parameters:
    ///   - path: The path, with each interpolated value escaped (see `StripePath`).
    ///   - params: Form-encoded as the body of a POST, or as the query string otherwise.
    ///   - expand: `expand[]` values, sent in the query string. (A params struct has its own
    ///     `expand`, encoded with the rest of its fields.)
    ///   - options: This request's connected account and idempotency key.
    public func send<T: Decodable>(
        _ method: HTTPMethod,
        _ path: StripePath,
        params: (any StripeParams)? = nil,
        expand: [String]? = nil,
        options: RequestOptions = .init()
    ) async throws -> T {
        let request = self.request(method, path, params: params, expand: expand, options: options)
        let data = try await execute(request, timeout: .seconds(60), maxBytes: 10 << 20)
        return try Self.decoder.decode(T.self, from: data)
    }

    /// Send a request whose response is a file, such as a quote PDF, and return its bytes.
    /// - Parameter baseURL: The host to send it to, when it isn't the API host (files.stripe.com).
    public func sendForData(
        _ method: HTTPMethod,
        _ path: StripePath,
        params: (any StripeParams)? = nil,
        expand: [String]? = nil,
        baseURL: String? = nil,
        options: RequestOptions = .init()
    ) async throws -> Data {
        let request = self.request(method, path, params: params, expand: expand, baseURL: baseURL, options: options)
        return try await execute(request, timeout: .seconds(120), maxBytes: 50 << 20)
    }

    /// Upload a file as `multipart/form-data` and decode the JSON response.
    /// - Parameter baseURL: The host to send it to, when it isn't the API host (files.stripe.com).
    public func sendMultipart<T: Decodable>(
        _ path: StripePath,
        baseURL: String? = nil,
        fileData: Data,
        fileName: String,
        mimeType: String,
        purpose: String,
        options: RequestOptions = .init()
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

        var request = self.request(.POST, path, baseURL: baseURL, options: options)
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
    /// `options` give the request's idempotency key, and can override the handler's connected
    /// account.
    /// Internal rather than private so tests can check what gets sent.
    func request(
        _ method: HTTPMethod,
        _ path: StripePath,
        params: (any StripeParams)? = nil,
        expand: [String]? = nil,
        baseURL: String? = nil,
        options: RequestOptions = .init()
    ) -> HTTPClientRequest {
        let form = params?.toFormBody() ?? ""
        var query: [String] = []
        if method != .POST, !form.isEmpty {
            query.append(form)
        }
        for value in expand ?? [] {
            query.append("expand[]=\(value.percentEncoded())")
        }

        var url = (baseURL ?? self.baseURL) + path.description
        if !query.isEmpty {
            url += "?" + query.joined(separator: "&")
        }

        var request = HTTPClientRequest(url: url)
        request.method = method
        request.headers.add(name: "Authorization", value: "Bearer \(apiKey)")
        request.headers.add(name: "Stripe-Version", value: apiVersion)
        // Stripe-Account: act as a connected account (per request, or via onBehalfOf(_:))
        if let stripeAccount = options.stripeAccount ?? stripeAccount {
            request.headers.add(name: "Stripe-Account", value: stripeAccount)
        }
        // Idempotency-Key: the request's own, or for a POST that may be retried, a generated one,
        // so a retry after a lost response can't perform it twice (as Stripe's SDKs do)
        if let idempotencyKey = options.idempotencyKey ?? (method == .POST && maxNetworkRetries > 0 ? "stripe-kit-retry-\(UUID().uuidString)" : nil) {
            request.headers.add(name: "Idempotency-Key", value: idempotencyKey)
        }
        if method == .POST {
            request.headers.add(name: "Content-Type", value: "application/x-www-form-urlencoded")
            request.body = .bytes(ByteBuffer(string: form))
        }
        return request
    }

    /// Send `request` and return the response body, or throw the `StripeError` it describes.
    /// Retries up to `maxNetworkRetries` times after a network error or a retryable response,
    /// waiting `retryDelay` between attempts. The request is sent unchanged each time, so a
    /// POST keeps its idempotency key.
    private func execute(_ request: HTTPClientRequest, timeout: TimeAmount, maxBytes: Int) async throws -> Data {
        var retries = 0
        while true {
            let response: HTTPClientResponse
            do {
                response = try await httpClient.execute(request, timeout: timeout)
            } catch where retries < maxNetworkRetries && !(error is CancellationError) {
                // No response (connection refused or reset, timeout, ...): Stripe may or may not
                // have received it, and the idempotency key makes a POST safe to resend
                retries += 1
                try await Self.sleep(seconds: Self.retryDelay(retry: retries, retryAfter: nil))
                continue
            }
            let data = Data(try await response.body.collect(upTo: maxBytes).readableBytesView)

            if (200..<300).contains(response.status.code) {
                return data
            }
            if retries < maxNetworkRetries, Self.shouldRetry(status: response.status.code, headers: response.headers) {
                retries += 1
                let retryAfter = response.headers.first(name: "Retry-After")
                try await Self.sleep(seconds: Self.retryDelay(retry: retries, retryAfter: retryAfter))
                continue
            }
            // Errors are JSON, even from endpoints whose success response is a file
            if let stripeError = try? JSONDecoder().decode(StripeError.self, from: data) {
                throw stripeError
            }
            throw StripeError(error: StripeAPIError(type: .apiError, message: "HTTP \(response.status.code)"))
        }
    }

    // MARK: - Retry Policy

    /// Whether a failed response is worth retrying, following Stripe's SDKs: the
    /// `Stripe-Should-Retry` header when Stripe sends it, otherwise a 409 conflict (e.g. a
    /// lock timeout) or a 5xx error.
    static func shouldRetry(status: UInt, headers: HTTPHeaders) -> Bool {
        switch headers.first(name: "Stripe-Should-Retry") {
        case "true": return true
        case "false": return false
        default: return status == 409 || status >= 500
        }
    }

    static let initialRetryDelay: TimeInterval = 0.5
    static let maxRetryDelay: TimeInterval = 5

    /// Seconds to wait before retry number `retry` (1-based): exponential backoff from 0.5s,
    /// capped at 5s, with jitter (50–100% of it, but never under 0.5s), and at least as long as
    /// a `Retry-After` of up to 60 seconds asks. `random` is the jitter, in 0...1.
    static func retryDelay(retry: Int, retryAfter: String?, random: Double = .random(in: 0...1)) -> TimeInterval {
        var delay = min(initialRetryDelay * Double(sign: .plus, exponent: retry - 1, significand: 1), maxRetryDelay)
        delay *= 0.5 * (1 + random)
        delay = max(initialRetryDelay, delay)
        if let retryAfter = retryAfter.flatMap({ TimeInterval($0) }), retryAfter <= 60 {
            delay = max(delay, retryAfter)
        }
        return delay
    }

    private static func sleep(seconds: TimeInterval) async throws {
        try await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
    }
}

extension Data {
    mutating func appendUTF8(_ string: String) {
        append(contentsOf: Array(string.utf8))
    }
}
