//
//
// PlantCare
// Created by: tiago.pereira on 4/6/25
//

import SwiftUI

struct DashboardSection: Hashable {
    var type: SectionType
    var items: [DashboardItem]
    
    init(type: SectionType, items: [DashboardItem] = []) {
        self.type = type
        self.items = items
    }
    
    mutating func update(items: [DashboardItem]) {
        self.items = items
    }
}

extension DashboardSection {
    enum SectionType {
        case water
        case plants
        case types
    }
}


extension DashboardSection {
    var title: String {
        switch type {
        case .water:
            return .localized(.water)
        case .plants:
            return .localized(.plants)
        case .types:
            return .localized(.types)
        }
    }
    
    var actionString: String {
        switch type {
        case .water:
            return .localized(.water_plants)
        case .plants:
            return .localized(.details)
        case .types:
            return .localized(.details)
        }
    }
}
