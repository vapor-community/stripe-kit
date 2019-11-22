//
//  CountrySpecRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/23/19.
//

import NIO
import NIOHTTP1

public protocol CountrySpecRoutes {
    /// Lists all Country Spec objects available in the API.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/country_specs/list)
    /// - Returns: A `StripeCountrySpecList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeCountrySpecList>
    
    /// Returns a Country Spec for a given Country code.
    ///
    /// - Parameter country: An ISO 3166-1 alpha-2 country code. Available country codes can be listed with the [List Country Specs](https://stripe.com/docs/api#list_country_specs) endpoint.
    /// - Returns: A `StripeCountrySpec`.
    func retrieve(country: String) -> EventLoopFuture<StripeCountrySpec>
    
    var headers: HTTPHeaders { get set }
}

extension CountrySpecRoutes {
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeCountrySpecList> {
        return listAll(filter: filter)
    }
    
    public func retrieve(country: String) -> EventLoopFuture<StripeCountrySpec> {
        return retrieve(country: country)
    }
}

public struct StripeCountrySpecRoutes: CountrySpecRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeCountrySpecList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return apiHandler.send(method: .GET, path: StripeAPIEndpoint.countrySpec.endpoint, query: queryParams, headers: headers)
    }
    
    public func retrieve(country: String) -> EventLoopFuture<StripeCountrySpec> {
         return apiHandler.send(method: .GET, path: StripeAPIEndpoint.countrySpecs(country).endpoint, headers: headers)
    }
}
