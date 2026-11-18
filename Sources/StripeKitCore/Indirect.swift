//
//  Indirect.swift
//  StripeKitCore
//
//  Hand-written infrastructure (not emitted by stripe-kit-codegen).
//

/// Stores a property's value out of line (Rust SDKs use `Box<T>` for the same thing).
///
/// stripe-kit-codegen marks a property `@Indirect` when it embeds another API resource, such
/// as `ApiErrors.paymentIntent`. That keeps models small (embedding resources inline made
/// some many KB), and lets models be recursive: a struct can't contain itself, even through
/// other structs, and `PaymentIntent.lastPaymentError` is an `ApiErrors`, which has a
/// `paymentIntent`.
///
/// Transparent to callers and to `Codable`: it reads, writes, encodes and decodes as the
/// wrapped value.
@propertyWrapper
public struct Indirect<Value: Codable & Sendable>: Codable, Sendable {
    private final class Box: Sendable {
        let value: Value
        init(_ value: Value) { self.value = value }
    }

    private var box: Box

    public init(wrappedValue: Value) {
        box = Box(wrappedValue)
    }

    public var wrappedValue: Value {
        get { box.value }
        set { box = Box(newValue) }
    }

    public init(from decoder: any Decoder) throws {
        box = Box(try Value(from: decoder))
    }

    public func encode(to encoder: any Encoder) throws {
        try box.value.encode(to: encoder)
    }
}

extension KeyedDecodingContainer {
    /// Lets an optional `@Indirect` property be missing from the JSON, like a plain optional.
    public func decode<T>(_ type: Indirect<T?>.Type, forKey key: Key) throws -> Indirect<T?> {
        try decodeIfPresent(type, forKey: key) ?? Indirect(wrappedValue: nil)
    }
}
