//
//  CountrySpecRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/23/19.
//

import NIO
import NIOHTTP1
import Baggage

public protocol CountrySpecRoutes {
    /// Lists all Country Spec objects available in the API.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/country_specs/list)
    /// - Returns: A `StripeCountrySpecList`.
    func listAll(filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeCountrySpecList>
    
    /// Returns a Country Spec for a given Country code.
    ///
    /// - Parameter country: An ISO 3166-1 alpha-2 country code. Available country codes can be listed with the [List Country Specs](https://stripe.com/docs/api#list_country_specs) endpoint.
    /// - Returns: A `StripeCountrySpec`.
    func retrieve(country: String, context: LoggingContext) -> EventLoopFuture<StripeCountrySpec>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension CountrySpecRoutes {
    public func listAll(filter: [String: Any]? = nil, context: LoggingContext) -> EventLoopFuture<StripeCountrySpecList> {
        return listAll(filter: filter)
    }
    
    public func retrieve(country: String, context: LoggingContext) -> EventLoopFuture<StripeCountrySpec> {
        return retrieve(country: country)
    }
}

public struct StripeCountrySpecRoutes: CountrySpecRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let countryspecs = APIBase + APIVersion + "country_specs"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func listAll(filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeCountrySpecList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return apiHandler.send(method: .GET, path: countryspecs, query: queryParams, headers: headers)
    }
    
    public func retrieve(country: String, context: LoggingContext) -> EventLoopFuture<StripeCountrySpec> {
         return apiHandler.send(method: .GET, path: "\(countryspecs)/\(country)", headers: headers)
    }
}
