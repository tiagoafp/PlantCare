import Foundation
import SwiftData

enum PlantDetailDestination: Hashable, Identifiable {
    case edit(PlantRecord)
    
    var id: String {
        switch self {
        case .edit:
            return "edit"
        }
    }
}
