// MARK: - Model Generator
// Generates Swift model files from StripeResource intermediate representations
// Follows spec-driven optionality matching official Stripe TypeScript SDK:
//   - required + non-nullable → non-optional (guaranteed by Stripe)
//   - required + nullable → optional (Type?)
//   - not required → optional (Type?)

import Foundation

struct ModelGenerator {
    let parser: SpecParser
    /// "Type.property" for each property stored `@Indirect` (see `indirectProperties(…)`)
    let indirectProperties: Set<String>

    /// `resources` and `inlineTypes` are every model to be generated.
    init(parser: SpecParser, resources: [StripeResource], inlineTypes: [StripeResource]) {
        self.parser = parser
        self.indirectProperties = Self.indirectProperties(resources: resources, inlineTypes: inlineTypes, parser: parser)
    }

    /// The properties to store `@Indirect` (out of line), keeping models small and finite:
    ///
    /// - Every property that holds another API resource (ApiErrors.paymentIntent). Resources
    ///   are large, and a model embedding them inline grows to many KB (ApiErrors was 11 KB,
    ///   and Invoice and TerminalReader embed it), enough for a debug build's decoder to
    ///   overflow a 512 KB Swift concurrency thread stack.
    /// - Any property that still closes a cycle, since a struct can't contain itself, even
    ///   through other structs or enums. These are the back edges of a depth-first walk in
    ///   name order, so they're stable between runs. None remain in today's spec: every
    ///   cycle passes through an embedded resource.
    ///
    /// Arrays, dictionaries and expandable fields already store their values out of line, so
    /// only direct object properties and enum payloads count.
    static func indirectProperties(resources: [StripeResource], inlineTypes: [StripeResource], parser: SpecParser) -> Set<String> {
        let resourceNames = Set(resources.map(\.swiftTypeName))
        var result = Set<String>()

        // Type → (property, type it stores inline); property is nil for an enum case payload
        var edges: [String: [(property: String?, target: String)]] = [:]
        for type in resources + inlineTypes {
            if let variants = type.anyOfVariants, !variants.isEmpty {
                edges[type.swiftTypeName] = variants.map { (nil, parser.schemaNameToSwiftType($0)) }
            } else {
                edges[type.swiftTypeName] = type.properties.compactMap { property in
                    guard case .object(let name) = property.type else { return nil }
                    if resourceNames.contains(name) {
                        result.insert("\(type.swiftTypeName).\(property.swiftName)")
                        return nil
                    }
                    return (property.swiftName, name)
                }
            }
        }

        var finished: [String: Bool] = [:]  // false while on the walk's stack
        func visit(_ name: String) {
            finished[name] = false
            let sorted = (edges[name] ?? []).sorted { ($0.property ?? "", $0.target) < ($1.property ?? "", $1.target) }
            for edge in sorted where edges[edge.target] != nil {
                switch finished[edge.target] {
                case false?:
                    guard let property = edge.property else {
                        preconditionFailure("\(name) is recursive through an enum case; box it in the generator")
                    }
                    result.insert("\(name).\(property)")
                case nil:
                    visit(edge.target)
                case true?:
                    break
                }
            }
            finished[name] = true
        }
        for name in edges.keys.sorted() where finished[name] == nil {
            visit(name)
        }
        return result
    }
    
