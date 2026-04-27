
// Copyright © 2026 Sage.
// All Rights Reserved.


enum PlantTypeSelectorDestination: Hashable, Identifiable {
    case example

    var id: String {
        switch self {
        case .example:
            return "example"
        }
    }
}
