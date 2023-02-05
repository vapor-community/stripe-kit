//
//  CardRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/3/19.
//

import NIO
import NIOHTTP1

public protocol CardRoutes {
    /// When you create a new credit card, you must specify a customer or recipient on which to create it. /n If the card’s owner has no default card, then the new card will become the default. However, if the owner already has a default, then it will not change. To change the default, you should either update the customer to have a new `default_source`, or update the recipient to have a new `default_card`.
    ///
    /// - Parameters:
    ///   - customer: The ID of the customer to attach this source to.
    ///   - source:A token, like the ones returned by Stripe.js. Stripe will automatically validate the card.
    ///   - metadata: A set of key-value pairs that you can attach to a card object. It can be useful for storing additional information about the card in a structured format.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeCard`.
    func create(customer: String, source: Any, metadata: [String: String]?, expand: [String]?) -> EventLoopFuture<StripeCard>
    
    /// You can always see the 10 most recent cards directly on a customer; this method lets you retrieve details about a specific card stored on the customer.
    ///
    /// - Parameters:
    ///   - id: ID of card to retrieve.
    ///   - customer: The ID of the customer this source belongs to.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeCard`.
    func retrieve(id: String, customer: String, expand: [String]?) -> EventLoopFuture<StripeCard>
    
    /// If you need to update only some card details, like the billing address or expiration date, you can do so without having to re-enter the full card details. Also, Stripe works directly with card networks so that your customers can continue using your service without interruption. /n When you update a card, Stripe will automatically validate the card.
    ///
    /// - Parameters:
    ///   - id: The ID of the card to be updated.
    ///   - customer: The ID of the customer this source belongs to.
    ///   - addressCity: City/District/Suburb/Town/Village. This will be unset if you POST an empty value.
    ///   - addressCountry: Billing address country, if provided when creating card. This will be unset if you POST an empty value.
    ///   - addressLine1: Address line 1 (Street address/PO Box/Company name). This will be unset if you POST an empty value.
    ///   - addressLine2: Address line 2 (Apartment/Suite/Unit/Building). This will be unset if you POST an empty value.
    ///   - addressState: State/County/Province/Region. This will be unset if you POST an empty value.
    ///   - addressZip: ZIP or postal code. This will be unset if you POST an empty value.
    ///   - expMonth: Two digit number representing the card’s expiration month.
    ///   - expYear: Four digit number representing the card’s expiration year.
    ///   - metadata: A set of key-value pairs that you can attach to a card object. It can be useful for storing additional information about the bank account in a structured format.
    ///   - name: Cardholder name. This will be unset if you POST an empty value.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeCard`.
    func update(id: String,
                customer: String,
                addressCity: String?,
                addressCountry: String?,
                addressLine1: String?,
                addressLine2: String?,
                addressState: String?,
                addressZip: String?,
                expMonth: Int?,
                expYear: Int?,
                metadata: [String: String]?,
                name: String?,
                expand: [String]?) -> EventLoopFuture<StripeCard>
    
    /// You can delete cards accounts from a Customer. /n If you delete a card that is currently the default source, then the most recently added source will become the new default. If you delete a card that is the last remaining source on the customer, then the `default_source` attribute will become null. /n For recipients: if you delete the default card, then the most recently added card will become the new default. If you delete the last remaining card on a recipient, then the `default_card` attribute will become null. /n Note that for cards belonging to customers, you might want to prevent customers on paid subscriptions from deleting all cards on file, so that there is at least one default card for the next invoice payment attempt.
    ///
    /// - Parameters:
    ///   - id: The ID of the source to be deleted.
    ///   - customer: The ID of the customer this source belongs to.
    /// - Returns: A `StripeDeletedObject`.
    func delete(id: String, customer: String) -> EventLoopFuture<DeletedObject>
    
