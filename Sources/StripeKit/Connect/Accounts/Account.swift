//
//  Account.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import Foundation

/// The [Account Object](https://stripe.com/docs/api/accounts/object)
public struct ConnectAccount: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// The business type.
    public var businessType: ConnectAccountBusinessType?
    /// A hash containing the set of capabilities that was requested for this account and their associated states. Keys may be `account`, `card_issuing`, `card_payments`, `cross_border_payouts_recipient`, `giropay`, `ideal`, `klarna`, `legacy_payments`, `masterpass`, `payouts`, `platform_payments`, `sofort`, or `visa_checkout`. Values may be active, inactive, or pending.
    public var capabilities: ConnectAccountCapablities?
    /// Information about the company or business. This field is null unless business_type is set to company.
    public var company: ConnectAccountCompany?
    /// The account’s country.
    public var country: String?
    /// The primary user’s email address.
    public var email: String?
    /// Information about the person represented by the account. This field is null unless business_type is set to individual.
    public var individual: Person?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Information about the requirements for the account, including what information needs to be collected, and by when.
    public var requirements: ConnectAccountRequirements?
    /// Details on the [acceptance of the Stripe Services Agreement](https://stripe.com/docs/connect/updating-accounts#tos-acceptance)
    public var tosAcceptance: ConnectAccountTOSAcceptance?
    /// The Stripe account type. Can be `standard`, `express`, or `custom`.
    public var type: ConnectAccountType?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Optional information related to the business.
    public var businessProfile: ConnectAccountBusinessProfile?
    /// Whether the account can create live charges.
    public var chargesEnabled: Bool?
    /// The controller of the account. This field is only available for Standard accounts.
    public var controller: ConnectAccountController?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// Three-letter ISO currency code representing the default currency for the account. This must be a currency that Stripe supports in the account’s country.
    public var defaultCurrency: Currency?
    /// Whether account details have been submitted. Standard accounts cannot receive payouts before this is true.
    public var detailsSubmitted: Bool?
    /// External accounts (bank accounts and debit cards) currently attached to this account
    public var externalAccounts: ConnectAccountExternalAccountsList?
    /// Information about the upcoming new requirements for the account, including what information needs to be collected, and by when.
    public var futureRequirements: ConnectAccountFutureRequirements?
    /// Whether Stripe can send payouts to this account.
    public var payoutsEnabled: Bool?
    /// Account options for customizing how the account functions within Stripe.
    public var settings: ConnectAccountSettings?
    
    public init(id: String,
                businessType: ConnectAccountBusinessType? = nil,
                capabilities: ConnectAccountCapablities? = nil,
                company: ConnectAccountCompany? = nil,
                country: String? = nil,
                email: String? = nil,
                individual: Person? = nil,
                metadata: [String : String]? = nil,
                requirements: ConnectAccountRequirements? = nil,
                tosAcceptance: ConnectAccountTOSAcceptance? = nil,
                type: ConnectAccountType? = nil,
                object: String,
                businessProfile: ConnectAccountBusinessProfile? = nil,
                chargesEnabled: Bool? = nil,
                controller: ConnectAccountController? = nil,
                created: Date? = nil,
                defaultCurrency: Currency? = nil,
                detailsSubmitted: Bool? = nil,
                externalAccounts: ConnectAccountExternalAccountsList? = nil,
                futureRequirements: ConnectAccountFutureRequirements? = nil,
                payoutsEnabled: Bool? = nil,
                settings: ConnectAccountSettings? = nil) {
        self.id = id
        self.businessType = businessType
        self.capabilities = capabilities
        self.company = company
        self.country = country
        self.email = email
        self.individual = individual
        self.metadata = metadata
        self.requirements = requirements
        self.tosAcceptance = tosAcceptance
        self.type = type
        self.object = object
        self.businessProfile = businessProfile
        self.chargesEnabled = chargesEnabled
        self.controller = controller
        self.created = created
        self.defaultCurrency = defaultCurrency
        self.detailsSubmitted = detailsSubmitted
        self.externalAccounts = externalAccounts
        self.futureRequirements = futureRequirements
        self.payoutsEnabled = payoutsEnabled
        self.settings = settings
    }
}

public struct ConnectAccountList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [ConnectAccount]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [ConnectAccount]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}

public struct ConnectAccountBusinessProfile: Codable {
    /// [The merchant category code for the account](https://stripe.com/docs/connect/setting-mcc). MCCs are used to classify businesses based on the goods or services they provide.
    public var mcc: String?
    /// The customer-facing business name.
    public var name: String?
    /// Internal-only description of the product sold or service provided by the business. It’s used by Stripe for risk and underwriting purposes.
    public var productDescription: String?
    /// A publicly available mailing address for sending support issues to.
    public var supportAddress: Address?
    /// A publicly available email address for sending support issues to.
    public var supportEmail: String?
    /// A publicly available phone number to call with support issues.
    public var supportPhone: String?
    /// A publicly available website for handling support issues.
    public var supportUrl: String?
    /// The business’s publicly available website.
    public var url: String?
    
    public init(mcc: String? = nil,
                name: String? = nil,
                productDescription: String? = nil,
                supportAddress: Address? = nil,
                supportEmail: String? = nil,
                supportPhone: String? = nil,
                supportUrl: String? = nil,
                url: String? = nil) {
        self.mcc = mcc
        self.name = name
        self.productDescription = productDescription
        self.supportAddress = supportAddress
        self.supportEmail = supportEmail
        self.supportPhone = supportPhone
        self.supportUrl = supportUrl
        self.url = url
    }
}

