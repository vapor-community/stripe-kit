//
//  Person.swift
//  Stripe
//
//  Created by Andrew Edwards on 2/24/19.
//

import Foundation

/// The [Persons Object](https://stripe.com/docs/api/persons/object)
public struct Person: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// The account the person is associated with.
    public var account: String?
    /// The persons address.
    public var address: Address?
    /// The Persons date of birth.
    public var dob: PersonDOB?
    /// The person's email address.
    public var email: String?
    /// The person's first name.
    public var firstName: String?
    /// The person's last name.
    public var lastName: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The person's phone number.
    public var phone: String?
    /// Describes the person’s relationship to the account.
    public var relationship: PersonRelationship?
    /// Information about the requirements for this person, including what information needs to be collected, and by when.
    public var requirements: PersonRequirements?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The Kana variation of the person’s address (Japan only).
    public var addressKana: AddressKana?
    /// The Kanji variation of the person’s address (Japan only).
    public var addressKanji: AddressKanji?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The Kana variation of the person’s name (Japan only).
    public var firstNameKana: String?
    /// The Kanji variation of the person’s name (Japan only).
    public var firstNameKanji: String?
    /// Information about the upcoming new requirements for this person, including what information needs to be collected, and by when.
    public var futureRequirements: PersonFutureRequirements?
    /// The person’s gender (International regulations require either “male” or “female”).
    public var gender: PersonGender?
    /// Whether the person’s `id_number` was provided.
    public var idNumberProvided: Bool?
    /// Whether the person’s `id_number_secondary` was provided.
    public var idNumberSecondaryProvided: Bool?
    /// The Kana variation of the person’s last name (Japan only).
    public var lastNameKana: String?
    /// The Kanji variation of the person’s last name (Japan only).
    public var lastNameKanji: String?
    /// The person's maiden name.
    public var maidenName: String?
    /// The country where the person is a national.
    public var nationality: String?
    /// Indicates if the person or any of their representatives, family members, or other closely related persons, declares that they hold or have held an important public job or function, in any jurisdiction.
    public var politicalExposure: PersonPoliticalExposure?
    /// The person’s registered address.
    public var registeredAddres: Address?
    /// Whether the last 4 digits of this person’s SSN have been provided.
    public var ssnLast4Provided: Bool?
    /// The persons’s verification status.
    public var verification: PersonVerification?
    
    public init(id: String,
                account: String? = nil,
                address: Address? = nil,
                dob: PersonDOB? = nil,
                email: String? = nil,
                firstName: String? = nil,
                lastName: String? = nil,
                metadata: [String : String]? = nil,
                phone: String? = nil,
                relationship: PersonRelationship? = nil,
                requirements: PersonRequirements? = nil,
                object: String,
                addressKana: AddressKana? = nil,
                addressKanji: AddressKanji? = nil,
                created: Date,
                firstNameKana: String? = nil,
                firstNameKanji: String? = nil,
                futureRequirements: PersonFutureRequirements? = nil,
                gender: PersonGender? = nil,
                idNumberProvided: Bool? = nil,
                idNumberSecondaryProvided: Bool? = nil,
                lastNameKana: String? = nil,
                lastNameKanji: String? = nil,
                maidenName: String? = nil,
                nationality: String? = nil,
                politicalExposure: PersonPoliticalExposure? = nil,
                registeredAddres: Address? = nil,
                ssnLast4Provided: Bool? = nil,
                verification: PersonVerification? = nil) {
        self.id = id
        self.account = account
        self.address = address
        self.dob = dob
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.metadata = metadata
        self.phone = phone
        self.relationship = relationship
        self.requirements = requirements
        self.object = object
        self.addressKana = addressKana
        self.addressKanji = addressKanji
        self.created = created
        self.firstNameKana = firstNameKana
        self.firstNameKanji = firstNameKanji
        self.futureRequirements = futureRequirements
        self.gender = gender
        self.idNumberProvided = idNumberProvided
        self.idNumberSecondaryProvided = idNumberSecondaryProvided
        self.lastNameKana = lastNameKana
        self.lastNameKanji = lastNameKanji
        self.maidenName = maidenName
        self.nationality = nationality
        self.politicalExposure = politicalExposure
        self.registeredAddres = registeredAddres
        self.ssnLast4Provided = ssnLast4Provided
        self.verification = verification
    }
}

