//
//  FileLinkRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 9/14/18.
//

import NIO
import NIOHTTP1
import Foundation
import Baggage

public protocol FileLinkRoutes {
    /// Creates a new file link object.
    ///
    /// - Parameters:
    ///   - file: The ID of the file. The file’s `purpose` must be one of the following: `business_icon`, `business_logo`, `customer_signature`, `dispute_evidence`, `finance_report_run`, `pci_document`, `sigma_scheduled_query`, or `tax_document_user_upload`.
    ///   - expiresAt: A future timestamp after which the link will no longer be usable.
    ///   - metadata: Set of key-value pairs that you can attach to an object.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeFileLink`.
    func create(file: String,
                expiresAt: Date?,
                metadata: [String: String]?,
                expand: [String]?,
                context: LoggingContext) -> EventLoopFuture<StripeFileLink>
    
    /// Retrieves the file link with the given ID.
    ///
    /// - Parameters:
    ///   - link: The identifier of the file link to be retrieved.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeFileLink`.
    func retrieve(link: String, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeFileLink>
    
    /// Updates an existing file link object. Expired links can no longer be updated
    ///
    /// - Parameters:
    ///   - link: The ID of the file link.
    ///   - expiresAt: A future timestamp after which the link will no longer be usable, or `now` to expire the link immediately.
    ///   - metadata: Set of key-value pairs that you can attach to an object.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `StripeFileLink`.
    func update(link: String,
                expiresAt: Any?,
                metadata: [String: String]?,
                expand: [String]?,
                context: LoggingContext) -> EventLoopFuture<StripeFileLink>
    
    
    /// Returns a list of file links.
    ///
    /// - Parameter filter: A dictionary that contains the filters. More info [here](https://stripe.com/docs/api/curl#list_file_links).
    /// - Returns: A `StripeFileLinkList`.
    func listAll(filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeFileLinkList>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension FileLinkRoutes {
    public func create(file: String,
                       expiresAt: Date? = nil,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil,
                       context: LoggingContext) -> EventLoopFuture<StripeFileLink> {
        return create(file: file,
                      expiresAt: expiresAt,
                      metadata: metadata,
                      expand: expand,
                      context: context)
    }
    
    public func retrieve(link: String, expand: [String]? = nil, context: LoggingContext) -> EventLoopFuture<StripeFileLink> {
        return retrieve(link: link, expand: expand, context: context)
    }
    
    public func update(link: String,
                       expiresAt: Any? = nil,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil,
                       context: LoggingContext) -> EventLoopFuture<StripeFileLink> {
        return update(link: link,
                      expiresAt: expiresAt,
                      metadata: metadata,
                      expand: expand,
                      context: context)
    }
    
    public func listAll(filter: [String: Any]? = nil, context: LoggingContext) -> EventLoopFuture<StripeFileLinkList> {
        return listAll(filter: filter, context: context)
    }
}

public struct StripeFileLinkRoutes: FileLinkRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let filelinks = APIBase + APIVersion + "file_links"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(file: String,
                       expiresAt: Date?,
                       metadata: [String: String]?,
                       expand: [String]?,
                       context: LoggingContext) -> EventLoopFuture<StripeFileLink> {
        var body: [String: Any] = [:]
        if let expiresAt = expiresAt {
            body["expires_at"] = Int(expiresAt.timeIntervalSince1970)
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: filelinks, body: .string(body.queryParameters), headers: headers, context: context)
    }
    
    public func retrieve(link: String, expand: [String]?, context: LoggingContext) -> EventLoopFuture<StripeFileLink> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(filelinks)/\(link)", query: queryParams, headers: headers, context: context)
    }
    
    public func update(link: String,
                       expiresAt: Any?,
                       metadata: [String: String]?,
                       expand: [String]?,
                       context: LoggingContext) -> EventLoopFuture<StripeFileLink> {
        var body: [String: Any] = [:]
        
        if let expiresAt = expiresAt as? Date {
            body["expires_at"] = Int(expiresAt.timeIntervalSince1970)
        }
        
        if let expiresAt = expiresAt as? String {
            body["expires_at"] = expiresAt
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(filelinks)/\(link)", body: .string(body.queryParameters), headers: headers, context: context)
    }
    
    public func listAll(filter: [String: Any]?, context: LoggingContext) -> EventLoopFuture<StripeFileLinkList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: filelinks, query: queryParams, headers: headers, context: context)
    }
}
