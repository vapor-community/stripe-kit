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
    /// - Returns: A `StripeCard`.
    /// - Throws: A `StripeError`.
    func create(customer: String, source: Any, metadata: [String: String]?) throws -> EventLoopFuture<StripeCard>
    
    /// You can always see the 10 most recent cards directly on a customer; this method lets you retrieve details about a specific card stored on the customer.
    ///
    /// - Parameters:
    ///   - id: ID of card to retrieve.
    ///   - customer: The ID of the customer this source belongs to.
    /// - Returns: A `StripeCard`.
    /// - Throws: A `StripeError`.
    func retrieve(id: String, customer: String) throws -> EventLoopFuture<StripeCard>
    
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
    /// - Returns: A `StripeCard`.
    /// - Throws: A `StripeError`.
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
                name: String?) throws -> EventLoopFuture<StripeCard>
    
    /// You can delete cards accounts from a Customer. /n If you delete a card that is currently the default source, then the most recently added source will become the new default. If you delete a card that is the last remaining source on the customer, then the `default_source` attribute will become null. /n For recipients: if you delete the default card, then the most recently added card will become the new default. If you delete the last remaining card on a recipient, then the `default_card` attribute will become null. /n Note that for cards belonging to customers, you might want to prevent customers on paid subscriptions from deleting all cards on file, so that there is at least one default card for the next invoice payment attempt.
    ///
    /// - Parameters:
    ///   - id: The ID of the source to be deleted.
    ///   - customer: The ID of the customer this source belongs to.
    /// - Returns: A `StripeDeletedObject`.
    /// - Throws: A `StripeError`.
    func delete(id: String, customer: String) throws -> EventLoopFuture<StripeDeletedObject>
    
    /// You can see a list of the cards belonging to a customer. Note that the 10 most recent sources are always available on the Customer object. If you need more than those 10, you can use this API method and the limit and starting_after parameters to page through additional cards.
    ///
    /// - Parameters:
    ///   - customer: The ID of the customer whose cards will be retrieved.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/cards/list?lang=curl).
    /// - Returns: A `StripeCardList`.
    /// - Throws: A `StripeError`.
    func listAll(customer: String, filter: [String: Any]?) throws -> EventLoopFuture<StripeCardList>
}

extension CardRoutes {
    public func create(customer: String, source: Any, metadata: [String: String]? = nil) throws -> EventLoopFuture<StripeCard> {
        return try create(customer: customer, source: source, metadata: metadata)
    }
    
    public func retrieve(id: String, customer: String) throws -> EventLoopFuture<StripeCard> {
        return try retrieve(id: id, customer: customer)
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
                       name: String?) throws -> EventLoopFuture<StripeCard> {
        return try update(id: id,
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
                          name: name)
    }
    
    public func delete(id: String, customer: String) throws -> EventLoopFuture<StripeDeletedObject> {
        return try delete(id: id, customer: customer)
    }
    
    public func listAll(customer: String, filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeCardList> {
        return try listAll(customer: customer, filter: filter)
    }
}


