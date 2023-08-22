//
//  AccountRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import NIO
import NIOHTTP1
import Foundation

public protocol AccountRoutes: StripeAPIRoute {
    /// With [Connect](https://stripe.com/docs/connect), you can create Stripe accounts for your users. To do this, you’ll first need to [register your platform](https://dashboard.stripe.com/account/applications/settings).
    ///
    /// If you’ve already collected information for your connected accounts, you can pre-fill that information when creating the account. Connect Onboarding won’t ask for the pre-filled information during account onboarding. You can pre-fill any information on the account.
    ///
    /// - Parameters:
    ///   - type: The type of Stripe account to create. May be one of `custom`, `express` or `standard`.
    ///   - country: The country in which the account holder resides, or in which the business is legally established. This should be an ISO 3166-1 alpha-2 country code. For example, if you are in the United States and the business for which you’re creating an account is legally represented in Canada, you would use `CA` as the country for the account being created.
    ///   - email: The email address of the account holder. For Custom accounts, this is only to make the account easier to identify to you: Stripe will never directly email your users.
    ///   - capabilities: Each key of the dictionary represents a capability, and each capability maps to its settings (e.g. whether it has been requested or not). Each capability will be inactive until you have provided its specific requirements and Stripe has verified them. An account may have some of its requested capabilities be active and some be inactive.
    ///   - businessType: The business type.
    ///   - company: Information about the company or business. This field is available for any `business_type`.
    ///   - individual: Information about the person represented by the account. This field is null unless `business_type` is set to `individual`.
    ///   - metadata: A set of key-value pairs that you can attach to an `Account` object. This can be useful for storing additional information about the account in a structured format.
    ///   - tosAcceptance: Details on the account’s acceptance of the [Stripe Services Agreement](https://stripe.com/docs/connect/updating-accounts#tos-acceptance).
    ///   - accountToken: An [account token](https://stripe.com/docs/api#create_account_token), used to securely provide details to the account.
    ///   - businessProfile: Non-essential business information about the account
    ///   - defaultCurrency: Three-letter ISO currency code representing the default currency for the account. This must be a currency that Stripe supports in the account’s country.
    ///   - documents: Documents that may be submitted to satisfy various informational requests.
    ///   - externalAccount: A card or bank account to attach to the account. You can provide either a token, like the ones returned by Stripe.js, or a dictionary, as documented in the `external_account` parameter for [bank account](https://stripe.com/docs/api#account_create_bank_account) creation. By default, providing an external account sets it as the new default external account for its currency, and deletes the old default if one exists. To add additional external accounts without replacing the existing default for the currency, use the bank account or card creation API.
    ///   - settings: Options for customizing how the account functions within Stripe.
    /// - Returns: Returns an Account object if the call succeeds.
    func create(type: ConnectAccountType,
                country: String?,
                email: String?,
                capabilities: [String: Any]?,
                businessType: ConnectAccountBusinessType?,
                company: [String: Any]?,
                individual: [String: Any]?,
                metadata: [String: String]?,
                tosAcceptance: [String: Any]?,
                accountToken: String?,
                businessProfile: [String: Any]?,
                defaultCurrency: Currency?,
                documents: [String: Any]?,
                externalAccount: Any?,
                settings: [String: Any]?) async throws -> ConnectAccount
    
    /// Retrieves the details of an account.
    ///
    /// - Parameter account: The identifier of the account to retrieve. If none is provided, the account associated with the API key is returned.
    /// - Returns: Returns an Account object if the call succeeds. If the account ID does not exist, this call returns an error.
    func retrieve(account: String) async throws -> ConnectAccount
    