public enum ConnectAccountBusinessType: String, Codable {
    case individual
    case company
    case nonProfit = "non_profit"
    case governmentEntity = "government_entity"
}

public struct ConnectAccountCapablities: Codable {
    /// The status of the ACSS Direct Debits payments capability of the account, or whether the account can directly process ACSS Direct Debits charges.
    public var acssDebitPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the Affirm capability of the account, or whether the account can directly process Affirm charges.
    public var affirmPayments: ConnectAccountCapabilitiesStatus?
    
    /// The status of the Afterpay Clearpay capability of the account, or whether the account can directly process Afterpay Clearpay charges.
    public var afterpayClearpayPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the BECS Direct Debit (AU) payments capability of the account, or whether the account can directly process BECS Direct Debit (AU) charges.
    public var auBecsDebitPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the Bacs Direct Debits payments capability of the account, or whether the account can directly process Bacs Direct Debits charges.
    public var bacsDebitPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the Bancontact payments capability of the account, or whether the account can directly process Bancontact charges.
    public var bancontactPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the `customer_balance` payments capability of the account, or whether the account can directly process `customer_balance` charges.
    public var bankTransferPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the blik payments capability of the account, or whether the account can directly process blik charges.
    public var blikPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the boleto payments capability of the account, or whether the account can directly process boleto charges.
    public var boletoPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the card issuing capability of the account, or whether you can use Issuing to distribute funds on cards
    public var cardIssuing: ConnectAccountCapabilitiesStatus?
    /// The status of the card payments capability of the account, or whether the account can directly process credit and debit card charges.
    public var cardPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the Cartes Bancaires payments capability of the account, or whether the account can directly process Cartes Bancaires card charges in EUR currency.
    public var cartesBancairesPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the Cash App Pay capability of the account, or whether the account can directly process Cash App Pay payments.
    public var cashappPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the EPS payments capability of the account, or whether the account can directly process EPS charges.
    public var epsPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the FPX payments capability of the account, or whether the account can directly process FPX charges.
    public var fpxPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the giropay payments capability of the account, or whether the account can directly process giropay charges.
    public var giropayPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the GrabPay payments capability of the account, or whether the account can directly process GrabPay charges.
    public var grabpayPayments:ConnectAccountCapabilitiesStatus?
    /// The status of the iDEAL payments capability of the account, or whether the account can directly process iDEAL charges.
    public var idealPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the `india_international_payments` capability of the account, or whether the account can process international charges (non INR) in India.
    public var indiaInternationalPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the JCB payments capability of the account, or whether the account (Japan only) can directly process JCB credit card charges in JPY currency.
    public var jcbPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the Klarna payments capability of the account, or whether the account can directly process Klarna charges.
    public var klarnaPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the konbini payments capability of the account, or whether the account can directly process konbini charges.
    public var konbiniPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the legacy payments capability of the account.
    public var legacyPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the `link_payments` capability of the account, or whether the account can directly process Link charges.
    public var linkPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the OXXO payments capability of the account, or whether the account can directly process OXXO charges.
    public var oxxoPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the P24 payments capability of the account, or whether the account can directly process P24 charges.
    public var p24Payments: ConnectAccountCapabilitiesStatus?
    /// The status of the paynow payments capability of the account, or whether the account can directly process paynow charges.
    public var paynowPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the promptpay payments capability of the account, or whether the account can directly process promptpay charges.
    public var promptpayPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the SEPA Direct Debits payments capability of the account, or whether the account can directly process SEPA Direct Debits charges.
    public var sepaDebitPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the Sofort payments capability of the account, or whether the account can directly process Sofort charges.
    public var sofortPayments: ConnectAccountCapabilitiesStatus?
    /// The status of the tax reporting 1099-K (US) capability of the account.
    public var taxReportingUs1099K: ConnectAccountCapabilitiesStatus?
    /// The status of the tax reporting 1099-MISC (US) capability of the account.
    public var taxReportingUs1099Misc: ConnectAccountCapabilitiesStatus?
    /// The status of the transfers capability of the account, or whether your platform can transfer funds to the account.
    public var transfers: ConnectAccountCapabilitiesStatus?
    /// The status of the US bank account ACH payments capability of the account, or whether the account can directly process US bank account charges.
    public var usBankAccountAchPayments: ConnectAccountCapabilitiesStatus?
    
