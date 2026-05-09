import Foundation
import SwiftData

enum DashboardDestination: Hashable, Identifiable {
    case addPlant
    case detail(PersistentIdentifier)
    
    var id: String {
        switch self {
        case .addPlant:
            return "addPlant"
        case .detail(let id):
            return "detail_\(id)"
        }
    }
}
