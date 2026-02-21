// MARK: - Spec Parser
// Transforms raw OpenAPI spec into StripeResource intermediate representations

import Foundation

struct SpecParser {
    let spec: OpenAPISpec
    
    /// Pre-computed set of Swift type names that collide (e.g. "Session", "Configuration")
    private let collidingBaseNames: Set<String>
    
    init(spec: OpenAPISpec) {
        self.spec = spec
        
        // Detect which base names collide across different schemas
        var baseNameToSchemas: [String: [String]] = [:]
        for (schemaName, schema) in spec.components.schemas {
            guard !schemaName.starts(with: "deleted_") else { continue }
            let name = schema.xResourceId ?? schemaName
            let baseName = SpecParser.baseSwiftType(name)
            baseNameToSchemas[baseName, default: []].append(name)
        }
        self.collidingBaseNames = Set(
            baseNameToSchemas.filter { $0.value.count > 1 }.keys
        )
    }
    
    /// Build a deterministic mapping of schema name → API paths by scanning response $refs.
    /// This replaces naive pluralization with the spec's actual data.
    func buildPathMapping() -> [String: [(method: String, path: String)]] {
        var mapping: [String: [(method: String, path: String)]] = [:]
        
        for (path, pathItem) in spec.paths {
            let operations: [(String, OperationObject?)] = [
                ("GET", pathItem.get),
                ("POST", pathItem.post),
                ("DELETE", pathItem.delete),
            ]
            
            for (method, operation) in operations {
                guard let op = operation,
                      let response = op.responses?["200"],
                      let content = response.content?["application/json"],
                      let schema = content.schema else { continue }
                
                // Direct $ref → single resource endpoint
                if let ref = schema.ref {
                    let schemaName = refToSchemaName(ref)
                    mapping[schemaName, default: []].append((method, path))
                }
                
                // List wrapper → data.items.$ref
                if let dataItems = schema.properties?["data"]?.items,
                   let ref = dataItems.ref {
                    let schemaName = refToSchemaName(ref)
                    mapping[schemaName, default: []].append((method, path))
                }
            }
        }
        
        return mapping
    }
    
    private func refToSchemaName(_ ref: String) -> String {
        ref.split(separator: "/").last.map(String.init) ?? ref
    }
    
    /// Parse all resources from the spec
    func parseResources() -> [StripeResource] {
        var resources: [StripeResource] = []
        
        for (schemaName, schema) in spec.components.schemas {
            guard let resourceId = schema.xResourceId else { continue }
            guard !resourceId.starts(with: "deleted_") else { continue }
            
            let domain = StripeDomain.from(resourceId: resourceId)
            let required = schema.required ?? []
            let expandable = schema.xExpandableFields ?? []
            
            let properties = (schema.properties ?? [:]).map { name, prop in
                resolveProperty(
                    name: name,
                    property: prop,
                    isRequired: required.contains(name),
                    isExpandable: expandable.contains(name),
                    allSchemas: spec.components.schemas
                )
            }.sorted { $0.name < $1.name }
            
            let anyOfVariants: [String]? = schema.anyOf.map { refs in
                refs.compactMap { $0.ref?.split(separator: "/").last.map(String.init) }
            }
            
            resources.append(StripeResource(
                schemaName: schemaName,
                resourceId: resourceId,
                domain: domain,
                swiftTypeName: schemaNameToSwiftType(resourceId),
                description: schema.description ?? "",
                properties: properties,
                expandableFields: Set(expandable),
                requiredFields: Set(required),
                anyOfVariants: anyOfVariants
            ))
        }
        
        return resources.sorted { $0.swiftTypeName < $1.swiftTypeName }
    }
    
