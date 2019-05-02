//
//  FileRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 9/15/18.
//

import NIO
import NIOHTTP1
import Foundation

public protocol FileRoutes {
    /// To upload a file to Stripe, you’ll need to send a request of type `multipart/form-data`. The request should contain the file you would like to upload, as well as the parameters for creating a file. \n All of Stripe’s officially supported API libraries should have support for sending `multipart/form-data`.
    ///
    /// - Parameters:
    ///   - file: A file to upload. The file should follow the specifications of RFC 2388 (which defines file transfers for the `multipart/form-data` protocol).
    ///   - purpose: The purpose of the uploaded file. Possible values are `business_icon`, `business_logo`, `customer_signature`, `dispute_evidence`, `identity_document`, `pci_document`, or `tax_document_user_upload`.
    ///   - fileLinkData: Optional parameters to automatically create a file link for the newly created file.
    /// - Returns: A `StripeFile`.
    /// - Throws: A `StripeError`.
    func create(file: Data, purpose: StripeFilePurpose, fileLinkData: [String: Any]?) throws -> EventLoopFuture<StripeFile>
    
    /// Retrieves the details of an existing file object. Supply the unique file upload ID from a file creation request, and Stripe will return the corresponding transfer information.
    ///
    /// - Parameter id: The identifier of the file upload to be retrieved.
    /// - Returns: A `StripeFile`.
    /// - Throws: A `StripeError`.
    func retrieve(file: String) throws -> EventLoopFuture<StripeFile>
    
    /// Returns a list of the files that you have uploaded to Stripe. The file uploads are returned sorted by creation date, with the most recently created file uploads appearing first.
    ///
    /// - Parameter filter: A dictionary that contains the filters. More info [here](https://stripe.com/docs/api/curl#list_file_uploads).
    /// - Returns: A `FileUploadList`
    /// - Throws: A `StripeError`.
    func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeFileUploadList>
    
    mutating func addHeaders(_ : HTTPHeaders)
}

extension FileRoutes {
    public func create(file: Data, purpose: StripeFilePurpose, fileLinkData: [String: Any]? = nil) throws -> EventLoopFuture<StripeFile> {
        return try create(file: file, purpose: purpose, fileLinkData: fileLinkData)
    }
    
    public func retrieve(file: String) throws -> EventLoopFuture<StripeFile> {
        return try retrieve(file: file)
    }
    
    public func listAll(filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeFileUploadList> {
        return try listAll(filter: filter)
    }
}

public struct StripeFileRoutes: FileRoutes {
    private let apiHandler: StripeAPIHandler
    private var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public mutating func addHeaders(_ _headers: HTTPHeaders) {
        _headers.forEach { self.headers.replaceOrAdd(name: $0.name, value: $0.value) }
    }
    
    public mutating func create(file: Data, purpose: StripeFilePurpose, fileLinkData: [String: Any]?) throws -> EventLoopFuture<StripeFile> {
        var body: Data = Data()
        
        // Form data structure found here.
        // https://www.w3.org/TR/html401/interact/forms.html#h-17.13.4
        
        let boundary = "Stripe-Vapor-\(UUID().uuidString)"
        addHeaders(["Content-Type": "multipart/form-data;boundary=\(boundary)"])
        body.append("\r\n--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"purpose\"\r\n\r\n")
        body.append("\(purpose.rawValue)")
        body.append("\r\n--\(boundary)\r\n")
        // filename can just be `blob` since Stripe's server doesn't care about the filename.
        // .NET example -> https://github.com/stripe/stripe-dotnet/blob/6453f36744d77bd5b56c009e9b00591e4aecbd30/src/Stripe.net/Infrastructure/Requestor.cs#L197-L199
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"blob\"\r\n")
        body.append("Content-Type: application/octet-stream\r\n\r\n")
        body.append(file)
        
        if let fileLinkData = fileLinkData {
            body.append("\r\n--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"file_link_data\"\r\n")
            body.append("Content-Type: application/x-www-form-urlencoded; name=\"file_link_data\"\r\n")
            body.append(fileLinkData.queryParameters)
        }
        
        body.append("\r\n--\(boundary)--\r\n")
        
        return try apiHandler.send(method: .POST, path: StripeAPIEndpoint.file.endpoint, body: .data(body), headers: headers)
    }
    
    public func retrieve(file: String) throws -> EventLoopFuture<StripeFile> {
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.files(file).endpoint, headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) throws -> EventLoopFuture<StripeFileUploadList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try apiHandler.send(method: .GET, path: StripeAPIEndpoint.file.endpoint, query: queryParams, headers: headers)
    }
}

/// Thank you @vzsg for this nice little clean snippet
private extension Data {
    mutating func append(_ string: String) {
        guard let data = string.data(using: .utf8) else { return }
        self.append(data)
    }
}