    /// Generate the full Swift source for a resource's model file. `listAlias` adds
    /// `{Type}List = StripeList<{Type}>`, as resources (types with an x-resourceId) get.
    func generate(resource: StripeResource, listAlias: Bool = false) -> String {
        // Polymorphic anyOf schemas → generate enum instead of struct
        if let variants = resource.anyOfVariants, !variants.isEmpty {
            return generatePolymorphicEnum(resource: resource, variants: variants)
        }

        let type = resource.swiftTypeName
        var w = fileHeader("\(type).swift")
        w.doc(resource.description)
        w.block("public struct \(type): Codable, Sendable {") { w in
            for property in resource.properties {
                writeProperty(property, resource: resource, to: &w)
            }
            // CodingKeys enum if any property names differ from swift names
            if resource.properties.contains(where: { $0.name != $0.swiftName }) {
                w.line()
                w.block("public enum CodingKeys: String, CodingKey {") { w in
                    for property in resource.properties {
                        let name = escapedSwiftName(property.swiftName)
                        w.line(property.name == property.swiftName ? "case \(name)" : "case \(name) = \"\(property.name)\"")
                    }
                }
            }
        }
        w.line()

        // Generate standalone enum types for enum-typed properties
        for property in resource.properties {
            guard case .enum(let cases, let valueDescriptions) = property.type else { continue }
            let enumLines = generateStringEnum(
                name: "\(type)\(capitalize(property.swiftName))",
                cases: cases,
                description: property.description,
                valueDescriptions: valueDescriptions
            )
            guard !enumLines.isEmpty else { continue }
            w.append(enumLines)
            w.line()
        }

        if listAlias {
            w.line("public typealias \(type)List = StripeList<\(type)>")
            w.line()
        }
        return w.text
    }
    
    // MARK: - Property Generation
    
    private func writeProperty(_ property: StripeProperty, resource: StripeResource, to w: inout CodeWriter) {
        w.doc(property.description)
        
        // Spec-driven optionality (matching TypeScript SDK):
        //   required + non-nullable → non-optional
        //   required + nullable → optional
        //   not-required → optional
        let isNonOptional = property.isRequired && !property.isNullable
        // Expandable properties are always optional — the wrapper's wrappedValue is String?/[String]?
        let isExpandableType: Bool
        switch property.type {
        case .expandable, .expandableCollection: isExpandableType = true
        default: isExpandableType = false
        }
        let optionalMark = (isNonOptional && !isExpandableType) ? "" : "?"
        
        if indirectProperties.contains("\(resource.swiftTypeName).\(property.swiftName)") {
            w.line("@Indirect")
        }

        // Expandable property wrapper annotations
        switch property.type {
        case .expandable(let wrappedType):
            w.line("@Expandable<\(wrappedType)>")
        case .expandableCollection(let wrappedType):
            w.line("@ExpandableCollection<\(wrappedType)>")
        default:
            break
        }
        
        let swiftType = swiftTypeString(for: property, resource: resource)
        w.line("public var \(escapedSwiftName(property.swiftName)): \(swiftType)\(optionalMark)")
    }
    
    // MARK: - Type Mapping
    
    func swiftTypeString(for property: StripeProperty, resource: StripeResource) -> String {
        typeToSwift(property.type, propertyName: property.swiftName, resourceName: resource.swiftTypeName)
    }
    
    func typeToSwift(_ type: StripePropertyType, propertyName: String = "", resourceName: String = "") -> String {
        switch type {
        case .string: return "String"
        case .integer: return "Int"
        case .date: return "Date"
        case .number: return "Double"
        case .boolean: return "Bool"
        case .object(let name): return name
        case .array(let element): return "[\(typeToSwift(element))]"
        case .dictionary(let value): return "[String: \(typeToSwift(value))]"
        case .expandable: return "String"
        case .expandableCollection: return "[String]"
        case .enum:
            // Wire enum type: ResourceNamePropertyName
            if !resourceName.isEmpty && !propertyName.isEmpty {
                return "\(resourceName)\(capitalize(propertyName))"
            }
            return "String"
        // Free-form objects (no declared fields or value type) and unresolvable anyOf unions:
        // values can be any JSON, so [String: String] would fail on numbers, bools and nulls.
        case .hash: return "[String: JSONValue]"
        // A schema with no type at all: it can be any JSON
        case .any: return "JSONValue"
        }
    }
    
    // MARK: - Polymorphic Enum Generation
    
