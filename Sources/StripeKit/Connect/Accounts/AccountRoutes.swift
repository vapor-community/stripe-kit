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

public protocol AccountRoutes {
    /// With [Connect](https://stripe.com/docs/connect), you can create Stripe accounts for your users. To do this, you’ll first need to [register your platform](https://dashboard.stripe.com/account/applications/settings).
    /// For Standard accounts, parameters other than `country`, `email`, and `type` are used to prefill the account application that we ask the account holder to complete.
    ///
    /// - Parameters:
    ///   - type: The type of Stripe account to create. Currently must be `custom`, as only [Custom accounts](https://stripe.com/docs/connect/custom-accounts) may be created via the API.
    ///   - country: The country in which the account holder resides, or in which the business is legally established. This should be an ISO 3166-1 alpha-2 country code. For example, if you are in the United States and the business for which you’re creating an account is legally represented in Canada, you would use `CA` as the country for the account being created.
    ///   - email: The email address of the account holder. For Custom accounts, this is only to make the account easier to identify to you: Stripe will never directly email your users.
    ///   - accountToken: An [account token](https://stripe.com/docs/api#create_account_token), used to securely provide details to the account.
    ///   - businessProfile: Non-essential business information about the account
    ///   - businessType: The business type. Can be `individual` or `company`.
    ///   - company: Information about the company or business. This field is null unless `business_type` is set to `company`.
    ///   - defaultCurrency: Three-letter ISO currency code representing the default currency for the account. This must be a currency that Stripe supports in the account’s country.
    ///   - externalAccount: A card or bank account to attach to the account. You can provide either a token, like the ones returned by Stripe.js, or a dictionary, as documented in the `external_account` parameter for [bank account](https://stripe.com/docs/api#account_create_bank_account) creation. By default, providing an external account sets it as the new default external account for its currency, and deletes the old default if one exists. To add additional external accounts without replacing the existing default for the currency, use the bank account or card creation API.
    ///   - individual: Information about the person represented by the account. This field is null unless `business_type` is set to `individual`.
    ///   - metadata: A set of key-value pairs that you can attach to an `Account` object. This can be useful for storing additional information about the account in a structured format.
    ///   - requestedCapabilities: The set of capabilities you want to unlock for this account (US only). Each capability will be inactive until you have provided its specific requirements and Stripe has verified them. An account may have some of its requested capabilities be active and some be inactive. This will be unset if you POST an empty value.
    ///   - settings: Options for customizing how the account functions within Stripe.
    ///   - tosAcceptance: Details on the account’s acceptance of the [Stripe Services Agreement](https://stripe.com/docs/connect/updating-accounts#tos-acceptance).
    /// - Returns: A `StripeConnectAccount`.
    func create(type: StripeConnectAccountType,
                country: String?,
                email: String?,
                accountToken: String?,
                businessProfile: [String: Any]?,
                businessType: StripeConnectAccountBusinessType?,
                company: [String: Any]?,
                defaultCurrency: StripeCurrency?,
                externalAccount: Any?,
                individual: [String: Any]?,
                metadata: [String: String]?,
                requestedCapabilities: [String],
                settings: [String: Any]?,
                tosAcceptance: [String: Any]?) -> EventLoopFuture<StripeConnectAccount>
    
    /// Retrieves the details of an account.
    ///
    /// - Parameter account: The identifier of the account to retrieve. If none is provided, the account associated with the API key is returned.
    /// - Returns: A `StripeConnectAccount`.
    func retrieve(account: String) -> EventLoopFuture<StripeConnectAccount>
    
