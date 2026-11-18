import Foundation
import Testing
import NIOHTTP1
import AsyncHTTPClient
@testable import StripeKit

/// Retries follow Stripe's SDKs: 2 by default, honouring `Stripe-Should-Retry`, with backoff,
/// and with a generated idempotency key on POSTs so a retry can't perform one twice.
@Suite("Retries")
struct RetryTests {
    @Test("Stripe-Should-Retry decides when present; otherwise 409 and 5xx retry",
          arguments: [
              (409, nil, true), (500, nil, true), (503, nil, true),
              (400, nil, false), (401, nil, false), (402, nil, false), (404, nil, false), (429, nil, false),
              (429, "true", true), (400, "true", true), (500, "false", false), (409, "false", false),
          ] as [(UInt, String?, Bool)])
    func shouldRetry(status: UInt, header: String?, expected: Bool) {
        var headers = HTTPHeaders()
        if let header { headers.add(name: "Stripe-Should-Retry", value: header) }
        #expect(StripeAPIHandler.shouldRetry(status: status, headers: headers) == expected)
    }

    @Test("Backoff doubles from 0.5s up to 5s, with jitter, and honours Retry-After up to 60s")
    func retryDelay() {
        // Without jitter (random: 1), each retry doubles until the cap
        #expect(StripeAPIHandler.retryDelay(retry: 1, retryAfter: nil, random: 1) == 0.5)
        #expect(StripeAPIHandler.retryDelay(retry: 2, retryAfter: nil, random: 1) == 1)
        #expect(StripeAPIHandler.retryDelay(retry: 3, retryAfter: nil, random: 1) == 2)
        #expect(StripeAPIHandler.retryDelay(retry: 6, retryAfter: nil, random: 1) == 5)
        // Full jitter halves it, but never below the initial delay
        #expect(StripeAPIHandler.retryDelay(retry: 3, retryAfter: nil, random: 0) == 1)
        #expect(StripeAPIHandler.retryDelay(retry: 1, retryAfter: nil, random: 0) == 0.5)
        // Retry-After lengthens the wait, unless it's over 60s or not a number of seconds
        #expect(StripeAPIHandler.retryDelay(retry: 1, retryAfter: "10", random: 1) == 10)
        #expect(StripeAPIHandler.retryDelay(retry: 1, retryAfter: "120", random: 1) == 0.5)
        #expect(StripeAPIHandler.retryDelay(retry: 1, retryAfter: "Wed, 21 Oct 2026 07:28:00 GMT", random: 1) == 0.5)
    }

    @Test("A POST gets a generated idempotency key when it may be retried")
    func generatedIdempotencyKeys() {
        let handler = StripeAPIHandler(httpClient: .shared, apiKey: "sk_test_123")
        #expect(handler.maxNetworkRetries == 2)

        let post = handler.request(.POST, "/v1/customers").headers["Idempotency-Key"]
        #expect(post.count == 1)
        #expect(post.first?.hasPrefix("stripe-kit-retry-") == true)
        // A new key per request
        #expect(handler.request(.POST, "/v1/customers").headers["Idempotency-Key"] != post)
        // The caller's own key wins
        #expect(handler.request(.POST, "/v1/customers", options: .init(idempotencyKey: "mine")).headers["Idempotency-Key"] == ["mine"])
        // Only POSTs, and only when retries are on
        #expect(handler.request(.GET, "/v1/customers").headers["Idempotency-Key"].isEmpty)
        let noRetries = StripeAPIHandler(httpClient: .shared, apiKey: "sk_test_123", maxNetworkRetries: 0)
        #expect(noRetries.request(.POST, "/v1/customers").headers["Idempotency-Key"].isEmpty)
    }

    @Test("The client passes its retry setting on, including to onBehalfOf clients")
    func clientConfiguration() {
        let client = StripeClient.live(httpClient: .shared, apiKey: "sk_test_123", maxNetworkRetries: 5)
        #expect(client.handler.maxNetworkRetries == 5)
        #expect(client.onBehalfOf("acct_1").handler.maxNetworkRetries == 5)
        #expect(StripeClient.test.handler.maxNetworkRetries == 0)
    }
}

// MARK: - Against a local server

import NIOCore
import NIOPosix

