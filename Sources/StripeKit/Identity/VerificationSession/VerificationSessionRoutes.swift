//
//  VerificationSessionRoutes.swift
//  StripeKit
//
//  Created by Andrew Edwards on 7/24/21.
//

import NIO
import NIOHTTP1

public protocol VerificationSessionRoutes {
    /// Creates a VerificationSession object.
    /// After the VerificationSession is created, display a verification modal using the session `client_secret` or send your users to the session’s url.
    /// If your API key is in test mode, verification checks won’t actually process, though everything else will occur as if in live mode.
    /// - Parameter type: The type of verification check to be performed.
    /// - Parameter metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    /// - Parameter options: A set of options for the session’s verification checks.
    /// - Parameter returnUrl: The URL that the user will be redirected to upon completing the verification flow.
    /// - Parameter expand: An array of properties to expand.
    ///
    /// - Returns: A `StripeVerificationSession`.
    func create(type: StripeVerificationSessionType,
                metadata: [String: String]?,
                options: [String: Any]?,
                returnUrl: String?,
                expand: [String]?) -> EventLoopFuture<StripeVerificationSession>
    
    /// Returns a list of VerificationSessions
    /// - Parameter filter: A dictionary that will be used for the query parameters.
    /// - Returns: A `StripeVerificationSessionList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeVerificationSessionList>
    
    
    /// Retrieves the details of a VerificationSession that was previously created.
    /// When the session status is `requires_input`, you can use this method to retrieve a valid `client_secret` or url to allow re-submission.
    /// - Parameter verificationSessionId: Id of the verification session.
    /// - Parameter expand: An array of properties to expand.
    ///
    /// - Returns: A `StripeVerificationSession`.
    func retrieve(verificationSessionId: String, expand: [String]?) -> EventLoopFuture<StripeVerificationSession>
    
    /// Updates a VerificationSession object.
    /// When the session status is `requires_input`, you can use this method to update the verification check and options.
    /// - Parameter verificationSessionId: Id of the verification session.
    /// - Parameter metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    /// - Parameter options: A set of options for the session’s verification checks.
    /// - Parameter type: The type of verification check to be performed.
    /// - Parameter expand: An array of properties to expand.
    ///
    /// - Returns: A `StripeVerificationSession`.
    func update(verificationSessionId: String,
                metadata: [String: String]?,
                options: [String: Any]?,
                type: StripeVerificationSessionType?,
                expand: [String]?) -> EventLoopFuture<StripeVerificationSession>
    
    
    /// A VerificationSession object can be canceled when it is in `requires_input` status.
    /// Once canceled, future submission attempts are disabled. This cannot be undone.
    /// - Parameter verificationSessionId: Id of the verification session.
    /// - Parameter expand: An array of properties to expand.
    ///
    /// - Returns: The canceled `StripeVerificationSession`.
    func cancel(verificationSessionId: String, expand: [String]?) -> EventLoopFuture<StripeVerificationSession>
    
    /// Redact a VerificationSession to remove all collected information from Stripe. This will redact the VerificationSession and all objects related to it, including VerificationReports, Events, request logs, etc.
    ///
    /// A VerificationSession object can be redacted when it is in `requires_input` or verified status. Redacting a VerificationSession in `requires_action` state will automatically cancel it.
    ///
    /// The redaction process may take up to four days. When the redaction process is in progress, the VerificationSession’s `redaction.status` field will be set to `processing`; when the process is finished, it will change to `redacted` and an `identity.verification_session.redacted` event will be emitted.
    ///
    /// Redaction is irreversible. Redacted objects are still accessible in the Stripe API, but all the fields that contain personal data will be replaced by the string [redacted] or a similar placeholder. The metadata field will also be erased. Redacted objects cannot be updated or used for any purpose.
    /// - Parameter verificationSessionId: Id of the verification session.
    /// - Parameter expand: An array of properties to expand.
    ///
    /// - Returns: The redacted `StripeVerificationSession`.
    func redact(verificationSessionId: String, expand: [String]?) -> EventLoopFuture<StripeVerificationSession>
    
