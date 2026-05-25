import Foundation

enum PlantActivityDetailDestination: Hashable, Identifiable {
    case edit(PlantRecord, PlantActivityRecord)
    
    var id: String {
        switch self {
        case .edit(_, let activity):
            return "edit_\(activity.id)"
        }
    }
}

