//
//  PayoutRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/20/18.
//

import NIO
import NIOHTTP1

public protocol PayoutRoutes {
    /// To send funds to your own bank account, you create a new payout object. Your Stripe balance must be able to cover the payout amount, or you’ll receive an “Insufficient Funds” error. /n If your API key is in test mode, money won’t actually be sent, though everything else will occur as if in live mode. /n If you are creating a manual payout on a Stripe account that uses multiple payment source types, you’ll need to specify the source type balance that the payout should draw from. The balance object details available and pending amounts by source type.
    ///
    /// - Parameters:
    ///   - amount: A positive integer in cents representing how much to payout.
    ///   - currency: Three-letter ISO currency code, in lowercase. Must be a supported currency.
    ///   - description: An arbitrary string attached to the object. Often useful for displaying to users. This will be unset if you POST an empty value.
    ///   - destination: The ID of a bank account or a card to send the payout to. If no destination is supplied, the default external account for the specified currency will be used.
    ///   - metadata: A set of key-value pairs that you can attach to a payout object. It can be useful for storing additional information about the payout in a structured format.
    ///   - method: The method used to send this payout, which can be `standard` or `instant`. `instant` is only supported for payouts to debit cards. (See Instant payouts for marketplaces for more information.)
    ///   - sourceType: The source balance to draw this payout from. Balances for different payment sources are kept separately. You can find the amounts with the balances API. One of `bank_account` or `card`.
    ///   - statementDescriptor: A string to be displayed on the recipient’s bank or card statement. This may be at most 22 characters. Attempting to use a `statement_descriptor` longer than 22 characters will return an error. Note: Most banks will truncate this information and/or display it inconsistently. Some may not display it at all.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripePayout`.
    func create(amount: Int,
                currency: StripeCurrency,
                description: String?,
                destination: String?,
                metadata: [String: String]?,
                method: StripePayoutMethod?,
                sourceType: StripePayoutSourceType?,
                statementDescriptor: String?,
                expand: [String]?) -> EventLoopFuture<StripePayout>
    
    /// Retrieves the details of an existing payout. Supply the unique payout ID from either a payout creation request or the payout list, and Stripe will return the corresponding payout information.
    ///
    /// - Parameter payout: The identifier of the payout to be retrieved.
    /// - Parameter expand: An array of properties to expand.
    /// - Returns: A `StripePayout`.
    func retrieve(payout: String, expand: [String]?) -> EventLoopFuture<StripePayout>
    
    /// Updates the specified payout by setting the values of the parameters passed. Any parameters not provided will be left unchanged. This request accepts only the metadata as arguments.
    ///
    /// - Parameters:
    ///   - payout: The identifier of the payout to be updated.
    ///   - metadata: A set of key-value pairs that you can attach to a payout object. It can be useful for storing additional information about the payout in a structured format.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripePayout`.
    func update(payout: String, metadata: [String: String]?, expand: [String]?) -> EventLoopFuture<StripePayout>
    
    /// Returns a list of existing payouts sent to third-party bank accounts or that Stripe has sent you. The payouts are returned in sorted order, with the most recently created payouts appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/payouts/list)
    /// - Returns: A `StripePayoutsList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripePayoutsList>
    
    /// A previously created payout can be canceled if it has not yet been paid out. Funds will be refunded to your available balance. You may not cancel automatic Stripe payouts.
    ///
    /// - Parameter payout: The identifier of the payout to be canceled.
    /// - Parameter expand: An array of properties to expand.
    /// - Returns: A `StripePayout`.
    func cancel(payout: String, expand: [String]?) -> EventLoopFuture<StripePayout>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension PayoutRoutes {
    public func create(amount: Int,
                       currency: StripeCurrency,
                       description: String? = nil,
                       destination: String? = nil,
                       metadata: [String: String]? = nil,
                       method: StripePayoutMethod? = nil,
                       sourceType: StripePayoutSourceType? = nil,
                       statementDescriptor: String? = nil,
                       expand: [String]? = nil) -> EventLoopFuture<StripePayout> {
        return create(amount: amount,
                      currency: currency,
                      description: description,
                      destination: destination,
                      metadata: metadata,
                      method: method,
                      sourceType: sourceType,
                      statementDescriptor: statementDescriptor,
                      expand: expand)
    }
    
    public func retrieve(payout: String, expand: [String]? = nil) -> EventLoopFuture<StripePayout> {
        return retrieve(payout: payout, expand: expand)
    }
    
    public func update(payout: String, metadata: [String: String]? = nil, expand: [String]? = nil) -> EventLoopFuture<StripePayout> {
        return update(payout: payout, metadata: metadata, expand: expand)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripePayoutsList> {
        return listAll(filter: filter)
    }
    
    public func cancel(payout: String, expand: [String]? = nil) -> EventLoopFuture<StripePayout> {
        return cancel(payout: payout, expand: expand)
    }
}

public struct StripePayoutRoutes: PayoutRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let payouts = APIBase + APIVersion + "payouts"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(amount: Int,
                       currency: StripeCurrency,
                       description: String?,
                       destination: String?,
                       metadata: [String: String]?,
                       method: StripePayoutMethod?,
                       sourceType: StripePayoutSourceType?,
                       statementDescriptor: String?,
                       expand: [String]?) -> EventLoopFuture<StripePayout> {
        var body: [String: Any] = [:]
        
        body["amount"] = amount
        body["currency"] = currency.rawValue
        
        if let description = description {
            body["description"] = description
        }
        
        if let destination = destination {
            body["destination"] = destination
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let method = method {
            body["method"] = method.rawValue
        }
        
        if let sourceType = sourceType {
            body["source_type"] = sourceType.rawValue
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: payouts, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(payout: String, expand: [String]?) -> EventLoopFuture<StripePayout> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(payouts)/\(payout)", query: queryParams, headers: headers)
    }
    
    public func update(payout: String, metadata: [String: String]?, expand: [String]?) -> EventLoopFuture<StripePayout> {
        var body: [String: Any] = [:]
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(payouts)/\(payout)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripePayoutsList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: payouts, query: queryParams, headers: headers)
    }
    
    public func cancel(payout: String, expand: [String]?) -> EventLoopFuture<StripePayout> {
        var body: [String: Any] = [:]
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(payouts)/\(payout)/cancel", body: .string(body.queryParameters), headers: headers)
    }
}
