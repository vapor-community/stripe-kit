//
//  ExternalAccountsRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/23/19.
//

import NIO
import NIOHTTP1

public protocol ExternalAccountsRoutes: StripeAPIRoute {
    /// Creates a new bank account. When you create a new bank account, you must specify a [Custom account](https://stripe.com/docs/connect/custom-accounts) to create it on.
    ///
    /// - Parameters:
    ///   - account: The connect account this bank account should be created for.
    ///   - externalAccount: Either a token, like the ones returned by [Stripe.js](https://stripe.com/docs/stripe-js/reference), or a dictionary containing a user’s bank account details
    ///   - metadata: A set of key-value pairs that you can attach to an external account object. It can be useful for storing additional information about the external account in a structured format.
    ///   - defaultForCurrency: When set to true, or if this is the first external account added in this currency, this account becomes the default external account for its currency.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns the bank account object.
    func createBankAccount(account: String,
                           externalAccount: Any,
                           metadata: [String: String]?,
                           defaultForCurrency: Bool?,
                           expand: [String]?) async throws -> BankAccount
    
    /// By default, you can see the 10 most recent external accounts stored on a Custom account directly on the object, but you can also retrieve details about a specific bank account stored on the [Custom account](https://stripe.com/docs/connect/custom-accounts).
    ///
    /// - Parameters:
    ///   - account: The connect account associated with this bank account.
    ///   - id: The ID of the bank account to retrieve.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns the bank account object.
    func retrieveBankAccount(account: String,
                             id: String,
                             expand: [String]?) async throws -> BankAccount
    
    /// Updates the metadata, account holder name, and account holder type of a bank account belonging to a [Custom account](https://stripe.com/docs/connect/custom-accounts), and optionally sets it as the default for its currency. Other bank account details are not editable by design.
    ///
    /// You can re-enable a disabled bank account by performing an update call without providing any arguments or changes.
    ///
    /// - Parameters:
    ///   - account: The connect account associated with this bank account.
    ///   - id: The ID of the bank account to update.
    ///   - defaultForCurrency: When set to true, this becomes the default external account for its currency.
    ///   - metadata: A set of key-value pairs that you can attach to an external account object. It can be useful for storing additional information about the external account in a structured format.
    ///   - accountHolderName: The name of the person or business that owns the bank account. This will be unset if you POST an empty value.
    ///   - accountHolderType: The type of entity that holds the account. This can be either `individual` or `company`. This will be unset if you POST an empty value.
    ///   - accountType: The bank account type. This can only be checking or savings in most countries. In Japan, this can only be futsu or toza.
    ///   - documents: Documents that may be submitted to satisfy various informational requests.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns the bank account object.
    func updateBankAccount(account: String,
                           id: String,
                           defaultForCurrency: Bool?,
                           metadata: [String: String]?,
                           accountHolderName: String?,
                           accountHolderType: BankAccountHolderType?,
                           accountType: String?,
                           documents: [String: Any]?,
                           expand: [String]?) async throws -> BankAccount
    
    /// Deletes a bank account. You can delete destination bank accounts from a [Custom account](https://stripe.com/docs/connect/custom-accounts) .
    ///
    /// There are restrictions for deleting a bank account with `default_for_currency` set to true. You cannot delete a bank account if any of the following apply:
    /// - The bank account's `currency` is the same as the Account[default_currency].
    /// - There is another external account (card or bank account) with the same currency as the bank account.
    ///
    /// To delete a bank account, you must first replace the default external account by setting `default_for_currency` with another external account in the same currency.
    ///
    /// - Parameters:
    ///   - account: The connect account associated with this bank account.
    ///   - id: The ID of the bank account to be deleted.
    /// - Returns: Returns the deleted bank account object.
    func deleteBankAccount(account: String, id: String) async throws -> DeletedObject
    
    /// You can see a list of the bank accounts that belong to a connected account. Note that the 10 most recent external accounts are always available by default on the corresponding Stripe object. If you need more than those 10, you can use this API method and the `limit` and `starting_after` parameters to page through additional bank accounts.
    ///
    /// - Parameters:
    ///   - account: The connect account associated with the bank account(s).
    ///   - filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/external_account_bank_accounts/list)
    /// - Returns: Returns a list of the bank accounts stored on the account.
    func listAllBankAccounts(account: String, filter: [String: Any]?) async throws -> BankAccountList
    
