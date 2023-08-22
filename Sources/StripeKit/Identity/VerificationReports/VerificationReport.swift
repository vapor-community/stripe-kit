//
//  VerificationReport.swift
//  StripeKit
//
//  Created by Andrew Edwards on 7/24/21.
//

import Foundation

public struct VerificationReport: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Result of the document check for this report.
    public var document: VerificationReportDocument?
    /// Result of the id number check for this report.
    public var idNumber: VerificationReportIdNumber?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool
    /// Configuration options for this report.
    public var options: VerificationReportOptions?
    /// Result of the selfie check for this report.
    public var selfie: VerificationReportSelfie?
    /// Type of report.
    public var type: VerificationReportType?
    /// ID of the VerificationSession that created this report.
    public var verificationSession: String?
    
    public init(id: String,
                object: String,
                created: Date,
                document: VerificationReportDocument? = nil,
                idNumber: VerificationReportIdNumber? = nil,
                livemode: Bool,
                options: VerificationReportOptions? = nil,
                selfie: VerificationReportSelfie? = nil,
                type: VerificationReportType? = nil,
                verificationSession: String? = nil) {
        self.id = id
        self.object = object
        self.created = created
        self.document = document
        self.idNumber = idNumber
        self.livemode = livemode
        self.options = options
        self.selfie = selfie
        self.type = type
        self.verificationSession = verificationSession
    }
}

public struct VerificationReportDocument: Codable {
    /// Address as it appears in the document.
    public var address: Address?
    /// Date of birth as it appears in the document.
    /// This field is not included by default. To include it in the response, expand the `dob` field.
    public var dob: PersonDOB?
    /// Details on the verification error. Present when status is `unverified`.
    public var error: VerificationReportDocumentError?
    /// Expiration date of the document.
    /// This field is not included by default. To include it in the response, expand the `expiration_date` field.
    public var expirationDate: PersonDOB?
    /// Array of `File` ids containing images for this document.
    public var files: [String]?
    /// First name as it appears in the document.
    public var firstName: String?
    /// Issued date of the document.
    public var issuedDate: PersonDOB?
    /// Issuing country of the document.
    public var issuingCountry: String?
    /// Last name as it appears in the document.
    public var lastName: String?
    /// Document ID number.
    /// This field is not included by default. To include it in the response, expand the `number` field.
    public var number: String?
    /// Status of this `document` check.
    public var status: VerificationReportDocumentStatus?
    /// The type of the document.
    public var type: VerificationReportDocumentType?
    
    public init(address: Address? = nil,
                dob: PersonDOB? = nil,
                error: VerificationReportDocumentError? = nil,
                expirationDate: PersonDOB? = nil,
                files: [String]? = nil,
                firstName: String? = nil,
                issuedDate: PersonDOB? = nil,
                issuingCountry: String? = nil,
                lastName: String? = nil,
                number: String? = nil,
                status: VerificationReportDocumentStatus? = nil,
                type: VerificationReportDocumentType? = nil) {
        self.address = address
        self.dob = dob
        self.error = error
        self.expirationDate = expirationDate
        self.files = files
        self.firstName = firstName
        self.issuedDate = issuedDate
        self.issuingCountry = issuingCountry
        self.lastName = lastName
        self.number = number
        self.status = status
        self.type = type
    }
}

public struct VerificationReportDocumentError: Codable {
    /// A short machine-readable string giving the reason for the verification failure.
    public var code: VerificationReportDocumentErrorCode?
    /// A human-readable message giving the reason for the failure. These messages can be shown to your users.
    public var reason: String?
    
    public init(code: VerificationReportDocumentErrorCode? = nil, reason: String? = nil) {
        self.code = code
        self.reason = reason
    }
}

public enum VerificationReportDocumentErrorCode: String, Codable {
    /// The provided identity document has expired.
    case documentExpired = "document_expired"
    /// Stripe couldn’t verify the provided identity document. See [list of supported document types](https://stripe.com/docs/identity/verification-checks?type=document)
    case documentUnverifiedOther = "document_unverified_other"
    /// The provided identity document isn’t one of the session’s [allowed document types](https://stripe.com/docs/api/identity/verification_sessions/create#create_identity_verification_session-options-document-allow_document_types)
    case documentTypeNotSupported = "document_type_not_supported"
}
    
public enum VerificationReportDocumentStatus: String, Codable {
    /// The check resulted in a successful verification.
    case verified
    /// The data being checked was not able to be verified.
    case unverified
}

public enum VerificationReportDocumentType: String, Codable {
    /// Drivers license document type.
    case drivingLicense = "driving_license"
    /// Passport document type.
    case passport
    /// ID card document type.
    case idCard = "id_card"
}

public struct VerificationReportIdNumber: Codable {
    /// Date of birth.
    /// This field is not included by default. To include it in the response, expand the `dob` field.
    public var dob: PersonDOB?
    /// Details on the verification error. Present when status is `unverified`.
    public var error: VerificationReportIdNumberError?
    /// First name.
    public var firstName: String?
    /// This field is not included by default. To include it in the response, expand the `id_number` field.
    public var idNumber: String?
    /// Type of ID number.
    public var idNumberType: VerificationReportIdNumberType?
    /// Last name.
    public var lastName: String?
    /// Status of the `id_number` check.
    public var status: VerificationReportIdNumberStatus?
    
    public init(dob: PersonDOB? = nil,
                error: VerificationReportIdNumberError? = nil,
                firstName: String? = nil,
                idNumber: String? = nil,
                idNumberType: VerificationReportIdNumberType? = nil,
                lastName: String? = nil,
                status: VerificationReportIdNumberStatus? = nil) {
        self.dob = dob
        self.error = error
        self.firstName = firstName
        self.idNumber = idNumber
        self.idNumberType = idNumberType
        self.lastName = lastName
        self.status = status
    }
}

