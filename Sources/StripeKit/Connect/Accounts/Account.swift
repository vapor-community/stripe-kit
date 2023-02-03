//
//  Account.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import Foundation

/// The [Account Object](https://stripe.com/docs/api/accounts/object)
public struct StripeConnectAccount: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Optional information related to the business.
    public var businessProfile: StripeConnectAccountBusinessProfile?
    /// The business type.
    public var businessType: StripeConnectAccountBusinessType?
    /// A hash containing the set of capabilities that was requested for this account and their associated states. Keys may be `account`, `card_issuing`, `card_payments`, `cross_border_payouts_recipient`, `giropay`, `ideal`, `klarna`, `legacy_payments`, `masterpass`, `payouts`, `platform_payments`, `sofort`, or `visa_checkout`. Values may be active, inactive, or pending.
    public var capabilities: StripeConnectAccountCapablities?
    /// Whether the account can create live charges.
    public var chargesEnabled: Bool?
    /// The controller of the account. This field is only available for Standard accounts.
    public var controller: StripeConnectAccountController?
    /// Information about the company or business. This field is null unless business_type is set to company.
    public var company: StripeConnectAccountCompany?
    /// The account’s country.
    public var country: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// Three-letter ISO currency code representing the default currency for the account. This must be a currency that Stripe supports in the account’s country.
    public var defaultCurrency: Currency?
    /// Whether account details have been submitted. Standard accounts cannot receive payouts before this is true.
    public var detailsSubmitted: Bool?
    /// The primary user’s email address.
    public var email: String?
    /// External accounts (bank accounts and debit cards) currently attached to this account
    public var externalAccounts: StripeExternalAccountsList?
    /// Information about the person represented by the account. This field is null unless business_type is set to individual.
    public var individual: StripePerson?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Whether Stripe can send payouts to this account.
    public var payoutsEnabled: Bool?
    /// Information about the requirements for the account, including what information needs to be collected, and by when.
    public var requirements: StripeConnectAccountRequirements?
    /// Account options for customizing how the account functions within Stripe.
    public var settings: StripeConnectAccountSettings?
    /// Details on the [acceptance of the Stripe Services Agreement](https://stripe.com/docs/connect/updating-accounts#tos-acceptance)
    public var tosAcceptance: StripeConnectAccountTOSAcceptance?
    /// The Stripe account type. Can be `standard`, `express`, or `custom`.
    public var type: StripeConnectAccountType?
}

public struct StripeConnectAccountList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeConnectAccount]?
}

public struct StripeConnectAccountBusinessProfile: Codable {
    /// The merchant category code for the account. MCCs are used to classify businesses based on the goods or services they provide.
    public var mcc: String?
    /// The customer-facing business name.
    public var name: String?
    /// Internal-only description of the product sold or service provided by the business. It’s used by Stripe for risk and underwriting purposes.
    public var productDescription: String?
    /// A publicly available mailing address for sending support issues to.
    public var supportAddress: StripeAddress?
    /// A publicly available email address for sending support issues to.
    public var supportEmail: String?
    /// A publicly available phone number to call with support issues.
    public var supportPhone: String?
    /// A publicly available website for handling support issues.
    public var supportUrl: String?
    /// The business’s publicly available website.
    public var url: String?
}

public enum StripeConnectAccountBusinessType: String, Codable {
    case individual
    case company
    case nonProfit = "non_profit"
    case governmentEntity = "government_entity"
}

