// MARK: - Schema Classification & Dependency Graph

import Foundation

/// Classifies OpenAPI schemas into generation categories and builds
/// the transitive dependency graph for domain filtering.
///
/// This is Phase 2 of the pipeline:
///   Parse → **Classify** → Resolve → Generate → Assemble
struct SchemaClassifier {
    
    let spec: OpenAPISpec
    
    // MARK: - Schema Kind
    
    enum SchemaKind {
        case resource(schemaName: String)           // x-resourceId present, no anyOf
        case polymorphic(schemaName: String, variants: [String])  // anyOf with $ref variants
        case inline(schemaName: String)             // no x-resourceId
        case deleted                                // deleted_* prefix
    }
    
    // MARK: - Classification
    
    /// Classify every schema in the spec into its generation category.
    func classifyAll() -> [String: SchemaKind] {
        var result: [String: SchemaKind] = [:]
        
        for (name, schema) in spec.components.schemas {
            result[name] = classify(name: name, schema: schema)
        }
        
        return result
    }
    
    /// Classify a single schema.
    private func classify(name: String, schema: SchemaObject) -> SchemaKind {
        // Deleted variants — skip entirely
        if name.hasPrefix("deleted_") {
            return .deleted
        }
        
        // Polymorphic: has anyOf with $ref variants (e.g., external_account)
        if let anyOf = schema.anyOf, !anyOf.isEmpty {
            let variants = anyOf.compactMap { $0.ref?.split(separator: "/").last.map(String.init) }
            if !variants.isEmpty {
                return .polymorphic(schemaName: name, variants: variants)
            }
        }
        
        // Resource: has x-resourceId
        if schema.xResourceId != nil {
            return .resource(schemaName: name)
        }
        
        // Everything else is an inline schema
        return .inline(schemaName: name)
    }
    
    // MARK: - Transitive Dependency Graph
    
    /// Given a set of seed schema names, compute the transitive closure of all
    /// schemas they depend on (via $ref in properties). Returns the full set of
    /// schema names needed.
    func transitiveClosure(seeds: Set<String>) -> Set<String> {
        var visited: Set<String> = []
        var queue = Array(seeds)
        
        while let current = queue.popLast() {
            guard !visited.contains(current) else { continue }
            visited.insert(current)
            
            guard let schema = spec.components.schemas[current] else { continue }
            
            // Collect all $ref targets from this schema
            let refs = collectAllRefs(from: schema)
            for ref in refs {
                if !visited.contains(ref) {
                    queue.append(ref)
                }
            }
        }
        
        return visited
    }
    
    /// Compute the set of schemas to generate for a given domain filter.
    /// Uses transitive reachability from the domain's resources.
    func schemasForDomains(_ domains: Set<StripeDomain>) -> Set<String> {
        // 1. Find all resource schemas in the requested domains
        var seeds: Set<String> = []
        for (name, schema) in spec.components.schemas {
            guard !name.hasPrefix("deleted_") else { continue }
            
            let resourceId = schema.xResourceId ?? name
            let domain = StripeDomain.from(resourceId: resourceId)
            
            if domains.contains(domain) {
                seeds.insert(name)
            }
        }
        
        // 2. Compute transitive closure — pulls in all referenced types
        return transitiveClosure(seeds: seeds)
    }
    
    // MARK: - Ref Collection
    
    /// Collect all $ref schema names from a schema's entire property tree.
    private func collectAllRefs(from schema: SchemaObject) -> [String] {
        var refs: [String] = []
        
        // Top-level anyOf (polymorphic schemas)
        if let anyOf = schema.anyOf {
            for variant in anyOf {
                collectPropertyRefs(from: variant, into: &refs)
            }
        }
        
        // Properties
        for (_, prop) in schema.properties ?? [:] {
            collectPropertyRefs(from: prop, into: &refs)
        }
        
        return refs
    }
    
    /// Recursively collect $ref targets from a property and its children.
    private func collectPropertyRefs(from prop: PropertyObject, into refs: inout [String]) {
        // Direct $ref
        if let ref = prop.ref {
            if let name = ref.split(separator: "/").last.map(String.init) {
                refs.append(name)
            }
        }
        
        // anyOf variants
        if let anyOf = prop.anyOf {
            for variant in anyOf {
                collectPropertyRefs(from: variant, into: &refs)
            }
        }
        
        // oneOf variants
        if let oneOf = prop.oneOf {
            for variant in oneOf {
                collectPropertyRefs(from: variant, into: &refs)
            }
        }
        
        // Array items
        if let items = prop.items {
            collectPropertyRefs(from: items, into: &refs)
        }
        
        // Additional properties (dict values)
        if let additionalProperties = prop.additionalProperties {
            collectPropertyRefs(from: additionalProperties, into: &refs)
        }
    }
}
