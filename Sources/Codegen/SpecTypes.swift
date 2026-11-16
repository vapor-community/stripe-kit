// MARK: - OpenAPI Spec Data Types

import Foundation

/// Represents the top-level OpenAPI spec structure (subset we care about)
struct OpenAPISpec: Decodable {
    let openapi: String
    let info: SpecInfo
    let paths: [String: PathItem]
    let components: Components
    
    struct SpecInfo: Decodable {
        let title: String
        let version: String
    }
    
    struct Components: Decodable {
        let schemas: [String: SchemaObject]
    }
}

/// A schema object from the spec
struct SchemaObject: Decodable {
    let type: String?
    let description: String?
    let properties: [String: PropertyObject]?
    let required: [String]?
    let `enum`: [String]?
    let anyOf: [PropertyObject]?
    let oneOf: [PropertyObject]?
    let nullable: Bool?
    let items: PropertyObject?
    
    // Stripe vendor extensions
    let xResourceId: String?
    let xExpandableFields: [String]?
    
    enum CodingKeys: String, CodingKey {
        case type, description, properties, required
        case `enum`, anyOf, oneOf, nullable, items
        case xResourceId = "x-resourceId"
        case xExpandableFields = "x-expandableFields"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        properties = try container.decodeIfPresent([String: PropertyObject].self, forKey: .properties)
        required = try container.decodeIfPresent([String].self, forKey: .required)
        `enum` = try container.decodeIfPresent(MixedEnumArray.self, forKey: .enum)?.values
        anyOf = try container.decodeIfPresent([PropertyObject].self, forKey: .anyOf)
        oneOf = try container.decodeIfPresent([PropertyObject].self, forKey: .oneOf)
        nullable = try container.decodeIfPresent(Bool.self, forKey: .nullable)
        items = try container.decodeIfPresent(PropertyObject.self, forKey: .items)
        xResourceId = try container.decodeIfPresent(String.self, forKey: .xResourceId)
        xExpandableFields = try container.decodeIfPresent([String].self, forKey: .xExpandableFields)
    }
}

/// A property within a schema — must be a class due to recursive `items` field
final class PropertyObject: Decodable {
    let type: String?
    let description: String?
    let title: String?
    let `enum`: [String]?
    let ref: String?
    let anyOf: [PropertyObject]?
    let oneOf: [PropertyObject]?
    let nullable: Bool?
    let items: PropertyObject?
    let properties: [String: PropertyObject]?
    let required: [String]?
    let additionalProperties: PropertyObject?
    
    enum CodingKeys: String, CodingKey {
        case type, description, title, `enum`
        case ref = "$ref"
        case anyOf, oneOf, nullable, items, properties, required
        case additionalProperties
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        `enum` = try container.decodeIfPresent(MixedEnumArray.self, forKey: .enum)?.values
        ref = try container.decodeIfPresent(String.self, forKey: .ref)
        anyOf = try container.decodeIfPresent([PropertyObject].self, forKey: .anyOf)
        oneOf = try container.decodeIfPresent([PropertyObject].self, forKey: .oneOf)
        nullable = try container.decodeIfPresent(Bool.self, forKey: .nullable)
        items = try container.decodeIfPresent(PropertyObject.self, forKey: .items)
        properties = try container.decodeIfPresent([String: PropertyObject].self, forKey: .properties)
        required = try container.decodeIfPresent([String].self, forKey: .required)
        // additionalProperties can be a boolean or an object schema
        if let obj = try? container.decodeIfPresent(PropertyObject.self, forKey: .additionalProperties) {
            additionalProperties = obj
        } else {
            // Boolean additionalProperties (e.g. `"additionalProperties": false`) — ignore
            additionalProperties = nil
        }
    }