public struct PersonDOB: Codable {
    /// The day of birth, between 1 and 31.
    public var day: Int?
    /// The month of birth, between 1 and 12.
    public var month: Int?
    /// The four-digit year of birth.
    public var year: Int?
    
    public init(day: Int? = nil,
                month: Int? = nil,
                year: Int? = nil) {
        self.day = day
        self.month = month
        self.year = year
    }
}

public enum PersonGender: String, Codable {
    case male
    case female
}

public enum PersonPoliticalExposure: String, Codable {
    /// The person has disclosed that they have no political exposure
    case none
    /// The person has disclosed that they do have political exposure
    case existing
}

public struct PersonRelationship: Codable {
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
    
    public init(director: Bool? = nil,
                executive: Bool? = nil,
                owner: Bool? = nil,
                percentOwnership: Decimal? = nil,
                representative: Bool? = nil,
                title: String? = nil) {
        self.director = director
        self.executive = executive
        self.owner = owner
        self.percentOwnership = percentOwnership
        self.representative = representative
        self.title = title
    }
}

public struct PersonRequirements: Codable {
    /// Fields that are due and can be satisfied by providing the corresponding alternative fields instead.
    public var alternatives: [PersonRequirementsAlternative]?
    /// Fields that need to be collected to keep the person’s account enabled. If not collected by the account’s `current_deadline`, these fields appear in `past_due` as well, and the account is disabled.
    public var currentlyDue: [String]?
    /// The fields that are `currently_due` and need to be collected again because validation or verification failed for some reason.
    public var errors: [PersonRequirementsError]?
    /// Fields that need to be collected assuming all volume thresholds are reached. As fields are needed, they are moved to `currently_due` and the account’s `current_deadline` is set.
    public var eventuallyDue: [String]?
    /// Fields that weren’t collected by the account’s `current_deadline`. These fields need to be collected to enable payouts for the person’s account.
    public var pastDue: [String]?
    /// Fields that may become required depending on the results of verification or review. An empty array unless an asynchronous verification is pending. If verification fails, the fields in this array become required and move to `currently_due` or `past_due`.
    public var pendingVerification: [String]?
    
    public init(alternatives: [PersonRequirementsAlternative]? = nil,
                currentlyDue: [String]? = nil,
                errors: [PersonRequirementsError]? = nil,
                eventuallyDue: [String]? = nil,
                pastDue: [String]? = nil,
                pendingVerification: [String]? = nil) {
        self.alternatives = alternatives
        self.currentlyDue = currentlyDue
        self.errors = errors
        self.eventuallyDue = eventuallyDue
        self.pastDue = pastDue
        self.pendingVerification = pendingVerification
    }
}

public struct PersonRequirementsAlternative: Codable {
    /// Fields that can be provided to satisfy all fields in `original_fields_due`.
    public var alternativeFieldsDue: [String]?
    /// Fields that are due and can be satisfied by providing all fields in `alternative_fields_due`.
    public var originalFieldsDue: [String]?
    
    public init(alternativeFieldsDue: [String]? = nil, originalFieldsDue: [String]? = nil) {
        self.alternativeFieldsDue = alternativeFieldsDue
        self.originalFieldsDue = originalFieldsDue
    }
}

public struct PersonRequirementsError: Codable {
    /// The code for the type of error.
    public var code: PersonRequirementsErrorCode?
    
    public init(code: PersonRequirementsErrorCode? = nil) {
        self.code = code
    }
}

