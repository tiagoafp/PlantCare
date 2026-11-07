import Foundation
import SwiftData

enum PlantDetailDestination: Hashable, Identifiable {
    case edit(PlantRecord)
    case logActivity(PlantRecord)
    case editActivity(PlantRecord, PlantActivityRecord)
    case viewAllActivites(plantId: UUID)
    
    var id: String {
        switch self {
        case .edit:
            return "edit"
        case .logActivity(let plant):
            return "logActivity_\(plant.id)"
        case .editActivity(_, let activity):
            return "editActivity_\(activity.id)"
        case .viewAllActivites(plantId: let id):
            return "viewAllActivites_\(id)"
        }
    }
}
