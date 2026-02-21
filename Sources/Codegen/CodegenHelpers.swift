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
