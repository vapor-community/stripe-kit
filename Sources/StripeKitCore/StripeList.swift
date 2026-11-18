//
//  StripeList.swift
//  StripeKitCore
//
//  Hand-written infrastructure (not emitted by stripe-kit-codegen).
//

/// A page of a list (`object: "list"`), from a list endpoint such as `GET /v1/customers` or a
/// list-valued field such as a customer's `sources`.
///
/// Each resource has an alias for its list, e.g. `CustomerList` is `StripeList<Customer>`.
/// Pass the last item's ID as `startingAfter` in the list params to get the next page.
public struct StripeList<Item: Codable & Sendable>: Codable, Sendable {
    /// Always `list`.
    public var object: String
    /// The items on this page.
    public var data: [Item]
    /// Whether there are more items after this page.
    public var hasMore: Bool
    /// The URL of this list.
    public var url: String

    public init(object: String = "list", data: [Item] = [], hasMore: Bool = false, url: String = "") {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }

    public enum CodingKeys: String, CodingKey {
        case object
        case data
        case hasMore = "has_more"
        case url
    }
}
