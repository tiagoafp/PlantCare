import Foundation
import SwiftData

enum PlantDetailDestination: Hashable, Identifiable {
    case edit(PlantRecord)
    case logActivity(PlantRecord)
    case editActivity(PlantRecord, PlantActivityRecord)
    
    var id: String {
        switch self {
        case .edit:
            return "edit"
        case .logActivity(let plant):
            return "logActivity_\(plant.id.uuidString)"
        case .editActivity(_, let activity):
            return "editActivity_\(activity.id.uuidString)"
        }
    }
}
