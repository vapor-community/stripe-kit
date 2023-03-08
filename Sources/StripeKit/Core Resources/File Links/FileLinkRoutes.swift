//
//  FileLinkRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 9/14/18.
//

import NIO
import NIOHTTP1
import Foundation

public protocol FileLinkRoutes: StripeAPIRoute {
    /// Creates a new file link object.
    ///
    /// - Parameters:
    ///   - file: The ID of the file. The file’s `purpose` must be one of the following: `business_icon`, `business_logo`, `customer_signature`, `dispute_evidence`, `finance_report_run`, `identity_document_downloadable`, `pci_document`, `selfie`, `sigma_scheduled_query`,`tax_document_user_upload` or `terminal_reader_splashscreen`.
    ///   - expiresAt: A future timestamp after which the link will no longer be usable.
    ///   - metadata: Set of key-value pairs that you can attach to an object.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns the file link object if successful, and returns an error otherwise.
    func create(file: String,
                expiresAt: Date?,
                metadata: [String: String]?,
                expand: [String]?) async throws -> FileLink
    
    /// Retrieves the file link with the given ID.
    ///
    /// - Parameters:
    ///   - link: The identifier of the file link to be retrieved.
    ///   - expand: An array of properties to expand.
    /// - Returns: Returns a file link object if a valid identifier was provided, and returns an error otherwise.
    func retrieve(link: String, expand: [String]?) async throws -> FileLink
    
    /// Updates an existing file link object. Expired links can no longer be updated
    ///
    /// - Parameters:
    ///   - link: The ID of the file link.
    ///   - expiresAt: A future timestamp after which the link will no longer be usable, or `now` to expire the link immediately.
    ///   - metadata: Set of key-value pairs that you can attach to an object.
    ///   - expand: An array of properties to expand.
    /// - Returns: A `FileLink`.
    func update(link: String,
                expiresAt: Any?,
                metadata: [String: String]?,
                expand: [String]?) async throws -> FileLink
    
    
    /// Returns a list of file links.
    ///
    /// - Parameter filter: A dictionary that contains the filters. More info [here](https://stripe.com/docs/api/curl#list_file_links).
    /// - Returns: A `FileLinkList`.
    func listAll(filter: [String: Any]?) async throws -> FileLinkList
}


public struct StripeFileLinkRoutes: FileLinkRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let filelinks = APIBase + APIVersion + "file_links"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(file: String,
                       expiresAt: Date? = nil,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil) async throws -> FileLink {
        var body: [String: Any] = [:]
        if let expiresAt {
            body["expires_at"] = Int(expiresAt.timeIntervalSince1970)
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: filelinks, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(link: String, expand: [String]? = nil) async throws -> FileLink {
        var queryParams = ""
        if let expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: "\(filelinks)/\(link)", query: queryParams, headers: headers)
    }
    
    public func update(link: String,
                       expiresAt: Any? = nil,
                       metadata: [String: String]? = nil,
                       expand: [String]? = nil) async throws -> FileLink {
        var body: [String: Any] = [:]
        
        if let expiresAt = expiresAt as? Date {
            body["expires_at"] = Int(expiresAt.timeIntervalSince1970)
        }
        
        if let expiresAt = expiresAt as? String {
            body["expires_at"] = expiresAt
        }
        
        if let metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let expand {
            body["expand"] = expand
        }
        
        return try await apiHandler.send(method: .POST, path: "\(filelinks)/\(link)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> FileLinkList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: filelinks, query: queryParams, headers: headers)
    }
}
