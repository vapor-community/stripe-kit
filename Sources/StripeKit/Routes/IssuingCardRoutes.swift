//
//  IssuingCardRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/31/19.
//

import NIO
import NIOHTTP1

public protocol IssuingCardRoutes {
    /// Creates an Issuing `Card` object.
    ///
    /// - Parameters:
    ///   - currency: The currency for the card. This currently must be usd.
    ///   - type: The type of card to issue. Possible values are physical or virtual.
    ///   - authorizationControls: Spending rules that give you some control over how your cards can be used. Refer to our authorizations documentation for more details.
    ///   - cardholder: The Cardholder object with which the card will be associated.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - replacementFor: The card this is meant to be a replacement for (if any).
    ///   - replacementReason: If `replacement_for` is specified, this should indicate why that card is being replaced. One of `damage`, `expiration`, `loss`, or `theft`.
    ///   - shipping: The address where the card will be shipped.
    ///   - status: Specifies whether to permit authorizations on this card. Possible values are `active` or `inactive`.
    /// - Returns: A `StripeIssuingCard`.
    func create(currency: StripeCurrency,
                type: StripeIssuingCardType,
                authorizationControls: [String: Any]?,
                cardholder: String?,
                metadata: [String: String]?,
                replacementFor: String?,
                replacementReason: StripeIssuingCardReplacementReason?,
                shipping: [String: Any]?,
                status: StripeIssuingCardStatus?) -> EventLoopFuture<StripeIssuingCard>
    
    /// Retrieves an Issuing `Card` object.
    ///
    /// - Parameter card: The identifier of the card to be retrieved.
    /// - Returns: A `StripeIssuingCard`.
    func retrieve(card: String) -> EventLoopFuture<StripeIssuingCard>
    
    /// For virtual cards only. Retrieves an Issuing Card_details object that contains the sensitive details of a virtual card.
    ///
    /// - Parameter card: The identifier of the virtual card to be retrieved.
    /// - Returns: A `StripeIssuingCardDetails`.
    func retrieveDetails(card: String) -> EventLoopFuture<StripeIssuingCardDetails>
    
    /// Updates the specified Issuing Card object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    ///
    /// - Parameters:
    ///   - card: The identifier of the issued card to update.
    ///   - authorizationControls: Spending rules that give you some control over how your cards can be used. Refer to our authorizations documentation for more details. This will be unset if you POST an empty value.
    ///   - cardholder: The Cardholder to associate the card with.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    ///   - status: Specifies whether to permit authorizations on this card. Possible values are `active`, `inactive`, or the terminal states: `canceled`, `lost`, `stolen`.
    /// - Returns: A `StripeIssuingCard`.
    func update(card: String,
                authorizationControls: [String: Any]?,
                cardholder: String?,
                metadata: [String: String]?,
                status: StripeIssuingCardStatus?) -> EventLoopFuture<StripeIssuingCard>
    
    /// Returns a list of Issuing Card objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    ///
    /// - Parameter filter:  A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/issuing/cards/list).
    /// - Returns: A `StripeIssuingCardList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeIssuingCardList>
    
    var headers: HTTPHeaders { get set }
}

extension IssuingCardRoutes {
    func create(currency: StripeCurrency,
                type: StripeIssuingCardType,
                authorizationControls: [String: Any]? = nil,
                cardholder: String? = nil,
                metadata: [String: String]? = nil,
                replacementFor: String? = nil,
                replacementReason: StripeIssuingCardReplacementReason? = nil,
                shipping: [String: Any]? = nil,
                status: StripeIssuingCardStatus? = nil) -> EventLoopFuture<StripeIssuingCard> {
        return create(currency: currency,
                          type: type,
                          authorizationControls: authorizationControls,
                          cardholder: cardholder,
                          metadata: metadata,
                          replacementFor: replacementFor,
                          replacementReason: replacementReason,
                          shipping: shipping,
                          status: status)
    }
    
    func retrieve(card: String) -> EventLoopFuture<StripeIssuingCard> {
        return retrieve(card: card)
    }
    
    func retrieveDetails(card: String) -> EventLoopFuture<StripeIssuingCardDetails> {
        return retrieveDetails(card: card)
    }
    
    func update(card: String,
                authorizationControls: [String: Any]? = nil,
                cardholder: String? = nil,
                metadata: [String: String]? = nil,
                status: StripeIssuingCardStatus? = nil) -> EventLoopFuture<StripeIssuingCard> {
        return update(card: card,
                          authorizationControls: authorizationControls,
                          cardholder: cardholder,
                          metadata: metadata,
                          status: status)
    }
    
    func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeIssuingCardList> {
        return listAll(filter: filter)
    }
}

public struct StripeIssuingCardRoutes: IssuingCardRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(currency: StripeCurrency,
                       type: StripeIssuingCardType,
                       authorizationControls: [String: Any]?,
                       cardholder: String?,
                       metadata: [String: String]?,
                       replacementFor: String?,
                       replacementReason: StripeIssuingCardReplacementReason?,
                       shipping: [String: Any]?,
                       status: StripeIssuingCardStatus?) -> EventLoopFuture<StripeIssuingCard> {
        var body: [String: Any] = ["currency": currency.rawValue,
                                   "type": type.rawValue]
        
        if let authorizationControls = authorizationControls {
            authorizationControls.forEach { body["authorization_controls[\($0)]"] = $1 }
        }
        
        if let cardholder = cardholder {
            body["cardholder"] = cardholder
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let replacementFor = replacementFor {
            body["replacement_for"] = replacementFor
        }
        
        if let replacementReason = replacementReason {
            body["replacement_reason"] = replacementReason.rawValue
        }
        
        if let shipping = shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let status = status {
            body["status"] = status.rawValue
        }
        
        return apiHandler.send(method: .POST, path: StripeAPIEndpoint.issuingCard.endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(card: String) -> EventLoopFuture<StripeIssuingCard> {
        return apiHandler.send(method: .GET, path: StripeAPIEndpoint.issuingCards(card).endpoint, headers: headers)
    }
    
    public func retrieveDetails(card: String) -> EventLoopFuture<StripeIssuingCardDetails> {
        return apiHandler.send(method: .GET, path: StripeAPIEndpoint.issuingCardDetails(card).endpoint, headers: headers)
    }
    
    public func update(card: String,
                       authorizationControls: [String: Any]?,
                       cardholder: String?,
                       metadata: [String: String]?,
                       status: StripeIssuingCardStatus?) -> EventLoopFuture<StripeIssuingCard> {
        var body: [String: Any] = [:]
        
        if let authorizationControls = authorizationControls {
            authorizationControls.forEach { body["authorization_controls[\($0)]"] = $1 }
        }
        
        if let cardholder = cardholder {
            body["cardholder"] = cardholder
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let status = status {
            body["status"] = status.rawValue
        }
        
        return apiHandler.send(method: .POST, path: StripeAPIEndpoint.issuingCards(card).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeIssuingCardList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: StripeAPIEndpoint.issuingCard.endpoint, query: queryParams, headers: headers)
    }
}
