//
//  TokenRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 5/12/17.
//
//

import NIO
import NIOHTTP1

public protocol TokenRoutes: StripeAPIRoute {
    /// Creates a single-use token that represents a credit card’s details. This token can be used in place of a credit card dictionary with any API method. These tokens can be used only once: by creating a new Charge object, or by attaching them to a Customer object.
    ///
    /// In most cases, you should use our recommended payments integrations instead of using the API.
    ///
    /// - Parameters:
    ///   - card: The card this token will represent. If you also pass in a customer, the card must be the ID of a card belonging to the customer. Otherwise, if you do not pass in a customer, this is a dictionary containing a user's credit card details, with the options described below.
    ///   - customer: The customer (owned by the application's account) for which to create a token. For use only with Stripe Connect. Also, this can be used only with an OAuth access token or Stripe-Account header. For more details, see Shared Customers.
    /// - Returns: Returns the created card token if successful. Otherwise, this call raises an error.
    func create(card: Any?, customer: String?) async throws -> Token
    
    /// Creates a single-use token that represents a bank account’s details. This token can be used with any API method in place of a bank account dictionary. This token can be used only once, by attaching it to a Custom account.
    ///
    /// - Parameters:
    ///   - bankAcocunt: The bank account this token will represent.
    ///   - customer: The customer (owned by the application’s account) for which to create a token. This can be used only with an OAuth access token or Stripe-Account header. For more details, see Cloning Saved Payment Methods.
    /// - Returns: Returns the created bank account token if successful. Otherwise, this call returns an error.
    func create(bankAcocunt: [String: Any]?, customer: String?) async throws -> Token
    
    /// Creates a single-use token that represents the details of personally identifiable information (PII). This token can be used in place of an id_number in Account or Person Update API methods. A PII token can be used only once.
    ///
    /// - Parameter pii: The PII this token will represent.
    /// - Returns: Returns the created PII token if successful. Otherwise, this call returns an error.
    func create(pii: String) async throws -> Token
    
    /// Creates a single-use token that wraps a user’s legal entity information. Use this when creating or updating a Connect account. See the account tokens documentation to learn more. /n Account tokens may be created only in live mode, with your application’s publishable key. Your application’s secret key may be used to create account tokens only in test mode.
    ///
    /// - Parameter account: Information for the account this token will represent.
    /// - Returns: Returns the created account token if successful. Otherwise, this call returns an error.
    func create(account: [String: Any]) async throws -> Token
    
    /// Creates a single-use token that represents the details for a person. Use this when creating or updating persons associated with a Connect account. See the documentation to learn more.
    ///
    /// Person tokens may be created only in live mode, with your application’s publishable key. Your application’s secret key may be used to create person tokens only in test mode.
    /// - Parameter person: Information for the person this token will represent.
    /// - Returns: Returns the created person token if successful. Otherwise, this call returns an error.
    func create(person: [String: Any]) async throws -> Token
    
    /// Creates a single-use token that represents an updated CVC value to be used for CVC re-collection. This token can be used when confirming a card payment using a saved card on a PaymentIntent with `confirmation_method`: manual.
    ///
    /// For most cases, use our JavaScript library instead of using the API. For a `PaymentIntent` with `confirmation_method: automatic`, use our recommended payments integration without tokenizing the CVC value.
    /// - Parameter cvcUpdate: The CVC value, in string form.
    /// - Returns: Returns the created CVC update token if successful. Otherwise, this call raises an error.
    func create(cvcUpdate: String) async throws -> Token
    
    /// Retrieves the token with the given ID.
    ///
    /// - Parameter token: The ID of the desired token.
    /// - Returns: Returns a token if a valid ID was provided. Returns an error otherwise.
    func retrieve(token: String) async throws -> Token
}

public struct StripeTokenRoutes: TokenRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let tokens = APIBase + APIVersion + "tokens"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func create(card: Any? = nil,
                       customer: String? = nil) async throws -> Token {
        var body: [String: Any] = [:]
        
        if let card = card as? [String: Any] {
            card.forEach { body["card[\($0)]"] = $1 }
        } else if let card = card as? String {
            body["card"] = card
        }
        
        if let customer {
            body["customer"] = customer
        }
        
        return try await apiHandler.send(method: .POST, path: tokens, body: .string(body.queryParameters), headers: headers)
    }
    
    public func create(bankAcocunt: [String: Any]? = nil, customer: String? = nil) async throws -> Token {
        var body: [String: Any] = [:]
        
        if let bankAcocunt {
            bankAcocunt.forEach { body["bank_account[\($0)]"] = $1 }
        }
        
        if let customer {
            body["customer"] = customer
        }
        
        return try await apiHandler.send(method: .POST, path: tokens, body: .string(body.queryParameters), headers: headers)
    }
    
    public func create(pii: String) async throws -> Token {
        let body: [String: Any] = ["id_number": pii]
        
        return try await apiHandler.send(method: .POST, path: tokens, body: .string(body.queryParameters), headers: headers)
    }
    
    public func create(account: [String: Any]) async throws -> Token {
        var body: [String: Any] = [:]
        
        account.forEach { body["account[\($0)]"] = $1 }
        
        return try await apiHandler.send(method: .POST, path: tokens, body: .string(body.queryParameters), headers: headers)
    }
    
    public func create(person: [String: Any]) async throws -> Token {
        var body: [String: Any] = [:]
        
        person.forEach { body["person[\($0)]"] = $1 }
        
        return try await apiHandler.send(method: .POST, path: tokens, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(token: String) async throws -> Token {
        try await apiHandler.send(method: .GET, path: "\(tokens)/\(token)", headers: headers)
    }
    
    public func create(cvcUpdate: String) async throws -> Token {
        let body: [String: Any] = ["cvc_update": ["cvc": cvcUpdate]]
        
        return try await apiHandler.send(method: .POST, path: tokens, body: .string(body.queryParameters), headers: headers)
    }
}