    public init(acssDebitPayments: ConnectAccountCapabilitiesStatus? = nil,
                affirmPayments: ConnectAccountCapabilitiesStatus? = nil,
                afterpayClearpayPayments: ConnectAccountCapabilitiesStatus? = nil,
                auBecsDebitPayments: ConnectAccountCapabilitiesStatus? = nil,
                bacsDebitPayments: ConnectAccountCapabilitiesStatus? = nil,
                bancontactPayments: ConnectAccountCapabilitiesStatus? = nil,
                bankTransferPayments: ConnectAccountCapabilitiesStatus? = nil,
                blikPayments: ConnectAccountCapabilitiesStatus? = nil,
                boletoPayments: ConnectAccountCapabilitiesStatus? = nil,
                cardIssuing: ConnectAccountCapabilitiesStatus? = nil,
                cardPayments: ConnectAccountCapabilitiesStatus? = nil,
                cartesBancairesPayments: ConnectAccountCapabilitiesStatus? = nil,
                cashappPayments: ConnectAccountCapabilitiesStatus? = nil,
                epsPayments: ConnectAccountCapabilitiesStatus? = nil,
                fpxPayments: ConnectAccountCapabilitiesStatus? = nil,
                giropayPayments: ConnectAccountCapabilitiesStatus? = nil,
                grabpayPayments: ConnectAccountCapabilitiesStatus? = nil,
                idealPayments: ConnectAccountCapabilitiesStatus? = nil,
                indiaInternationalPayments: ConnectAccountCapabilitiesStatus? = nil,
                jcbPayments: ConnectAccountCapabilitiesStatus? = nil,
                klarnaPayments: ConnectAccountCapabilitiesStatus? = nil,
                konbiniPayments: ConnectAccountCapabilitiesStatus? = nil,
                legacyPayments: ConnectAccountCapabilitiesStatus? = nil,
                linkPayments: ConnectAccountCapabilitiesStatus? = nil,
                oxxoPayments: ConnectAccountCapabilitiesStatus? = nil,
                p24Payments: ConnectAccountCapabilitiesStatus? = nil,
                paynowPayments: ConnectAccountCapabilitiesStatus? = nil,
                promptpayPayments: ConnectAccountCapabilitiesStatus? = nil,
                sepaDebitPayments: ConnectAccountCapabilitiesStatus? = nil,
                sofortPayments: ConnectAccountCapabilitiesStatus? = nil,
                taxReportingUs1099K: ConnectAccountCapabilitiesStatus? = nil,
                taxReportingUs1099Misc: ConnectAccountCapabilitiesStatus? = nil,
                transfers: ConnectAccountCapabilitiesStatus? = nil,
                usBankAccountAchPayments: ConnectAccountCapabilitiesStatus? = nil) {
        self.acssDebitPayments = acssDebitPayments
        self.affirmPayments = affirmPayments
        self.afterpayClearpayPayments = afterpayClearpayPayments
        self.auBecsDebitPayments = auBecsDebitPayments
        self.bacsDebitPayments = bacsDebitPayments
        self.bancontactPayments = bancontactPayments
        self.bankTransferPayments = bankTransferPayments
        self.blikPayments = blikPayments
        self.boletoPayments = boletoPayments
        self.cardIssuing = cardIssuing
        self.cardPayments = cardPayments
        self.cartesBancairesPayments = cartesBancairesPayments
        self.cashappPayments = cashappPayments
        self.epsPayments = epsPayments
        self.fpxPayments = fpxPayments
        self.giropayPayments = giropayPayments
        self.grabpayPayments = grabpayPayments
        self.idealPayments = idealPayments
        self.indiaInternationalPayments = indiaInternationalPayments
        self.jcbPayments = jcbPayments
        self.klarnaPayments = klarnaPayments
        self.konbiniPayments = konbiniPayments
        self.legacyPayments = legacyPayments
        self.linkPayments = linkPayments
        self.oxxoPayments = oxxoPayments
        self.p24Payments = p24Payments
        self.paynowPayments = paynowPayments
        self.promptpayPayments = promptpayPayments
        self.sepaDebitPayments = sepaDebitPayments
        self.sofortPayments = sofortPayments
        self.taxReportingUs1099K = taxReportingUs1099K
        self.taxReportingUs1099Misc = taxReportingUs1099Misc
        self.transfers = transfers
        self.usBankAccountAchPayments = usBankAccountAchPayments
    }
}

public enum ConnectAccountCapabilitiesStatus: String, Codable {
    case active
    case inactive
    case pending
}

public struct ConnectAccountController: Codable {
    /// `true` if the Connect application retrieving the resource controls the account and can therefore exercise platform controls. Otherwise, this field is null.
    public var isController: Bool?
    /// The controller type. Can be `application`, if a Connect application controls the account, or `account`, if the account controls itself.
    public var type: ConnectAccountControllerType?
    
    public init(isController: Bool? = nil, type: ConnectAccountControllerType? = nil) {
        self.isController = isController
        self.type = type
    }
}

public enum ConnectAccountControllerType: String, Codable {
    case application
    case account
}

