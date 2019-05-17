//
//  Account.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import Foundation

/// The [Account Object](https://stripe.com/docs/api/accounts/object?lang=curl).
public struct StripeConnectAccount: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Optional information related to the business.
    public var businessProfile: StripeConnectAccountBusinessProfile?
    /// The business type. Can be `individual` or `company`.
    public var businessType: StripeConnectAccountBusinessType?
    /// A hash containing the set of capabilities that was requested for this account and their associated states. Keys may be `account`, `card_issuing`, `card_payments`, `cross_border_payouts_recipient`, `giropay`, `ideal`, `klarna`, `legacy_payments`, `masterpass`, `payouts`, `platform_payments`, `sofort`, or `visa_checkout`. Values may be active, inactive, or pending.
    public var capabilities: StripeConnectAccountCapablities?
    /// Whether the account can create live charges.
    public var chargesEnabled: Bool?
    /// Information about the company or business. This field is null unless business_type is set to company.
    public var company: StripeConnectAccountCompany?
    /// The account’s country.
    public var country: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// Three-letter ISO currency code representing the default currency for the account. This must be a currency that Stripe supports in the account’s country.
    public var defaultCurrency: StripeCurrency?
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
    public var requirements: StripeConnectAccountRequirmenets?
    /// Account options for customizing how the account functions within Stripe.
    public var settings: StripeConnectAccountSettings?
    /// Details on the [acceptance of the Stripe Services Agreement](https://stripe.com/docs/connect/updating-accounts#tos-acceptance)
    public var tosAcceptance: StripeConnectAccountTOSAcceptance?
    /// The Stripe account type. Can be `standard`, `express`, or `custom`.
    public var type: StripeConnectAccountType?
}

public struct StripeConnectAccountList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeConnectAccount]?
}

