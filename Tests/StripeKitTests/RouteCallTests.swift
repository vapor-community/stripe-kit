import Foundation
import Testing
@testable import StripeKit

/// The generated route methods: argument labels, defaults, and forwarding to the route's
/// stored closure, which tests can replace.
@Suite("Route calls")
struct RouteCallTests {
    /// What a stubbed route was called with
    actor Calls {
        var all: [String] = []
        func record(_ call: String) { all.append(call) }
    }

    @Test("Methods fill in defaults and forward to the replaceable closures")
    func methodsForwardToClosures() async throws {
        let calls = Calls()
        var client = StripeClient.test
        client.customers.retrieve = { id, expand, options in
            await calls.record("retrieve \(id) \(expand ?? []) \(options.idempotencyKey ?? "-")")
            return try Fixtures.decode("customer", as: ObjectOrDeleted<Customer, DeletedCustomer>.self)
        }
        client.customers.create = { params, options in
            await calls.record("create \(params.email ?? "-") \(options.stripeAccount ?? "-")")
            return try Fixtures.decode("customer", as: Customer.self)
        }
        client.customers.retrievePaymentMethod = { customer, paymentMethod, _, _ in
            await calls.record("retrievePaymentMethod \(customer) \(paymentMethod)")
            return try Fixtures.decode("payment_method", as: PaymentMethod.self)
        }
        client.terminal.readers.list = { params, _ in
            await calls.record("readers.list \(params.limit.map(String.init) ?? "-")")
            return TerminalReaderList(object: "list", data: [])
        }

        _ = try await client.customers.retrieve("cus_1")
        _ = try await client.customers.retrieve("cus_1", expand: ["default_source"], options: .init(idempotencyKey: "key_1"))
        _ = try await client.customers.create()
        _ = try await client.customers.create(.init(email: "a@example.com"), options: .init(stripeAccount: "acct_1"))
        _ = try await client.customers.retrievePaymentMethod("cus_1", paymentMethod: "pm_1")
        _ = try await client.terminal.readers.list(.init(limit: 3))

        #expect(await calls.all == [
            "retrieve cus_1 [] -",
            "retrieve cus_1 [\"default_source\"] key_1",
            "create - -",
            "create a@example.com acct_1",
            "retrievePaymentMethod cus_1 pm_1",
            "readers.list 3",
        ])
    }
}
