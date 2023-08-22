//
//  CardholderRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/19.
//

import NIO
import NIOHTTP1

public protocol CardholderRoutes: StripeAPIRoute {
    /// Creates a new Issuing Cardholder object that can be issued cards.
    ///
    /// - Parameters:
    ///   - billing: The cardholder’s billing address.
    ///   - name: The cardholder’s name. This will be printed on cards issued to them. The maximum length of this field is 24 characters. This field cannot contain any special characters or numbers.
    ///   - email: The cardholder’s email address.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - phoneNumber: The cardholder’s phone number. This will be transformed to E.164 if it is not provided in that format already. This is required for all cardholders who will be creating EU cards. See the 3D Secure documentation for more details.
    ///   - company: Additional information about a `company` cardholder.
    ///   - individual: Additional information about an `individual` cardholder.
    ///   - spendingControls: Rules that control spending across this cardholder’s cards. Refer to our documentation for more details.
    ///   - status: Specifies whether to permit authorizations on this cardholder’s cards. Defaults to active.
    ///   - type: The type of cardholder. Possible values are `individual` or `business_entity`.
    /// - Returns: Returns an Issuing Cardholder object if creation succeeds.
    func create(billing: [String: Any],
                name: String,
                email: String?,
                metadata: [String: String]?,
                phoneNumber: String?,
                company: [String: Any]?,
                individual: [String: Any]?,
                spendingControls: [String: Any]?,
                status: CardholderStatus?,
                type: CardholderType) async throws -> Cardholder
    
    /// Retrieves an Issuing Cardholder object.
    ///
    /// - Parameter cardholder: The identifier of the cardholder to be retrieved.
    /// - Returns: Returns an Issuing Cardholder object if a valid identifier was provided.
    func retrieve(cardholder: String) async throws -> Cardholder
    
    /// Updates the specified Issuing Cardholder object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    ///
    /// - Parameters:
    ///   - cardholder: The ID of the cardholder to update.
    ///   - billing: The cardholder’s billing address.
    ///   - email: The cardholder’s email address.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - phoneNumber: The cardholder’s phone number. This will be transformed to E.164 if it is not provided in that format already.
    ///   - company: Additional information about a `company` cardholder.
    ///   - individual: Additional information about an `individual` cardholder.
    ///   - spendingControls: Rules that control spending across this cardholder’s cards. Refer to our documentation for more details.
    ///   - status: Specifies whether to permit authorizations on this cardholder’s cards.
    /// - Returns: Returns an updated Issuing Cardholder object if a valid identifier was provided.
    func update(cardholder: String,
                billing: [String: Any]?,
                email: String?,
                metadata: [String: String]?,
                phoneNumber: String?,
                company: [String: Any]?,
                individual: [String: Any]?,
                spendingControls: [String: Any]?,
                status: CardholderStatus?) async throws -> Cardholder
    
    /// Returns a list of Issuing Cardholder objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter:  A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/issuing/cardholders/list).
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` cardholders, starting after cardholder `starting_after`. Each entry in the array is a separate Issuing ``Cardholder`` object. If no more cardholders are available, the resulting array will be empty.
    func listAll(filter: [String: Any]?) async throws -> AuthorizationList
}

public struct StripeCardholderRoutes: CardholderRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let cardholders = APIBase + APIVersion + "issuing/cardholders"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(billing: [String: Any],
                       name: String,
                       email: String? = nil,
                       metadata: [String: String]? = nil,
                       phoneNumber: String? = nil,
                       company: [String: Any]? = nil,
                       individual: [String: Any]? = nil,
                       spendingControls: [String: Any]? = nil,
                       status: CardholderStatus? = nil,
                       type: CardholderType) async throws -> Cardholder {
        var body: [String: Any] = ["name": name,
                                   "type": type.rawValue]
        billing.forEach { body["billing[\($0)]"] = $1 }
        
        if let email {
            body["email"] = email
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let phoneNumber {
            body["phone_number"] = phoneNumber
        }
        
        if let company {
            company.forEach { body["company[\($0)]"] = $1 }
        }
        
        if let individual {
            individual.forEach { body["individual[\($0)]"] = $1 }
        }
        
        if let spendingControls {
            spendingControls.forEach { body["spending_controls[\($0)]"] = $1 }
        }
        
        if let status  {
            body["status"] = status.rawValue
        }
        
        return try await apiHandler.send(method: .POST, path: cardholders, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(cardholder: String) async throws -> Cardholder {
        try await apiHandler.send(method: .GET, path: "\(cardholders)/\(cardholder)", headers: headers)
    }
    
    public func update(cardholder: String,
                       billing: [String: Any]? = nil,
                       email: String? = nil,
                       metadata: [String: String]? = nil,
                       phoneNumber: String? = nil,
                       company: [String: Any]? = nil,
                       individual: [String: Any]? = nil,
                       spendingControls: [String: Any]? = nil,
                       status: CardholderStatus? = nil) async throws -> Cardholder {
        var body: [String: Any] = [:]
        
        if let billing {
            billing.forEach { body["billing[\($0)]"] = $1 }
        }
        
        if let email {
            body["email"] = email
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let phoneNumber {
            body["phone_number"] = phoneNumber
        }
        
        if let company {
            company.forEach { body["company[\($0)]"] = $1 }
        }
        
        if let individual {
            individual.forEach { body["individual[\($0)]"] = $1 }
        }
        
        if let spendingControls {
            spendingControls.forEach { body["spending_controls[\($0)]"] = $1 }
        }
        
        if let status {
            body["status"] = status.rawValue
        }
        
        return try await apiHandler.send(method: .POST, path: "\(cardholders)/\(cardholder)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> AuthorizationList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: cardholders, query: queryParams, headers: headers)
    }
}
