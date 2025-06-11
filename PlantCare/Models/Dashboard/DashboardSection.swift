//
//
// PlantCare
// Created by: tiago.pereira on 4/6/25
//

import SwiftUI

struct DashboardSection<Item: DashboardSectionItemProtocol> {
    let type: DashboardSectionType
    var items: [Item]
    
    init(type: DashboardSectionType, items: [Item] = []) {
        self.type = type
        self.items = items
    }
    
    mutating func update(items: [Item]) {
        self.items = items
    }
}


extension DashboardSection: DashboardSectionProtocol {
    var title: String {
        switch type {
        case .water:
            return .translation(.water)
        case .plants:
            return .translation(.plants)
        case .type:
            return .translation(.types)
        }
    }
    
    var actionString: String {
        switch type {
        case .water:
            return .translation(.water_plants)
        case .plants:
            return .translation(.details)
        case .type:
            return .translation(.details)
        }
    }
    
    
}
