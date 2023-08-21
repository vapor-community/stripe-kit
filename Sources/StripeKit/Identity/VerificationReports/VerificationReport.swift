//
//  VerificationReport.swift
//  StripeKit
//
//  Created by Andrew Edwards on 7/24/21.
//

import Foundation

public struct StripeVerificationReport: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Result of the document check for this report.
    public var document: StripeVerificationReportDocument?
    /// Result of the id number check for this report.
    public var idNumber: StripeVerificationReportIdNumber?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool
    /// Configuration options for this report.
    public var options: StripeVerificationReportOptions?
    /// Result of the selfie check for this report.
    public var selfie: StripeVerificationReportSelfie?
    /// Type of report.
    public var type: StripeVerificationReportType?
    /// ID of the VerificationSession that created this report.
    public var verificationSession: String?
}

public struct StripeVerificationReportDocument: StripeModel {
    /// Address as it appears in the document.
    public var address: StripeAddress?
    /// Date of birth as it appears in the document.
    /// This field is not included by default. To include it in the response, expand the `dob` field.
    public var dob: StripePersonDOB?
    /// Details on the verification error. Present when status is `unverified`.
    public var error: StripeVerificationReportDocumentError?
    /// Expiration date of the document.
    /// This field is not included by default. To include it in the response, expand the `expiration_date` field.
    public var expirationDate: StripePersonDOB?
    /// Array of `File` ids containing images for this document.
    public var files: [String]?
    /// First name as it appears in the document.
    public var firstName: String?
    /// Issued date of the document.
    public var issuedDate: StripePersonDOB?
    /// Issuing country of the document.
    public var issuingCountry: String?
    /// Last name as it appears in the document.
    public var lastName: String?
    /// Document ID number.
    /// This field is not included by default. To include it in the response, expand the `number` field.
    public var number: String?
    /// Status of this `document` check.
    public var status: StripeVerificationReportDocumentStatus?
    /// The type of the document.
    public var type: StripeVerificationReportDocumentType?
}

public struct StripeVerificationReportDocumentError: StripeModel {
    /// A short machine-readable string giving the reason for the verification failure.
    public var code: StripeVerificationReportDocumentErrorCode?
    /// A human-readable message giving the reason for the failure. These messages can be shown to your users.
    public var reason: String?
}

public enum StripeVerificationReportDocumentErrorCode: String, StripeModel {
    /// The provided identity document has expired.
    case documentExpired = "document_expired"
    /// Stripe couldn’t verify the provided identity document. See [list of supported document types](https://stripe.com/docs/identity/verification-checks?type=document)
    case documentUnverifiedOther = "document_unverified_other"
    /// The provided identity document isn’t one of the session’s [allowed document types](https://stripe.com/docs/api/identity/verification_sessions/create#create_identity_verification_session-options-document-allow_document_types)
    case documentTypeNotSupported = "document_type_not_supported"
}
    
public enum StripeVerificationReportDocumentStatus: String, StripeModel {
    /// The check resulted in a successful verification.
    case verified
    /// The data being checked was not able to be verified.
    case unverified
}

public enum StripeVerificationReportDocumentType: String, StripeModel {
    /// Drivers license document type.
    case drivingLicense = "driving_license"
    /// Passport document type.
    case passport
    /// ID card document type.
    case idCard = "id_card"
}

public struct StripeVerificationReportIdNumber: StripeModel {
    /// Date of birth.
    /// This field is not included by default. To include it in the response, expand the `dob` field.
    public var dob: StripePersonDOB?
    /// Details on the verification error. Present when status is `unverified`.
    public var error: StripeVerificationReportIdNumberError?
    /// First name.
    public var firstName: String?
    /// This field is not included by default. To include it in the response, expand the `id_number` field.
    public var idNumber: String?
    /// Type of ID number.
    public var idNumberType: StripeVerificationReportIdNumberType?
    /// Last name.
    public var lastName: String?
    /// Status of the `id_number` check.
    public var status: StripeVerificationReportIdNumberStatus?
}

public struct StripeVerificationReportIdNumberError: StripeModel {
    /// A short machine-readable string giving the reason for the verification failure.
    public var code: StripeVerificationReportIdNumberErrorReason?
    /// A human-readable message giving the reason for the failure. These messages can be shown to your users.
    public var reason: String?
}