    /// Creates a new card. When you create a new card, you must specify a [Custom account](https://stripe.com/docs/connect/custom-accounts) to create it on. \n If the account has no default destination card, then the new card will become the default. However, if the owner already has a default then it will not change. To change the default, you should set `default_for_currency` to `true` when creating a card for a Custom account.
    ///
    /// - Parameters:
    ///   - account: The connect account this card should be created for.
    ///   - externalAccount: Either a token, like the ones returned by [Stripe.js](https://stripe.com/docs/stripe-js/reference), or a dictionary containing a user’s card details.
    ///   - metadata: A set of key-value pairs that you can attach to an external account object. It can be useful for storing additional information about the external account in a structured format.
    ///   - defaultForCurrency: When set to true, or if this is the first external account added in this currency, this account becomes the default external account for its currency.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns the card object.
    func createCard(account: String,
                    externalAccount: Any,
                    metadata: [String: String]?,
                    defaultForCurrency: Bool?,
                    expand: [String]?) async throws -> Card
    
    /// By default, you can see the 10 most recent external accounts stored on a [Custom account](https://stripe.com/docs/connect/custom-accounts) directly on the object, but you can also retrieve details about a specific card stored on the [Custom account](https://stripe.com/docs/connect/custom-accounts).
    ///
    /// - Parameters:
    ///   - account: The connect account associated with this card.
    ///   - id: The ID of the card to retrieve.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns the card object.
    func retrieveCard(account: String, id: String, expand: [String]?) async throws -> Card
    
    /// If you need to update only some card details, like the billing address or expiration date, you can do so without having to re-enter the full card details. Stripe also works directly with card networks so that your customers can [continue using your service](https://stripe.com/docs/saving-cards#automatic-card-updates) without interruption.
    /// - Parameters:
    ///   - account: The connect account associated with this card.
    ///   - id: The ID of the card to update.
    ///   - defaultForCurrency: When set to true, this becomes the default external account for its currency.
    ///   - metadata: A set of key-value pairs that you can attach to an external account object. It can be useful for storing additional information about the external account in a structured format.
    ///   - addressCity: City/District/Suburb/Town/Village. This will be unset if you POST an empty value.
    ///   - addressCountry: Billing address country, if provided when creating card. This will be unset if you POST an empty value.
    ///   - addressLine1: Address line 1 (Street address/PO Box/Company name). This will be unset if you POST an empty value.
    ///   - addressLine2: Address line 2 (Apartment/Suite/Unit/Building). This will be unset if you POST an empty value.
    ///   - addressState: State/County/Province/Region. This will be unset if you POST an empty value.
    ///   - addressZip: ZIP or postal code. This will be unset if you POST an empty value.
    ///   - expMonth: Two digit number representing the card’s expiration month.
    ///   - expYear: Four digit number representing the card’s expiration year.
    ///   - name: Cardholder name. This will be unset if you POST an empty value.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns the card object.
    func updateCard(account: String,
                    id: String,
                    defaultForCurrency: Bool?,
                    metadata: [String: String]?,
                    addressCity: String?,
                    addressCountry: String?,
                    addressLine1: String?,
                    addressLine2: String?,
                    addressState: String?,
                    addressZip: String?,
                    expMonth: Int?,
                    expYear: Int?,
                    name: String?,
                    expand: [String]?) async throws -> Card
    
    /// You can delete cards from a Custom account.
    ///
    /// There are restrictions for deleting a card with `default_for_currency` set to true. You cannot delete a card if any of the following apply:
    /// - The card's currency is the same as the Account[default_currency].
    /// - There is another external account (card or bank account) with the same currency as the card.
    ///
    /// To delete a card, you must first replace the default external account by setting `default_for_currency` with another external account in the same currency.
    ///
    /// - Parameters:
    ///   - account: The connect account associated with this card.
    ///   - id: The ID of the card to be deleted.
    /// - Returns: Returns the deleted card object.
    func deleteCard(account: String, id: String) async throws -> DeletedObject
    
    /// List all cards belonging to a connect account. You can see a list of the cards belonging to a [Custom account](https://stripe.com/docs/connect/custom-accounts). Note that the 10 most recent external accounts are always available by default on the corresponding Stripe object. If you need more than those 10, you can use this API method and the `limit` and `starting_after` parameters to page through additional bank accounts.
    ///
    /// - Parameters:
    ///   - account: The connect account associated with the card(s).
    ///   - filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/external_account_cards/list)
    /// - Returns: Returns a list of the cards stored on the account.
    func listAllCards(account: String, filter: [String: Any]?) async throws -> CardList
}

