//
//  AccountLinkRoutes.swift
//  
//
//  Created by Andrew Edwards on 11/3/19.
//

import NIO
import NIOHTTP1
import Foundation

public protocol AccountLinkRoutes {
    
    /// Creates an AccountLink object that returns a single-use Stripe URL that the user can redirect their user to in order to take them through the Connect Onboarding flow.
    /// - Parameter account: The identifier of the account to create an account link for.
    /// - Parameter failureUrl: The URL that the user will be redirected to if the account link is no longer valid.
    /// - Parameter successUrl: The URL that the user will be redirected to upon leaving or completing the linked flow successfully.
    /// - Parameter type: The type of account link the user is requesting. Possible values are `custom_account_verification` or `custom_account_update`.
    /// - Parameter collect: The information the platform wants to collect from users up-front. Possible values are `currently_due` and `eventually_due`.
    func create(account: String,
                failureUrl: String,
                successUrl: String,
                type: AccountLinkCreationType,
                collect: AccountLinkCreationCollectType?) -> EventLoopFuture<AccountLink>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

public struct StripeAccountLinkRoutes: AccountLinkRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let accountlinks = APIBase + APIVersion + "account_links"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(account: String,
                       failureUrl: String,
                       successUrl: String,
                       type: AccountLinkCreationType,
                       collect: AccountLinkCreationCollectType?) -> EventLoopFuture<AccountLink> {
        var body: [String: Any] = ["account": account,
                                   "failure_url": failureUrl,
                                   "success_url": successUrl,
                                   "type": type.rawValue]
        
        if let collect = collect {
            body["collect"] = collect.rawValue
        }
        
        return apiHandler.send(method: .POST, path: accountlinks, body: .string(body.queryParameters), headers: headers)
    }
}
