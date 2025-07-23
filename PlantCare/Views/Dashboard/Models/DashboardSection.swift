//
//
// PlantCare
// Created by: tiago.pereira on 4/6/25
//

import SwiftUI

enum DashboardSection: Hashable {
    case water
    case plants
    case types
    
    var title: String {
        switch self {
        case .water:
            return .localized(.water)
        case .plants:
            return .localized(.plants)
        case .types:
            return .localized(.types)
        }
    }
    
    var actionString: String {
        switch self {
        case .water:
            return .localized(.water_plants)
        case .plants:
            return .localized(.details)
        case .types:
            return .localized(.details)
        }
    }
}