public struct StripeConnectAccountCapablities: Codable {
    /// The status of the ACSS Direct Debits payments capability of the account, or whether the account can directly process ACSS Direct Debits charges.
    public var acssDebitPayments: StripeConnectAccountCapabilitiesStatus?
    /// The status of the Afterpay Clearpay capability of the account, or whether the account can directly process Afterpay Clearpay charges.
    public var afterpayClearpayPayments: StripeConnectAccountCapabilitiesStatus?
    /// The status of the BECS Direct Debit (AU) payments capability of the account, or whether the account can directly process BECS Direct Debit (AU) charges.
    public var auBecsDebitPayments: StripeConnectAccountCapabilitiesStatus?
    /// The status of the Bacs Direct Debits payments capability of the account, or whether the account can directly process Bacs Direct Debits charges.
    public var bacsDebitPayments: StripeConnectAccountCapabilitiesStatus?
    /// The status of the Bancontact payments capability of the account, or whether the account can directly process Bancontact charges.
    public var bancontactPayments: StripeConnectAccountCapabilitiesStatus?
    /// The status of the card issuing capability of the account, or whether you can use Issuing to distribute funds on cards
    public var cardIssuing: StripeConnectAccountCapabilitiesStatus?
    /// The status of the card payments capability of the account, or whether the account can directly process credit and debit card charges.
    public var cardPayments: StripeConnectAccountCapabilitiesStatus?
    /// The status of the Cartes Bancaires payments capability of the account, or whether the account can directly process Cartes Bancaires card charges in EUR currency.
    public var cartesBancairesPayments: StripeConnectAccountCapabilitiesStatus?
    /// The status of the EPS payments capability of the account, or whether the account can directly process EPS charges.
    public var epsPayments: StripeConnectAccountCapabilitiesStatus?
    /// The status of the FPX payments capability of the account, or whether the account can directly process FPX charges.
    public var fpxPayments: StripeConnectAccountCapabilitiesStatus?
    /// The status of the giropay payments capability of the account, or whether the account can directly process giropay charges.
    public var giropayPayments: StripeConnectAccountCapabilitiesStatus?
    /// The status of the GrabPay payments capability of the account, or whether the account can directly process GrabPay charges.
    public var grabpayPayments:StripeConnectAccountCapabilitiesStatus?
    /// The status of the iDEAL payments capability of the account, or whether the account can directly process iDEAL charges.
    public var idealPayments: StripeConnectAccountCapabilitiesStatus?
    /// The status of the JCB payments capability of the account, or whether the account (Japan only) can directly process JCB credit card charges in JPY currency.
    public var jcbPayments: StripeConnectAccountCapabilitiesStatus?
    /// The status of the legacy payments capability of the account.
    public var legacyPayments: StripeConnectAccountCapabilitiesStatus?
    /// The status of the OXXO payments capability of the account, or whether the account can directly process OXXO charges.
    public var oxxoPayments: StripeConnectAccountCapabilitiesStatus?
    /// The status of the P24 payments capability of the account, or whether the account can directly process P24 charges.
    public var p24Payments: StripeConnectAccountCapabilitiesStatus?
    /// The status of the SEPA Direct Debits payments capability of the account, or whether the account can directly process SEPA Direct Debits charges.
    public var sepaDebitPayments: StripeConnectAccountCapabilitiesStatus?
    /// The status of the Sofort payments capability of the account, or whether the account can directly process Sofort charges.
    public var sofortPayments: StripeConnectAccountCapabilitiesStatus?
    /// The status of the tax reporting 1099-K (US) capability of the account.
    public var taxReportingUs1099K: StripeConnectAccountCapabilitiesStatus?
    /// The status of the tax reporting 1099-MISC (US) capability of the account.
    public var taxReportingUs1099Misc: StripeConnectAccountCapabilitiesStatus?
    /// The status of the transfers capability of the account, or whether your platform can transfer funds to the account.
    public var transfers: StripeConnectAccountCapabilitiesStatus?
}

public enum StripeConnectAccountCapabilitiesStatus: String, Codable {
    case active
    case inactive
    case pending
}

public struct StripeConnectAccountController: Codable {
    /// `true` if the Connect application retrieving the resource controls the account and can therefore exercise platform controls. Otherwise, this field is null.
    public var isController: Bool?
    /// The controller type. Can be `application`, if a Connect application controls the account, or `account`, if the account controls itself.
    public var type: StripeConnectAccountControllerType?
}

