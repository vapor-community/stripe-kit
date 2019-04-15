//
//  FileLinkRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 9/14/18.
//

import NIO
import Foundation

public protocol FileLinkRoutes {
    /// Creates a new file link object.
    ///
    /// - Parameters:
    ///   - file: The ID of the file. The file’s `purpose` must be one of the following: `business_icon`, `business_logo`, `customer_signature`, `dispute_evidence`, `finance_report_run`, `pci_document`, `sigma_scheduled_query`, or `tax_document_user_upload`.
    ///   - expiresAt: A future timestamp after which the link will no longer be usable.
    ///   - metadata: Set of key-value pairs that you can attach to an object.
    /// - Returns: A `StripeFileLink`.
    /// - Throws: A `StripeError`.
    func create(file: String, expiresAt: Date?, metadata: [String: String]?) throws -> EventLoopFuture<StripeFileLink>
    
    /// Retrieves the file link with the given ID.
    ///
    /// - Parameter link: The identifier of the file link to be retrieved.
    /// - Returns: A `StripeFileLink`.
    /// - Throws: A `StripeError`.
    func retrieve(link: String) throws -> EventLoopFuture<StripeFileLink>
    
    /// Updates an existing file link object. Expired links can no longer be updated
    ///
    /// - Parameters:
    ///   - link: The ID of the file link.
    ///   - expiresAt: A future timestamp after which the link will no longer be usable, or `now` to expire the link immediately.
    ///   - metadata: Set of key-value pairs that you can attach to an object.
    /// - Returns: A `StripeFileLink`.
    /// - Throws: A `StripeError`.
    func update(link: String, expiresAt: Any?, metadata: [String: String]?) throws -> EventLoopFuture<StripeFileLink>
    
    
    /// Returns a list of file links.
    ///
    /// - Parameter filter: A dictionary that contains the filters. More info [here](https://stripe.com/docs/api/curl#list_file_links).
    /// - Returns: A `StripeFileLinkList`.
    /// - Throws: A `StripeError`.
    func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeFileLinkList>
}

extension FileLinkRoutes {
    public func create(file: String, expiresAt: Date? = nil, metadata: [String: String]? = nil) throws -> EventLoopFuture<StripeFileLink> {
        return try create(file: file, expiresAt: expiresAt, metadata: metadata)
    }
    
    public func retrieve(link: String) throws -> EventLoopFuture<StripeFileLink> {
        return try retrieve(link: link)
    }
    
    public func update(link: String, expiresAt: Any? = nil, metadata: [String: String]? = nil) throws -> EventLoopFuture<StripeFileLink> {
        return try update(link: link, expiresAt: expiresAt, metadata: metadata)
    }
    
    public func listAll(filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeFileLinkList> {
        return try listAll(filter: filter)
    }
}

public struct StripeFileLinkRoutes: FileLinkRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    public func create(file: String, expiresAt: Date?, metadata: [String: String]?) throws -> EventLoopFuture<StripeFileLink> {
        var body: [String: Any] = [:]
        if let expiresAt = expiresAt {
            body["expires_at"] = Int(expiresAt.timeIntervalSince1970)
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        return try request.send(method: .POST, path: StripeAPIEndpoint.fileLink.endpoint, body: body.queryParameters)
    }
    
    public func retrieve(link: String) throws -> EventLoopFuture<StripeFileLink> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.fileLinks(link).endpoint)
    }
    
    public func update(link: String, expiresAt: Any?, metadata: [String: String]?) throws -> EventLoopFuture<StripeFileLink> {
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
        return try request.send(method: .POST, path: StripeAPIEndpoint.fileLinks(link).endpoint, body: body.queryParameters)
    }
    
    public func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeFileLinkList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try request.send(method: .GET, path: StripeAPIEndpoint.fileLink.endpoint, query: queryParams)
    }
}