public enum PersonRequirementsErrorCode: String, Codable {
    /// The combination of the city, state, and postal code in the provided address could not be validated.
    case invalidAddressCityStatePostalCode = "invalid_address_city_state_postal_code"
    /// The street name and/or number for the provided address could not be validated.
    case invalidStreetAddress = "invalid_street_address"
    /// The existing terms of service signature has been invalidated because the account’s tax ID has changed. The account needs to accept the terms of service again. For more information, see [this documentation](https://stripe.com/docs/connect/update-verified-information) .
    case invalidTosAcceptance = "invalid_tos_acceptance"
    /// An invalid value was provided for the related field. This is a general error code.
    case invalidValueOther = "invalid_value_other"
    /// The representative must have an address in the same country as the company.
    case invalidRepresentativeCountry = "invalid_representative_country"
    /// The address on the document did not match the address on the account. Upload a document with a matching address or update the address on the account.
    case verificationDocumentAddressMismatch = "verification_document_address_mismatch"
    /// The company address was missing on the document. Upload a document that includes the address.
    case verificationDocumentAddressMissing = "verification_document_address_missing"
    /// The uploaded file for the document was invalid or corrupt. Upload a new file of the document.
    case verificationDocumentCorrupt = "verification_document_corrupt"
    /// The provided document was from an unsupported country.
    case verificationDocumentCountryNotSupported = "verification_document_country_not_supported"
    /// The date of birth (DOB) on the document did not match the DOB on the account. Upload a document with a matching DOB or update the DOB on the account.
    case verificationDocumentDobMismatch = "verification_document_dob_mismatch"
    /// The same type of document was used twice. Two unique types of documents are required for verification. Upload two different documents.
    case verificationDocumentDuplicateType = "verification_document_duplicate_type"
    /// The document could not be used for verification because it has expired. If it’s an identity document, its expiration date must be after the date the document was submitted. If it’s an address document, the issue date must be within the last six months.
    case verificationDocumentExpired = "verification_document_expired"
    /// The document could not be verified because it was detected as a copy (e.g., photo or scan). Upload the original document.
    case verificationDocumentFailedCopy = "verification_document_failed_copy"
    /// The document could not be used for verification because it was in greyscale. Upload a color copy of the document.
    case verificationDocumentFailedGreyscale = "verification_document_failed_greyscale"
    /// The document could not be verified for an unknown reason. Ensure that the document follows the [guidelines for document uploads](https://stripe.com/docs/connect/identity-verification-api#acceptable-verification-documents) .
    case verificationDocumentFailedOther = "verification_document_failed_other"
    /// A test data helper was supplied to simulate verification failure. Refer to the documentation for [test file tokens](https://stripe.com/docs/connect/testing#test-file-tokens) .
    case verificationDocumentFailedTestMode = "verification_document_failed_test_mode"
    /// The document was identified as altered or falsified.
    case verificationDocumentFraudulent = "verification_document_fraudulent"
    /// The company ID number on the account could not be verified. Correct any errors in the ID number field or upload a document that includes the ID number.
    case verificationDocumentIdNumberMismatch = "verification_document_id_number_mismatch"
    /// The company ID number was missing on the document. Upload a document that includes the ID number.
    case verificationDocumentIdNumberMissing = "verification_document_id_number_missing"
    /// The document was cropped or missing important information. Upload a complete scan of the document.
    case verificationDocumentIncomplete = "verification_document_incomplete"
    /// The uploaded file was not one of the valid document types. Ensure that the document follows the [guidelines for document uploads](https://stripe.com/docs/connect/identity-verification-api#acceptable-verification-documents) .
    case verificationDocumentInvalid = "verification_document_invalid"
    /// The issue or expiry date is missing on the document. Upload a document that includes the issue and expiry dates.
    case verificationDocumentIssueOrExpiryDateMissing = "verification_document_issue_or_expiry_date_missing"
    /// The document was identified as altered or falsified.
    case verificationDocumentManipulated = "verification_document_manipulated"
    /// The uploaded file was missing the back of the document. Upload a complete scan of the document.
    case verificationDocumentMissingBack = "verification_document_missing_back"
    /// The uploaded file was missing the front of the document. Upload a complete scan of the document.
    case verificationDocumentMissingFront = "verification_document_missing_front"
    /// The name on the document did not match the name on the account. Upload a document with a matching name or update the name on the account.
    case verificationDocumentNameMismatch = "verification_document_name_mismatch"
    /// The company name was missing on the document. Upload a document that includes the company name.
    case verificationDocumentNameMissing = "verification_document_name_missing"
    /// The nationality on the document did not match the person’s stated nationality. Update the person’s stated nationality, or upload a document that matches it.
    case verificationDocumentNationalityMismatch = "verification_document_nationality_mismatch"
    /// The document could not be read. Ensure that the document follows the [guidelines for document uploads](https://stripe.com/docs/connect/identity-verification-api#acceptable-verification-documents) .
    case verificationDocumentNotReadable = "verification_document_not_readable"
    /// A valid signature is missing on the document. Upload a document that includes a valid signature.
    case verificationDocumentNotSigned = "verification_document_not_signed"
    /// No document was uploaded. Upload the document again.
    case verificationDocumentNotUploaded = "verification_document_not_uploaded"
    /// The document was identified as altered or falsified
    case verificationDocumentPhotoMismatch = "verification_document_photo_mismatch"
    /// The uploaded file exceeded the 10 MB size limit. Resize the document and upload the new file.
    case verificationDocumentTooLarge = "verification_document_too_large"
    /// The provided document type was not accepted. Ensure that the document follows the [guidelines for document uploads](https://stripe.com/docs/connect/identity-verification-api#acceptable-verification-documents) .
    case verificationDocumentTypeNotSupported = "verification_document_type_not_supported"
    /// The address on the account could not be verified. Correct any errors in the address field or upload a document that includes the address.
    case verificationFailedAddressMatch = "verification_failed_address_match"
    /// The Importer Exporter Code (IEC) number could not be verified. Correct any errors in the company’s IEC number field. (India only)
    case verificationFailedBusinessIecNumber = "verification_failed_business_iec_number"
    /// The document could not be verified. Upload a document that includes the company name, ID number, and address fields.
    case verificationFailedDocumentMatch = "verification_failed_document_match"
    /// The company ID number on the account could not be verified. Correct any errors in the ID number field or upload a document that includes the ID number.
    case verificationFailedIdNumberMatch = "verification_failed_id_number_match"
    /// The person’s keyed-in identity information could not be verified. Correct any errors or upload a document that matches the identity fields (e.g., name and date of birth) entered.
    case verificationFailedKeyedIdentity = "verification_failed_keyed_identity"
    /// The keyed-in information on the account could not be verified. Correct any errors in the company name, ID number, or address fields. You can also upload a document that includes those fields.
    case verificationFailedKeyedMatch = "verification_failed_keyed_match"
    /// The company name on the account could not be verified. Correct any errors in the company name field or upload a document that includes the company name.
    case verificationFailedNameMatch = "verification_failed_name_match"
    /// We could not verify that the person resides at the provided address. The address must be a valid physical address where the individual resides and cannot be a P.O. Box.
    case verificationFailedResidentialAddress = "verification_failed_residential_address"
    /// The tax ID on the account cannot be verified by the IRS. Either correct any possible errors in the company name or tax ID, or upload a document that contains those fields.
    case verificationFailedTaxIdMatch = "verification_failed_tax_id_match"
    /// The tax ID on the account was not recognized by the IRS. Refer to the support article for newly-issued tax ID numbers.
    case verificationFailedTaxIdNotIssued = "verification_failed_tax_id_not_issued"
    /// Verification failed for an unknown reason. Correct any errors and resubmit the required fields.
    case verificationFailedOther = "verification_failed_other"
    /// We have identified owners that haven’t been added on the account. Add any missing owners to the account.
    case verificationMissingOwners = "verification_missing_owners"
    /// We have identified executives that haven’t been added on the account. Add any missing executives to the account.
    case verificationMissingExecutives = "verification_missing_executives"
    /// We have identified holding companies with significant percentage ownership. Upload a Memorandum of Association for each of the holding companies.
    case verificationRequiresAdditionalMemorandumOfAssociations = "verification_requires_additional_memorandum_of_associations"
    /// Underage. Age must be at least 18.
    case invalidDobAgeUnder18 = "invalid_dob_age_under_18"
}