public struct ConnectAccountCompany: Codable {
    /// The company’s primary address.
    public var address: Address?
    /// The Kana variation of the company’s primary address (Japan only).
    public var addressKana: AddressKana?
    /// The Kanji variation of the company’s primary address (Japan only).
    public var addressKanji: AddressKanji?
    /// Whether the company’s directors have been provided. This Boolean will be `true` if you’ve manually indicated that all directors are provided via the `directors_provided` parameter.
    public var directorsProvided: Bool?
    /// Whether the company’s executives have been provided. This Boolean will be `true` if you’ve manually indicated that all executives are provided via the `executives_provided` parameter, or if Stripe determined that sufficient executives were provided.
    public var executivesProvided: Bool?
    /// The export license ID number of the company, also referred as Import Export Code (India only).
    public var exportLicenseId: String?
    /// The purpose code to use for export transactions (India only).
    public var exportPurposeCode: String?
    /// The company’s legal name.
    public var name: String?
    /// The Kana variation of the company's legal name (Japan only).
    public var nameKana: String?
    /// The Kanji variation of the company's legal name (Japan only).
    public var nameKanji: String?
    /// Whether the company’s owners have been provided. This Boolean will be `true` if you’ve manually indicated that all owners are provided via the `owners_provided` parameter, or if Stripe determined that all owners were provided. Stripe determines ownership requirements using both the number of owners provided and their total percent ownership (calculated by adding the `percent_ownership` of each owner together).
    public var ownersProvided: Bool?
    /// This hash is used to attest that the beneficial owner information provided to Stripe is both current and correct.
    public var ownershipDeclaration: ConnectAccountCompanyOwnershipDeclaration?
    /// The company’s phone number (used for verification).
    public var phone: String?
    /// The category identifying the legal structure of the company or legal entity.
    public var structure: ConnectAccountCompanyStructure?
    /// Whether the company’s business ID number was provided.
    public var taxIdProvided: Bool?
    /// The jurisdiction in which the `tax_id` is registered (Germany-based companies only).
    public var taxIdRegistrar: String?
    /// Whether the company’s business VAT number was provided.
    public var vatIdProvided: Bool?
    /// Information on the verification state of the company.
    public var verification: ConnectAccountCompanyVerification?
    
    public init(address: Address? = nil,
                addressKana: AddressKana? = nil,
                addressKanji: AddressKanji? = nil,
                directorsProvided: Bool? = nil,
                executivesProvided: Bool? = nil,
                exportLicenseId: String? = nil,
                exportPurposeCode: String? = nil,
                name: String? = nil,
                nameKana: String? = nil,
                nameKanji: String? = nil,
                ownersProvided: Bool? = nil,
                ownershipDeclaration: ConnectAccountCompanyOwnershipDeclaration? = nil,
                phone: String? = nil,
                structure: ConnectAccountCompanyStructure? = nil,
                taxIdProvided: Bool? = nil,
                taxIdRegistrar: String? = nil,
                vatIdProvided: Bool? = nil,
                verification: ConnectAccountCompanyVerification? = nil) {
        self.address = address
        self.addressKana = addressKana
        self.addressKanji = addressKanji
        self.directorsProvided = directorsProvided
        self.executivesProvided = executivesProvided
        self.exportLicenseId = exportLicenseId
        self.exportPurposeCode = exportPurposeCode
        self.name = name
        self.nameKana = nameKana
        self.nameKanji = nameKanji
        self.ownersProvided = ownersProvided
        self.ownershipDeclaration = ownershipDeclaration
        self.phone = phone
        self.structure = structure
        self.taxIdProvided = taxIdProvided
        self.taxIdRegistrar = taxIdRegistrar
        self.vatIdProvided = vatIdProvided
        self.verification = verification
    }
}

public struct ConnectAccountCompanyOwnershipDeclaration: Codable {
    /// The Unix timestamp marking when the beneficial owner attestation was made.
    public var date: Date?
    /// The IP address from which the beneficial owner attestation was made.
    public var ip: String?
    /// The user-agent string from the browser where the beneficial owner attestation was made.
    public var userAgent: String?
    
    public init(date: Date? = nil,
                ip: String? = nil,
                userAgent: String? = nil) {
        self.date = date
        self.ip = ip
        self.userAgent = userAgent
    }
}

public struct ConnectAccountCompanyVerification: Codable {
    /// A document for the company.
    public var document: ConnectAccountCompanyVerificationDocument?
    
    public init(document: ConnectAccountCompanyVerificationDocument? = nil) {
        self.document = document
    }
}

public struct ConnectAccountCompanyVerificationDocument: Codable {
    /// The back of a document returned by a file upload with a `purpose` value of `additional_verification`.
    @Expandable<File> public var back: String?
    /// A user-displayable string describing the verification state of this document.
    public var details: String?
    /// One of `document_corrupt`, `document_expired`, `document_failed_copy`, `document_failed_greyscale`, `document_failed_other`, `document_failed_test_mode`, `document_fraudulent`, `document_incomplete`, `document_invalid`, `document_manipulated`, `document_not_readable`, `document_not_uploaded`, `document_type_not_supported`, or `document_too_large`. A machine-readable code specifying the verification state for this document.
    public var detailsCode: ConnectAccountCompanyVerificationDocumentDetailsCode?
    /// The front of a document returned by a file upload with a `purpose` value of `additional_verification`.
    @Expandable<File> public var front: String?
    
    public init(back: String? = nil,
                details: String? = nil,
                detailsCode: ConnectAccountCompanyVerificationDocumentDetailsCode? = nil,
                front: String? = nil) {
        self._back = Expandable(id: back)
        self.details = details
        self.detailsCode = detailsCode
        self._front = Expandable(id: front)
    }
}

