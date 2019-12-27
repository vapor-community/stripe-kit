//
//  Person.swift
//  Stripe
//
//  Created by Andrew Edwards on 2/24/19.
//

import Foundation

// https://stripe.com/docs/api/persons/object?&lang=curl
public struct StripePerson: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The account the person is associated with.
    public var account: String?
    /// The persons address.
    public var address: StripeAddress?
    /// The Kana variation of the person’s address (Japan only).
    public var addressKana: StripeAddressKana?
    /// The Kanji variation of the person’s address (Japan only).
    public var addressKanji: StripeAddressKanji?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The Persons date of birth.
    public var dob: StripePersonDOB?
    /// The person's email address.
    public var email: String?
    /// The person's first name.
    public var firstName: String?
    /// The Kana variation of the person’s name (Japan only).
    public var firstNameKana: String?
    /// The Kanji variation of the person’s name (Japan only).
    public var firstNameKanji: String?
    /// The person’s gender (International regulations require either “male” or “female”).
    public var gender: StripePersonGender?
    /// Whether the person’s id_number was provided.
    public var idNumberProvided: Bool?
    /// The person's last name.
    public var lastName: String?
    /// The Kana variation of the person’s last name (Japan only).
    public var lastNameKana: String?
    /// The Kanji variation of the person’s last name (Japan only).
    public var lastNameKanji: String?
    /// The person's maiden name.
    public var maidenName: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The person's phone number.
    public var phone: String?
    /// Describes the person’s relationship to the account.
    public var relationship: StripePersonRelationship?
    /// Information about the requirements for this person, including what information needs to be collected, and by when.
    public var requirements: StripePersonRequirements?
    /// Whether the last 4 digits of this person’s SSN have been provided.
    public var ssnLast4Provided: Bool?
    /// The persons’s verification status.
    public var verification: StripePersonVerification?
}

public struct StripePersonDOB: StripeModel {
    /// The day of birth, between 1 and 31.
    public var day: Int?
    /// The month of birth, between 1 and 12.
    public var month: Int?
    /// The four-digit year of birth.
    public var year: Int?
}

public enum StripePersonGender: String, StripeModel {
    case male
    case female
}

public struct StripePersonRelationship: StripeModel {
    /// Whether the person is a director of the account’s legal entity. Currently only required for accounts in the EU. Directors are typically members of the governing board of the company, or responsible for ensuring the company meets its regulatory obligations.
    public var director: Bool?
    /// Whether the person has significant responsibility to control, manage, or direct the organization.
    public var executive: Bool?
    /// Whether the person is an owner of the account’s legal entity.
    public var owner: Bool?
    /// The percent owned by the person of the account’s legal entity.
    public var percentOwnership: Decimal?
    /// Whether the person is authorized as the primary representative of the account. This is the person nominated by the business to provide information about themselves, and general information about the account. There can only be one representative at any given time. At the time the account is created, this person should be set to the person responsible for opening the account.
    public var representative: Bool?
    /// The person’s title (e.g., CEO, Support Engineer).
    public var title: String?
}

public struct StripePersonRequirements: StripeModel {
    /// Fields that need to be collected to keep the person’s account enabled. If not collected by the account’s current_deadline, these fields appear in past_due as well, and the account is disabled.
    public var currentlyDue: [String]?
    /// Fields that need to be collected assuming all volume thresholds are reached. As fields are needed, they are moved to `currently_due` and the account’s `current_deadline` is set.
    public var eventuallyDue: [String]?
    /// Fields that weren’t collected by the account’s current_deadline. These fields need to be collected to enable payouts for the person’s account.
    public var pastDue: [String]?
    /// Fields that may become required depending on the results of verification or review. An empty array unless an asynchronous verification is pending. If verification fails, the fields in this array become required and move to `currently_due` or `past_due`.
    public var pendingVerification: [String]?
}

public struct StripePersonVerification: StripeModel {
    /// A document showing address, either a passport, local ID card, or utility bill from a well-known utility company.
    public var additionalDocument: StripePersonVerificationDocument?
    /// A user-displayable string describing the verification state for the person. For example, this may say “Provided identity information could not be verified”.
    public var details: String?
    /// One of `document_address_mismatch`, `document_dob_mismatch`, `document_duplicate_type`, `document_id_number_mismatch`, `document_name_mismatch`, `document_nationality_mismatch`, `failed_keyed_identity`, or `failed_other`. A machine-readable code specifying the verification state for the person.
    public var detailsCode: StripePersonVerificationDetailsCode?
    /// An identifying document for the person, either a passport or local ID card.
    public var document: StripePersonVerificationDocument?
    /// The state of verification for the person. Possible values are `unverified`, `pending`, or `verified`.
    public var status: StripePersonVerificationStatus?
}

public enum StripePersonVerificationDetailsCode: String, StripeModel {
    case documentAddressMismatch = "document_address_mismatch"
    case documentDobMismatch = "document_dob_mismatch"
    case documentDuplicateType = "document_duplicate_type"
    case documentIdNumberMismatch = "document_id_number_mismatch"
    case documentNameMismatch = "document_name_mismatch"
    case documentNationalityMismatch = "document_nationality_mismatch"
    case failedKeyedIdentity = "failed_keyed_identity"
    case failedOther = "failed_other"
}


public struct StripePersonVerificationDocument: StripeModel {
    /// The back of a document returned by a file upload with a `purpose` value of `additional_verification`.
    public var back: String?
    /// A user-displayable string describing the verification state of this document.
    public var details: String?
    /// One of `document_corrupt`, `document_expired`, `document_failed_copy`, `document_failed_greyscale`, `document_failed_other`, `document_failed_test_mode`, `document_fraudulent`, `document_incomplete`, `document_invalid`, `document_manipulated`, `document_not_readable`, `document_not_uploaded`, `document_type_not_supported`, or `document_too_large`. A machine-readable code specifying the verification state for this document.
    public var detailsCode: StripePersonVerificationDocumentDetailsCode?
    /// The front of a document returned by a file upload with a `purpose` value of `additional_verification`.
    public var front: String?
}

public enum StripePersonVerificationDocumentDetailsCode: String, StripeModel {
    case documentCorrupt = "document_corrupt"
    case documentFailedCopy = "document_failed_copy"
    case documentNotReadable = "document_not_readable"
    case documentFailedGreyscale = "document_failed_greyscale"
    case documentNotUploaded = "document_not_uploaded"
    case documentIdTypeNotSupported = "document_id_type_not_supported"
    case documentIdCountryNotSupported = "document_id_country_not_supported"
    case documentFailedOther = "document_failed_other"
    case documentFraudulent = "document_fraudulent"
    case documentInvalid = "document_invalid"
    case documentManipulated = "document_manipulated"
    case documentMissingBack = "document_missing_back"
    case documentMissingFront = "document_missing_front"
    case documentPhotoMismatch = "document_photo_mismatch"
    case documentTooLarge = "document_too_large"
    case documentFailedTestMode = "document_failed_test_mode"
}

public enum StripePersonVerificationStatus: String, StripeModel {
    case unverified
    case pending
    case verified
}

public struct StripePersonsList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripePerson]?
}