public struct StripeConnectAccountBusinessProfile: StripeModel {
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

public enum StripeConnectAccountBusinessType: String, StripeModel {
    case individual
    case company
}

public struct StripeConnectAccountCapablities: StripeModel {
    /// The status of the card payments capability of the account, or whether the account can directly process credit and debit card charges.
    public var cardPayments: StripeConnectAccountCapabilitiesStatus?
    /// The status of the legacy payments capability of the account.
    public var legacyPayments: StripeConnectAccountCapabilitiesStatus?
    /// The status of the platform payments capability of the account, or whether your platform can process charges on behalf of the account.
    public var platformPayments: StripeConnectAccountCapabilitiesStatus?
}

public enum StripeConnectAccountCapabilitiesStatus: String, StripeModel {
    case active
    case inactive
    case pending
}

public struct StripeConnectAccountCompany: StripeModel {
    /// The company’s primary address.
    public var address: StripeAddress?
    /// Whether the company’s directors have been provided. This Boolean will be `true` if you’ve manually indicated that all directors are provided via the `directors_provided` parameter.
    public var directorsProvided: Bool?
    /// The company’s legal name.
    public var name: String?
    /// Whether the company’s owners have been provided. This Boolean will be true if you’ve manually indicated that all owners are provided via the owners_provided parameter, or if Stripe determined that all owners were provided. Stripe determines ownership requirements using both the number of owners provided and their total percent ownership (calculated by adding the percent_ownership of each owner together).
    public var ownersProvided: Bool?
    /// The company’s phone number (used for verification).
    public var phone: String?
    /// Whether the company’s business ID number was provided.
    public var taxIdProvided: Bool?
    /// The jurisdiction in which the tax_id is registered (Germany-based companies only).
    public var taxIdRegistrar: String?
    /// Whether the company’s business VAT number was provided.
    public var vatIdProvided: Bool?
}

public struct StripeConnectAccountRequirmenets: StripeModel {
    /// The date the fields in currently_due must be collected by to keep payouts enabled for the account. These fields might block payouts sooner if the next threshold is reached before these fields are collected.
    public var currentDeadline: Date?
    /// The fields that need to be collected to keep the account enabled. If not collected by the current_deadline, these fields appear in past_due as well, and the account is disabled.
    public var currentlyDue: [String]?
    /// If the account is disabled, this string describes why the account can’t create charges or receive payouts. Can be requirements.past_due, requirements.pending_verification, rejected.fraud, rejected.terms_of_service, rejected.listed, rejected.other, listed, under_review, or other.
    public var disabledReason: String?
    /// The fields that need to be collected assuming all volume thresholds are reached. As they become required, these fields appear in currently_due as well, and the current_deadline is set.
    public var eventuallyDue: [String]?
    /// The fields that weren’t collected by the current_deadline. These fields need to be collected to re-enable the account.
    public var pastDue: [String]?
}

public struct StripeConnectAccountSettings: StripeModel {
    /// Settings used to apply the account’s branding to email receipts, invoices, Checkout, and other products.
    public var branding: StripeConnectAccountSettingsBranding?
    /// Settings specific to card charging on the account.
    public var cardPayments: StripeConnectAccountSettingsCardPayments?
    /// Settings used to configure the account within the Stripe dashboard.
    public var dashboard: StripeConnectAccountSettingsDashboard?
    /// Settings that apply across payment methods for charging on the account.
    public var payments: StripeConnectAccountSettingsPayments?
    /// Settings specific to the account’s payouts.
    public var payouts: StripeConnectAccountSettingsPayouts?
}

public struct StripeConnectAccountSettingsBranding: StripeModel {
    /// (ID of a file upload) An icon for the account. Must be square and at least 128px x 128px.
    public var icon: String?
    /// (ID of a file upload) A logo for the account that will be used in Checkout instead of the icon and without the account’s name next to it if provided. Must be at least 128px x 128px.
    public var logo: String?
    /// A CSS hex color value representing the primary branding color for this account
    public var primaryColor: String?
}

public struct StripeConnectAccountSettingsCardPayments: StripeModel {
    /// Automatically declines certain charge types regardless of whether the card issuer accepted or declined the charge.
    public var declineOn: StripeConnectAccountSettingsCardPaymentsDeclineOn?
    /// The default text that appears on credit card statements when a charge is made. This field prefixes any dynamic statement_descriptor specified on the charge. statement_descriptor_prefix is useful for maximizing descriptor space for the dynamic portion.
    public var statementDescriptorPrefix: String?
}

public struct StripeConnectAccountSettingsCardPaymentsDeclineOn: StripeModel {
    /// Whether Stripe automatically declines charges with an incorrect ZIP or postal code. This setting only applies when a ZIP or postal code is provided and they fail bank verification.
    public var avsFailure: Bool?
    /// Whether Stripe automatically declines charges with an incorrect CVC. This setting only applies when a CVC is provided and it fails bank verification.
    public var cvcFailure: Bool?
}

public struct StripeConnectAccountSettingsDashboard: StripeModel {
    /// The display name for this account. This is used on the Stripe Dashboard to differentiate between accounts.
    public var displayName: String?
    /// The timezone used in the Stripe Dashboard for this account. A list of possible time zone values is maintained at the IANA Time Zone Database.
    public var timezone: String?
}

public struct StripeConnectAccountSettingsPayments: StripeModel {
    /// The default text that appears on credit card statements when a charge is made. This field prefixes any dynamic statement_descriptor specified on the charge.
    public var statementDescriptor: String?
}

public struct StripeConnectAccountSettingsPayouts: StripeModel {
    /// A Boolean indicating if Stripe should try to reclaim negative balances from an attached bank account. See our Understanding Connect Account Balances documentation for details. Default value is true for Express accounts and false for Custom accounts.
    public var debitNegativeBalances: Bool?
    /// Details on when funds from charges are available, and when they are paid out to an external account. See our Setting Bank and Debit Card Payouts documentation for details.
    public var schedule: StripeConnectAccountSettingsPayoutSchedule?
    /// The text that appears on the bank account statement for payouts. If not set, this defaults to the platform’s bank descriptor as set in the Dashboard.
    public var statementDescriptor: String?
}

public struct StripeConnectAccountSettingsPayoutSchedule: StripeModel {
    /// The number of days charges for the account will be held before being paid out.
    public var delayDays: Int?
    /// How frequently funds will be paid out. One of manual (payouts only created via API call), daily, weekly, or monthly.
    public var interval: StripePayoutInterval?
    /// The day of the month funds will be paid out. Only shown if interval is monthly. Payouts scheduled between the 29th and 31st of the month are sent on the last day of shorter months.
    public var monthlyAnchor: Int?
    /// The day of the week funds will be paid out, of the style ‘monday’, ‘tuesday’, etc. Only shown if interval is weekly.
    public var weeklyAnchor: StripeWeeklyAnchor?
}

public struct StripeConnectAccountTOSAcceptance: StripeModel {
    /// The Unix timestamp marking when the Stripe Services Agreement was accepted by the account representative
    public var date: Date?
    /// The IP address from which the Stripe Services Agreement was accepted by the account representative
    public var ip: String?
    /// The user agent of the browser from which the Stripe Services Agreement was accepted by the account representative
    public var userAgent: String?
}

public enum StripeConnectAccountType: String, StripeModel {
    case standard
    case express
    case custom
}

public struct StripeConnectAccountLoginLink: StripeModel {
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// The URL for the login link.
    public var url: String?
}

public enum StripeConnectAccountRejectReason: String, Codable {
    case fraud
    case termsOfService = "terms_of_service"
    case other
}