public enum ConnectAccountCompanyVerificationDocumentDetailsCode: String, Codable {
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

public enum ConnectAccountCompanyStructure: String, Codable {
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

public struct ConnectAccountRequirements: Codable {
    ///Fields that are due and can be satisfied by providing the corresponding alternative fields instead.
    public var alternatives: [ConnectAccountRequirementsAlternative]?
    /// Date by which the fields in `currently_due` must be collected to keep the account enabled. These fields may disable the account sooner if the next threshold is reached before they are collected.
    public var currentDeadline: Date?
    /// Fields that need to be collected to keep the account enabled. If not collected by `current_deadline`, these fields appear in `past_due` as well, and the account is disabled.
    public var currentlyDue: [String]?
    /// If the account is disabled, this string describes why. Can be `requirements.past_due`, `requirements.pending_verification`, `listed`, `platform_paused`, `rejected.fraud`, `rejected.listed`, `rejected.terms_of_service`, `rejected.other`, `under_review`, or `other`.
    public var disabledReason: ConnectAccountRequirementsDisabledReason?
    /// Fields that are `currently_due` and need to be collected again because validation or verification failed.
    public var errors: [ConnectAccountRequirementsError]?
    /// Fields that need to be collected assuming all volume thresholds are reached. As they become required, they appear in `currently_due` as well, and `current_deadline` becomes set.
    public var eventuallyDue: [String]?
    /// Fields that weren’t collected by `current_deadline`. These fields need to be collected to enable the account.
    public var pastDue: [String]?
    /// Fields that may become required depending on the results of verification or review. Will be an empty array unless an asynchronous verification is pending. If verification fails, these fields move to `eventually_due`, `currently_due`, or `past_due`.
    public var pendingVerification: [String]?
    
    public init(alternatives: [ConnectAccountRequirementsAlternative]? = nil,
                currentDeadline: Date? = nil,
                currentlyDue: [String]? = nil,
                disabledReason: ConnectAccountRequirementsDisabledReason? = nil,
                errors: [ConnectAccountRequirementsError]? = nil,
                eventuallyDue: [String]? = nil,
                pastDue: [String]? = nil,
                pendingVerification: [String]? = nil) {
        self.alternatives = alternatives
        self.currentDeadline = currentDeadline
        self.currentlyDue = currentlyDue
        self.disabledReason = disabledReason
        self.errors = errors
        self.eventuallyDue = eventuallyDue
        self.pastDue = pastDue
        self.pendingVerification = pendingVerification
    }
}

public struct ConnectAccountRequirementsAlternative: Codable {
    /// Fields that can be provided to satisfy all fields in `original_fields_due`.
    public var alternativeFieldsDue: [String]?
    /// Fields that are due and can be satisfied by providing all fields in `alternative_fields_due`.
    public var originalFieldsDue: [String]?
    
    public init(alternativeFieldsDue: [String]? = nil, originalFieldsDue: [String]? = nil) {
        self.alternativeFieldsDue = alternativeFieldsDue
        self.originalFieldsDue = originalFieldsDue
    }
}

public enum ConnectAccountRequirementsDisabledReason: String, Codable {
    case requirementsPastDue = "requirements.past_due"
    case requirementsPendingVerification = "requirements.pending_verification"
    case listed
    case platformPaused = "platform_paused"
    case rejectedFraud = "rejected.fraud"
    case rejectedListed = "rejected.listed"
    case rejectedTermsOfService = "rejected.terms_of_service"
    case rejectedOther = "rejected.other"
    case underReview = "under_review"
    case other
}

public struct ConnectAccountRequirementsError: Codable {
    /// The code for the type of error.
    public var code: ConnectAccountRequirementsErrorCode?
    /// An informative message that indicates the error type and provides additional details about the error.
    public var reason: String?
    /// The specific user onboarding requirement field (in the requirements hash) that needs to be resolved.
    public var requirement: String?
    
