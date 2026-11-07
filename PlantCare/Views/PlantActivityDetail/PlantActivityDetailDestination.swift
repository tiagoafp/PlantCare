import Foundation

enum PlantActivityDetailDestination: Hashable, Identifiable {
    case edit(plantId: UUID, activityId: UUID)
    
    var id: String {
        switch self {
        case .edit(_, let activity):
            return "edit_\(activity.uuidString)"
        }
    }
}