    /// Parse all inline schemas (those without x-resourceId) into StripeResources,
    /// so they can be generated as standalone types referenced by the main models.
    /// Filtering is handled externally by SchemaClassifier's transitive closure.
    func parseInlineSchemas() -> [StripeResource] {
        var resources: [StripeResource] = []
        
        for (schemaName, schema) in spec.components.schemas {
            guard schema.xResourceId == nil else { continue }
            guard !schemaName.starts(with: "deleted_") else { continue }
            // Skip dot-named schemas that collide with a real underscore-named schema
            // e.g. "payment_intent.processing" → "payment_intent_processing" already exists
            if schemaName.contains(".") {
                let normalized = schemaName.replacing(".", with: "_")
                if spec.components.schemas[normalized] != nil { continue }
            }
            
            let required = schema.required ?? []
            let expandable = schema.xExpandableFields ?? []
            
            let properties = (schema.properties ?? [:]).map { name, prop in
                resolveProperty(
                    name: name,
                    property: prop,
                    isRequired: required.contains(name),
                    isExpandable: expandable.contains(name),
                    allSchemas: spec.components.schemas
                )
            }.sorted { $0.name < $1.name }
            
            resources.append(StripeResource(
                schemaName: schemaName,
                resourceId: schemaName,
                domain: .core,
                swiftTypeName: schemaNameToSwiftType(schemaName),
                description: schema.description ?? "",
                properties: properties,
                expandableFields: Set(expandable),
                requiredFields: Set(required),
                anyOfVariants: nil
            ))
        }
        
        return resources.sorted { $0.swiftTypeName < $1.swiftTypeName }
    }
    
    // MARK: - Property Resolution
    
    private func resolveProperty(
        name: String,
        property: PropertyObject,
        isRequired: Bool,
        isExpandable: Bool,
        allSchemas: [String: SchemaObject]
    ) -> StripeProperty {
        let type = resolveType(
            property: property, 
            fieldName: name,
            isExpandable: isExpandable,
            allSchemas: allSchemas
        )
        
        return StripeProperty(
            name: name,
            swiftName: snakeToCamel(name),
            description: (property.description ?? "")
                .replacing("\n", with: " ")
                .trimmingCharacters(in: .whitespaces),
            type: type,
            isRequired: isRequired,
            isNullable: property.nullable ?? false,
            isExpandable: isExpandable,
            enumCases: property.enum
        )
    }
    
    private func resolveType(
        property: PropertyObject,
        fieldName: String,
        isExpandable: Bool,
        allSchemas: [String: SchemaObject]
    ) -> StripePropertyType {
        
        // Handle anyOf — common pattern for expandable fields
        if let anyOf = property.anyOf, !anyOf.isEmpty {
            return resolveAnyOf(
                anyOf, 
                fieldName: fieldName, 
                isExpandable: isExpandable,
                allSchemas: allSchemas
            )
        }
        
        // Handle oneOf
        if let oneOf = property.oneOf, !oneOf.isEmpty {
            return resolveAnyOf(
                oneOf,
                fieldName: fieldName, 
                isExpandable: isExpandable,
                allSchemas: allSchemas
            )
        }
        
        // Handle $ref
        if let ref = property.ref {
            let typeName = refToTypeName(ref)
            if isExpandable {
                return .expandable(wrappedType: schemaNameToSwiftType(typeName))
            }
            return .object(name: schemaNameToSwiftType(typeName))
        }
        
        // Handle by type
        switch property.type {
        case "string":
            if let enumCases = property.enum {
                return .enum(cases: enumCases)
            }
            return .string
        case "integer":
            return .integer
        case "number":
            return .number
        case "boolean":
            return .boolean
        case "array":
            if let items = property.items {
                let elementType = resolveType(
                    property: items,
                    fieldName: fieldName,
                    isExpandable: false,
                    allSchemas: allSchemas
                )
                if isExpandable {
                    // Array of expandable references
                    if case .object(let name) = elementType {
                        return .expandableCollection(wrappedType: name)
                    }
                }
                return .array(element: elementType)
            }
            return .array(element: .any)
        case "object":
            if let additionalProperties = property.additionalProperties {
                let valueType = resolveType(
                    property: additionalProperties,
                    fieldName: fieldName,
                    isExpandable: false,
                    allSchemas: allSchemas
                )
                return .dictionary(value: valueType)
            }
            // Detect Stripe list sub-objects: inline objects with {object, data, has_more, url}
            // where data is an array of items. These should map to "ElementTypeList".
            if let props = property.properties,
               props["object"] != nil,
               props["has_more"] != nil,
               props["url"] != nil,
               let dataProp = props["data"],
               dataProp.type == "array",
               let items = dataProp.items {
                // Single $ref → use the referenced type for List naming
                if let ref = items.ref {
                    let elementTypeName = refToTypeName(ref)
                    let swiftElementType = schemaNameToSwiftType(elementTypeName)
                    return .object(name: "\(swiftElementType)List")
                }
                // Polymorphic anyOf (e.g., external_accounts → [bank_account, card])
                // Use the field name to derive the list type, since Stripe has dedicated
                // schemas like "external_account" and "payment_source" for these.
                if items.anyOf != nil {
                    let singular = fieldName.hasSuffix("s") ? String(fieldName.dropLast()) : fieldName
                    let swiftType = schemaNameToSwiftType(singular)
                    return .object(name: "\(swiftType)List")
                }
            }
            // Inline object with properties — this is a hash/metadata
            if property.properties != nil {
                return .hash
            }
            return .hash
        default:
            return .any
        }
    }
    