    /// Updates a connected [Express or Custom account](https://stripe.com/docs/connect/accounts) by setting the values of the parameters passed. Any parameters not provided are left unchanged. Most parameters can be changed only for Custom accounts. (These are marked Custom Only below.) Parameters marked Custom and Express are supported by both account types.
    /// To update your own account, use the [Dashboard](https://dashboard.stripe.com/account). Refer to our [Connect](https://stripe.com/docs/connect/updating-accounts) documentation to learn more about updating accounts.
    ///
    /// - Parameters:
    ///   - account: The identifier of the account to update.
    ///   - accountToken: An [account token](https://stripe.com/docs/api#create_account_token), used to securely provide details to the account.
    ///   - businessProfile: Non-essential business information about the account
    ///   - businessType: The business type. Can be `individual` or `company`.
    ///   - company: Information about the company or business. This field is null unless `business_type` is set to `company`.
    ///   - defaultCurrency: Three-letter ISO currency code representing the default currency for the account. This must be a currency that Stripe supports in the account’s country.
    ///   - email: Email address of the account representative. For Standard accounts, this is used to ask them to claim their Stripe account. For Custom accounts, this only makes the account easier to identify to platforms; Stripe does not email the account representative.
    ///   - externalAccount: A card or bank account to attach to the account. You can provide either a token, like the ones returned by Stripe.js, or a dictionary, as documented in the `external_account` parameter for bank account creation.
    ///   - individual: Information about the person represented by the account. This field is null unless `business_type` is set to `individual`.
    ///   - metadata: A set of key-value pairs that you can attach to an `Account` object. This can be useful for storing additional information about the account in a structured format.
    ///   - requestedCapabilities: The set of capabilities you want to unlock for this account (US only). Each capability will be inactive until you have provided its specific requirements and Stripe has verified them. An account may have some of its requested capabilities be active and some be inactive. This will be unset if you POST an empty value.
    ///   - settings: Options for customizing how the account functions within Stripe.
    ///   - tosAcceptance: Details on the account’s acceptance of the [Stripe Services Agreement](https://stripe.com/docs/connect/updating-accounts#tos-acceptance).
    /// - Returns: A `StripeConnectAccount`.
    func update(account: String,
                accountToken: String?,
                businessProfile: [String: Any]?,
                businessType: StripeConnectAccountBusinessType?,
                company: [String: Any]?,
                defaultCurrency: StripeCurrency?,
                email: String?,
                externalAccount: Any?,
                individual: [String: Any]?,
                metadata: [String: String]?,
                requestedCapabilities: [String],
                settings: [String: Any]?,
                tosAcceptance: [String: Any]?) -> EventLoopFuture<StripeConnectAccount>
    
    /// With Connect, you may delete Custom accounts you manage.
    /// Custom accounts created using test-mode keys can be deleted at any time. Custom accounts created using live-mode keys may only be deleted once all balances are zero.
    /// If you are looking to close your own account, use the [data tab in your account settings](https://dashboard.stripe.com/account/data) instead.
    ///
    /// - Parameter account: The identifier of the account to be deleted. If none is provided, will default to the account of the API key.
    /// - Returns: A `StripeDeletedObject`.
    func delete(account: String) -> EventLoopFuture<StripeDeletedObject>
    
    /// With Connect, you may flag accounts as suspicious.
    /// Test-mode Custom and Express accounts can be rejected at any time. Accounts created using live-mode keys may only be rejected once all balances are zero.
    ///
    /// - Parameters:
    ///   - account: The identifier of the account to reject
    ///   - reason: The reason for rejecting the account. Can be `fraud`, `terms_of_service`, or `other`.
    /// - Returns: A `StripeConnectAccount`.
    func reject(account: String, reason: StripeConnectAccountRejectReason) -> EventLoopFuture<StripeConnectAccount>
    
    /// Returns a list of accounts connected to your platform via Connect. If you’re not a platform, the list is empty.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/accounts/list)
    /// - Returns: A `StripeConnectAccountList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeConnectAccountList>
    
