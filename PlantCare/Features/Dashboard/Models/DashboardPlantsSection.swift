//
//
// PlantCare
// Created by: tiago.pereira on 4/6/25
//

import SwiftUI

struct DashboardPlantsSection<Item: DashboardSectionItemProtocol> {
    var type: SectionType
    var items: [Item]
    
    init(type: SectionType, items: [Item] = []) {
        self.type = type
        self.items = items
    }
    
    mutating func update(items: [Item]) {
        self.items = items
    }
}

extension DashboardPlantsSection {
    enum SectionType {
        case water
        case plants
    }
}


extension DashboardPlantsSection {
    var title: String {
        switch type {
        case .water:
            return .localized(.water)
        case .plants:
            return .localized(.plants)
        }
    }
    
    var actionString: String {
        switch type {
        case .water:
            return .localized(.water_plants)
        case .plants:
            return .localized(.details)
        }
    }
}
