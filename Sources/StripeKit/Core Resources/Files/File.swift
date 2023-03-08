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
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The time at which the file expires and is no longer available in epoch seconds.
    public var expiresAt: Date?
    /// A filename for the file, suitable for saving to a filesystem.
    public var filename: String?
    /// A list of file links.
    public var links: StripeFileLinkList?
    /// The [purpose](https://stripe.com/docs/file-upload#uploading-a-file) of the uploaded file.
    public var purpose: StripeFilePurpose?
    /// The size in bytes of the file upload object.
    public var size: Int?
    /// A user friendly title for the document.
    public var title: String?
    /// The type of the file returned (e.g., `csv`, `pdf`, `jpg`, or `png`).
    public var type: StripeFileType?
    /// The URL from which the file can be downloaded using your live secret API key.
    public var url: String?
}

public enum StripeFilePurpose: String, Codable {
    case additionalVerification = "additional_verification"
    case businessIcon = "business_icon"
    case businessLogo = "business_logo"
    case customerSignature = "customer_signature"
    case disputeEvidence = "dispute_evidence"
    case identityDocument = "identity_document"
    case pciDocument = "pci_document"
    case taxDocumentUserUpload = "tax_document_user_upload"
}

public enum StripeFileType: String, Codable {
    case csv
    case docx
    case gif
    case jpg
    case pdf
    case png
    case xls
    case xlsx
}

public struct StripeFileUploadList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeFile]?
}
