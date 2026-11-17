// MARK: - Shared Codegen Helpers
// Common utilities used across all generators

import Foundation

/// Strip HTML tags, normalize whitespace, collapse newlines
func cleanDescription(_ text: String) -> String {
    var cleaned = text
    cleaned = cleaned.replacing(/<[^>]+>/, with: "")
    cleaned = cleaned.replacing("\n", with: " ")
    cleaned = cleaned.replacing(#/  +/#, with: " ")
    return String(cleaned.trimmingCharacters(in: .whitespaces))
}

/// Backtick-escape Swift reserved keywords
func escapedSwiftName(_ name: String) -> String {
    // Only actual Swift keywords need backtick escaping.
    // Common property names like `type`, `description`, `object` are NOT keywords.
    let reserved: Set<String> = [
        "class", "struct", "enum", "protocol", "extension",
        "func", "var", "let", "import", "return", "if", "else",
        "switch", "case", "default", "for", "while", "repeat",
        "break", "continue", "in", "where", "throw", "throws",
        "try", "catch", "as", "is", "true", "false", "nil",
        "self", "super", "init", "deinit", "subscript", "operator",
        "static", "public", "private", "internal", "open",
        "do", "guard", "defer", "typealias", "associatedtype", "inout",
    ]
    if reserved.contains(name) {
        return "`\(name)`"
    }
    return name
}

/// Convert a raw enum value to a valid Swift camelCase identifier
func enumCaseToSwift(_ rawValue: String) -> String {
    if rawValue == "*" { return "all" }
    
    let sanitized = rawValue
        .replacing(".", with: "_")
        .replacing("-", with: "_")
        .replacing("/", with: "_")
        .replacing(" ", with: "_")
    
    let cleaned = sanitized.unicodeScalars.filter {
        CharacterSet.alphanumerics.contains($0) || $0 == "_"
    }.map { String($0) }.joined()
    
    let parts = cleaned.split(separator: "_").filter { !$0.isEmpty }
    guard let first = parts.first else { return "unknown" }
    
    var camel = String(first).lowercased() + parts.dropFirst()
        .map { $0.capitalized }
        .joined()
    
    if let c = camel.first, c.isNumber {
        camel = "v" + camel
    }
    
    return escapedSwiftName(camel)
}

/// Convert snake_case to camelCase
func snakeToCamel(_ name: String) -> String {
    let parts = name.split(separator: "_")
    guard let first = parts.first else { return name }
    return String(first) + parts.dropFirst()
        .map { $0.capitalized }
        .joined()
}

/// Capitalize the first letter of a string
func capitalize(_ s: String) -> String {
    s.prefix(1).uppercased() + s.dropFirst()
}

/// The schema name a `$ref` points to: "#/components/schemas/customer" → "customer"
func refToSchemaName(_ ref: String) -> String {
    ref.split(separator: "/").last.map(String.init) ?? ref
}

/// `///` doc comment lines for a spec description (HTML stripped, wrapped at 100 columns).
/// Empty when there's no description.
func docComment(_ description: String?, indent: String = "") -> [String] {
    guard let description, !description.isEmpty else { return [] }
    return wordWrap(cleanDescription(description), lineLength: 100).map { "\(indent)/// \($0)" }
}

/// The case a polymorphic enum (`ExternalAccount`, `PaymentSource`) holds an object of a type it
/// doesn't know in, as raw JSON: `.undocumented(json)`. Named like swift-openapi-generator's
/// `undocumented` cases.
let undocumentedCase = "undocumented"

/// A Swift string literal for `value`
func swiftStringLiteral(_ value: String) -> String {
    "\"" + value.replacingOccurrences(of: "\\", with: "\\\\").replacingOccurrences(of: "\"", with: "\\\"") + "\""
}

/// An extensible string type for a spec enum: a struct holding the raw value, with a static
/// member per known value, like the "extensible enums" Apple's Objective-C headers import as
/// (`NS_TYPED_EXTENSIBLE_ENUM`) and Soto's open-ended types.
///
///     public struct PaymentMethodType: RawRepresentable, Codable, Hashable, Sendable {
///         public let rawValue: String
///         public static var card: Self { .init(rawValue: "card") }
///     }
///
/// Stripe adds enum values without a new API version (new payment method types, error codes,
/// …), so any value decodes, including ones this version doesn't list, and can be sent in
/// params (`.init(rawValue: "new_value")`). Call sites read like an enum's: `type == .card`,
/// `switch type { case .card: … default: … }`. No mapping code is needed, so it costs a line
/// per value.
///
/// `valueDescriptions` (from `x-stripeEnum`) become the members' doc comments. "" is skipped
/// (Stripe uses it to mean "unset"); values that map to the same Swift name keep the first.
/// Empty when no values are left.
func generateStringEnum(
    name: String,
    cases: [String],
    description: String? = nil,
    valueDescriptions: [String: String] = [:]
) -> [String] {
    var members: [(name: String, rawValue: String)] = []
    var seen: Set<String> = ["rawValue"]
    for rawValue in cases where !rawValue.isEmpty {
        let member = enumCaseToSwift(rawValue)
        guard seen.insert(member).inserted else { continue }
        members.append((member, rawValue))
    }
    guard !members.isEmpty else { return [] }

    var lines = docComment(description)
    lines.append("public struct \(name): RawRepresentable, Codable, Hashable, Sendable {")
    lines.append("    public let rawValue: String")
    lines.append("")
    lines.append("    public init(rawValue: String) {")
    lines.append("        self.rawValue = rawValue")
    lines.append("    }")
    lines.append("")
    for member in members {
        lines.append(contentsOf: docComment(valueDescriptions[member.rawValue], indent: "    "))
        lines.append("    public static var \(member.name): Self { .init(rawValue: \(swiftStringLiteral(member.rawValue))) }")
    }
    lines.append("}")
    return lines
}

/// Word-wrap text to a given line length
func wordWrap(_ text: String, lineLength: Int) -> [String] {
    var lines: [String] = []
    var currentLine = ""
    
    for word in text.split(separator: " ") {
        if currentLine.isEmpty {
            currentLine = String(word)
        } else if currentLine.count + 1 + word.count > lineLength {
            lines.append(currentLine)
            currentLine = String(word)
        } else {
            currentLine += " " + word
        }
    }
    if !currentLine.isEmpty {
        lines.append(currentLine)
    }
    
    return lines
}
