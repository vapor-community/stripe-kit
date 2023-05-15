//
//  ReviewRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/26/19.
//

import NIO
import NIOHTTP1

public protocol ReviewRoutes: StripeAPIRoute {
    /// Approves a `Review` object, closing it and removing it from the list of reviews.
    ///
    /// - Parameter review: The identifier of the review to be approved.
    /// - Parameter expand: An array of properties to expand.
    /// - Returns: Returns the approved Review object.
    func approve(review: String, expand: [String]?) async throws -> Review
    
    /// Retrieves a Review object.
    ///
    /// - Parameter review: The identifier of the review to be retrieved.
    /// - Parameter expand: An array of properties to expand.
    /// - Returns: Returns a Review object if a valid identifier was provided.
    func retrieve(review: String, expand: [String]?) async throws -> Review
    
    /// Returns a list of `Review` objects that have `open` set to `true`. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/radar/reviews/list).
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` reviews, starting after review `starting_after`. Each entry in the array is a separate Review object. If no more reviews are available, the resulting array will be empty.
    func listAll(filter: [String: Any]?) async throws -> ReviewList
}

public struct StripeReviewRoutes: ReviewRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let reviews = APIBase + APIVersion + "reviews"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }    
    
    public func approve(review: String, expand: [String]? = nil) async throws -> Review {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(reviews)\(review)/approve", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(review: String, expand: [String]? = nil) async throws -> Review {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(reviews)\(review)", query: queryParams, headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) async throws -> ReviewList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        return try await apiHandler.send(method: .GET, path: reviews, query: queryParams, headers: headers)
    }
}
