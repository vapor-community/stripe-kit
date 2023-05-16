//
//  Cardholder.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/21/19.
//

import Foundation

/// The [Cardholder object](https://stripe.com/docs/api/issuing/cardholders/object)
public struct Cardholder: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// The cardholder’s billing address.
    public var billing: CardholderBilling?
    /// The cardholder’s email address.
    public var email: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// The cardholder’s name. This will be printed on cards issued to them.
    public var name: String?
    /// The cardholder’s phone number.
    public var phoneNumber: String?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// One of `individual` or `business_entity`.
    public var type: CardholderType?
    /// Additional information about a business_entity cardholder.
    public var company: CardholderCompany?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// Additional information about an individual cardholder.
    public var individual: CardholderIndividual?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Information about verification requirements for the cardholder, including what information needs to be collected.
    public var requirements: CardholderAuthorizationRequirements?
    /// Rules that control spending across this cardholder’s cards. Refer to our documentation for more details.
    public var spendingControls: CardholderSpendingControls?
    /// Specifies whether to permit authorizations on this cardholder’s cards.
    public var status: CardholderStatus?
    
    public init(id: String,
                billing: CardholderBilling? = nil,
                email: String? = nil,
                metadata: [String : String]? = nil,
                name: String? = nil,
                phoneNumber: String? = nil,
                object: String,
                type: CardholderType? = nil,
                company: CardholderCompany? = nil,
                created: Date,
                individual: CardholderIndividual? = nil,
                livemode: Bool? = nil,
                requirements: CardholderAuthorizationRequirements? = nil,
                spendingControls: CardholderSpendingControls? = nil,
                status: CardholderStatus? = nil) {
        self.id = id
        self.billing = billing
        self.email = email
        self.metadata = metadata
        self.name = name
        self.phoneNumber = phoneNumber
        self.object = object
        self.type = type
        self.company = company
        self.created = created
        self.individual = individual
        self.livemode = livemode
        self.requirements = requirements
        self.spendingControls = spendingControls
        self.status = status
    }
}

public struct CardholderSpendingControls: Codable {
    /// Array of strings containing categories of authorizations to allow. All other categories will be blocked. Cannot be set with `blocked_categories`.
    public var allowedCategories: [String]?
    /// Array of strings containing categories of authorizations to decline. All other categories will be allowed. Cannot be set with `allowed_categories`.
    public var blockedCategories: [String]?
    /// Limit spending with amount-based rules that apply across this cardholder’s cards.
    public var spendingLimits: [CardholderSpendingControlSpendingLimit]?
    /// Currency of the amounts within `spending_limits`.
    public var spendingLimitsCurrency: Currency?
    
    public init(allowedCategories: [String]? = nil,
                blockedCategories: [String]? = nil,
                spendingLimits: [CardholderSpendingControlSpendingLimit]? = nil,
                spendingLimitsCurrency: Currency? = nil) {
        self.allowedCategories = allowedCategories
        self.blockedCategories = blockedCategories
        self.spendingLimits = spendingLimits
        self.spendingLimitsCurrency = spendingLimitsCurrency
    }
}

public struct CardholderSpendingControlSpendingLimit: Codable {
    /// Maximum amount allowed to spend per interval. This amount is in the card’s currency and in the smallest currency unit.
    public var amount: Int?
    /// Array of strings containing categories this limit applies to. Omitting this field will apply the limit to all categories.
    public var categories: [String]?
    /// Interval (or event) to which the amount applies.
    public var interval: CardholderSpendingControlSpendingLimitInterval?
}

public enum CardholderSpendingControlSpendingLimitInterval: String, Codable {
    /// Limit applies to each authorization.
    case perAuthorization = "per_authorization"
    /// Limit applies to a day, starting at midnight UTC.
    case daily
    /// Limit applies to a week, starting on Sunday at midnight UTC.
    case weekly
    /// Limit applies to a month, starting on the 1st.
    case monthly
    /// Limit applies to a year, starting on January 1st.
    case yearly
    /// Limit applies to all transactions.
    case allTime = "all_time"
}

public struct CardholderBilling: Codable {
    /// The cardholder’s billing address.
    public var address: Address?
    
    public init(address: Address? = nil) {
        self.address = address
    }
}

public struct CardholderCompany: Codable {
    /// Whether the company’s business ID number was provided.
    public var taxIdProvided: Bool?
    
    public init(taxIdProvided: Bool? = nil) {
        self.taxIdProvided = taxIdProvided
    }
}

public struct CardholderIndividual: Codable {
    ///Information related to the `card_issuing` program for this cardholder.
    public var cardIssuing: CardholderIndividualCardIssuing?
    /// The date of birth of this cardholder.
    public var dob: PersonDOB?
    /// The first name of this cardholder
    public var firstName: String?
    /// The first name of this cardholder
    public var lastName: String?
    /// Government-issued ID document for this cardholder.
    public var verification: CardholderIndividualVerification?
    
    public init(cardIssuing: CardholderIndividualCardIssuing? = nil,
                dob: PersonDOB? = nil,
                firstName: String? = nil,
                lastName: String? = nil,
                verification: CardholderIndividualVerification? = nil) {
        self.cardIssuing = cardIssuing
        self.dob = dob
        self.firstName = firstName
        self.lastName = lastName
        self.verification = verification
    }
}