    /// Updates a connected [Express or Custom account](https://stripe.com/docs/connect/accounts) by setting the values of the parameters passed. Any parameters not provided are left unchanged.
    ///
    /// For Custom accounts, you can update any information on the account. For other accounts, you can update all information until that account has started to go through Connect Onboarding. Once you create an [Account Link](https://stripe.com/docs/api/account_links) for a Standard or Express account, some parameters can no longer be changed. These are marked as **Custom Only** or **Custom and Express** below.
    ///
    /// To update your own account, use the [Dashboard](https://dashboard.stripe.com/account). Refer to our [Connect](https://stripe.com/docs/connect/updating-accounts) documentation to learn more about updating accounts.
    ///
    /// - Parameters:
    ///   - account: The identifier of the account to update.
    ///   - businessType: The business type. Can be `individual` or `company`.
    ///   - capabilities: The set of capabilities you want to unlock for this account (US only). Each capability will be inactive until you have provided its specific requirements and Stripe has verified them. An account may have some of its requested capabilities be active and some be inactive. This will be unset if you POST an empty value.
    ///   - company: Information about the company or business. This field is available for any `business_type`.
    ///   - email: The email address of the account holder. This is only to make the account easier to identify to you. Stripe only emails Custom accounts with your consent.
    ///   - individual: Information about the person represented by the account. This field is null unless `business_type` is set to `individual`.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - tosAcceptance: Details on the account’s acceptance of the [Stripe Services Agreement](https://stripe.com/docs/connect/updating-accounts#tos-acceptance) .
    ///   - accountToken: An [account token](https://stripe.com/docs/api#create_account_token), used to securely provide details to the account.
    ///   - businessProfile: Non-essential business information about the account
    ///   - defaultCurrency: Three-letter ISO currency code representing the default currency for the account. This must be a currency that Stripe supports in the account’s country.
    ///   - documents: Documents that may be submitted to satisfy various informational requests.
    ///   - externalAccount: A card or bank account to attach to the account for receiving payouts (you won’t be able to use it for top-ups). You can provide either a token, like the ones returned by Stripe.js, or a dictionary, as documented in the `external_account` parameter for bank account creation. By default, providing an external account sets it as the new default external account for its currency, and deletes the old default if one exists. To add additional external accounts without replacing the existing default for the currency, use the bank account or card creation APIs.
    ///   - settings: Options for customizing how the account functions within Stripe.
    /// - Returns: Returns an Account object if the call succeeds. If the account ID does not exist or another issue occurs, this call returns an error.
    func update(account: String,
                businessType: ConnectAccountBusinessType?,
                capabilities: [String: Any]?,
                company: [String: Any]?,
                email: String?,
                individual: [String: Any]?,
                metadata: [String: String]?,
                tosAcceptance: [String: Any]?,
                accountToken: String?,
                businessProfile: [String: Any]?,
                defaultCurrency: Currency?,
                documents: [String: Any]?,
                externalAccount: Any?,
                settings: [String: Any]?) async throws -> ConnectAccount
    
    /// With Connect, you may delete Custom accounts you manage.
    ///
    /// Accounts created using test-mode keys can be deleted at any time. Standard accounts created using live-mode keys cannot be deleted. Custom or Express accounts created using live-mode keys can only be deleted once all balances are zero.
    ///
    /// If you want to delete your own account, use the [account information tab in your account settings](https://dashboard.stripe.com/account) instead.
    /// - Parameter account: The identifier of the account to be deleted. If none is provided, will default to the account of the API key.
    /// - Returns: Returns an object with a deleted parameter if the call succeeds. If the account ID does not exist, this call returns an error.
    func delete(account: String) async throws -> DeletedObject
    
    /// With Connect, you may flag accounts as suspicious.
    ///
    /// Test-mode Custom and Express accounts can be rejected at any time. Accounts created using live-mode keys may only be rejected once all balances are zero.
    ///
    /// - Parameters:
    ///   - account: The identifier of the account to reject
    ///   - reason: The reason for rejecting the account. Can be `fraud`, `terms_of_service`, or `other`.
    /// - Returns: Returns an account with`payouts_enabled` and `charges_enabled` set to false on success. If the account ID does not exist, this call returns an error.
    func reject(account: String, reason: ConnectAccountRejectReason) async throws -> ConnectAccount
    
    /// Returns a list of accounts connected to your platform via Connect. If you’re not a platform, the list is empty.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/accounts/list)
    /// - Returns: A dictionary with a `data` property that contains an array of up to `limit` accounts, starting after account `starting_after`. Each entry in the array is a separate `Account` object. If no more accounts are available, the resulting array is empty.
    func listAll(filter: [String: Any]?) async throws -> ConnectAccountList
    
    /// Creates a single-use login link for an Express account to access their Stripe dashboard.
    /// You may only create login links for [Express accounts](https://stripe.com/docs/connect/express-accounts) connected to your platform.
    ///
    /// - Parameters:
    ///   - account: The identifier of the account to create a login link for.
    /// - Returns: Returns a login link object if the call succeeded.
    func createLoginLink(account: String) async throws -> ConnectAccountLoginLink
}

