// MARK: - Stripe Resource Representation

import Foundation

/// A Stripe resource extracted from the spec — the intermediate representation
/// that model/route generators consume
struct StripeResource: Sendable {
    let schemaName: String
    let resourceId: String
    let domain: StripeDomain
    let swiftTypeName: String
    let description: String
    let properties: [StripeProperty]
    let expandableFields: Set<String>
    let requiredFields: Set<String>
    /// For polymorphic `anyOf` schemas (e.g., external_account → [bank_account, card]).
    /// Contains the x-resourceId values of each variant.
    let anyOfVariants: [String]?
}

/// A property on a Stripe resource 
struct StripeProperty: Sendable {
    let name: String
    let swiftName: String
    let description: String
    let type: StripePropertyType
    let isRequired: Bool
    let isNullable: Bool
    let isExpandable: Bool
    let enumCases: [String]?
}

/// The resolved Swift type for a property
indirect enum StripePropertyType: Sendable {
    case string
    case integer
    case number
    case boolean
    case object(name: String)              // $ref to another schema
    case array(element: StripePropertyType)
    case dictionary(value: StripePropertyType)
    case expandable(wrappedType: String)   // @Expandable<T>
    case dynamicExpandable(types: [String]) // @DynamicExpandable<T1, T2...>
    case expandableCollection(wrappedType: String) // @ExpandableCollection<T>
    case `enum`(cases: [String])
    case hash                               // [String: Any] escape hatch
    case any                                // fallback
    case date                               // epoch seconds
}

/// Domain groupings for Stripe resources — derived from schema naming
enum StripeDomain: String, CaseIterable, Sendable {
    case core           // Top-level resources (charge, customer, etc.)
    case billing        // billing.* 
    case billingPortal  // billing_portal.*
    case checkout       // checkout.*
    case climate        // climate.*
    case connect        // accounts, transfers, etc. (special case)
    case entitlements   // entitlements.*
    case financialConnections // financial_connections.*
    case forwarding     // forwarding.*
    case identity       // identity.*
    case issuing        // issuing.*
    case paymentLinks   // payment links (from paths)
    case radar          // radar.*
    case reporting      // reporting.*
    case sigma          // sigma.*
    case tax            // tax.*
    case terminal       // terminal.*
    case treasury       // treasury.*
    case testHelpers    // test_helpers.*
    case apps           // apps.*
    
    /// Maps from the spec's dot-prefix to domain
    static func from(resourceId: String) -> StripeDomain {
        let parts = resourceId.split(separator: ".")
        guard parts.count > 1 else { return .core }
        switch String(parts[0]) {
        case "billing": return .billing
        case "billing_portal": return .billingPortal
        case "checkout": return .checkout
        case "climate": return .climate
        case "entitlements": return .entitlements
        case "financial_connections": return .financialConnections
        case "forwarding": return .forwarding
        case "identity": return .identity
        case "issuing": return .issuing
        case "radar": return .radar
        case "reporting": return .reporting
        case "sigma": return .sigma
        case "tax": return .tax
        case "terminal": return .terminal
        case "treasury": return .treasury
        case "test_helpers": return .testHelpers
        case "apps": return .apps
        default: return .core
        }
    }
    
    /// Human-readable directory name matching StripeKit conventions
    var directoryName: String {
        switch self {
        case .core: return "Core Resources"
        case .billing: return "Billing"
        case .billingPortal: return "Billing/Customer Portal"
        case .checkout: return "Checkout"
        case .climate: return "Climate"
        case .connect: return "Connect"
        case .entitlements: return "Entitlements"
        case .financialConnections: return "Financial Connections"
        case .forwarding: return "Forwarding"
        case .identity: return "Identity"
        case .issuing: return "Issuing"
        case .paymentLinks: return "Payment Links"
        case .radar: return "Fraud"
        case .reporting: return "Reporting"
        case .sigma: return "Sigma"
        case .tax: return "Tax"
        case .terminal: return "Terminal"
        case .treasury: return "Treasury"
        case .testHelpers: return "Test Helpers"
        case .apps: return "Apps"
        }
    }
}