    /// Headers to send with the request.
    var headers: HTTPHeaders { get set }
}

extension VerificationSessionRoutes {
    func create(type: StripeVerificationSessionType,
                metadata: [String: String]? = nil,
                options: [String: Any]? = nil,
                returnUrl: String? = nil,
                expand: [String]? = nil) -> EventLoopFuture<StripeVerificationSession> {
        create(type: type,
               metadata: metadata,
               options: options,
               returnUrl: returnUrl,
               expand: expand)
    }
    
    func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeVerificationSessionList> {
        listAll(filter: filter)
    }
    
    func retrieve(verificationSessionId: String, expand: [String]? = nil) -> EventLoopFuture<StripeVerificationSession> {
        retrieve(verificationSessionId: verificationSessionId, expand: expand)
    }
    
    func update(verificationSessionId: String,
                metadata: [String: String]? = nil,
                options: [String: Any]? = nil,
                type: StripeVerificationSessionType? = nil,
                expand: [String]? = nil) -> EventLoopFuture<StripeVerificationSession> {
        update(verificationSessionId: verificationSessionId, metadata: metadata, options: options, type: type, expand: expand)
    }
    
    func cancel(verificationSessionId: String, expand: [String]? = nil) -> EventLoopFuture<StripeVerificationSession> {
        cancel(verificationSessionId: verificationSessionId, expand: expand)
    }
    
    func redact(verificationSessionId: String, expand: [String]? = nil) -> EventLoopFuture<StripeVerificationSession> {
        redact(verificationSessionId: verificationSessionId, expand: expand)
    }
}

public struct StripeVerificationSessionRoutes: VerificationSessionRoutes {
    public var headers: HTTPHeaders = [:]
    
    private let apiHandler: StripeAPIHandler
    private let verificationsession = APIBase + APIVersion + "identity/verification_sessions"
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(type: StripeVerificationSessionType,
                       metadata: [String: String]?,
                       options: [String: Any]?,
                       returnUrl: String?,
                       expand: [String]?) -> EventLoopFuture<StripeVerificationSession> {
        var body: [String: Any] = ["type": type.rawValue]
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let options = options {
            options.forEach { body["options[\($0)]"] = $1 }
        }
        
        if let returnUrl = returnUrl {
            body["return_url"] = returnUrl
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: verificationsession, body: .string(body.queryParameters), headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeVerificationSessionList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return apiHandler.send(method: .GET, path: verificationsession, query: queryParams, headers: headers)
    }
    
    public func retrieve(verificationSessionId: String, expand: [String]?) -> EventLoopFuture<StripeVerificationSession> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .GET, path: "\(verificationsession)/\(verificationSessionId)", query: queryParams, headers: headers)
    }
    
    public func update(verificationSessionId: String,
                       metadata: [String: String]?,
                       options: [String: Any]?,
                       type: StripeVerificationSessionType?,
                       expand: [String]?) -> EventLoopFuture<StripeVerificationSession> {
        var body: [String: Any] = [:]
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let options = options {
            options.forEach { body["options[\($0)]"] = $1 }
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        if let type = type {
            body["type"] = type.rawValue
        }
        
        if let expand = expand {
            body["expand"] = expand
        }
        
        return apiHandler.send(method: .POST, path: "\(verificationsession)/\(verificationSessionId)", body: .string(body.queryParameters), headers: headers)
    }
    
    public func cancel(verificationSessionId: String, expand: [String]?) -> EventLoopFuture<StripeVerificationSession> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .POST, path: "\(verificationsession)/\(verificationSessionId)/cancel", query: queryParams, headers: headers)
    }
    
    public func redact(verificationSessionId: String, expand: [String]?) -> EventLoopFuture<StripeVerificationSession> {
        var queryParams = ""
        if let expand = expand {
            queryParams = ["expand": expand].queryParameters
        }
        
        return apiHandler.send(method: .POST, path: "\(verificationsession)/\(verificationSessionId)/redact", query: queryParams, headers: headers)
    }
}