    /// Generate a Swift enum for a polymorphic anyOf schema (e.g., external_account → BankAccount | Card)
    private func generatePolymorphicEnum(resource: StripeResource, variants: [String]) -> String {
        let type = resource.swiftTypeName
        let variantInfos = variants.map { resourceId -> (id: String, swiftType: String, caseName: String) in
            (id: resourceId, swiftType: parser.schemaNameToSwiftType(resourceId), caseName: enumCaseToSwift(resourceId))
        }
        precondition(!variantInfos.contains { $0.caseName == undocumentedCase }, "\(type) has a variant named \(undocumentedCase)")

        var w = fileHeader("\(type).swift")
        w.line("/// One of several object types, decoded by its `object` field: \(variantInfos.map(\.swiftType).joined(separator: ", ")).")
        w.line("/// An object of a type this version of StripeKit doesn't know decodes as `.\(undocumentedCase)`.")
        w.block("public enum \(type): Codable, Sendable {") { w in
            for v in variantInfos {
                w.line("case \(v.caseName)(\(v.swiftType))")
            }
            w.line("/// An object of a type this version of StripeKit doesn't know, as raw JSON")
            w.line("case \(undocumentedCase)(JSONValue)")
            w.line()
            w.line("// MARK: - Discriminated Codable")
            w.line()
            w.block("private enum CodingKeys: String, CodingKey {") { $0.line("case object") }
            w.line()

            w.block("public init(from decoder: any Decoder) throws {") { w in
                w.line("let container = try decoder.container(keyedBy: CodingKeys.self)")
                w.line("let object = try container.decode(String.self, forKey: .object)")
                w.line("switch object {")
                for v in variantInfos {
                    w.line("case \"\(objectValue(forVariant: v.id))\":")
                    w.indented { $0.line("self = .\(v.caseName)(try \(v.swiftType)(from: decoder))") }
                }
                w.line("default:")
                w.indented { $0.line("self = .\(undocumentedCase)(try JSONValue(from: decoder))") }
                w.line("}")
            }
            w.line()

            w.block("public func encode(to encoder: any Encoder) throws {") { w in
                w.line("switch self {")
                for caseName in variantInfos.map(\.caseName) + [undocumentedCase] {
                    w.line("case .\(caseName)(let value):")
                    w.indented { $0.line("try value.encode(to: encoder)") }
                }
                w.line("}")
            }
            w.line()

            // Convenience accessors
            for v in variantInfos {
                w.line("/// Returns the \(v.swiftType) if this is a `.\(v.caseName)`, otherwise nil.")
                w.block("public var \(v.caseName): \(v.swiftType)? {") { w in
                    w.line("if case .\(v.caseName)(let value) = self { return value }")
                    w.line("return nil")
                }
                w.line()
            }
        }
        w.line()

        // The list alias, with a read-only array per variant (`bankAccounts`, `cards`) over `data`
        w.line("public typealias \(type)List = StripeList<\(type)>")
        w.line()
        w.block("extension StripeList where Item == \(type) {") { w in
            for (index, v) in variantInfos.enumerated() {
                if index > 0 { w.line() }
                w.line("/// The `\(v.swiftType)` items in `data`")
                w.line("public var \(pluralPropertyName(v.caseName)): [\(v.swiftType)] { data.compactMap(\\.\(v.caseName)) }")
            }
        }
        w.line()
        return w.text
    }
    
    /// The `object` value that identifies a variant. A deleted object keeps its resource's
    /// value: "deleted_card" has `"object": "card"`.
    private func objectValue(forVariant id: String) -> String {
        id.starts(with: SpecParser.deletedPrefix) ? String(id.dropFirst(SpecParser.deletedPrefix.count)) : id
    }

    /// Pluralize a camelCase enum case name for use as a typed array property
    private func pluralPropertyName(_ caseName: String) -> String {
        // bankAccount → bankAccounts, card → cards
        if caseName.hasSuffix("s") || caseName.hasSuffix("x") || caseName.hasSuffix("z") {
            return caseName + "es"
        }
        return caseName + "s"
    }
}