    /// You can see a list of the cards belonging to a customer. Note that the 10 most recent sources are always available on the Customer object. If you need more than those 10, you can use this API method and the limit and starting_after parameters to page through additional cards.
    ///
    /// - Parameters:
    ///   - customer: The ID of the customer whose cards will be retrieved.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/cards/list).
    /// - Returns: A `StripeCardList`.
    func listAll(customer: String, filter: [String: Any]?) -> EventLoopFuture<StripeCardList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension CardRoutes {
    public func create(customer: String,
                       source: Any,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeCard> {
        return create(customer: customer, source: source, metadata: metadata, expand: expand)
    }
    
    public func retrieve(id: String, customer: String, expand: [String]? = nil) -> EventLoopFuture<StripeCard> {
        return retrieve(id: id, customer: customer, expand: expand)
    }
    
    public func update(id: String,
                       customer: String,
                       addressCity: String? = nil,
                       addressCountry: String? = nil,
                       addressLine1: String? = nil,
                       addressLine2: String? = nil,
                       addressState: String? = nil,
                       addressZip: String? = nil,
                       expMonth: Int? = nil,
                       expYear: Int? = nil,
                       metadata: [String: String]? = nil,
                       name: String? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripeCard> {
        return update(id: id,
                      customer: customer,
                      addressCity: addressCity,
                      addressCountry: addressCountry,
                      addressLine1: addressLine1,
                      addressLine2: addressLine2,
                      addressState: addressState,
                      addressZip: addressZip,
                      expMonth: expMonth,
                      expYear: expYear,
                      metadata: metadata,
                      name: name,
                      expand: expand)
    }
    
    public func delete(id: String, customer: String) -> EventLoopFuture<DeletedObject> {
        return delete(id: id, customer: customer)
    }
    
    public func listAll(customer: String, filter: [String: Any]? = nil) -> EventLoopFuture<StripeCardList> {
        return listAll(customer: customer, filter: filter)
    }
}

public struct StripeCardRoutes: CardRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let cards = APIBase +  APIVersion + "customers"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(customer: String, source: Any, metadata: [String: String]?, expand: [String]?) -> EventLoopFuture<StripeCard> {
        var body: [String: Any] = [:]
        
        if let source = source as? String {
            body["source"] = source
        }
        
        if let source = source as? [String: Any] {
            source.forEach { body["source[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(cards)/\(customer)/sources", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(id: String, customer: String, expand: [String]?) -> EventLoopFuture<StripeCard> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(cards)/\(customer)/sources/\(id)", query: queryParams, headers: headers)
    }
    
    public func update(id: String,
                       customer: String,
                       addressCity: String?,
                       addressCountry: String?,
                       addressLine1: String?,
                       addressLine2: String?,
                       addressState: String?,
                       addressZip: String?,
                       expMonth: Int?,
                       expYear: Int?,
                       metadata: [String: String]?,
                       name: String?,
                       expand: [String]?) -> EventLoopFuture<StripeCard> {
        var body: [String: Any] = [:]
        
        if let addressCity = addressCity {
            body["address_city"] = addressCity
        }
        
        if let addressCountry = addressCountry {
            body["address_country"] = addressCountry
        }
        
        if let addressLine1 = addressLine1 {
            body["address_line1"] = addressLine1
        }
        
        if let addressLine2 = addressLine2 {
            body["address_line2"] = addressLine2
        }
        
        if let addressState = addressState {
            body["address_state"] = addressState
        }
        
        if let addressZip = addressZip {
            body["address_zip"] = addressZip
        }
        
        if let expMonth = expMonth {
            body["exp_month"] = expMonth
        }
        
        if let expYear = expYear {
            body["exp_year"] = expYear
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let name = name {
            body["name"] = name
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(cards)/\(customer)/sources/\(id)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(id: String, customer: String) -> EventLoopFuture<DeletedObject> {
        return apiHandler.send(method: .DELETE, path: "\(cards)/\(customer)/sources/\(id)", headers: headers)
    }
    
    public func listAll(customer: String, filter: [String: Any]?) -> EventLoopFuture<StripeCardList> {
        var queryParams = "object=card"
        if let filter = filter {
            queryParams += "&" + filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(cards)/\(customer)/sources", query: queryParams, headers: headers)
    }
}
