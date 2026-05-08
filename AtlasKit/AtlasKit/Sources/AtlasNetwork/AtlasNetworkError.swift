import Foundation

public enum AtlasNetworkError: Error {
    case malformed
    case generic(reason: String)
    case decode(DecodingError)
}
