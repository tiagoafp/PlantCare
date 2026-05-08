import AtlasNetwork
import Foundation

enum PlantnetEndpoint: Sendable {
    case identify(String)
    
    var endpoint: String {
        switch self {
        case .identify:
            return "identify/all"
        }
    }
    
    var httpMethod: AtlasHTTPMethod {
        switch self {
        case .identify:
            return .post
        }
    }
    
    var contentType: String {
        switch self {
        case .identify(let boundary):
            return "multipart/form-data; boundary=\(boundary)"
        }
    }
}
