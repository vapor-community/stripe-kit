// MARK: - Infrastructure Generator
// Generates the spec-wide files: StripeClient.swift (the client wiring every route struct),
// StripeEventType.swift, StripeEvent.swift (the event struct only), and the test target's
// fixture type registry. The rest of the runtime (StripeAPIHandler, webhook verification,
// JSONValue, …) is hand-written in Sources/StripeKit/Infrastructure/ and never regenerated.

import Foundation

struct InfraGenerator {
    let spec: OpenAPISpec
    let parser: SpecParser
    /// Every resource (for the fixture registry)
    let resources: [StripeResource]
    /// The resources that have at least one route (for the client)
    let routedResources: [StripeResource]
    
    // MARK: - StripeClient
    
    /// Generate the StripeClient struct that wires all route structs
    func generateStripeClient() -> String {
        // Core resources ("customer") are client properties: `stripe.customers`. Namespaced ones
        // ("terminal.reader") are grouped under a property per namespace, as in Stripe's API
        // paths (/v1/terminal/readers), docs and most of its SDKs: `stripe.terminal.readers`.
        let core = routedResources.filter { namespace(of: $0) == nil }
        let byNamespace = Dictionary(grouping: routedResources.filter { namespace(of: $0) != nil }) { namespace(of: $0)! }
        let namespaces = byNamespace.keys.sorted()

        let coreProperties = core.map { (name: pluralized(snakeToCamel($0.resourceId)), type: "\($0.swiftTypeName)Routes") }
        let namespaceProperties = namespaces.map { (name: snakeToCamel($0), type: parser.schemaNameToSwiftType($0)) }
        let clientNames = ["apiVersion", "handler"] + coreProperties.map(\.name) + namespaceProperties.map(\.name)
        precondition(Set(clientNames).count == clientNames.count, "StripeClient property names collide: \(clientNames)")

        var w = fileHeader("StripeClient.swift", apiVersion: spec.info.version, imports: ["AsyncHTTPClient"])

        // Client struct
        w.line("/// The entry point for the Stripe API: `stripe.customers`, `stripe.terminal.readers`, ….")
        w.line("/// API Version: \(spec.info.version)")
        w.block("public struct StripeClient: Sendable {") { w in
            w.line("/// The Stripe API version these types were generated from. Sent as the `Stripe-Version`")
            w.line("/// header on every request, so responses match the generated models.")
            w.line("public static let apiVersion = \"\(spec.info.version)\"")
            w.line()
            w.line("/// The API handler used for requests. Stored to support `onBehalfOf(_:)` scoping.")
            w.line("public let handler: StripeAPIHandler")
            w.line()
            for property in coreProperties {
                w.line("public var \(property.name): \(property.type)")
            }
            w.line()
            for (namespace, property) in zip(namespaces, namespaceProperties) {
                w.line("/// The \(namespace) APIs (`/v1/\(namespace)/…`)")
                w.line("public var \(property.name): \(property.type)")
            }
        }
        w.line()

        // A struct per namespace, nested in StripeClient
        w.block("extension StripeClient {") { w in
            for (index, namespace) in namespaces.enumerated() {
                let resources = byNamespace[namespace]!.sorted { $0.resourceId < $1.resourceId }
                let members = resources.map { resource in
                    (name: pluralized(snakeToCamel(String(resource.resourceId.dropFirst(namespace.count + 1)))), type: "\(resource.swiftTypeName)Routes")
                }
                precondition(Set(members.map(\.name)).count == members.count, "StripeClient.\(namespace) property names collide")

                if index > 0 { w.line() }
                w.line("/// The \(namespace) APIs (`/v1/\(namespace)/…`), e.g. `stripe.\(snakeToCamel(namespace)).\(members[0].name)`.")
                w.block("public struct \(parser.schemaNameToSwiftType(namespace)): Sendable {") { w in
                    for member in members {
                        w.line("public var \(member.name): \(member.type)")
                    }
                    w.line()
                    w.block("static func live(handler: StripeAPIHandler) -> Self {") { w in
                        w.block("Self(", closer: ")") { w in
                            for (memberIndex, member) in members.enumerated() {
                                w.line("\(member.name): .live(handler: handler)\(memberIndex < members.count - 1 ? "," : "")")
                            }
                        }
                    }
                }
            }
        }
        w.line()

        // .live factory
        let allProperties = coreProperties.map(\.name) + namespaceProperties.map(\.name)
        w.block("extension StripeClient {") { w in
            w.line("/// Create a live client connected to the Stripe API.")
            w.line("/// - Parameters:")
            w.line("///   - stripeAccount: Make every request as this connected account (see `onBehalfOf(_:)`).")
            w.line("///   - maxNetworkRetries: Retries after a network error or a response Stripe marks retryable,")
            w.line("///     with backoff, 2 by default as in Stripe's own SDKs. 0 turns retries off.")
            w.block("public static func live(httpClient: HTTPClient, apiKey: String, stripeAccount: String? = nil, maxNetworkRetries: Int = 2) -> StripeClient {") { w in
                w.line(".live(handler: StripeAPIHandler(httpClient: httpClient, apiKey: apiKey, stripeAccount: stripeAccount, maxNetworkRetries: maxNetworkRetries))")
            }
            w.line()
            w.line("/// A client whose routes all send their requests through `handler`.")
            w.block("static func live(handler: StripeAPIHandler) -> StripeClient {") { w in
                w.block("StripeClient(", closer: ")") { w in
                    w.line("handler: handler,")
                    for (index, name) in allProperties.enumerated() {
                        w.line("\(name): .live(handler: handler)\(index < allProperties.count - 1 ? "," : "")")
                    }
                }
            }
        }
        w.line()
        return w.text
    }
    