    private func resolveAnyOf(
        _ variants: [PropertyObject],
        fieldName: String,
        isExpandable: Bool,
        allSchemas: [String: SchemaObject]
    ) -> StripePropertyType {
        // Filter out string-only variants (typically the ID string for expandables)
        let nonStringVariants = variants.filter { $0.type != "string" }
        let refVariants = variants.compactMap { $0.ref }.map(refToTypeName)
        
        if isExpandable {
            let objectRefs = refVariants.map(schemaNameToSwiftType)
            
            if let first = objectRefs.first, objectRefs.count == 1 {
                return .expandable(wrappedType: first)
            } else if objectRefs.count > 1 {
                // Multiple possible types → DynamicExpandable
                return .dynamicExpandable(types: objectRefs)
            }
        }
        
        // Non-expandable anyOf — try to pick the most specific type
        if nonStringVariants.count == 1, let single = nonStringVariants.first {
            return resolveType(
                property: single,
                fieldName: fieldName,
                isExpandable: false,
                allSchemas: allSchemas
            )
        }
        
        if let ref = refVariants.first, refVariants.count == 1 {
            return .object(name: schemaNameToSwiftType(ref))
        }
        
        // If only a string variant exists, it's a string
        if variants.count == 1, variants.first?.type == "string" {
            if let enumCases = variants.first?.enum {
                return .enum(cases: enumCases)
            }
            return .string
        }
        
        return .hash
    }
    
    // MARK: - Naming Helpers
    
    private func refToTypeName(_ ref: String) -> String {
        // "#/components/schemas/foo" → "foo"
        ref.split(separator: "/").last.map(String.init) ?? ref
    }
    
    /// Compute the base Swift type from just the last segment
    private static func baseSwiftType(_ name: String) -> String {
        let baseName: String
        if name.contains(".") {
            baseName = String(name.split(separator: ".").last ?? Substring(name))
        } else {
            baseName = name
        }
        return baseName
            .split(separator: "_")
            .map { $0.capitalized }
            .joined()
    }
    
    /// Convert schema name to Swift PascalCase type name.
    /// Includes the namespace prefix when base name collides (e.g. CheckoutSession, IssuingCard).
    /// Inline schemas (no dot) are treated as-is (e.g. "thresholds_resource_usage_threshold_config").
    func schemaNameToSwiftType(_ name: String) -> String {
        let baseName = SpecParser.baseSwiftType(name)
        
        if name.contains(".") && collidingBaseNames.contains(baseName) {
            // Include namespace: "checkout.session" → "CheckoutSession"
            // "financial_connections.session" → "FinancialConnectionsSession"
            return name
                .replacing(".", with: "_")
                .split(separator: "_")
                .map { $0.capitalized }
                .joined()
        }
        
        // Non-namespaced or no collision: just PascalCase the whole thing
        if name.contains(".") {
            return baseName
        }
        
        return name
            .split(separator: "_")
            .map { $0.capitalized }
            .joined()
    }
}