public struct CardholderIndividualCardIssuing: Codable {
    /// Information about cardholder acceptance of [Authorized User Terms](https://stripe.com/docs/issuing/cards) .
    public var userTermsAcceptance: CardholderIndividualCardIssuingUserTermsAcceptance?
    
    public init(userTermsAcceptance: CardholderIndividualCardIssuingUserTermsAcceptance? = nil) {
        self.userTermsAcceptance = userTermsAcceptance
    }
}

public struct CardholderIndividualCardIssuingUserTermsAcceptance: Codable {
    /// The Unix timestamp marking when the cardholder accepted the Authorized User Terms. Required for Celtic Spend Card users.
    public var date: Date?
    /// The IP address from which the cardholder accepted the Authorized User Terms. Required for Celtic Spend Card users.
    public var ip: String?
    /// The user agent of the browser from which the cardholder accepted the Authorized User Terms.
    public var userAgent: String?
    
    public init(date: Date? = nil,
                ip: String? = nil,
                userAgent: String? = nil) {
        self.date = date
        self.ip = ip
        self.userAgent = userAgent
    }
}


public struct CardholderIndividualVerification: Codable {
    /// An identifying document, either a passport or local ID card.
    public var document: CardholderIndividualVerificationDocument?
    
    public init(document: CardholderIndividualVerificationDocument? = nil) {
        self.document = document
    }
}

public struct CardholderIndividualVerificationDocument: Codable {
    /// The back of a document returned by a file upload with a `purpose` value of `additional_verification`.
    @Expandable<File> public var back: String?
    /// The front of a document returned by a file upload with a `purpose` value of `additional_verification`.
    @Expandable<File> public var front: String?
    
    public init(back: String? = nil, front: String? = nil) {
        self._back = Expandable(id: back)
        self._front = Expandable(id: front)
    }
}

public struct CardholderAuthorizationRequirements: Codable {
    /// If `disabled_reason` is present, all cards will decline authorizations with `cardholder_verification_required` reason.
    public var disabledReason: CardholderAuthorizationRequirementsDisabledReason?
    /// Array of fields that need to be collected in order to verify and re-enable the cardholder.
    public var pastDue: [CardholderAuthorizationRequirementsPastDue]?
    
    public init(disabledReason: CardholderAuthorizationRequirementsDisabledReason? = nil,
                pastDue: [CardholderAuthorizationRequirementsPastDue]? = nil) {
        self.disabledReason = disabledReason
        self.pastDue = pastDue
    }
}

public enum CardholderStatus: String, Codable {
    /// Cards attached to this cardholder can approve authorizations,
    case active
    /// Cards attached to this cardholder will decline all authorizations with a `cardholder_inactive` reason.
    case inactive
    /// Cards attached to this cardholder will decline all authorizations without an authorization object created. This status is non-reversible.
    case blocked
}

public enum CardholderType: String, Codable {
    /// The cardholder is a person, and additional information includes first and last name, date of birth, etc. If you’re issuing Celtic Spend Cards, then Individual cardholders must accept Authorized User Terms prior to activating their card.
    case individial
    /// The cardholder is a company or business entity, and additional information includes their tax ID. This option may not be available if your use case only supports individual cardholders.
    case company
}

public enum CardholderAuthorizationRequirementsDisabledReason: String, Codable {
    /// Account might be on a prohibited persons or companies list. The `past_due` field contains information that you need to provide before the cardholder can approve authorizations.
    case listed
    /// This cardholder has raised additional review. Stripe will make a decision and update the `disabled_reason` field.
    case underReview = "under_review"
    /// Cardholder is rejected because they are on a third-party prohibited persons or companies list (such as financial services provider or government). Their status will be `blocked`.
    case rejectedListed = "rejected.listed"
    /// Cardholder has outstanding requirements. The `past_due` field contains information that you need to provide before the cardholder can activate cards.
    case requirementsPastDue = "requirements.past_due"
}

public enum CardholderAuthorizationRequirementsPastDue: String, Codable {
    /// The IP address from which the Cardholder accepted their Authorized User Terms. Required for Celtic Spend Card users.
    case individualCardIssuingUserTermsAcceptanceIp = "individual.card_issuing.user_terms_acceptance.ip"
    /// The Unix timestamp marking when the Cardholder accepted their Authorized User Terms. Required for Celtic Spend Card users.
    case individualCardIssuingUserTermsAcceptanceDate = "individual.card_issuing.user_terms_acceptance.date"
    /// The cardholder’s legal first name.
    case individualFirstName = "individual.first_name"
    /// The cardholder’s legal last name.
    case individualLastName = "individual.last_name"
    /// The cardholder’s date of birth’s day.
    case individualDobDay = "individual.dob.day"
    /// The cardholder’s date of birth’s month.
    case individualDobMonth = "individual.dob.month"
    /// The cardholder’s date of birth’s year.
    case individualDobYear = "individual.dob.year"
    /// The front and back of a government-issued form of identification.
    case individualVerificationDocument = "individual.verification.document"
    /// The cardholder’s business number (Tax ID).
    case companyTaxId = "company.tax_id"
}

public struct CardholderList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [Cardholder]?
    
    public init(object: String,
                hasMore: Bool? = nil,
                url: String? = nil,
                data: [Cardholder]? = nil) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