public enum StripeConnectAccountControllerType: String, Codable {
    case application
    case account
}

public struct StripeConnectAccountCompany: Codable {
    /// The company’s primary address.
    public var address: StripeAddress?
    /// The Kana variation of the company’s primary address (Japan only).
    public var addressKana: StripeAddressKana?
    /// The Kanji variation of the company’s primary address (Japan only).
    public var addressKanji: StripeAddressKanji?
    /// Whether the company’s directors have been provided. This Boolean will be `true` if you’ve manually indicated that all directors are provided via the `directors_provided` parameter.
    public var directorsProvided: Bool?
    /// Whether the company’s executives have been provided. This Boolean will be `true` if you’ve manually indicated that all executives are provided via the `executives_provided` parameter, or if Stripe determined that sufficient executives were provided.
    public var executivesProvided: Bool?
    /// The company’s legal name.
    public var name: String?
    /// The Kana variation of the company's legal name (Japan only).
    public var nameKana: String?
    /// The Kanji variation of the company's legal name (Japan only).
    public var nameKanji: String?
    /// Whether the company’s owners have been provided. This Boolean will be `true` if you’ve manually indicated that all owners are provided via the `owners_provided` parameter, or if Stripe determined that all owners were provided. Stripe determines ownership requirements using both the number of owners provided and their total percent ownership (calculated by adding the `percent_ownership` of each owner together).
    public var ownersProvided: Bool?
    /// This hash is used to attest that the beneficial owner information provided to Stripe is both current and correct.
    public var ownershipDeclaration: StripeConnectAccountCompanyOwnershipDeclaration?
    /// The company’s phone number (used for verification).
    public var phone: String?
    /// The category identifying the legal structure of the company or legal entity.
    public var structure: StripeConnectAccountCompanyStructure?
    /// Whether the company’s business ID number was provided.
    public var taxIdProvided: Bool?
    /// The jurisdiction in which the tax_id is registered (Germany-based companies only).
    public var taxIdRegistrar: String?
    /// Whether the company’s business VAT number was provided.
    public var vatIdProvided: Bool?
    /// Information on the verification state of the company.
    public var verification: StripeConnectAccountCompanyVerification?
}

public struct StripeConnectAccountCompanyOwnershipDeclaration: Codable {
    /// The Unix timestamp marking when the beneficial owner attestation was made.
    public var date: Date?
    /// The IP address from which the beneficial owner attestation was made.
    public var ip: String?
    /// The user-agent string from the browser where the beneficial owner attestation was made.
    public var userAgent: String?
}

public struct StripeConnectAccountCompanyVerification: Codable {
    /// A document for the company.
    public var document: StripeConnectAccountCompanyVerificationDocument?
}

public struct StripeConnectAccountCompanyVerificationDocument: Codable {
    /// The back of a document returned by a file upload with a `purpose` value of `additional_verification`.
    @Expandable<StripeFile> public var back: String?
    /// A user-displayable string describing the verification state of this document.
    public var details: String?
    /// One of `document_corrupt`, `document_expired`, `document_failed_copy`, `document_failed_greyscale`, `document_failed_other`, `document_failed_test_mode`, `document_fraudulent`, `document_incomplete`, `document_invalid`, `document_manipulated`, `document_not_readable`, `document_not_uploaded`, `document_type_not_supported`, or `document_too_large`. A machine-readable code specifying the verification state for this document.
    public var detailsCode: StripeConnectAccountCompanyVerificationDocumentDetailsCode?
    /// The front of a document returned by a file upload with a `purpose` value of `additional_verification`.
    @Expandable<StripeFile> public var front: String?
}

