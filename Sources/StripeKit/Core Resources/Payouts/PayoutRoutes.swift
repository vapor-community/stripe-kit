//
//  PayoutRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/20/18.
//

import NIO
import NIOHTTP1

public protocol PayoutRoutes: StripeAPIRoute {
    /// To send funds to your own bank account, you create a new payout object. Your Stripe balance must be able to cover the payout amount, or you’ll receive an “Insufficient Funds” error.
    ///
    ///  If your API key is in test mode, money won’t actually be sent, though everything else will occur as if in live mode.
    ///
    ///  If you are creating a manual payout on a Stripe account that uses multiple payment source types, you’ll need to specify the source type balance that the payout should draw from. The balance object details available and pending amounts by source type.
    ///
    /// - Parameters:
    ///   - amount: A positive integer in cents representing how much to payout.
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - description: An arbitrary string attached to the object. Often useful for displaying to users. This will be unset if you POST an empty value.
    ///   - metadata: A set of key-value pairs that you can attach to a payout object. It can be useful for storing additional information about the payout in a structured format.
    ///   - statementDescriptor: A string to be displayed on the recipient’s bank or card statement. This may be at most 22 characters. Attempting to use a `statement_descriptor` longer than 22 characters will return an error. Note: Most banks will truncate this information and/or display it inconsistently. Some may not display it at all.
    ///   - destination: The ID of a bank account or a card to send the payout to. If no destination is supplied, the default external account for the specified currency will be used.
    ///   - method: The method used to send this payout, which can be `standard` or `instant`. `instant` is only supported for payouts to debit cards. (See Instant payouts for marketplaces for more information.)
    ///   - sourceType: The source balance to draw this payout from. Balances for different payment sources are kept separately. You can find the amounts with the balances API. One of `bank_account` or `card`.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns a payout object if there were no initial errors with the payout creation (invalid routing number, insufficient funds, etc). The status of the payout object will be initially marked as pending.
    func create(amount: Int,
                currency: Currency,
                description: String?,
                metadata: [String: String]?,
                statementDescriptor: String?,
                destination: String?,
                method: PayoutMethod?,
                sourceType: PayoutSourceType?,
                expand: [String]?) async throws -> Payout
    
    /// Retrieves the details of an existing payout. Supply the unique payout ID from either a payout creation request or the payout list, and Stripe will return the corresponding payout information.
    ///
    /// - Parameter payout: The identifier of the payout to be retrieved.
    /// - Parameter expand: An array of properties to expand.
    /// - Returns: Returns a payout object if a valid identifier was provided, and returns an error otherwise.
    func retrieve(payout: String, expand: [String]?) async throws -> Payout
    
    /// Updates the specified payout by setting the values of the parameters passed. Any parameters not provided will be left unchanged. This request accepts only the metadata as arguments.
    ///
    /// - Parameters:
    ///   - payout: The identifier of the payout to be updated.
    ///   - metadata: A set of key-value pairs that you can attach to a payout object. It can be useful for storing additional information about the payout in a structured format.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns the payout object if the update succeeded. This call returns an error if update parameters are invalid.
    func update(payout: String, metadata: [String: String]?, expand: [String]?) async throws -> Payout
    
    /// Returns a list of existing payouts sent to third-party bank accounts or that Stripe has sent you. The payouts are returned in sorted order, with the most recently created payouts appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More](https://stripe.com/docs/api/payouts/list)
    /// - Returns: A dictionary with a data property that contains an array of up to limit payouts, starting after payout `starting_after`. Each entry in the array is a separate payout object. If no more payouts are available, the resulting array will be empty.
    func listAll(filter: [String: Any]?) async throws -> PayoutsList
    
    /// A previously created payout can be canceled if it has not yet been paid out. Funds will be refunded to your available balance. You may not cancel automatic Stripe payouts.
    ///
    /// - Parameter payout: The identifier of the payout to be canceled.
    /// - Parameter expand: An array of properties to expand.
    /// - Returns: Returns the payout object if the cancellation succeeded. Returns an error if the payout has already been canceled or cannot be canceled.
    func cancel(payout: String, expand: [String]?) async throws -> Payout
    
    /// Reverses a payout by debiting the destination bank account. Only payouts for connected accounts to US bank accounts may be reversed at this time. If the payout is in the pending status, `/v1/payouts/:id/cancel` should be used instead.
    ///
    /// By requesting a reversal via `/v1/payouts/:id/reverse`, you confirm that the authorized signatory of the selected bank account has authorized the debit on the bank account and that no other authorization is required.
    /// - Parameters:
    ///   - payout: The identifier of the payout to be reversed.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    /// - Returns: Returns the reversing payout object if the reversal was successful. Returns an error if the payout has already been reversed or cannot be reversed.
    func reverse(payout: String, metadata: [String: String]?, expand: [String]?) async throws -> Payout
}

public struct StripePayoutRoutes: PayoutRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let payouts = APIBase + APIVersion + "payouts"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(amount: Int,
                       currency: Currency,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       statementDescriptor: String? = nil,
                       destination: String? = nil,
                       method: PayoutMethod? = nil,
                       sourceType: PayoutSourceType? = nil,
                       expand: [String]? = nil) async throws -> Payout {
        var body: [String: Any] = [:]
        
        body["amount"] = amount
        body["currency"] = currency.rawValue
        
        if let description {
            body["description"] = description
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let destination {
            body["destination"] = destination
        }
        
        if let method {
            body["method"] = method.rawValue
        }
        
        if let sourceType {
            body["source_type"] = sourceType.rawValue
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: payouts, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(payout: String, expand: [String]? = nil) async throws -> Payout {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(payouts)/\(payout)", query: queryParams, headers: headers)
    }
    
    public func update(payout: String,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil) async throws -> Payout {
        var body: [String: Any] = [:]
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(payouts)/\(payout)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> PayoutsList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: payouts, query: queryParams, headers: headers)
    }
    
    public func cancel(payout: String, expand: [String]? = nil) async throws -> Payout {
        var body: [String: Any] = [:]
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(payouts)/\(payout)/cancel", body: .string(body.queryParameters), headers: headers)
    }
    
    public func reverse(payout: String,
                        metadata: [String: String]? = nil,
                        expand: [String]? = nil) async throws -> Payout {
        var body: [String: Any] = [:]
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(payouts)/\(payout)/reverse", body: .string(body.queryParameters), headers: headers)
    }
}
