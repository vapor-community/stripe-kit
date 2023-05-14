//
//  AccountSessionRoutes.swift
//  
//
//  Created by Andrew Edwards on 5/14/23.
//

import NIO
import NIOHTTP1
import Foundation

public protocol AccountSessionRoutes: StripeAPIRoute {
    
    /// Creates a AccountSession object that includes a single-use token that the platform can use on their front-end to grant client-side API access.
    /// - Parameter account: The identifier of the account to create an Account Session for.
    /// - Returns: Returns an Account Session object if the call succeeded.
    func create(account: String) async throws -> AccountSession
}

public struct StripeAccountSessionsRoutes: AccountSessionRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let accountsessions = APIBase + APIVersion + "account_sessions"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(account: String) async throws -> AccountSession {
        try await apiHandler.send(method: .POST, path: accountsessions, body: .string(["account": account].queryParameters), headers: headers)
    }
}
