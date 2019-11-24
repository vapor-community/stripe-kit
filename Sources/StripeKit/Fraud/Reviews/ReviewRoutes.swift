//
//  ReviewRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/26/19.
//

import NIO
import NIOHTTP1

public protocol ReviewRoutes {
    /// Approves a `Review` object, closing it and removing it from the list of reviews.
    ///
    /// - Parameter review: The identifier of the review to be approved.
    /// - Returns: A `StripeReview`.
    func approve(review: String) -> EventLoopFuture<StripeReview>
    
    /// Retrieves a Review object.
    ///
    /// - Parameter review: The identifier of the review to be retrieved.
    /// - Returns: A `StripeReview`.
    func retrieve(review: String) -> EventLoopFuture<StripeReview>
    
    /// Returns a list of `Review` objects that have `open` set to `true`. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/radar/reviews/list).
    /// - Returns: A `StripeReviewList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeReviewList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension ReviewRoutes {
    func approve(review: String) -> EventLoopFuture<StripeReview> {
        return approve(review: review)
    }
    
    func retrieve(review: String) -> EventLoopFuture<StripeReview> {
        return retrieve(review: review)
    }
    
    func listAll(filter: [String: Any]? = nil)  -> EventLoopFuture<StripeReviewList> {
        return listAll(filter: filter)
    }
}

public struct StripeReviewRoutes: ReviewRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let reviews = APIBase + APIVersion + "reviews"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }    
    
    public func approve(review: String) -> EventLoopFuture<StripeReview> {
        return apiHandler.send(method: .POST, path: "\(reviews)\(review)/approve", headers: headers)
    }
    
    public func retrieve(review: String) -> EventLoopFuture<StripeReview> {
        return apiHandler.send(method: .GET, path: "\(reviews)\(review)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeReviewList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return apiHandler.send(method: .GET, path: reviews, query: queryParams, headers: headers)
    }
}
