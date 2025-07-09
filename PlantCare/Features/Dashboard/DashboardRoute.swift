//
//
// PlantCare
// Created by: tiago.pereira on 31/5/25
//

import SwiftUI
import SwiftData

enum DashboardRoute: ViewRoute {
    case water
    case plants
    case types
    case plant(PersistentIdentifier)
    
    var id: String {
        switch self {
        case .water:
            return "water"
        case .plants:
            return "plants"
        case .types:
            return "types"
        case .plant:
            return "plant"
        }
    }
}