    /// Creates a single-use login link for an Express account to access their Stripe dashboard.
    /// You may only create login links for [Express accounts](https://stripe.com/docs/connect/express-accounts) connected to your platform.
    ///
    /// - Parameters:
    /// - account: The identifier of the account to create a login link for.
    /// - redirectUrl: Where to redirect the user after they log out of their dashboard.
    /// - Returns: A `StripeConnectAccountLoginLink`.
    func createLoginLink(account: String, redirectUrl: String?) -> EventLoopFuture<StripeConnectAccountLoginLink>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension AccountRoutes {
    public func create(type: StripeConnectAccountType,
                       country: String? = nil,
                       email: String? = nil,
                       accountToken: String? = nil,
                       businessProfile: [String: Any]? = nil,
                       businessType: StripeConnectAccountBusinessType? = nil,
                       company: [String: Any]? = nil,
                       defaultCurrency: StripeCurrency? = nil,
                       externalAccount: Any? = nil,
                       individual: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       requestedCapabilities: [String],
                       settings: [String: Any]? = nil,
                       tosAcceptance: [String: Any]? = nil) -> EventLoopFuture<StripeConnectAccount> {
        return create(type: type,
                      country: country,
                      email: email,
                      accountToken: accountToken,
                      businessProfile: businessProfile,
                      businessType: businessType,
                      company: company,
                      defaultCurrency: defaultCurrency,
                      externalAccount: externalAccount,
                      individual: individual,
                      metadata: metadata,
                      requestedCapabilities: requestedCapabilities,
                      settings: settings,
                      tosAcceptance: tosAcceptance)
    }
    
    public func retrieve(account: String) -> EventLoopFuture<StripeConnectAccount> {
        return retrieve(account: account)
    }
    
    public func update(account: String,
                       accountToken: String? = nil,
                       businessProfile: [String: Any]? = nil,
                       businessType: StripeConnectAccountBusinessType? = nil,
                       company: [String: Any]? = nil,
                       defaultCurrency: StripeCurrency? = nil,
                       email: String? = nil,
                       externalAccount: Any? = nil,
                       individual: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       requestedCapabilities: [String],
                       settings: [String: Any]? = nil,
                       tosAcceptance: [String: Any]? = nil) -> EventLoopFuture<StripeConnectAccount> {
        return update(account: account,
                      accountToken: accountToken,
                      businessProfile: businessProfile,
                      businessType: businessType,
                      company: company,
                      defaultCurrency: defaultCurrency,
                      email: email,
                      externalAccount: externalAccount,
                      individual: individual,
                      metadata: metadata,
                      requestedCapabilities: requestedCapabilities,
                      settings: settings,
                      tosAcceptance: tosAcceptance)
    }
    
    public func delete(account: String) -> EventLoopFuture<StripeDeletedObject> {
        return delete(account: account)
    }
    
    public func reject(account: String, reason: StripeConnectAccountRejectReason) -> EventLoopFuture<StripeConnectAccount> {
        return reject(account: account, reason: reason)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeConnectAccountList> {
        return listAll(filter: filter)
    }
    
    public func createLoginLink(account: String, redirectUrl: String?) -> EventLoopFuture<StripeConnectAccountLoginLink> {
        return createLoginLink(account: account, redirectUrl: redirectUrl)
    }
}

public struct StripeConnectAccountRoutes: AccountRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let accounts = APIBase + APIVersion + "accounts"
    
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(type: StripeConnectAccountType,
                       country: String?,
                       email: String?,
                       accountToken: String?,
                       businessProfile: [String: Any]?,
                       businessType: StripeConnectAccountBusinessType?,
                       company: [String: Any]?,
                       defaultCurrency: StripeCurrency?,
                       externalAccount: Any?,
                       individual: [String: Any]?,
                       metadata: [String: String]?,
                       requestedCapabilities: [String],
                       settings: [String: Any]?,
                       tosAcceptance: [String: Any]?) -> EventLoopFuture<StripeConnectAccount> {
        var body: [String: Any] = ["type": type.rawValue,
                                   "requested_capabilities": requestedCapabilities]
        
        if let country = country {
            body["country"] = country
        }
        
        if let email = email {
            body["email"] = email
        }
        
        if let accountToken = accountToken {
            body["account_token"] = accountToken
        }
        
        if let businessProfile = businessProfile {
            businessProfile.forEach { body["business_profile[\($0)]"] = $1 }
        }
        
        if let businessType = businessType {
            body["business_type"] = businessType.rawValue
        }
        
        if let company = company {
            company.forEach { body["company[\($0)]"] = $1 }
        }
        
        if let currency = defaultCurrency {
            body["default_currency"] = currency.rawValue
        }
        
        if let externalAccountToken = externalAccount as? String {
            body["external_account"] = externalAccountToken
        } else if let externalHashAccount = externalAccount as? [String: Any] {
            externalHashAccount.forEach { body["external_account[\($0)]"] = $1 }
        }
        
        if let individual = individual {
            individual.forEach { body["individual[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let settings = settings {
            settings.forEach { body["settings[\($0)]"] = $1 }
        }
        
        if let tos = tosAcceptance {
            tos.forEach { body["tos_acceptance[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: accounts, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(account: String) -> EventLoopFuture<StripeConnectAccount> {
        return apiHandler.send(method: .GET, path: "\(accounts)/\(account)", headers: headers)
    }
    
    public func update(account: String,
                       accountToken: String?,
                       businessProfile: [String: Any]?,
                       businessType: StripeConnectAccountBusinessType?,
                       company: [String: Any]?,
                       defaultCurrency: StripeCurrency?,
                       email: String?,
                       externalAccount: Any?,
                       individual: [String: Any]?,
                       metadata: [String: String]?,
                       requestedCapabilities: [String],
                       settings: [String: Any]?,
                       tosAcceptance: [String: Any]?) -> EventLoopFuture<StripeConnectAccount> {
        var body: [String: Any] = ["requested_capabilities": requestedCapabilities]
        
        if let accountToken = accountToken {
            body["account_token"] = accountToken
        }
        
        if let businessProfile = businessProfile {
            businessProfile.forEach { body["business_profile[\($0)]"] = $1 }
        }
        
        if let businessType = businessType {
            body["business_type"] = businessType.rawValue
        }
        
        if let company = company {
            company.forEach { body["company[\($0)]"] = $1 }
        }
        
        if let currency = defaultCurrency {
            body["default_currency"] = currency.rawValue
        }
        
        if let email = email {
            body["email"] = email
        }
        
        if let externalAccountToken = externalAccount as? String {
            body["external_account"] = externalAccountToken
        } else if let externalHashAccount = externalAccount as? [String: Any] {
            externalHashAccount.forEach { body["external_account[\($0)]"] = $1 }
        }
        
        if let individual = individual {
            individual.forEach { body["individual[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
                
        if let settings = settings {
            settings.forEach { body["settings[\($0)]"] = $1 }
        }
        
        if let tos = tosAcceptance {
            tos.forEach { body["tos_acceptance[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: "\(accounts)/\(account)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(account: String) -> EventLoopFuture<StripeDeletedObject> {
        return apiHandler.send(method: .DELETE, path: "\(accounts)/\(account)", headers: headers)
    }
    
    public func reject(account: String, reason: StripeConnectAccountRejectReason) -> EventLoopFuture<StripeConnectAccount> {
        let body = ["reason": reason.rawValue]
        return apiHandler.send(method: .POST, path: "\(accounts)/\(account)/reject", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeConnectAccountList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return apiHandler.send(method: .GET, path: accounts, query: queryParams, headers: headers)
    }
    
    public func createLoginLink(account: String, redirectUrl: String?) -> EventLoopFuture<StripeConnectAccountLoginLink> {
        var body: [String: Any] = [:]
        
        if let redirectUrl = redirectUrl {
            body["redirect_url"] = redirectUrl
        }
        
        return apiHandler.send(method: .POST, path: "\(accounts)/\(account)/login_links")
    }
}