public struct StripeConnectAccountRoutes: AccountRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let accounts = APIBase + APIVersion + "accounts"
    
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(type: ConnectAccountType,
                       country: String? = nil,
                       email: String? = nil,
                       capabilities: [String: Any]? = nil,
                       businessType: ConnectAccountBusinessType? = nil,
                       company: [String: Any]? = nil,
                       individual: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       tosAcceptance: [String: Any]? = nil,
                       accountToken: String? = nil,
                       businessProfile: [String: Any]? = nil,
                       defaultCurrency: Currency? = nil,
                       documents: [String: Any]? = nil,
                       externalAccount: Any? = nil,
                       settings: [String: Any]? = nil) async throws -> ConnectAccount {
        var body: [String: Any] = ["type": type.rawValue]
        
        if let country {
            body["country"] = country
        }
        
        if let email {
            body["email"] = email
        }
        
        if let capabilities {
            capabilities.forEach { body["capabilities[\($0)]"] = $1 }
        }
        
        if let businessType {
            body["business_type"] = businessType.rawValue
        }
        
        if let company {
            company.forEach { body["company[\($0)]"] = $1 }
        }
        
        if let individual {
            individual.forEach { body["individual[\($0)]"] = $1 }
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let tosAcceptance {
            tosAcceptance.forEach { body["tos_acceptance[\($0)]"] = $1 }
        }
        
        if let accountToken {
            body["account_token"] = accountToken
        }
        
        if let businessProfile {
            businessProfile.forEach { body["business_profile[\($0)]"] = $1 }
        }

        if let defaultCurrency {
            body["default_currency"] = defaultCurrency.rawValue
        }
        
        if let documents {
            documents.forEach { body["documents[\($0)]"] = $1 }
        }
        
        if let externalAccountToken = externalAccount as? String {
            body["external_account"] = externalAccountToken
        } else if let externalHashAccount = externalAccount as? [String: Any] {
            externalHashAccount.forEach { body["external_account[\($0)]"] = $1 }
        }
        
        if let settings {
            settings.forEach { body["settings[\($0)]"] = $1 }
        }
        
        return try await apiHandler.send(method: .POST, path: accounts, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(account: String) async throws -> ConnectAccount {
        try await apiHandler.send(method: .GET, path: "\(accounts)/\(account)", headers: headers)
    }
    
    public func update(account: String,
                       businessType: ConnectAccountBusinessType? = nil,
                       capabilities: [String: Any]? = nil,
                       company: [String: Any]? = nil,
                       email: String? = nil,
                       individual: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       tosAcceptance: [String: Any]? = nil,
                       accountToken: String? = nil,
                       businessProfile: [String: Any]? = nil,
                       defaultCurrency: Currency? = nil,
                       documents: [String: Any]? = nil,
                       externalAccount: Any? = nil,
                       settings: [String: Any]? = nil) async throws -> ConnectAccount {
		var body: [String: Any] = [:]
			
        if let businessType {
            body["business_type"] = businessType.rawValue
        }
        
		if let capabilities {
            capabilities.forEach { body["capabilities[\($0)]"] = $1}
		}
        
        if let company {
            company.forEach { body["company[\($0)]"] = $1 }
        }
        
        if let email {
            body["email"] = email
        }
        
        if let individual {
            individual.forEach { body["individual[\($0)]"] = $1 }
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let tosAcceptance {
            tosAcceptance.forEach { body["tos_acceptance[\($0)]"] = $1 }
        }
        
        if let accountToken {
            body["account_token"] = accountToken
        }
        
        if let businessProfile {
            businessProfile.forEach { body["business_profile[\($0)]"] = $1 }
        }
        
        if let defaultCurrency {
            body["default_currency"] = defaultCurrency.rawValue
        }
        
        if let documents {
            documents.forEach { body["documents[\($0)]"] = $1 }
        }
        
        if let externalAccountToken = externalAccount as? String {
            body["external_account"] = externalAccountToken
        } else if let externalHashAccount = externalAccount as? [String: Any] {
            externalHashAccount.forEach { body["external_account[\($0)]"] = $1 }
        }
                
        if let settings {
            settings.forEach { body["settings[\($0)]"] = $1 }
        }
        
        return try await apiHandler.send(method: .POST, path: "\(accounts)/\(account)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(account: String) async throws -> DeletedObject {
        try await apiHandler.send(method: .DELETE, path: "\(accounts)/\(account)", headers: headers)
    }
    
    public func reject(account: String, reason: ConnectAccountRejectReason) async throws -> ConnectAccount {
        try await apiHandler.send(method: .POST, path: "\(accounts)/\(account)/reject", body: .string(["reason": reason.rawValue].queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> ConnectAccountList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        return try await apiHandler.send(method: .GET, path: accounts, query: queryParams, headers: headers)
    }
    
    public func createLoginLink(account: String) async throws -> ConnectAccountLoginLink {
        try await apiHandler.send(method: .POST, path: "\(accounts)/\(account)/login_links", headers: headers)
    }
}
