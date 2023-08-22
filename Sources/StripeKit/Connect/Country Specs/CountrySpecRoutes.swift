//
//  CountrySpecRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/23/19.
//

import NIO
import NIOHTTP1

public protocol CountrySpecRoutes: StripeAPIRoute {
    /// Lists all Country Spec objects available in the API.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/country_specs/list)
    /// - Returns: Returns a list of `country_spec` objects.
    func listAll(filter: [String: Any]?) async throws -> CountrySpecList
    
    /// Returns a Country Spec for a given Country code.
    ///
    /// - Parameter country: An ISO 3166-1 alpha-2 country code. Available country codes can be listed with the [List Country Specs](https://stripe.com/docs/api#list_country_specs) endpoint.
    /// - Returns: Returns a `country_spec` object if a valid country code is provided, and returns an error otherwise.
    func retrieve(country: String) async throws -> CountrySpec
}

public struct StripeCountrySpecRoutes: CountrySpecRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let countryspecs = APIBase + APIVersion + "country_specs"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> CountrySpecList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        return try await apiHandler.send(method: .GET, path: countryspecs, query: queryParams, headers: headers)
    }
    
    public func retrieve(country: String) async throws -> CountrySpec {
         try await apiHandler.send(method: .GET, path: "\(countryspecs)/\(country)", headers: headers)
    }
}
