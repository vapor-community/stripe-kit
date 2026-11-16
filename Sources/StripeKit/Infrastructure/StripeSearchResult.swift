//
//  StripeSearchResult.swift
//  StripeKit
//
//  Hand-written infrastructure (not emitted by stripe-kit-codegen).
//

import Foundation

/// The response of a Stripe search endpoint (`object: "search_result"`), e.g.
/// `GET /v1/customers/search`.
///
/// Pass `nextPage` as the `page` param of the next search call to get the following page.
public struct StripeSearchResult<Item: Codable & Sendable>: Codable, Sendable {
    /// Always `search_result`.
    public var object: String
    /// The items matching the query on this page.
    public var data: [Item]
    /// Whether there are more results after this page.
    public var hasMore: Bool
    /// Cursor for the next page, or `nil` on the last page.
    public var nextPage: String?
    /// Total number of matching objects. Only set when requested with `expand: ["total_count"]`.
    public var totalCount: Int?
    /// The URL of this search.
    public var url: String

    public enum CodingKeys: String, CodingKey {
        case object
        case data
        case hasMore = "has_more"
        case nextPage = "next_page"
        case totalCount = "total_count"
        case url
    }
}
