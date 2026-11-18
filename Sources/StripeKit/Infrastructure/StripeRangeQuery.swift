//
//  StripeRangeQuery.swift
//  StripeKit
//
//  Hand-written infrastructure (not emitted by stripe-kit-codegen).
//

/// An integer filter on a list endpoint, such as `created` or `amount`. The spec types
/// these as `integer | range_query_specs`.
///
/// ```swift
/// CustomerListParams(created: .equals(1_700_000_000))   // created=1700000000
/// CustomerListParams(created: .range(gte: start, lt: end)) // created[gte]=…&created[lt]=…
/// ```
public enum StripeRangeQuery: Codable, Sendable, Equatable {
    /// Matches exactly this value.
    case equals(Int)
    /// Matches values within the bounds. Omitted bounds are open.
    case range(gt: Int? = nil, gte: Int? = nil, lt: Int? = nil, lte: Int? = nil)

    private enum CodingKeys: String, CodingKey {
        case gt, gte, lt, lte
    }

    public func encode(to encoder: any Encoder) throws {
        switch self {
        case .equals(let value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case .range(let gt, let gte, let lt, let lte):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(gt, forKey: .gt)
            try container.encodeIfPresent(gte, forKey: .gte)
            try container.encodeIfPresent(lt, forKey: .lt)
            try container.encodeIfPresent(lte, forKey: .lte)
        }
    }

    public init(from decoder: any Decoder) throws {
        if let value = try? decoder.singleValueContainer().decode(Int.self) {
            self = .equals(value)
            return
        }
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self = .range(
            gt: try container.decodeIfPresent(Int.self, forKey: .gt),
            gte: try container.decodeIfPresent(Int.self, forKey: .gte),
            lt: try container.decodeIfPresent(Int.self, forKey: .lt),
            lte: try container.decodeIfPresent(Int.self, forKey: .lte)
        )
    }
}