public enum StripeConnectAccountCompanyVerificationDocumentDetailsCode: String, Codable {
    case documentCorrupt = "document_corrupt"
    case documentExpired = "document_expired"
    case documentFailedCopy = "document_failed_copy"
    case documentFailedGreyscale = "document_failed_greyscale"
    case documentFailedOther = "document_failed_other"
    case documentFailedTestMode = "document_failed_test_mode"
    case documentFraudulent = "document_fraudulent"
    case documentIncomplete = "document_incomplete"
    case documentInvalid = "document_invalid"
    case documentManipulated = "document_manipulated"
    case documentNotReadable = "document_not_readable"
    case documentNotUploaded = "document_not_uploaded"
    case documentTypeNotSupported = "document_type_not_supported"
    case documentTooLarge = "document_too_large"
}

public enum StripeConnectAccountCompanyStructure: String, Codable {
    case governmentInstrumentality = "government_instrumentality"
    case governmentalUnit = "governmental_unit"
    case incorporatedNonProfit = "incorporated_non_profit"
    case limitedLiabilityPartnership = "limited_liability_partnership"
    case multiMemberLlc = "multi_member_llc"
    case privateCompany = "private_company"
    case privateCorporation = "private_corporation"
    case privatePartnership = "private_partnership"
    case publicCompany = "public_company"
    case publicCorporation = "public_corporation"
    case publicPartnership = "public_partnership"
    case singleMemberLlc = "single_member_llc"
    case soleProprietorship = "sole_proprietorship"
    case taxExemptGovernmentInstrumentality = "tax_exempt_government_instrumentality"
    case unincorporatedAssociation = "unincorporated_association"
    case unincorporatedNonProfit = "unincorporated_non_profit"
    case freeZoneLLC = "free_zone_llc"
    case soleEstablishment = "sole_establishment"
    case freeZoneEstablishment = "free_zone_establishment"
    case llc
}

public struct StripeConnectAccountRequirements: Codable {
    /// Date by which the fields in `currently_due` must be collected to keep the account enabled. These fields may disable the account sooner if the next threshold is reached before they are collected.
    public var currentDeadline: Date?
    /// Fields that need to be collected to keep the account enabled. If not collected by `current_deadline`, these fields appear in `past_due` as well, and the account is disabled.
    public var currentlyDue: [String]?
    /// If the account is disabled, this string describes why. Can be `requirements.past_due`, `requirements.pending_verification`, `listed`, `platform_paused`, `rejected.fraud`, `rejected.listed`, `rejected.terms_of_service`, `rejected.other`, `under_review`, or `other`.
    public var disabledReason: StripeConnectAccountRequirementsDisabledReason?
    /// Fields that are `currently_due` and need to be collected again because validation or verification failed.
    public var errors: [StripeConnectAccountRequirementsError]?
    /// Fields that need to be collected assuming all volume thresholds are reached. As they become required, they appear in `currently_due` as well, and `current_deadline` becomes set.
    public var eventuallyDue: [String]?
    /// Fields that weren’t collected by `current_deadline`. These fields need to be collected to enable the account.
    public var pastDue: [String]?
    /// Fields that may become required depending on the results of verification or review. Will be an empty array unless an asynchronous verification is pending. If verification fails, these fields move to `eventually_due`, `currently_due`, or `past_due`.
    public var pendingVerification: [String]?
}

public enum StripeConnectAccountRequirementsDisabledReason: String, Codable {
    case requirementsPastDue = "requirements.past_due"
    case requirementsPendingVerification = "requirements.pending_verification"
    case rejectedFraud = "rejected.fraud"
    case rejectedTermsOfService = "rejected.terms_of_service"
    case rejectedListed = "rejected.listed"
    case rejectedOther = "rejected.other"
    case listed
    case underReview = "under_review"
    case other
}

public struct StripeConnectAccountRequirementsError: Codable {
    /// The code for the type of error.
    public var code: StripeConnectAccountRequirementsErrorCode?
    /// An informative message that indicates the error type and provides additional details about the error.
    public var reason: String?
    /// The specific user onboarding requirement field (in the requirements hash) that needs to be resolved.
    public var requirement: String?
}