    /// Build a schema in code, e.g. an object synthesized from an operation's query parameters.
    init(
        type: String? = nil,
        description: String? = nil,
        title: String? = nil,
        enum: [String]? = nil,
        ref: String? = nil,
        anyOf: [PropertyObject]? = nil,
        oneOf: [PropertyObject]? = nil,
        nullable: Bool? = nil,
        items: PropertyObject? = nil,
        properties: [String: PropertyObject]? = nil,
        required: [String]? = nil,
        additionalProperties: PropertyObject? = nil
    ) {
        self.type = type
        self.description = description
        self.title = title
        self.enum = `enum`
        self.ref = ref
        self.anyOf = anyOf
        self.oneOf = oneOf
        self.nullable = nullable
        self.items = items
        self.properties = properties
        self.required = required
        self.additionalProperties = additionalProperties
    }

    /// A copy of this schema with a different description.
    func withDescription(_ description: String?) -> PropertyObject {
        PropertyObject(
            type: type, description: description, title: title, enum: `enum`, ref: ref,
            anyOf: anyOf, oneOf: oneOf, nullable: nullable, items: items,
            properties: properties, required: required, additionalProperties: additionalProperties
        )
    }
}

/// Handles Stripe's mixed-type enum arrays: `["string_val", true, 123, ""]`
/// Converts all values to String representations
struct MixedEnumArray: Decodable {
    let values: [String]
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var result: [String] = []
        
        while !container.isAtEnd {
            if let str = try? container.decode(String.self) {
                result.append(str)
            } else if let bool = try? container.decode(Bool.self) {
                result.append(String(bool))
            } else if let int = try? container.decode(Int.self) {
                result.append(String(int))
            } else if let double = try? container.decode(Double.self) {
                result.append(String(double))
            } else {
                // Skip unknown types
                _ = try? container.decode(AnyCodable.self)
            }
        }
        
        values = result
    }
}

/// Sink for unknown/unneeded JSON values
struct AnyCodable: Decodable {
    init(from decoder: Decoder) throws {
        _ = try? decoder.singleValueContainer()
    }
}

/// A path item from the spec
struct PathItem: Decodable {
    let get: OperationObject?
    let post: OperationObject?
    let delete: OperationObject?
    let put: OperationObject?
    let patch: OperationObject?
}

/// An operation (method) on a path
struct OperationObject: Decodable {
    let operationId: String?
    let description: String?
    let deprecated: Bool?
    let requestBody: RequestBody?
    let responses: [String: ResponseObject]?
    let parameters: [ParameterObject]?
    
    struct RequestBody: Decodable {
        let content: [String: MediaType]?
        let required: Bool?
    }
    
    struct MediaType: Decodable {
        /// Full PropertyObject so we can parse inline requestBody schemas
        let schema: PropertyObject?
    }
    
    struct ResponseObject: Decodable {
        let content: [String: MediaType]?
    }
}

/// A query/path parameter on an operation
struct ParameterObject: Decodable {
    let name: String?
    let `in`: String?
    let required: Bool?
    let description: String?
    let schema: PropertyObject?
}

extension OperationObject {
    /// Query parameters other than `expand` (which every operation handles on its own).
    var queryParameters: [ParameterObject] {
        (parameters ?? []).filter { $0.in == "query" && $0.name != nil && $0.name != "expand" && $0.schema != nil }
    }

    /// The operation's query parameters as an object schema, so `ParamGenerator` can turn
    /// them into a params struct the same way it does request bodies. Nil when there are none.
    /// Includes `expand`, so it lands in the struct's initializer like it does for request bodies.
    func queryParametersSchema(description: String?) -> PropertyObject? {
        guard !queryParameters.isEmpty else { return nil }
        let params = (parameters ?? []).filter { $0.in == "query" && $0.name != nil && $0.schema != nil }
        var properties: [String: PropertyObject] = [:]
        for param in params {
            guard let name = param.name, let schema = param.schema else { continue }
            properties[name] = schema.description == nil ? schema.withDescription(param.description) : schema
        }
        let required = params.filter { $0.required == true }.compactMap(\.name)
        return PropertyObject(type: "object", description: description, properties: properties, required: required)
    }
}
