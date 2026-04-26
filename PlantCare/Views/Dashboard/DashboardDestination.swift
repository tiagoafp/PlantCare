
enum DashboardDestination: Hashable, Identifiable {
    case addPlant
    
    var id: String {
        switch self {
        case .addPlant:
            return "addPlant"
        }
    }
}