public enum StripeConnectAccountRequirementsErrorCode: String, Codable {
    /// The combination of the city, state, and postal code in the provided address could not be validated.
    case invalidAddressCityStatePostalCode = "invalid_address_city_state_postal_code"
    /// The street name and/or number for the provided address could not be validated.
    case invalidStreetAddress = "invalid_street_address"
    /// An invalid value was provided for the related field. This is a general error code.
    case invalidValueOther = "invalid_value_other"
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
}

public struct StripeConnectAccountSettings: Codable {
    /// Settings specific to Bacs Direct Debit on the account.
    public var bacsDebitPayments: StripeConnectAccountSettingsBacsDebitPayments?
    /// Settings used to apply the account’s branding to email receipts, invoices, Checkout, and other products.
    public var branding: StripeConnectAccountSettingsBranding?
    /// Settings specific to the account’s use of the Card Issuing product.
    public var cardIssuing: StripeConnectAccountSettingsCardIssuing?
    /// Settings specific to card charging on the account.
    public var cardPayments: StripeConnectAccountSettingsCardPayments?
    /// Settings used to configure the account within the Stripe dashboard.
    public var dashboard: StripeConnectAccountSettingsDashboard?
    /// Settings that apply across payment methods for charging on the account.
    public var payments: StripeConnectAccountSettingsPayments?
    /// Settings specific to the account’s payouts.
    public var payouts: StripeConnectAccountSettingsPayouts?
    /// Settings specific to SEPA Direct Debit on the account.
    public var sepaDebitPayments: StripeConnectAccountSettingsSepaDebitPayments?
}

public struct StripeConnectAccountSettingsBacsDebitPayments: Codable {
    /// The Bacs Direct Debit Display Name for this account. For payments made with Bacs Direct Debit, this will appear on the mandate, and as the statement descriptor.
    public var displayName: String?
}

public struct StripeConnectAccountSettingsBranding: Codable {
    /// (ID of a file upload) An icon for the account. Must be square and at least 128px x 128px.
    @Expandable<StripeFile> public var icon: String?
    /// (ID of a file upload) A logo for the account that will be used in Checkout instead of the icon and without the account’s name next to it if provided. Must be at least 128px x 128px.
    @Expandable<StripeFile> public var logo: String?
    /// A CSS hex color value representing the primary branding color for this account
    public var primaryColor: String?
    /// A CSS hex color value representing the secondary branding color for this account
    public var secondaryColor: String?
}

public struct StripeConnectAccountSettingsCardIssuing: Codable {
    /// Details on the account’s acceptance of the Stripe Issuing Terms and Disclosures.
    public var tosAcceptance: StripeConnectAccountSettingsCardIssuingTOSAcceptance?
}

public struct StripeConnectAccountSettingsCardIssuingTOSAcceptance: Codable {
    /// The Unix timestamp marking when the account representative accepted the service agreement.
    public var date: Int?
    /// The IP address from which the account representative accepted the service agreement.
    public var ip: String?
    /// The user agent of the browser from which the account representative accepted the service agreement.
    public var userAgent: String?
}

public struct StripeConnectAccountSettingsCardPayments: Codable {
    /// Automatically declines certain charge types regardless of whether the card issuer accepted or declined the charge.
    public var declineOn: StripeConnectAccountSettingsCardPaymentsDeclineOn?
    /// The default text that appears on credit card statements when a charge is made. This field prefixes any dynamic statement_descriptor specified on the charge. statement_descriptor_prefix is useful for maximizing descriptor space for the dynamic portion.
    public var statementDescriptorPrefix: String?
}

