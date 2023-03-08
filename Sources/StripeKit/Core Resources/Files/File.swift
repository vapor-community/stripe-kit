//
//  File.swift
//  Stripe
//
//  Created by Andrew Edwards on 9/15/18.
//

import Foundation

/// The [File Object](https://stripe.com/docs/api/files/object)
public struct File: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// The [purpose](https://stripe.com/docs/file-upload#uploading-a-file) of the uploaded file.
    public var purpose: FilePurpose?
    /// The type of the file returned (e.g., `csv`, `pdf`, `jpg`, or `png`).
    public var type: FileType?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The time at which the file expires and is no longer available in epoch seconds.
    public var expiresAt: Date?
    /// A filename for the file, suitable for saving to a filesystem.
    public var filename: String?
    /// A list of file links.
    public var links: FileLinkList?
    /// The size in bytes of the file upload object.
    public var size: Int?
    /// A user friendly title for the document.
    public var title: String?
    /// The URL from which the file can be downloaded using your live secret API key.
    public var url: String?
    
    public init(id: String,
                purpose: FilePurpose? = nil,
                type: FileType? = nil,
                object: String,
                created: Date,
                expiresAt: Date? = nil,
                filename: String? = nil,
                links: FileLinkList? = nil,
                size: Int? = nil,
                title: String? = nil,
                url: String? = nil) {
        self.id = id
        self.purpose = purpose
        self.type = type
        self.object = object
        self.created = created
        self.expiresAt = expiresAt
        self.filename = filename
        self.links = links
        self.size = size
        self.title = title
        self.url = url
    }
}

public enum FilePurpose: String, Codable {
    /// Additional documentation requirements that can be requested for an account.
    case accountRequirement = "account_requirement"
    /// Additional verification for custom accounts.
    case additionalVerification = "additional_verification"
    /// A business icon.
    case businessIcon = "business_icon"
    /// A business logo.
    case businessLogo = "business_logo"
    /// Customer signature image.
    case customerSignature = "customer_signature"
    /// Evidence to submit with a dispute response.
    case disputeEvidence = "dispute_evidence"
    case documentProviderIdentityDocument = "document_provider_identity_document"
    /// User-accessible copies of query results from the Reporting dataset.
    case financeReportRun = "finance_report_run"
    ///A document to verify the identity of an account owner during account provisioning.
    case identityDocument = "identity_document"
    /// Image of a document collected by Stripe Identity.
    case identityDocumentDownloadable = "identity_document_downloadable"
    /// A self-assessment PCI questionnaire.
    case pciDocument = "pci_document"
    /// Image of a selfie collected by Stripe Identity.
    case selfie
    /// Sigma scheduled query file for export and download.
    case sigmaScheduledQuery = "sigma_scheduled_query"
    /// A user-uploaded tax document.
    case taxDocumentUserUpload = "tax_document_user_upload"
    /// Splashscreen to be displayed on Terminal readers.
    case terminalReaderSplashscreen = "terminal_reader_splashscreen"
}

public enum FileType: String, Codable {
    case csv
    case docx
    case gif
    case jpg
    case pdf
    case png
    case xls
    case xlsx
}

public struct FileUploadList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [File]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [File]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
