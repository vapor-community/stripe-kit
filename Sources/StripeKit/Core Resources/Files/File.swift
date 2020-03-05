//
//  FileUpload.swift
//  Stripe
//
//  Created by Andrew Edwards on 9/15/18.
//

import Foundation

/// The [File Object](https://stripe.com/docs/api/files/object).
public struct StripeFile: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// A filename for the file, suitable for saving to a filesystem.
    public var filename: String?
    /// A list of file links.
    public var links: StripeFileLinkList?
    /// The purpose of the file. Possible values are `business_icon`, `business_logo`, `customer_signature`, `dispute_evidence`, `finance_report_run`, `identity_document`, `pci_document`, `sigma_scheduled_query`, or `tax_document_user_upload`.
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

public enum StripeFilePurpose: String, StripeModel {
    case businessLogo = "business_logo"
    case customerSignature = "customer_signature"
    case disputeEvidence = "dispute_evidence"
    case identityDocument = "identity_document"
    case pciDocument = "pci_document"
    case taxDocumentUserUpload = "tax_document_user_upload"
}

public enum StripeFileType: String, StripeModel {
    case csv
    case docx
    case gif
    case jpg
    case pdf
    case png
    case xls
    case xlsx
}

public struct StripeFileUploadList: StripeModel {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeFile]?
}