public struct StripeConnectAccountSettingsCardPaymentsDeclineOn: Codable {
    /// Whether Stripe automatically declines charges with an incorrect ZIP or postal code. This setting only applies when a ZIP or postal code is provided and they fail bank verification.
    public var avsFailure: Bool?
    /// Whether Stripe automatically declines charges with an incorrect CVC. This setting only applies when a CVC is provided and it fails bank verification.
    public var cvcFailure: Bool?
}

public struct StripeConnectAccountSettingsDashboard: Codable {
    /// The display name for this account. This is used on the Stripe Dashboard to differentiate between accounts.
    public var displayName: String?
    /// The timezone used in the Stripe Dashboard for this account. A list of possible time zone values is maintained at the [IANA Time Zone Database](http://www.iana.org/time-zones) .
    public var timezone: String?
}

public struct StripeConnectAccountSettingsPayments: Codable {
    /// The default text that appears on credit card statements when a charge is made. This field prefixes any dynamic `statement_descriptor` specified on the charge.
    public var statementDescriptor: String?
    /// The Kana variation of the default text that appears on credit card statements when a charge is made (Japan only)
    public var statementDescriptorKana: String?
    /// The Kanji variation of the default text that appears on credit card statements when a charge is made (Japan only)
    public var statementDescriptorKanji: String?
}

public struct StripeConnectAccountSettingsPayouts: Codable {
    /// A Boolean indicating if Stripe should try to reclaim negative balances from an attached bank account. See our Understanding Connect Account Balances documentation for details. Default value is true for Express accounts and false for Custom accounts.
    public var debitNegativeBalances: Bool?
    /// Details on when funds from charges are available, and when they are paid out to an external account. See our Setting Bank and Debit Card Payouts documentation for details.
    public var schedule: StripeConnectAccountSettingsPayoutSchedule?
    /// The text that appears on the bank account statement for payouts. If not set, this defaults to the platform’s bank descriptor as set in the Dashboard.
    public var statementDescriptor: String?
}

public struct StripeConnectAccountSettingsPayoutSchedule: Codable {
    /// The number of days charges for the account will be held before being paid out.
    public var delayDays: Int?
    /// How frequently funds will be paid out. One of manual (payouts only created via API call), daily, weekly, or monthly.
    public var interval: StripeConnectAccountSettingsPayoutScheduleInterval?
    /// The day of the month funds will be paid out. Only shown if interval is monthly. Payouts scheduled between the 29th and 31st of the month are sent on the last day of shorter months.
    public var monthlyAnchor: Int?
    /// The day of the week funds will be paid out, of the style ‘monday’, ‘tuesday’, etc. Only shown if interval is weekly.
    public var weeklyAnchor: StripeConnectAccountSettingsPayoutScheduleWeeklyAnchor?
}

public struct StripeConnectAccountSettingsSepaDebitPayments: Codable {
    /// SEPA creditor identifier that identifies the company making the payment.
    public var creditorId: String?
}

public struct StripeConnectAccountTOSAcceptance: Codable {
    /// The Unix timestamp marking when the Stripe Services Agreement was accepted by the account representative
    public var date: Date?
    /// The IP address from which the Stripe Services Agreement was accepted by the account representative
    public var ip: String?
    /// The user agent of the browser from which the Stripe Services Agreement was accepted by the account representative
    public var userAgent: String?
    /// The user’s service agreement type
    public var serviceAgreement: String?
}

public enum StripeConnectAccountType: String, Codable {
    case standard
    case express
    case custom
}

public struct StripeConnectAccountLoginLink: Codable {
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The URL for the login link.
    public var url: String?
}

public enum StripeConnectAccountRejectReason: String, Codable {
    case fraud
    case termsOfService = "terms_of_service"
    case other
}

public enum StripeConnectAccountSettingsPayoutScheduleInterval: String, Codable {
    case manual
    case daily
    case weekly
    case monthly
}

public enum StripeConnectAccountSettingsPayoutScheduleWeeklyAnchor: String, Codable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}
