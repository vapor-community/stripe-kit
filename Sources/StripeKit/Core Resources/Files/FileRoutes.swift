//
//  FileRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 9/15/18.
//

import NIO
import NIOHTTP1
import Foundation

public protocol FileRoutes: StripeAPIRoute {
    /// To upload a file to Stripe, you’ll need to send a request of type `multipart/form-data`. The request should contain the file you would like to upload, as well as the parameters for creating a file. \n All of Stripe’s officially supported API libraries should have support for sending `multipart/form-data`.
    ///
    /// - Parameters:
    ///   - file: A file to upload. The file should follow the specifications of RFC 2388 (which defines file transfers for the `multipart/form-data` protocol).
    ///   - purpose: The purpose of the uploaded file.
    ///   - fileLinkData: Optional parameters to automatically create a file link for the newly created file.
    /// - Returns: Returns the file object..
    mutating func create(file: Data, purpose: FilePurpose, fileLinkData: [String: Any]?) async throws -> File
    
    /// Retrieves the details of an existing file object. Supply the unique file ID from a file, and Stripe will return the corresponding file object. To access file contents, see the [File Upload Guide](https://stripe.com/docs/file-upload#download-file-contents) .
    ///
    /// - Parameter id: The identifier of the file upload to be retrieved.
    /// - Returns: Returns a file object if a valid identifier was provided, and returns an error otherwise.
    func retrieve(file: String) async throws -> File
    
    /// Returns a list of the files that you have uploaded to Stripe. The file uploads are returned sorted by creation date, with the most recently created file uploads appearing first.
    ///
    /// - Parameter filter: A dictionary that contains the filters. More info [here](https://stripe.com/docs/api/curl#list_file_uploads).
    /// - Returns: A `FileUploadList`
    func listAll(filter: [String: Any]?) async throws -> FileUploadList
}

public struct StripeFileRoutes: FileRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let filesupload = FilesAPIBase + APIVersion + "files"
    private let files = APIBase + APIVersion + "files"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public mutating func create(file: Data, purpose: FilePurpose, fileLinkData: [String: Any]? = nil) async throws -> File {
        var body: Data = Data()
        
        // Form data structure found here.
        // https://www.w3.org/TR/html401/interact/forms.html#h-17.13.4
        
        let boundary = "Stripe-Kit-\(UUID().uuidString)"
        headers.add(name: "Content-Type", value: "multipart/form-data;boundary=\(boundary)")
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
        
        return try await apiHandler.send(method: .POST, path: filesupload, body: .data(body), headers: headers)
    }
    
    public func retrieve(file: String) async throws -> File {
        try await apiHandler.send(method: .GET, path: "\(files)/\(file)", headers: headers)
    }
    
    public func listAll(filter: [String: Any]? = nil) async throws -> FileUploadList {
        var queryParams = ""
        if let filter {
            queryParams = filter.queryParameters
        }
        
        return try await apiHandler.send(method: .GET, path: files, query: queryParams, headers: headers)
    }
}

/// Thank you @vzsg for this nice little clean snippet
private extension Data {
    mutating func append(_ string: String) {
        guard let data = string.data(using: .utf8) else { return }
        self.append(data)
    }
}
