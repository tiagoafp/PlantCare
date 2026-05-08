import Foundation

enum PlantTypeSelectorDestination: Hashable, Identifiable {
    case add(Data?, TrefleListResponse.Species)

    var id: String {
        switch self {
        case .add:
            return "add"
        }
    }
}
