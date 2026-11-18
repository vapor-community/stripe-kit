//
//  PercentEncoding.swift
//  StripeKitCore
//
//  Hand-written infrastructure (not emitted by stripe-kit-codegen).
//

extension StringProtocol {
    /// Percent-encodes every UTF-8 byte except RFC 3986's unreserved characters
    /// (`A-Z a-z 0-9 - . _ ~`), as Stripe's own SDKs do.
    ///
    /// The result is safe as a single path segment, a query value, or a form-encoded
    /// name or value. Foundation's `addingPercentEncoding(withAllowedCharacters:)` isn't
    /// available from `FoundationEssentials`, so this is written out.
    package func percentEncoded() -> String {
        guard utf8.contains(where: { !$0.isUnreserved }) else { return String(self) }

        return String(unsafeUninitializedCapacity: utf8.count * 3) { buffer in
            var count = 0
            for byte in utf8 {
                if byte.isUnreserved {
                    buffer[count] = byte
                    count += 1
                } else {
                    buffer[count] = UInt8(ascii: "%")
                    buffer[count + 1] = hexDigit(byte >> 4)
                    buffer[count + 2] = hexDigit(byte & 0x0F)
                    count += 3
                }
            }
            return count
        }
    }
}

extension UInt8 {
    /// RFC 3986 `unreserved`: `ALPHA / DIGIT / "-" / "." / "_" / "~"`
    fileprivate var isUnreserved: Bool {
        switch self {
        case UInt8(ascii: "A")...UInt8(ascii: "Z"),
             UInt8(ascii: "a")...UInt8(ascii: "z"),
             UInt8(ascii: "0")...UInt8(ascii: "9"),
             UInt8(ascii: "-"), UInt8(ascii: "."), UInt8(ascii: "_"), UInt8(ascii: "~"):
            true
        default:
            false
        }
    }
}

/// The uppercase hex digit for a value in `0...15`.
private func hexDigit(_ value: UInt8) -> UInt8 {
    value < 10 ? UInt8(ascii: "0") + value : UInt8(ascii: "A") + value - 10
}
