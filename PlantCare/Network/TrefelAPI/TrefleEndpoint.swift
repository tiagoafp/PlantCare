import AtlasNetwork

enum TrefleEndpoint: Sendable {
    case plants
    case search
    
    var endpoint: String {
        switch self {
        case .plants:
            return "plants"
        case .search:
            return "plants/search"
        }
    }
    
    var httpMethod: AtlasHTTPMethod {
        switch self {
        case .plants, .search:
            return .get
        }
    }
}