    public init(code: ConnectAccountRequirementsErrorCode? = nil,
                reason: String? = nil,
                requirement: String? = nil) {
        self.code = code
        self.reason = reason
        self.requirement = requirement
    }
}

public enum ConnectAccountRequirementsErrorCode: String, Codable {
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
	/// Your product description must be at least 10 characters.
	case invalidProductDescriptionLength = "invalid_product_description_length"
	/// Your product description must be different from your URL.
	case invalidProductDescriptionUrlMatch = "invalid_product_description_url_match"
	/// Your statement descriptor must be between 5 and 22 characters.
	case invalidStatementDescriptorLength = "invalid_statement_descriptor_length"
	/// Your statement descriptor must be similar to your business name, legal entity name or URL.
	case invalidStatementDescriptorBusinessMismatch = "invalid_statement_descriptor_business_mismatch"
	/// Generic or well-known statement descriptors aren't supported.
	case invalidStatementDescriptorDenylisted = "invalid_statement_descriptor_denylisted"
	/// The statement descriptor prefix must be similar to the full statement descriptor.
	case invalidStatementDescriptorPrefixMismatch = "invalid_statement_descriptor_prefix_mismatch"
	/// Generic or well-known statement descriptor prefixes aren't supported.
	case invalidStatementDescriptorPrefixDenylisted = "invalid_statement_descriptor_prefix_denylisted"
	/// Generic or well-known business names aren't supported.
	case invalidCompanyNameDenylisted = "invalid_company_name_denylisted"
	/// Generic or well-known business names aren't supported.
	case invalidBusinessProfileNameDenylisted = "invalid_business_profile_name_denylisted"
	/// Business profile names must consist of recognizable words.
	case invalidBusinessProfileName = "invalid_business_profile_name"
	/// Person must be at least 13 years old.
	case invalidDobAgeUnderMinimum = "invalid_dob_age_under_minimum"
	/// Date of birth must be within in the last 120 years.
	case invalidDobAgeOverMaximum = "invalid_dob_age_over_maximum"
	/// The phone number doesn't seem to be valid. Make sure it's formatted correctly.
	case invalidPhoneNumber = "invalid_phone_number"
	/// Tax IDs must be a unique set of 9 numbers without dashes or other special characters.
	case invalidTaxIdFormat = "invalid_tax_id_format"
	/// Format as https://example.com
	case invalidUrlFormat = "invalid_url_format"
	/// Generic business URLs aren't supported.
	case invalidUrlDenylisted = "invalid_url_denylisted"
}

public struct ConnectAccountFutureRequirements: Codable {
    /// Fields that are due and can be satisfied by providing the corresponding alternative fields instead.
    public var alternatives: [ConnectAccountFutureRequirementsAlternative]?
    /// Date on which `future_requirements` merges with the main `requirements` hash and `future_requirements` becomes empty. After the transition, `currently_due` requirements may immediately become `past_due`, but the account may also be given a grace period depending on its enablement state prior to transitioning.
    public var currentDeadline: Date?
    /// Fields that need to be collected to keep the account enabled. If not collected by `future_requirements[current_deadline]`, these fields will transition to the main `requirements` hash.
    public var currentlyDue: [String]?
    /// This is typed as a string for consistency with `requirements.disabled_reason`, but it safe to assume `future_requirements.disabled_reason` is empty because fields in `future_requirements` will never disable the account.
    public var disabledReason: String?
    /// Fields that are `currently_due` and need to be collected again because validation or verification failed.
    public var errors: [ConnectAccountRequirementsError]?
    /// Fields that need to be collected assuming all volume thresholds are reached. As they become required, they appear in `currently_due` as well.
    public var eventuallyDue: [String]?
    /// Fields that weren’t collected by `requirements.current_deadline`. These fields need to be collected to enable the capability on the account. New fields will never appear here; `future_requirements.past_due` will always be a subset of `requirements.past_due`.
    public var pastDue: [String]?
    /// Fields that may become required depending on the results of verification or review. Will be an empty array unless an asynchronous verification is pending. If verification fails, these fields move to `eventually_due` or `currently_due`.
    public var pendingVerification: [String]?
    
    public init(alternatives: [ConnectAccountFutureRequirementsAlternative]? = nil,
                currentDeadline: Date? = nil,
                currentlyDue: [String]? = nil,
                disabledReason: String? = nil,
                errors: [ConnectAccountRequirementsError]? = nil,
                eventuallyDue: [String]? = nil,
                pastDue: [String]? = nil,
                pendingVerification: [String]? = nil) {
        self.alternatives = alternatives
        self.currentDeadline = currentDeadline
        self.currentlyDue = currentlyDue
        self.disabledReason = disabledReason
        self.errors = errors
        self.eventuallyDue = eventuallyDue
        self.pastDue = pastDue
        self.pendingVerification = pendingVerification
    }
}

public struct ConnectAccountFutureRequirementsAlternative: Codable {
    /// Fields that can be provided to satisfy all fields in `original_fields_due`.
    public var alternativeFieldsDue: [String]?
    /// Fields that are due and can be satisfied by providing all fields in `alternative_fields_due`.
    public var originalFieldsDue: [String]?
    
    public init(alternativeFieldsDue: [String]? = nil, originalFieldsDue: [String]? = nil) {
        self.alternativeFieldsDue = alternativeFieldsDue
        self.originalFieldsDue = originalFieldsDue
    }
}

public struct ConnectAccountSettings: Codable {
    /// Settings specific to Bacs Direct Debit on the account.
    public var bacsDebitPayments: ConnectAccountSettingsBacsDebitPayments?
    /// Settings used to apply the account’s branding to email receipts, invoices, Checkout, and other products.
    public var branding: ConnectAccountSettingsBranding?
    /// Settings specific to the account’s use of the Card Issuing product.
    public var cardIssuing: ConnectAccountSettingsCardIssuing?
    /// Settings specific to card charging on the account.
    public var cardPayments: ConnectAccountSettingsCardPayments?
    /// Settings used to configure the account within the Stripe dashboard.
    public var dashboard: ConnectAccountSettingsDashboard?
    /// Settings that apply across payment methods for charging on the account.
    public var payments: ConnectAccountSettingsPayments?
    /// Settings specific to the account’s payouts.
    public var payouts: ConnectAccountSettingsPayouts?
    /// Settings specific to SEPA Direct Debit on the account.
    public var sepaDebitPayments: ConnectAccountSettingsSepaDebitPayments?
    
    public init(bacsDebitPayments: ConnectAccountSettingsBacsDebitPayments? = nil,
                branding: ConnectAccountSettingsBranding? = nil,
                cardIssuing: ConnectAccountSettingsCardIssuing? = nil,
                cardPayments: ConnectAccountSettingsCardPayments? = nil,
                dashboard: ConnectAccountSettingsDashboard? = nil,
                payments: ConnectAccountSettingsPayments? = nil,
                payouts: ConnectAccountSettingsPayouts? = nil,
                sepaDebitPayments: ConnectAccountSettingsSepaDebitPayments? = nil) {
        self.bacsDebitPayments = bacsDebitPayments
        self.branding = branding
        self.cardIssuing = cardIssuing
        self.cardPayments = cardPayments
        self.dashboard = dashboard
        self.payments = payments
        self.payouts = payouts
        self.sepaDebitPayments = sepaDebitPayments
    }
}

public struct ConnectAccountSettingsBacsDebitPayments: Codable {
    /// The Bacs Direct Debit Display Name for this account. For payments made with Bacs Direct Debit, this will appear on the mandate, and as the statement descriptor.
    public var displayName: String?
    
