//
//  TransferRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/3/18.
//

import NIO
import NIOHTTP1
import Baggage

public protocol TransferRoutes {
    /// To send funds from your Stripe account to a connected account, you create a new transfer object. Your [Stripe balance](https://stripe.com/docs/api/transfers/create#balance) must be able to cover the transfer amount, or you’ll receive an “Insufficient Funds” error.
    ///
    /// - Parameters:
    ///   - amount: A positive integer in cents representing how much to transfer.
    ///   - currency: 3-letter ISO code for currency.
    ///   - destination: The ID of a connected Stripe account. [See the Connect documentation](https://stripe.com/docs/connect/charges-transfers) for details.
    ///   - description: An arbitrary string attached to the object. Often useful for displaying to users. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - sourceTransaction: You can use this parameter to transfer funds from a charge before they are added to your available balance. A pending balance will transfer immediately but the funds will not become available until the original charge becomes available. See the Connect documentation for details.
    ///   - sourceType: The source balance to use for this transfer. One of `bank_account` or `card`. For most users, this will default to `card`.
    ///   - transferGroup: A string that identifies this transaction as part of a group. See the Connect documentation for details.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeTransfer`.
    func create(amount: Int,
                currency: StripeCurrency,
                destination: String,
                description: String?,
                metadata: [String: String]?,
                sourceTransaction: String?,
                sourceType: StripeTransferSourceType?,
                transferGroup: String?,
                expand: [String]?,
                context: LoggingContext) -> EventLoopFuture<StripeTransfer>
    
    /// Retrieves the details of an existing transfer. Supply the unique transfer ID from either a transfer creation request or the transfer list, and Stripe will return the corresponding transfer information.
    ///
    /// - Parameter transfer: The identifier of the transfer to be retrieved.
    /// - Parameter expand: An array of properties to expand.
    /// - Returns: A `StripeTransfer`.
    func retrieve(transfer: String, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeTransfer>
    
    /// Updates the specified transfer by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    /// This request accepts only metadata as an argument.
    ///
    /// - Parameters:
    ///   - transfer: The ID of the transfer to be updated.
    ///   - description: An arbitrary string attached to the object. Often useful for displaying to users. This will be unset if you POST an empty value.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeTransfer`.
    func update(transfer: String,
                description: String?,
                metadata: [String: String]?,
                expand: [String]?,
                context: LoggingContext) -> EventLoopFuture<StripeTransfer>
    
    /// Returns a list of existing transfers sent to connected accounts. The transfers are returned in sorted order, with the most recently created transfers appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/transfers/list)
    /// - Returns: A `StripeTransferList`.
    func listAll(filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeTransferList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension TransferRoutes {
    public func create(amount: Int,
                       currency: StripeCurrency,
                       destination: String,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       sourceTransaction: String? = nil,
                       sourceType: StripeTransferSourceType? = nil,
                       transferGroup: String? = nil,
                       expand: [String]? = nil,
                       context: LoggingContext) -> EventLoopFuture<StripeTransfer> {
        return create(amount: amount,
                      currency: currency,
                      destination: destination,
                      description: description,
                      metadata: metadata,
                      sourceTransaction: sourceTransaction,
                      sourceType: sourceType,
                      transferGroup: transferGroup,
                      expand: expand)
    }
    
    public func retrieve(transfer: String, expand: [String]? = nil, context: LoggingContext) -> EventLoopFuture<StripeTransfer> {
        return retrieve(transfer: transfer, expand: expand)
    }
    
    public func update(transfer: String,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil,
                       context: LoggingContext) -> EventLoopFuture<StripeTransfer> {
        return update(transfer: transfer,
                      description: description,
                      metadata: metadata,
                      expand: expand)
    }
    
    public func listAll(filter: [String: Any]? = nil, context: LoggingContext) -> EventLoopFuture<StripeTransferList> {
        return listAll(filter: filter)
    }
}

public struct StripeTransferRoutes: TransferRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let transfers = APIBase + APIVersion + "transfers"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(amount: Int,
                       currency: StripeCurrency,
                       destination: String,
                       description: String?,
                       metadata: [String: String]?,
                       sourceTransaction: String?,
                       sourceType: StripeTransferSourceType?,
                       transferGroup: String?,
                       expand: [String]?,
                       context: LoggingContext) -> EventLoopFuture<StripeTransfer> {
        var body: [String: Any] = ["amount": amount,
                                   "currency": currency.rawValue,
                                   "destination": destination]
        
        if let description = description {
            body["description"] = description
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let sourceTransaction = sourceTransaction {
           body["source_transaction"] = sourceTransaction
        }
        
        if let sourceType = sourceType {
            body["source_type"] = sourceType
        }
        
        if let transferGroup = transferGroup {
            body["transfer_group"] = transferGroup
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: transfers, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(transfer: String, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeTransfer> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        return apiHandler.send(method: .GET, path: "\(transfers)/\(transfer)", query: queryParams, headers: headers)
    }
    
    public func update(transfer: String,
                       description: String?,
                       metadata: [String: String]?,
                       expand: [String]?,
                       context: LoggingContext) -> EventLoopFuture<StripeTransfer> {
        var body: [String: Any] = [:]
        
        if let description = description {
            body["description"] = description
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(transfers)/\(transfer)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeTransferList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return apiHandler.send(method: .GET, path: transfers, query: queryParams, headers: headers)
    }
}