extension RetryTests {
    @Test("Retries a retryable response, resending the same idempotency key")
    func retriesUntilSuccess() async throws {
        let server = try await StubServer.start(responses: [(500, [:]), (503, [:]), (200, [:])])
        defer { server.stop() }
        let handler = StripeAPIHandler(httpClient: .shared, apiKey: "sk_test_123")

        _ = try await handler.sendForData(.POST, "/v1/customers", baseURL: server.url)

        let keys = server.received.map { $0.headers["Idempotency-Key"] }
        #expect(keys.count == 3)
        #expect(Set(keys).count == 1)
        #expect(keys.first?.first?.hasPrefix("stripe-kit-retry-") == true)
    }

    @Test("Gives up after maxNetworkRetries, throwing the last error")
    func givesUp() async throws {
        let server = try await StubServer.start(responses: [(500, [:]), (500, [:]), (500, [:]), (200, [:])])
        defer { server.stop() }
        let handler = StripeAPIHandler(httpClient: .shared, apiKey: "sk_test_123", maxNetworkRetries: 1)

        await #expect(throws: StripeError.self) {
            try await handler.sendForData(.GET, "/v1/customers", baseURL: server.url)
        }
        #expect(server.received.count == 2)
    }

    @Test("Doesn't retry a client error, or when Stripe-Should-Retry says not to")
    func doesNotRetry() async throws {
        let server = try await StubServer.start(responses: [(402, [:]), (500, ["Stripe-Should-Retry": "false"]), (200, [:])])
        defer { server.stop() }
        let handler = StripeAPIHandler(httpClient: .shared, apiKey: "sk_test_123")

        await #expect(throws: StripeError.self) { try await handler.sendForData(.GET, "/v1/a", baseURL: server.url) }
        await #expect(throws: StripeError.self) { try await handler.sendForData(.GET, "/v1/b", baseURL: server.url) }
        #expect(server.received.map(\.uri) == ["/v1/a", "/v1/b"])
    }
}

/// A local HTTP server that answers each request with the next of `responses` and records the
/// requests it got.
final class StubServer: @unchecked Sendable {
    private let lock = NSLock()
    private var responses: [(status: UInt, headers: [String: String])]
    private var requests: [HTTPRequestHead] = []
    private var channel: (any Channel)?

    var url: String { "http://127.0.0.1:\(channel!.localAddress!.port!)" }
    var received: [HTTPRequestHead] { lock.withLock { requests } }

    private init(responses: [(UInt, [String: String])]) {
        self.responses = responses.map { (status: $0.0, headers: $0.1) }
    }

    static func start(responses: [(UInt, [String: String])]) async throws -> StubServer {
        let server = StubServer(responses: responses)
        server.channel = try await ServerBootstrap(group: MultiThreadedEventLoopGroup.singleton)
            .serverChannelOption(.socketOption(.so_reuseaddr), value: 1)
            .childChannelInitializer { channel in
                channel.pipeline.configureHTTPServerPipeline().flatMap {
                    channel.pipeline.addHandler(Handler(server: server))
                }
            }
            .bind(host: "127.0.0.1", port: 0)
            .get()
        return server
    }

    func stop() {
        try? channel?.close().wait()
    }

    fileprivate func record(_ head: HTTPRequestHead) -> (status: UInt, headers: [String: String]) {
        lock.withLock {
            requests.append(head)
            return responses.isEmpty ? (200, [:]) : responses.removeFirst()
        }
    }

    private final class Handler: ChannelInboundHandler, @unchecked Sendable {
        typealias InboundIn = HTTPServerRequestPart
        typealias OutboundOut = HTTPServerResponsePart
        let server: StubServer
        var head: HTTPRequestHead?

        init(server: StubServer) { self.server = server }

        func channelRead(context: ChannelHandlerContext, data: NIOAny) {
            switch unwrapInboundIn(data) {
            case .head(let head):
                self.head = head
            case .body:
                break
            case .end:
                let response = server.record(head!)
                let body = #"{"error": {"type": "api_error", "message": "stub"}}"#
                var headers = HTTPHeaders(response.headers.map { ($0.key, $0.value) })
                headers.add(name: "Content-Length", value: "\(body.utf8.count)")
                headers.add(name: "Content-Type", value: "application/json")
                context.write(wrapOutboundOut(.head(HTTPResponseHead(version: .http1_1, status: .init(statusCode: Int(response.status)), headers: headers))), promise: nil)
                context.write(wrapOutboundOut(.body(.byteBuffer(ByteBuffer(string: body)))), promise: nil)
                context.writeAndFlush(wrapOutboundOut(.end(nil)), promise: nil)
            }
        }
    }
}
