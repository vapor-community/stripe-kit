//
//  ObjectOrDeleted.swift
//  StripeKitCore
//
//  Hand-written infrastructure (not emitted by stripe-kit-codegen).
//

/// A response that is either the full object or a deleted object, as declared by Stripe's API spec.
///
/// For example, retrieving a customer that was deleted returns
/// `{"id": "cus_123", "object": "customer", "deleted": true}` instead of the customer:
///
/// ```swift
/// switch try await stripe.customers.retrieve("cus_123") {
/// case .object(let customer): print(customer.email ?? "")
/// case .deleted(let deleted): print("\(deleted.id) was deleted")
/// }
/// ```
///
/// Decoded by the `deleted` flag, which Stripe sets to `true` on every deleted object.
public enum ObjectOrDeleted<Object: Codable & Sendable, Deleted: Codable & Sendable>: Codable, Sendable {
    case object(Object)
    case deleted(Deleted)

    private enum CodingKeys: String, CodingKey {
        case deleted
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if try container.decodeIfPresent(Bool.self, forKey: .deleted) == true {
            self = .deleted(try Deleted(from: decoder))
        } else {
            self = .object(try Object(from: decoder))
        }
    }

    public func encode(to encoder: any Encoder) throws {
        switch self {
        case .object(let value): try value.encode(to: encoder)
        case .deleted(let value): try value.encode(to: encoder)
        }
    }

    /// The full object, or nil if it was deleted.
    public var object: Object? {
        if case .object(let value) = self { return value }
        return nil
    }

    /// The deleted object, or nil if the full object was returned.
    public var deleted: Deleted? {
        if case .deleted(let value) = self { return value }
        return nil
    }
}
