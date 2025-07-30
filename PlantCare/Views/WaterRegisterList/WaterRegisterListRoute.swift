//
// Copyright © 2025 Sage.
// All Rights Reserved.

enum WaterRegisterListRoute: ViewRoute {
    case edit
    
    var id: String {
        switch self {
        case .edit:
            return "edit"
        }
    }
}
