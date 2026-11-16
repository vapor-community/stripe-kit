// MARK: - Spec Parser
// Transforms raw OpenAPI spec into StripeResource intermediate representations

import Foundation

struct SpecParser {
    let spec: OpenAPISpec
    
    /// Pre-computed set of Swift type names that collide (e.g. "Session", "Configuration")
    private let collidingBaseNames: Set<String>

    /// "GET /v1/balance" → [(schema, method_name, method_on)] from every schema's `x-stripeOperations`
    private let stripeMethodNames: [String: [(schema: String, name: String, methodOn: String)]]
    
    init(spec: OpenAPISpec) {
        self.spec = spec

        var methodNames: [String: [(schema: String, name: String, methodOn: String)]] = [:]
        for (schemaName, schema) in spec.components.schemas {
            for op in schema.xStripeOperations ?? [] {
                methodNames["\(op.operation.uppercased()) \(op.path)", default: []].append((schemaName, op.methodName, op.methodOn))
            }
        }
        self.stripeMethodNames = methodNames
        
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
    
    /// The SDK method name Stripe gives an operation in `x-stripeOperations` (snake_case, e.g.
    /// "retrieve", "void_invoice"), as used by Stripe's official SDKs. Prefers the name listed
    /// on `schemaName` itself; otherwise the name most schemas listing the operation give it
    /// (DELETE /v1/customers/{customer}/sources/{id} is `delete` on bank_account and card,
    /// `detach` on source → `delete`). `service` methods win over `collection` methods (nested
    /// lists such as GET /v1/charges/{charge}/refunds only have the latter). Nil when the spec
    /// doesn't name it, or the most common names tie.
    func stripeMethodName(method: String, path: String, schemaName: String) -> String? {
        let all = stripeMethodNames["\(method) \(path)"] ?? []
        for methodOn in ["service", "collection"] {
            let entries = all.filter { $0.methodOn == methodOn }
            guard !entries.isEmpty else { continue }
            if let own = entries.first(where: { $0.schema == schemaName }) { return own.name }
            let counts = Dictionary(entries.map { ($0.name, 1) }, uniquingKeysWith: +)
            let top = counts.values.max() ?? 0
            let leaders = counts.filter { $0.value == top }.map(\.key)
            if leaders.count == 1 { return leaders[0] }
        }
        return nil
    }

    /// The polymorphic schema a response of several object types decodes as: the smallest
    /// schema whose `anyOf` includes every variant. POST /v1/customers/{customer}/sources/{id}
    /// returns `card | bank_account | source`, which `payment_source` (`account | bank_account
    /// | card | source`) covers. Nil when no single schema does.
    func polymorphicSchema(covering variants: Set<String>) -> String? {
        let candidates = spec.components.schemas.compactMap { name, schema -> (name: String, size: Int)? in
            guard let anyOf = schema.anyOf else { return nil }
            let refs = anyOf.compactMap { $0.ref.map(refToSchemaName) }
            guard refs.count == anyOf.count, variants.isSubset(of: Set(refs)) else { return nil }
            return (name, refs.count)
        }
        guard let smallest = candidates.map(\.size).min() else { return nil }
        let best = candidates.filter { $0.size == smallest }
        return best.count == 1 ? best[0].name : nil
    }

    /// The resource an operation belongs to per the spec's `x-stripeOperations`, when that
    /// differs from the type it returns. Stripe's SDKs group methods by this owner, e.g.
    /// GET /v1/customers/{customer}/payment_methods is `customers.listPaymentMethods`, though it
    /// returns payment methods. Nil when the operation should stay grouped by its response
    /// type: no single owner, the owner is what it returns, or the response isn't JSON.
    func reassignedOwner(method: String, path: String) -> String? {
        let owners = Set((stripeMethodNames["\(method) \(path)"] ?? []).filter { $0.methodOn == "service" }.map(\.schema))
        guard owners.count == 1, let owner = owners.first, spec.components.schemas[owner] != nil,
              let schema = operation(method: method, path: path)?.responses?["200"]?.content?["application/json"]?.schema
        else { return nil }
        return responseSchemaNames(schema).contains(owner) ? nil : owner
    }

    private func operation(method: String, path: String) -> OperationObject? {
        guard let item = spec.paths[path] else { return nil }
        switch method {
        case "GET": return item.get
        case "POST": return item.post
        case "DELETE": return item.delete
        default: return nil
        }
    }

    /// Schemas a response is made of: a `$ref` (and the live type of a `deleted_X`), the live
    /// type of `X | deleted_X`, or a list's item type.
    private func responseSchemaNames(_ schema: PropertyObject) -> Set<String> {
        var names = Set<String>()
        if let ref = schema.ref {
            let name = refToSchemaName(ref)
            names.insert(name)
            if name.starts(with: SpecParser.deletedPrefix) { names.insert(String(name.dropFirst(SpecParser.deletedPrefix.count))) }
        }
        for ref in (schema.anyOf ?? []).compactMap(\.ref) {
            let name = refToSchemaName(ref)
            if !name.starts(with: SpecParser.deletedPrefix) { names.insert(name) }
        }
        if let ref = schema.properties?["data"]?.items?.ref { names.insert(refToSchemaName(ref)) }
        return names
    }

    /// Build a deterministic mapping of schema name → API paths by scanning response $refs.
    /// This replaces naive pluralization with the spec's actual data. Operations whose
    /// `x-stripeOperations` owner differs from their response type go to the owner instead
    /// (see `reassignedOwner`).
    func buildPathMapping() -> [String: [(method: String, path: String)]] {
        var mapping: [String: [(method: String, path: String)]] = [:]
        
        for (path, pathItem) in spec.paths {
            let operations: [(String, OperationObject?)] = [
                ("GET", pathItem.get),
                ("POST", pathItem.post),
                ("DELETE", pathItem.delete),
            ]
            
            for (method, operation) in operations {
                // A file response (the quote PDF) has no JSON type to group by: use its owner
                if let op = operation, op.fileResponseContentType != nil {
                    let owners = Set((stripeMethodNames["\(method) \(path)"] ?? []).filter { $0.methodOn == "service" }.map(\.schema))
                    if owners.count == 1, let owner = owners.first {
                        mapping[owner, default: []].append((method, path))
                    }
                    continue
                }

                guard let op = operation,
                      let response = op.responses?["200"],
                      let content = response.content?["application/json"],
                      let schema = content.schema else { continue }

                // Grouped under its spec owner rather than its response type
                if let owner = reassignedOwner(method: method, path: path) {
                    mapping[owner, default: []].append((method, path))
                    continue
                }
                
                // Direct $ref → single resource endpoint
                if let ref = schema.ref {
                    let schemaName = refToSchemaName(ref)
                    mapping[schemaName, default: []].append((method, path))

                    // DELETE returning only "deleted_X" belongs to X
                    // (otherwise e.g. DELETE /v1/terminal/locations/{location} is never generated)
                    if method == "DELETE", schemaName.starts(with: SpecParser.deletedPrefix) {
                        let live = String(schemaName.dropFirst(SpecParser.deletedPrefix.count))
                        if spec.components.schemas[live] != nil {
                            mapping[live, default: []].append((method, path))
                        }
                    }
                }

                // "X | deleted_X" → X's endpoint (e.g. GET /v1/terminal/readers/{reader})
                if let refs = schema.anyOf?.compactMap({ $0.ref.map(refToSchemaName) }),
                   refs.count == schema.anyOf?.count {
                    let live = refs.filter { !$0.starts(with: SpecParser.deletedPrefix) }
                    if live.count == 1, refs.contains(SpecParser.deletedPrefix + live[0]) {
                        mapping[live[0], default: []].append((method, path))
                    }
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
            // Deleted objects (some carry an x-resourceId) are plain response types:
            // generate them here rather than as resources, which would also get routes and params.
            let isDeleted = schemaName.starts(with: SpecParser.deletedPrefix)
            guard schema.xResourceId == nil || isDeleted else { continue }
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
                // Polymorphic deleted objects (deleted_external_account → deleted_bank_account | deleted_card)
                anyOfVariants: isDeleted ? schema.anyOf.map { refs in
                    refs.compactMap { $0.ref.map(refToSchemaName) }
                } : nil
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
    /// Prefix of the spec's deleted-object schemas (e.g. "deleted_customer"), returned by DELETE endpoints.
    static let deletedPrefix = "deleted_"

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
        // Deleted objects mirror their resource's name: "deleted_terminal.location" → "DeletedLocation"
        if name.starts(with: SpecParser.deletedPrefix) {
            return "Deleted" + schemaNameToSwiftType(String(name.dropFirst(SpecParser.deletedPrefix.count)))
        }

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