public enum StripeVerificationReportIdNumberErrorReason: String, StripeModel {
    /// The information provided couldn’t be verified. See [list of supported ID numbers](https://stripe.com/docs/identity/verification-checks?type=id-number)
    case idNumberUnverifiedOther = "id_number_unverified_other"
    /// The provided document didn’t contain enough data to match against the ID number.
    case idNumberInsufficientDocumentData = "id_number_insufficient_document_data"
    /// The information provided couldn’t be matched against global databases.
    case idNumberMismatch = "id_number_mismatch"
}

public enum StripeVerificationReportIdNumberType: String, StripeModel {
    /// An individual CPF number from Brazil.
    case brCpf = "br_cpf"
    /// A national registration identity card number from Singapore.
    case sgNric = "sg_nric"
    /// A social security number from the United States.
    case usSsn = "us_ssn"
}

public enum StripeVerificationReportIdNumberStatus: String, StripeModel {
    /// The check resulted in a successful verification.
    case verified
    /// The data being checked was not able to be verified.
    case unverified
}

public struct StripeVerificationReportOptions: StripeModel {
    /// Configuration options to apply to the `document` check.
    public var document: StripeVerificationReportOptionsDocument?
    /// Configuration options to apply to the `id_number` check.
    public var idNumber: StripeVerificationReportOptionsIdNumber?
}

public struct StripeVerificationReportOptionsDocument: StripeModel {
    /// Array of strings of allowed identity document types. If the provided identity document isn’t one of the allowed types, the verification check will fail with a `document_type_not_allowed` error code.
    public var allowedTypes: [StripeVerificationReportOptionsDocumentAllowedType]?
    /// Collect an ID number and perform an [ID number check](https://stripe.com/docs/identity/verification-checks?type=id-number) with the document’s extracted name and date of birth.
    public var requireIdNumber: Bool?
    /// Disable image uploads, identity document images have to be captured using the device’s camera.
    public var requireLiveCapture: Bool?
    /// Capture a face image and perform a [selfie check](https://stripe.com/docs/identity/verification-checks?type=selfie) comparing a photo ID and a picture of your user’s face. Learn more.
    public var requireMatchingSelfie: Bool
}

public enum StripeVerificationReportOptionsDocumentAllowedType: String, StripeModel {
    /// Drivers license document type.
    case drivingLicense = "driving_license"
    /// Passport document type.
    case passport
    /// ID card document type.
    case idNumber = "id_card"
}

public struct StripeVerificationReportOptionsIdNumber: StripeModel {}

public struct StripeVerificationReportSelfie: StripeModel {
    /// ID of the File holding the image of the identity document used in this check.
    public var document: String?
    /// Details on the verification error. Present when status is `unverified`.
    public var error: StripeVerificationReportSelfieError?
    /// ID of the File holding the image of the selfie used in this check.
    public var selfie: String?
    /// Status of this `selfie` check.
    public var status: StripeVerificationReportSelfieStatus?
}

public struct StripeVerificationReportSelfieError: StripeModel {
    /// A short machine-readable string giving the reason for the verification failure.
    public var code: StripeVerificationReportSelfieErrorCode?
    /// A human-readable message giving the reason for the failure. These messages can be shown to your users.
    public var reason: String?
}

public enum StripeVerificationReportSelfieErrorCode: String, StripeModel {
    case selfieDocumentMissingPhoto = "selfie_document_missing_photo"
    case selfieFaceMismatch = "selfie_face_mismatch"
    case selfieUnverifiedOther = "selfie_unverified_other"
}

public enum StripeVerificationReportSelfieStatus: String, StripeModel {
    /// The check resulted in a successful verification.
    case verified
    /// The data being checked was not able to be verified.
    case unverified
}

public enum StripeVerificationReportType: String, StripeModel {
    /// Perform a document check.
    case document
    /// Perform an ID number check.
    case idNumber = "id_number"
}

public struct StripeVerificationReportList: StripeModel {
    public var object: String
    public var data: [StripeVerificationReport]?
    public var hasMore: Bool?
    public var url: String?
}