    public init(displayName: String? = nil) {
        self.displayName = displayName
    }
}

public struct ConnectAccountSettingsBranding: Codable {
    /// (ID of a file upload) An icon for the account. Must be square and at least 128px x 128px.
    @Expandable<File> public var icon: String?
    /// (ID of a file upload) A logo for the account that will be used in Checkout instead of the icon and without the account’s name next to it if provided. Must be at least 128px x 128px.
    @Expandable<File> public var logo: String?
    /// A CSS hex color value representing the primary branding color for this account
    public var primaryColor: String?
    /// A CSS hex color value representing the secondary branding color for this account
    public var secondaryColor: String?
    
    public init(icon: String? = nil,
                logo: String? = nil,
                primaryColor: String? = nil,
                secondaryColor: String? = nil) {
        self._icon = Expandable(id: icon)
        self._logo = Expandable(id: logo)
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
}

public struct ConnectAccountSettingsCardIssuing: Codable {
    /// Details on the account’s acceptance of the Stripe Issuing Terms and Disclosures.
    public var tosAcceptance: ConnectAccountSettingsCardIssuingTOSAcceptance?
    
    public init(tosAcceptance: ConnectAccountSettingsCardIssuingTOSAcceptance? = nil) {
        self.tosAcceptance = tosAcceptance
    }
}

public struct ConnectAccountSettingsCardIssuingTOSAcceptance: Codable {
    /// The Unix timestamp marking when the account representative accepted the service agreement.
    public var date: Int?
    /// The IP address from which the account representative accepted the service agreement.
    public var ip: String?
    /// The user agent of the browser from which the account representative accepted the service agreement.
    public var userAgent: String?
    
    public init(date: Int? = nil,
                ip: String? = nil,
                userAgent: String? = nil) {
        self.date = date
        self.ip = ip
        self.userAgent = userAgent
    }
}

public struct ConnectAccountSettingsCardPayments: Codable {
    /// Automatically declines certain charge types regardless of whether the card issuer accepted or declined the charge.
    public var declineOn: ConnectAccountSettingsCardPaymentsDeclineOn?
    /// The default text that appears on credit card statements when a charge is made. This field prefixes any dynamic `statement_descriptor` specified on the charge. `statement_descriptor_prefix` is useful for maximizing descriptor space for the dynamic portion.
    public var statementDescriptorPrefix: String?
    /// The Kana variation of the default text that appears on credit card statements when a charge is made (Japan only). This field prefixes any dynamic `statement_descriptor_suffix_kana` specified on the charge. `statement_descriptor_prefix_kana` is useful for maximizing descriptor space for the dynamic portion.
    public var statementDescriptorPrefixKana: String?
    /// The Kanji variation of the default text that appears on credit card statements when a charge is made (Japan only). This field prefixes any dynamic `statement_descriptor_suffix_kanji` specified on the charge. `statement_descriptor_prefix_kanji` is useful for maximizing descriptor space for the dynamic portion.
    public var statementDescriptorPrefixKanji: String?
    
    public init(declineOn: ConnectAccountSettingsCardPaymentsDeclineOn? = nil,
                statementDescriptorPrefix: String? = nil,
                statementDescriptorPrefixKana: String? = nil,
                statementDescriptorPrefixKanji: String? = nil) {
        self.declineOn = declineOn
        self.statementDescriptorPrefix = statementDescriptorPrefix
        self.statementDescriptorPrefixKana = statementDescriptorPrefixKana
        self.statementDescriptorPrefixKanji = statementDescriptorPrefixKanji
    }
}

public struct ConnectAccountSettingsCardPaymentsDeclineOn: Codable {
    /// Whether Stripe automatically declines charges with an incorrect ZIP or postal code. This setting only applies when a ZIP or postal code is provided and they fail bank verification.
    public var avsFailure: Bool?
    /// Whether Stripe automatically declines charges with an incorrect CVC. This setting only applies when a CVC is provided and it fails bank verification.
    public var cvcFailure: Bool?
    
    public init(avsFailure: Bool? = nil, cvcFailure: Bool? = nil) {
        self.avsFailure = avsFailure
        self.cvcFailure = cvcFailure
    }
}

public struct ConnectAccountSettingsDashboard: Codable {
    /// The display name for this account. This is used on the Stripe Dashboard to differentiate between accounts.
    public var displayName: String?
    /// The timezone used in the Stripe Dashboard for this account. A list of possible time zone values is maintained at the [IANA Time Zone Database](http://www.iana.org/time-zones) .
    public var timezone: String?
    