public struct PersonFutureRequirements: Codable {
    /// Fields that are due and can be satisfied by providing the corresponding alternative fields instead.
    public var alternatives: [PersonRequirementsAlternative]?
    /// Fields that need to be collected to keep the person’s account enabled. If not collected by the account’s `current_deadline`, these fields appear in `past_due` as well, and the account is disabled.
    public var currentlyDue: [String]?
    /// The fields that are `currently_due` and need to be collected again because validation or verification failed for some reason.
    public var errors: [PersonRequirementsError]?
    /// Fields that need to be collected assuming all volume thresholds are reached. As fields are needed, they are moved to `currently_due` and the account’s `current_deadline` is set.
    public var eventuallyDue: [String]?
    /// Fields that weren’t collected by the account’s `current_deadline`. These fields need to be collected to enable payouts for the person’s account.
    public var pastDue: [String]?
    /// Fields that may become required depending on the results of verification or review. An empty array unless an asynchronous verification is pending. If verification fails, the fields in this array become required and move to `currently_due` or `past_due`.
    public var pendingVerification: [String]?
    
    public init(alternatives: [PersonRequirementsAlternative]? = nil,
                currentlyDue: [String]? = nil,
                errors: [PersonRequirementsError]? = nil,
                eventuallyDue: [String]? = nil,
                pastDue: [String]? = nil,
                pendingVerification: [String]? = nil) {
        self.alternatives = alternatives
        self.currentlyDue = currentlyDue
        self.errors = errors
        self.eventuallyDue = eventuallyDue
        self.pastDue = pastDue
        self.pendingVerification = pendingVerification
    }
}