public struct StripeExternalAccountsRoutes: ExternalAccountsRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let accounts = APIBase + APIVersion + "accounts"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func createBankAccount(account: String,
                                  externalAccount: Any,
                                  metadata: [String: String]? = nil,
                                  defaultForCurrency: Bool? = nil,
                                  expand: [String]? = nil) async throws -> BankAccount {
        var body: [String: Any] = [:]
        
        if let bankToken = externalAccount as? String {
            body["external_account"] = bankToken
        } else if let bankDetails = externalAccount as? [String: Any] {
            bankDetails.forEach { body["external_account[\($0)]"] = $1 }
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let defaultForCurrency {
            body["default_for_currency"] = defaultForCurrency
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(accounts)/\(account)/external_accounts", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieveBankAccount(account: String,
                                    id: String,
                                    expand: [String]? = nil) async throws -> BankAccount {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        return try await apiHandler.send(method: .GET, path: "\(accounts)/\(account)/external_accounts/\(id)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func updateBankAccount(account: String,
                                  id: String,
                                  defaultForCurrency: Bool? = nil,
                                  metadata: [String: String]? = nil,
                                  accountHolderName: String? = nil,
                                  accountHolderType: BankAccountHolderType? = nil,
                                  accountType: String? = nil,
                                  documents: [String: Any]? = nil,
                                  expand: [String]? = nil) async throws -> BankAccount {
        var body: [String: Any] = [:]
        
        if let defaultForCurrency {
            body["default_for_currency"] = defaultForCurrency
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let accountHolderName {
            body["account_holder_name"] = accountHolderName
        }
        
        if let accountHolderType {
            body["account_holder_type"] = accountHolderType.rawValue
        }
        
        if let accountType {
            body["account_type"] = accountType
        }
        
        if let documents {
            documents.forEach { body["documents[\($0)]"] = $1 }
        }
        
        return try await apiHandler.send(method: .POST, path: "\(accounts)/\(account)/external_accounts/\(id)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func deleteBankAccount(account: String, id: String) async throws -> DeletedObject {
        try await apiHandler.send(method: .DELETE, path: "\(accounts)/\(account)/external_accounts/\(id)", headers: headers)
    }
    
    public func listAllBankAccounts(account: String, filter: [String: Any]? = nil) async throws -> BankAccountList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        return try await apiHandler.send(method: .GET, path: "\(accounts)/\(account)/external_accounts", query: queryParams, headers: headers)
    }
    
    public func createCard(account: String,
                           externalAccount: Any,
                           metadata: [String: String]? = nil,
                           defaultForCurrency: Bool? = nil,
                           expand: [String]? = nil) async throws -> Card {
        var body: [String: Any] = [:]
        
        if let cardToken = externalAccount as? String {
            body["external_account"] = cardToken
        } else if let cardDetails = externalAccount as? [String: Any] {
            cardDetails.forEach { body["external_account[\($0)]"] = $1 }
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let defaultForCurrency {
            body["default_for_currency"] = defaultForCurrency
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(accounts)/\(account)/external_accounts", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieveCard(account: String, id: String, expand: [String]? = nil) async throws -> Card {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .GET, path: "\(accounts)/\(account)/external_accounts/\(id)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func updateCard(account: String,
                           id: String,
                           defaultForCurrency: Bool? = nil,
                           metadata: [String: String]? = nil,
                           addressCity: String? = nil,
                           addressCountry: String? = nil,
                           addressLine1: String? = nil,
                           addressLine2: String? = nil,
                           addressState: String? = nil,
                           addressZip: String? = nil,
                           expMonth: Int? = nil,
                           expYear: Int? = nil,
                           name: String? = nil,
                           expand: [String]? = nil) async throws -> Card {
        var body: [String: Any] = [:]
        
        if let defaultForCurrency {
            body["default_for_currency"] = defaultForCurrency
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let addressCity {
            body["address_city"] = addressCity
        }
        
        if let addressCountry {
            body["address_country"] = addressCountry
        }
        
        if let addressLine1 {
            body["address_line1"] = addressLine1
        }
        
        if let addressLine2 {
            body["address_line2"] = addressLine2
        }
        
        if let addressState {
            body["address_state"] = addressState
        }
        
        if let addressZip {
            body["address_zip"] = addressZip
        }
        
        if let expMonth {
            body["exp_month"] = expMonth
        }
        
        if let expYear {
            body["exp_year"] = expYear
        }
        
        if let name {
            body["name"] = name
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(accounts)/\(account)/external_accounts/\(id)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func deleteCard(account: String, id: String) async throws -> DeletedObject {
        try await apiHandler.send(method: .DELETE, path: "\(accounts)/\(account)/external_accounts/\(id)", headers: headers)
    }
    
    public func listAllCards(account: String, filter: [String: Any]? = nil) async throws -> CardList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        return try await apiHandler.send(method: .GET, path: "\(accounts)/\(account)/external_accounts", query: queryParams, headers: headers)
    }
}