    public init(displayName: String? = nil, timezone: String? = nil) {
        self.displayName = displayName
        self.timezone = timezone
    }
}

public struct ConnectAccountSettingsPayments: Codable {
    /// The default text that appears on credit card statements when a charge is made. This field prefixes any dynamic `statement_descriptor` specified on the charge.
    public var statementDescriptor: String?
    /// The Kana variation of the default text that appears on credit card statements when a charge is made (Japan only)
    public var statementDescriptorKana: String?
    /// The Kanji variation of the default text that appears on credit card statements when a charge is made (Japan only)
    public var statementDescriptorKanji: String?
    /// The Kana variation of the default text that appears on credit card statements when a charge is made (Japan only). This field prefixes any dynamic `statement_descriptor_suffix_kana` specified on the charge. `statement_descriptor_prefix_kana` is useful for maximizing descriptor space for the dynamic portion.
    public var statementDescriptorPrefixKana: String?
    /// The Kanji variation of the default text that appears on credit card statements when a charge is made (Japan only). This field prefixes any dynamic `statement_descriptor_suffix_kanji` specified on the charge. `statement_descriptor_prefix_kanji` is useful for maximizing descriptor space for the dynamic portion.
    public var statementDescriptorPrefixKanji: String?
    
    public init(statementDescriptor: String? = nil,
                statementDescriptorKana: String? = nil,
                statementDescriptorKanji: String? = nil,
                statementDescriptorPrefixKana: String? = nil,
                statementDescriptorPrefixKanji: String? = nil) {
        self.statementDescriptor = statementDescriptor
        self.statementDescriptorKana = statementDescriptorKana
        self.statementDescriptorKanji = statementDescriptorKanji
        self.statementDescriptorPrefixKana = statementDescriptorPrefixKana
        self.statementDescriptorPrefixKanji = statementDescriptorPrefixKanji
    }
}

public struct ConnectAccountSettingsPayouts: Codable {
    /// A Boolean indicating if Stripe should try to reclaim negative balances from an attached bank account. See our Understanding Connect Account Balances documentation for details. Default value is true for Express accounts and false for Custom accounts.
    public var debitNegativeBalances: Bool?
    /// Details on when funds from charges are available, and when they are paid out to an external account. See our Setting Bank and Debit Card Payouts documentation for details.
    public var schedule: ConnectAccountSettingsPayoutSchedule?
    /// The text that appears on the bank account statement for payouts. If not set, this defaults to the platform’s bank descriptor as set in the Dashboard.
    public var statementDescriptor: String?
    
    public init(debitNegativeBalances: Bool? = nil,
                schedule: ConnectAccountSettingsPayoutSchedule? = nil,
                statementDescriptor: String? = nil) {
        self.debitNegativeBalances = debitNegativeBalances
        self.schedule = schedule
        self.statementDescriptor = statementDescriptor
    }
}

public struct ConnectAccountSettingsPayoutSchedule: Codable {
    /// The number of days charges for the account will be held before being paid out.
    public var delayDays: Int?
    /// How frequently funds will be paid out. One of manual (payouts only created via API call), daily, weekly, or monthly.
    public var interval: ConnectAccountSettingsPayoutScheduleInterval?
    /// The day of the month funds will be paid out. Only shown if interval is monthly. Payouts scheduled between the 29th and 31st of the month are sent on the last day of shorter months.
    public var monthlyAnchor: Int?
    /// The day of the week funds will be paid out, of the style ‘monday’, ‘tuesday’, etc. Only shown if interval is weekly.
    public var weeklyAnchor: ConnectAccountSettingsPayoutScheduleWeeklyAnchor?
    
    public init(delayDays: Int? = nil,
                interval: ConnectAccountSettingsPayoutScheduleInterval? = nil,
                monthlyAnchor: Int? = nil,
                weeklyAnchor: ConnectAccountSettingsPayoutScheduleWeeklyAnchor? = nil) {
        self.delayDays = delayDays
        self.interval = interval
        self.monthlyAnchor = monthlyAnchor
        self.weeklyAnchor = weeklyAnchor
    }
}

public struct ConnectAccountSettingsSepaDebitPayments: Codable {
    /// SEPA creditor identifier that identifies the company making the payment.
    public var creditorId: String?
    
    public init(creditorId: String? = nil) {
        self.creditorId = creditorId
    }
}

public struct ConnectAccountTOSAcceptance: Codable {
    /// The Unix timestamp marking when the Stripe Services Agreement was accepted by the account representative
    public var date: Date?
    /// The IP address from which the Stripe Services Agreement was accepted by the account representative
    public var ip: String?
    /// The user agent of the browser from which the Stripe Services Agreement was accepted by the account representative
    public var userAgent: String?
    /// The user’s service agreement type
    public var serviceAgreement: String?
    
    public init(date: Date? = nil,
                ip: String? = nil,
                userAgent: String? = nil,
                serviceAgreement: String? = nil) {
        self.date = date
        self.ip = ip
        self.userAgent = userAgent
        self.serviceAgreement = serviceAgreement
    }
}

public enum ConnectAccountType: String, Codable {
    case standard
    case express
    case custom
}

public struct ConnectAccountLoginLink: Codable {
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// The URL for the login link.
    public var url: String?
    
    public init(object: String,
                created: Date,
                url: String? = nil) {
        self.object = object
        self.created = created
        self.url = url
    }
}

public enum ConnectAccountRejectReason: String, Codable {
    case fraud
    case termsOfService = "terms_of_service"
    case other
}

public enum ConnectAccountSettingsPayoutScheduleInterval: String, Codable {
    case manual
    case daily
    case weekly
    case monthly
}

public enum ConnectAccountSettingsPayoutScheduleWeeklyAnchor: String, Codable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}