    // MARK: - Test Fixture Type Registry

    /// Generate a test-only registry mapping spec schema names to the generated Swift
    /// types, so tests can decode Stripe's published fixtures (fixtures3.json) into them.
    ///
    /// Covers every generated resource and inline type (including `Deleted*`), keyed by
    /// schema name and x-resourceId.
    func generateFixtureTypeRegistry(inlineSchemas: [StripeResource]) -> String {
        var resourceTypes: [String: String] = [:]

        for inline in inlineSchemas {
            resourceTypes[inline.schemaName] = inline.swiftTypeName
        }

        for resource in resources {
            resourceTypes[resource.schemaName] = resource.swiftTypeName
            resourceTypes[resource.resourceId] = resource.swiftTypeName
        }

        var w = fileHeader("FixtureTypes.swift", module: "StripeKitTests", apiVersion: spec.info.version, imports: ["StripeKit"])
        w.line("/// Generated resource types keyed by spec schema name / x-resourceId.")
        w.block("nonisolated(unsafe) let resourceTypes: [String: any Decodable.Type] = [", closer: "]") { w in
            for key in resourceTypes.keys.sorted() {
                w.line("\"\(key)\": \(resourceTypes[key]!).self,")
            }
        }
        w.line()
        return w.text
    }

    // MARK: - StripeEventType

    /// Generate the StripeEventType enum from the spec's event.type enum values
    func generateEventType() -> String {
        var w = fileHeader("StripeEventType.swift")
        let eventTypes = spec.components.schemas["event"]?.properties?["type"]?.enum ?? []
        w.append(generateStringEnum(
            name: "StripeEventType",
            cases: eventTypes.sorted(),
            description: "The type of a Stripe event, from the spec's `event.type` values. An event type newer than this version of StripeKit still decodes; its `rawValue` names it."
        ))
        w.line()
        return w.text
    }
    
    // MARK: - StripeEvent
    
    /// Generate the StripeEvent struct from the spec's event schema. Its `data` and `request`
    /// types and signature verification are hand-written (Infrastructure/StripeEvent+Webhooks.swift).
    func generateStripeEvent() -> String {
        var w = fileHeader("StripeEvent.swift")
        
        // Build property list from the event schema
        guard let eventSchema = spec.components.schemas["event"] else {
            fatalError("Missing 'event' schema in spec")
        }
        
        let required = Set(eventSchema.required ?? [])
        let properties = eventSchema.properties ?? [:]
        
        // Map spec properties to Swift declarations
        struct EventProperty: Comparable {
            let specName: String
            let swiftName: String
            let swiftType: String
            let isOptional: Bool
            let needsCodingKey: Bool // true if specName != swiftName
            
            static func < (lhs: EventProperty, rhs: EventProperty) -> Bool {
                lhs.specName < rhs.specName
            }
        }
        
        var eventProps: [EventProperty] = []
        
        for (name, prop) in properties {
            let swiftName = snakeToCamel(name)
            let isRequired = required.contains(name)
            let isNullable = prop.nullable ?? false
            let isOptional = !isRequired || isNullable
            
            // Determine Swift type
            let baseType: String
            switch name {
            case "type":
                baseType = "StripeEventType"
            case "data":
                baseType = "EventData"
            case "request":
                baseType = "EventRequest"
            case "created":
                baseType = "Date"
            default:
                switch prop.type {
                case "string": baseType = "String"
                case "integer": baseType = "Int"
                case "boolean": baseType = "Bool"
                default: baseType = "String"
                }
            }
            
            let swiftType = isOptional ? "\(baseType)?" : baseType
            let needsCodingKey = swiftName != name
            
            eventProps.append(EventProperty(
                specName: name,
                swiftName: swiftName,
                swiftType: swiftType,
                isOptional: isOptional,
                needsCodingKey: needsCodingKey
            ))
        }
        
        eventProps.sort()
        
        // StripeEvent struct
        w.line("/// A Stripe event, as delivered to webhooks. Verify and decode one with `StripeEvent.verify`.")
        w.line("/// Generated from the OpenAPI spec's `event` schema.")
        w.block("public struct StripeEvent: Codable, Sendable {") { w in
            for prop in eventProps {
                w.line("public var \(prop.swiftName): \(prop.swiftType)")
            }
            // CodingKeys — only needed if any property has a different spec name
            if eventProps.contains(where: \.needsCodingKey) {
                w.line()
                w.block("public enum CodingKeys: String, CodingKey {") { w in
                    for prop in eventProps {
                        w.line(prop.needsCodingKey ? "case \(prop.swiftName) = \"\(prop.specName)\"" : "case \(prop.swiftName)")
                    }
                }
            }
        }
        w.line()
        return w.text
    }
    
    // MARK: - Helpers
    
    /// The namespace of a resource ID ("terminal" for "terminal.reader"), or nil for a core resource
    private func namespace(of resource: StripeResource) -> String? {
        let parts = resource.resourceId.split(separator: ".")
        return parts.count > 1 ? String(parts[0]) : nil
    }

    /// paymentIntent → paymentIntents, ephemeralKey → ephemeralKeys, meterEventSummary →
    /// meterEventSummaries. Names already ending in "s" are plural already (taxSettings).
    private func pluralized(_ name: String) -> String {
        if name.hasSuffix("s") { return name }
        if name.hasSuffix("y"), let beforeY = name.dropLast().last, !"aeiou".contains(beforeY) {
            return String(name.dropLast()) + "ies"
        }
        if name.hasSuffix("x") || name.hasSuffix("ch") || name.hasSuffix("sh") { return name + "es" }
        return name + "s"
    }
}
