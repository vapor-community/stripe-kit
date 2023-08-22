//
//  IssuingCardRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/31/19.
//

import NIO
import NIOHTTP1

public protocol IssuingCardRoutes: StripeAPIRoute {
    /// Creates an Issuing `Card` object.
    ///
    /// - Parameters:
    ///   - cardholder: The Cardholder object with which the card will be associated.
    ///   - currency: The currency for the card. This currently must be usd.
    ///   - type: The type of card to issue. Possible values are physical or virtual.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - status: Specifies whether to permit authorizations on this card. Possible values are `active` or `inactive`.
    ///   - replacementFor: The card this is meant to be a replacement for (if any).
    ///   - replacementReason: If `replacement_for` is specified, this should indicate why that card is being replaced.
    ///   - shipping: The address where the card will be shipped.
    ///   - spendingControls: Spending rules that give you some control over how your cards can be used. Refer to our authorizations documentation for more details.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns an Issuing Card object if creation succeeds.
    func create(cardholder: String,
                currency: Currency,
                type: IssuingCardType,
                metadata: [String: String]?,
                status: IssuingCardStatus?,
                replacementFor: String?,
                replacementReason: IssuingCardReplacementReason?,
                shipping: [String: Any]?,
                spendingControls: [String: Any]?,
                expand: [String]?) async throws -> IssuingCard
    
    /// Retrieves an Issuing `Card` object.
    ///
    /// - Parameter card: The identifier of the card to be retrieved.
    /// - Parameter expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns an Issuing `Card` object if a valid identifier was provided. When requesting the ID of a card that has been deleted, a subset of the card’s information will be returned, including a `deleted` property, which will be true.
    func retrieve(card: String, expand: [String]?) async throws -> IssuingCard
    
    /// Updates the specified Issuing Card object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    ///
    /// - Parameters:
    ///   - card: The identifier of the issued card to update.
    ///   - cancellationReason: Reason why the `status` of this card is `canceled`.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - status: Dictates whether authorizations can be approved on this card. If this card is being canceled because it was lost or stolen, this information should be provided as `cancellation_reason`.
    ///   - pin: The desired new PIN for this card.
    ///   - spendingControls: Spending rules that give you some control over how your cards can be used. Refer to our authorizations documentation for more details. This will be unset if you POST an empty value.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns an updated Issuing Card object if a valid identifier was provided.
    func update(card: String,
                cancellationReason: IssuingCardCancellationReason?,
                metadata: [String: String]?,
                status: IssuingCardStatus?,
                pin: [String: Any]?,
                spendingControls: [String: Any]?,
                expand: [String]?) async throws -> IssuingCard
    
    /// Returns a list of Issuing Card objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/issuing/cards/list)
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` cards, starting after card `starting_after`. Each entry in the array is a separate Issuing `Card` object. If no more cards are available, the resulting array will be empty.
    func listAll(filter: [String: Any]?) async throws -> IssuingCardList
    
    /// Updates the shipping status of the specified Issuing `Card` object to shipped.
    /// - Parameters:
    ///   - card: The identifier of the issued card to update.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns an updated Issuing `Card` object.
    func ship(card: String, expand: [String]?) async throws -> IssuingCard
    
    /// Updates the shipping status of the specified Issuing `Card` object to `delivered`.
    /// - Parameters:
    ///   - card: The identifier of the issued card to update.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns an updated Issuing `Card` object.
    func deliver(card: String, expand: [String]?) async throws -> IssuingCard
    
    /// Updates the shipping status of the specified Issuing `Card` object to `returned`.
    /// - Parameters:
    ///   - card: The identifier of the issued card to update.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns an updated Issuing `Card` object.
    func `return`(card: String, expand: [String]?) async throws -> IssuingCard
    
    /// Updates the shipping status of the specified Issuing `Card` object to `failure`.
    /// - Parameters:
    ///   - card: The identifier of the issued card to update.
    ///   - expand: Specifies which fields in the response should be expanded.
    /// - Returns: Returns an updated Issuing `Card` object.
    func fail(card: String, expand: [String]?) async throws -> IssuingCard
}

public struct StripeIssuingCardRoutes: IssuingCardRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let issuingcards = APIBase + APIVersion + "issuing/cards"
    private let testhelpers = APIBase + APIVersion + "test_helpers/issuing/cards"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(cardholder: String,
                       currency: Currency,
                       type: IssuingCardType,
                       metadata: [String: String]? = nil,
                       status: IssuingCardStatus? = nil,
                       replacementFor: String? = nil,
                       replacementReason: IssuingCardReplacementReason? = nil,
                       shipping: [String: Any]? = nil,
                       spendingControls: [String: Any]? = nil,
                       expand: [String]? = nil) async throws -> IssuingCard {
        var body: [String: Any] = ["cardholder": cardholder,
                                   "currency": currency.rawValue,
                                   "type": type.rawValue]
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let status {
            body["status"] = status.rawValue
        }
        
        if let replacementFor {
            body["replacement_for"] = replacementFor
        }
        
        if let replacementReason {
            body["replacement_reason"] = replacementReason.rawValue
        }
        
        if let shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let spendingControls {
            spendingControls.forEach { body["spending_controls[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: issuingcards, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(card: String, expand: [String]? = nil) async throws -> IssuingCard {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(issuingcards)/\(card)", query: queryParams, headers: headers)
    }

    public func update(card: String,
                       cancellationReason: IssuingCardCancellationReason? = nil,
                       metadata: [String: String]? = nil,
                       status: IssuingCardStatus? = nil,
                       pin: [String: Any]? = nil,
                       spendingControls: [String: Any]? = nil,
                       expand: [String]? = nil) async throws -> IssuingCard {
        var body: [String: Any] = [:]
        
        if let cancellationReason {
            body["cancellation_reason"] = cancellationReason.rawValue
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let status {
            body["status"] = status.rawValue
        }
        
        if let pin {
            pin.forEach { body["pin[\($0)]"] = $1 }
        }
        
        if let spendingControls {
            spendingControls.forEach { body["spending_controls[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(issuingcards)/\(card)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> IssuingCardList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: issuingcards, query: queryParams, headers: headers)
    }
    
    public func ship(card: String, expand: [String]? = nil) async throws -> IssuingCard {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(testhelpers)/\(card)/shipping/ship", body: .string(body.queryParameters), headers: headers)
    }
    
    public func deliver(card: String, expand: [String]? = nil) async throws -> IssuingCard {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(testhelpers)/\(card)/shipping/deliver", body: .string(body.queryParameters), headers: headers)
    }
    
    public func `return`(card: String, expand: [String]? = nil) async throws -> IssuingCard {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(testhelpers)/\(card)/shipping/return", body: .string(body.queryParameters), headers: headers)
    }
    
    public func fail(card: String, expand: [String]? = nil) async throws -> IssuingCard {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(testhelpers)/\(card)/shipping/fail", body: .string(body.queryParameters), headers: headers)
    }
}
