//
//  FundingInstructionsRoutes.swift
//  
//
//  Created by Andrew Edwards on 5/16/23.
//

import NIO
import NIOHTTP1
import Foundation

public protocol FundingInstructionsRoutes: StripeAPIRoute {
    /// Create or retrieve funding instructions for an Issuing balance. If funding instructions don’t yet exist for the account, we’ll create new funding instructions. If we’ve already created funding instructions for the account, the same we’ll retrieve the same funding instructions. In other words, we’ll return the same funding instructions each time.
    /// - Parameters:
    ///   - bankTransfer: Additional parameters for `bank_transfer` funding types
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - fundingType: The `funding_type` to get the instructions for.
    /// - Returns: Returns funding instructions for an Issuing balance
    func create(bankTransfer: [String: Any],
                currency: Currency,
                fundingType: FundingInstructionsFundingType) async throws -> FundingInstructions
    
    /// Retrieve all applicable funding instructions for an Issuing balance.
    /// - Parameter filter: A dictionary used for query parameters.
    /// - Returns: Returns all funding instructions for an Issuing balance
    func listAll(filter: [String: Any]?) async throws -> FundingInstructionsList
    
    /// Simulates an external bank transfer and adds funds to an Issuing balance. This method can only be called in test mode.
    /// - Parameters:
    ///   - amount: The amount to top up
    ///   - currency: The currency to top up
    /// - Returns: Returns testmode funding instructions for an Issuing balance
    func simulateTopUp(amount: Int, currency: Currency) async throws -> FundingInstructions
}

public struct StripeFundingInstructionsRoutes: FundingInstructionsRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let fundinginstructions = APIBase + APIVersion + "issuing/funding_instructions"
    private let testhelpers = APIBase + APIVersion + "test_helpers/issuing/fund_balance"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(bankTransfer: [String: Any],
                       currency: Currency,
                       fundingType: FundingInstructionsFundingType) async throws -> FundingInstructions {
        var body: [String: Any] = ["currency": currency.rawValue,
                                   "funding_type": fundingType.rawValue]
        
        bankTransfer.forEach { body["bank_transfer[\($0)]"] = $1 }
        
        return try await apiHandler.send(method: .POST, path: fundinginstructions, body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> FundingInstructionsList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: fundinginstructions, query: queryParams, headers: headers)
    }
    
    public func simulateTopUp(amount: Int, currency: Currency) async throws -> FundingInstructions {
        let body: [String: Any] = ["amount": amount,
                                   "currency": currency.rawValue]
        return try await apiHandler.send(method: .POST, path: testhelpers, body: .string(body.queryParameters), headers: headers)
    }
}
