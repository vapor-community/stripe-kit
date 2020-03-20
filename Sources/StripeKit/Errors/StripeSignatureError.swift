/// An error returned when verifying signatures
public enum StripeSignatureError: Error {
    /// The supplied header could not be parsed in the appropiate format `"t=xxx,v1=yyy"`
    case unableToParseHeader
    /// No signatures were found that matched the expected signature
    case noMatchingSignatureFound
    /// The timestamp was outside of the tolerated time difference
    case timestampNotTolerated
}