public struct PersonVerification: Codable {
    /// A document showing address, either a passport, local ID card, or utility bill from a well-known utility company.
    public var additionalDocument: PersonVerificationDocument?
    /// A user-displayable string describing the verification state for the person. For example, this may say “Provided identity information could not be verified”.
    public var details: String?
    /// One of `document_address_mismatch`, `document_dob_mismatch`, `document_duplicate_type`, `document_id_number_mismatch`, `document_name_mismatch`, `document_nationality_mismatch`, `failed_keyed_identity`, or `failed_other`. A machine-readable code specifying the verification state for the person.
    public var detailsCode: PersonVerificationDetailsCode?
    /// An identifying document for the person, either a passport or local ID card.
    public var document: PersonVerificationDocument?
    /// The state of verification for the person. Possible values are `unverified`, `pending`, or `verified`.
    public var status: PersonVerificationStatus?
    
    public init(additionalDocument: PersonVerificationDocument? = nil,
                details: String? = nil,
                detailsCode: PersonVerificationDetailsCode? = nil,
                document: PersonVerificationDocument? = nil,
                status: PersonVerificationStatus? = nil) {
        self.additionalDocument = additionalDocument
        self.details = details
        self.detailsCode = detailsCode
        self.document = document
        self.status = status
    }
}

public enum PersonVerificationDetailsCode: String, Codable {
    case documentAddressMismatch = "document_address_mismatch"
    case documentDobMismatch = "document_dob_mismatch"
    case documentDuplicateType = "document_duplicate_type"
    case documentIdNumberMismatch = "document_id_number_mismatch"
    case documentNameMismatch = "document_name_mismatch"
    case documentNationalityMismatch = "document_nationality_mismatch"
    case failedKeyedIdentity = "failed_keyed_identity"
    case failedOther = "failed_other"
}

public struct PersonVerificationDocument: Codable {
    /// The back of a document returned by a file upload with a `purpose` value of `additional_verification`.
    @Expandable<File> public var back: String?
    /// A user-displayable string describing the verification state of this document. For example, if a document is uploaded and the picture is too fuzzy, this may say “Identity document is too unclear to read”.
    public var details: String?
    /// One of `document_corrupt`, `document_country_not_supported`, `document_expired`, `document_failed_copy`, `document_failed_other`, `document_failed_test_mode`, `document_fraudulent`, `document_failed_greyscale`, `document_incomplete`, `document_invalid`, `document_manipulated`, `document_missing_back`, `document_missing_front`, `document_not_readable`, `document_not_uploaded`, `document_photo_mismatch`, `document_too_large`, or `document_type_not_supported` . A machine-readable code specifying the verification state for this document.
    public var detailsCode: PersonVerificationDocumentDetailsCode?
    /// The front of a document returned by a file upload with a `purpose` value of `additional_verification`.
    @Expandable<File> public var front: String?
    
    public init(back: String? = nil,
                details: String? = nil,
                detailsCode: PersonVerificationDocumentDetailsCode? = nil,
                front: String? = nil) {
        self._back = Expandable(id: back)
        self.details = details
        self.detailsCode = detailsCode
        self._front = Expandable(id: front)
    }
}

public enum PersonVerificationDocumentDetailsCode: String, Codable {
    case documentCorrupt = "document_corrupt"
    case documentCountryNotSupported = "document_country_not_supported"
    case documentExpired = "document_expired"
    case documentFailedCopy = "document_failed_copy"
    case documentFailedOther = "document_failed_other"
    case documentFailedTestMode = "document_failed_test_mode"
    case documentFraudulent = "document_fraudulent"
    case documentFailedGreyscale = "document_failed_greyscale"
    case documentIncomplete = "document_incomplete"
    case documentInvalid = "document_invalid"
    case documentManipulated = "document_manipulated"
    case documentMissingBack = "document_missing_back"
    case documentMissingFront = "document_missing_front"
    case documentNotReadable = "document_not_readable"
    case documentNotUploaded = "document_not_uploaded"
    case documentPhotoMismatch = "document_photo_mismatch"
    case documentTooLarge = "document_too_large"
    case documentTypeNotSupported = "document_type_not_supported"
}

public enum PersonVerificationStatus: String, Codable {
    case unverified
    case pending
    case verified
}

public struct PersonsList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [Person]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [Person]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
