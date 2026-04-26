enum AddPlantDestination: Hashable, Identifiable {
    case example

    var id: String {
        switch self {
        case .example:
            return "example"
        }
    }
}