public struct VerificationReportIdNumberError: Codable {
    /// A short machine-readable string giving the reason for the verification failure.
    public var code: VerificationReportIdNumberErrorReason?
    /// A human-readable message giving the reason for the failure. These messages can be shown to your users.
    public var reason: String?
    
    public init(code: VerificationReportIdNumberErrorReason? = nil, reason: String? = nil) {
        self.code = code
        self.reason = reason
    }
}

public enum VerificationReportIdNumberErrorReason: String, Codable {
    /// The information provided couldn’t be verified. See [list of supported ID numbers](https://stripe.com/docs/identity/verification-checks?type=id-number)
    case idNumberUnverifiedOther = "id_number_unverified_other"
    /// The provided document didn’t contain enough data to match against the ID number.
    case idNumberInsufficientDocumentData = "id_number_insufficient_document_data"
    /// The information provided couldn’t be matched against global databases.
    case idNumberMismatch = "id_number_mismatch"
}

public enum VerificationReportIdNumberType: String, Codable {
    /// An individual CPF number from Brazil.
    case brCpf = "br_cpf"
    /// A national registration identity card number from Singapore.
    case sgNric = "sg_nric"
    /// A social security number from the United States.
    case usSsn = "us_ssn"
}

public enum VerificationReportIdNumberStatus: String, Codable {
    /// The check resulted in a successful verification.
    case verified
    /// The data being checked was not able to be verified.
    case unverified
}

public struct VerificationReportOptions: Codable {
    /// Configuration options to apply to the `document` check.
    public var document: VerificationReportOptionsDocument?
    /// Configuration options to apply to the `id_number` check.
    public var idNumber: VerificationReportOptionsIdNumber?
    
    public init(document: VerificationReportOptionsDocument? = nil,
                idNumber: VerificationReportOptionsIdNumber? = nil) {
        self.document = document
        self.idNumber = idNumber
    }
}

public struct VerificationReportOptionsDocument: Codable {
    /// Array of strings of allowed identity document types. If the provided identity document isn’t one of the allowed types, the verification check will fail with a `document_type_not_allowed` error code.
    public var allowedTypes: [VerificationReportOptionsDocumentAllowedType]?
    /// Collect an ID number and perform an [ID number check](https://stripe.com/docs/identity/verification-checks?type=id-number) with the document’s extracted name and date of birth.
    public var requireIdNumber: Bool?
    /// Disable image uploads, identity document images have to be captured using the device’s camera.
    public var requireLiveCapture: Bool?
    /// Capture a face image and perform a [selfie check](https://stripe.com/docs/identity/verification-checks?type=selfie) comparing a photo ID and a picture of your user’s face. Learn more.
    public var requireMatchingSelfie: Bool
    
    public init(allowedTypes: [VerificationReportOptionsDocumentAllowedType]? = nil,
                requireIdNumber: Bool? = nil,
                requireLiveCapture: Bool? = nil,
                requireMatchingSelfie: Bool) {
        self.allowedTypes = allowedTypes
        self.requireIdNumber = requireIdNumber
        self.requireLiveCapture = requireLiveCapture
        self.requireMatchingSelfie = requireMatchingSelfie
    }
}

public enum VerificationReportOptionsDocumentAllowedType: String, Codable {
    /// Drivers license document type.
    case drivingLicense = "driving_license"
    /// Passport document type.
    case passport
    /// ID card document type.
    case idCard = "id_card"
}

public struct VerificationReportOptionsIdNumber: Codable {
    public init() {}
}

public struct VerificationReportSelfie: Codable {
    /// ID of the File holding the image of the identity document used in this check.
    public var document: String?
    /// Details on the verification error. Present when status is `unverified`.
    public var error: VerificationReportSelfieError?
    /// ID of the File holding the image of the selfie used in this check.
    public var selfie: String?
    /// Status of this `selfie` check.
    public var status: VerificationReportSelfieStatus?
    
    public init(document: String? = nil,
                error: VerificationReportSelfieError? = nil,
                selfie: String? = nil,
                status: VerificationReportSelfieStatus? = nil) {
        self.document = document
        self.error = error
        self.selfie = selfie
        self.status = status
    }
}

public struct VerificationReportSelfieError: Codable {
    /// A short machine-readable string giving the reason for the verification failure.
    public var code: VerificationReportSelfieErrorCode?
    /// A human-readable message giving the reason for the failure. These messages can be shown to your users.
    public var reason: String?
    
    public init(code: VerificationReportSelfieErrorCode? = nil, reason: String? = nil) {
        self.code = code
        self.reason = reason
    }
}

public enum VerificationReportSelfieErrorCode: String, Codable {
    /// The provided identity document didn’t contain a picture of a face.
    case selfieDocumentMissingPhoto = "selfie_document_missing_photo"
    /// The captured face image didn’t match with the document’s face.
    case selfieFaceMismatch = "selfie_face_mismatch"
    /// Stripe couldn’t verify the provided selfie
    case selfieUnverifiedOther = "selfie_unverified_other"
    /// The captured face image was manipulated.
    case selfieManipulated = "selfie_manipulated"
}

public enum VerificationReportSelfieStatus: String, Codable {
    /// The check resulted in a successful verification.
    case verified
    /// The data being checked was not able to be verified.
    case unverified
}

public enum VerificationReportType: String, Codable {
    /// Perform a document check.
    case document
    /// Perform an ID number check.
    case idNumber = "id_number"
}

public struct VerificationReportList: Codable {
    public var object: String
    public var data: [VerificationReport]?
    public var hasMore: Bool?
    public var url: String?
    
    public init(object: String,
                data: [VerificationReport]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}
