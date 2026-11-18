//
//  StripeParams.swift
//  StripeKit
//
//  Hand-written infrastructure (not emitted by stripe-kit-codegen).
//

import Foundation

/// Protocol for typed API parameter structs.
/// Conforming types automatically get form-encoded body generation.
public protocol StripeParams: Codable, Sendable {
    /// Convert this params struct to a URL-encoded form body string.
    func toFormBody() -> String
}

extension StripeParams {
    /// Form-encodes the params using Stripe's bracket conventions.
    ///
    /// The params are encoded with `JSONEncoder` first, so the generated `CodingKeys`
    /// decide the wire names (`ssnLast4` → `ssn_last_4`) and enum values encode their raw
    /// value (`.offSession` → `off_session`). The JSON is then flattened:
    ///
    /// - Nested objects and dictionaries: `parent[child]=value`
    /// - Arrays of scalars (strings, numbers, enums): `key[]=value`
    /// - Arrays of objects: `key[0][field]=value`
    /// - `nil` optionals and empty arrays/objects are omitted.
    /// - Fields to clear (see `ClearableParams`) are sent empty: `field=`.
    public func toFormBody() -> String {
        let json: JSONValue
        do {
            let encoder = JSONEncoder()
            // Stripe takes timestamps as whole Unix seconds; `.secondsSince1970` would send
            // fractions (`1700000000.25`), which it rejects.
            encoder.dateEncodingStrategy = .custom { date, encoder in
                var container = encoder.singleValueContainer()
                try container.encode(Int64(date.timeIntervalSince1970.rounded(.down)))
            }
            json = try JSONDecoder().decode(JSONValue.self, from: encoder.encode(self))
        } catch {
            assertionFailure("StripeParams form encoding failed for \(Self.self): \(error)")
            return ""
        }
        var pairs: [(String, String)] = []
        json.flatten(key: "", into: &pairs)
        return pairs
            .map { "\($0.0)=\($0.1.addingPercentEncoding(withAllowedCharacters: .stripeQueryAllowed) ?? $0.1)" }
            .joined(separator: "&")
    }
}

// MARK: - Clearing Fields

/// A field of a params struct that Stripe lets you clear (see `ClearableParams`)
public protocol StripeClearableField: RawRepresentable, Codable, Hashable, Sendable where RawValue == String {}

/// Params with fields Stripe lets you clear by sending them empty (`field=`), as its API
/// reference describes for e.g. `metadata`, `shipping` or `discounts`. stripe-go calls this
/// unsetting a field.
///
/// ```swift
/// var params = CustomerUpdateParams()
/// params.clear(.shipping)   // shipping=
/// ```
public protocol ClearableParams: StripeParams {
    /// The fields Stripe lets you clear on these params
    associatedtype ClearableField: StripeClearableField
    /// The fields to send empty. Set with `clear(_:)`.
    var fieldsToClear: Set<ClearableField> { get set }
}

extension ClearableParams {
    /// Send `field` empty, which clears it on the object being updated. A value set on the
    /// field isn't sent.
    public mutating func clear(_ field: ClearableField) {
        fieldsToClear.insert(field)
    }
}

extension KeyedDecodingContainer {
    /// Lets params JSON without `fieldsToClear` decode, as an empty set
    public func decode<Field: StripeClearableField>(_ type: Set<Field>.Type, forKey key: Key) throws -> Set<Field> {
        try decodeIfPresent(type, forKey: key) ?? []
    }
}

/// The key a params struct encodes its `fieldsToClear` under (stripe-kit-codegen writes it into
/// each struct's CodingKeys), which `toFormBody()` turns into `field=` pairs.
let fieldsToClearKey = "__stripe_kit_fields_to_clear"

private extension JSONValue {
    private var isContainer: Bool {
        switch self {
        case .array, .object: return true
        default: return false
        }
    }

    func flatten(key: String, into pairs: inout [(String, String)]) {
        switch self {
        case .null:
            return
        case .bool(let value):
            pairs.append((key, value ? "true" : "false"))
        case .int(let value):
            pairs.append((key, "\(value)"))
        case .double(let value):
            pairs.append((key, "\(value)"))
        case .string(let value):
            pairs.append((key, value))
        case .array(let items):
            for (index, item) in items.enumerated() {
                item.flatten(key: item.isContainer ? "\(key)[\(index)]" : "\(key)[]", into: &pairs)
            }
        case .object(var fields):
            // Fields to clear are sent empty (`field=`), in place of any value
            if case .array(let names)? = fields.removeValue(forKey: fieldsToClearKey) {
                for case .string(let name) in names {
                    fields[name] = .string("")
                }
            }
            // Sorted for deterministic output; Stripe doesn't care about field order.
            for (name, value) in fields.sorted(by: { $0.key < $1.key }) {
                let name = name.addingPercentEncoding(withAllowedCharacters: .stripeQueryAllowed) ?? name
                value.flatten(key: key.isEmpty ? name : "\(key)[\(name)]", into: &pairs)
            }
        }
    }
}

extension CharacterSet {
    /// URL query allowed characters minus `+`, `&`, and `=` which have special
    /// meaning in form-encoded bodies.
    static let stripeQueryAllowed: CharacterSet = {
        var cs = CharacterSet.urlQueryAllowed
        cs.remove("+")
        cs.remove("&")
        cs.remove("=")
        return cs
    }()
}
