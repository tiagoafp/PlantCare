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
            return .localized(.water)
        case .plants:
            return .localized(.plants)
        case .type:
            return .localized(.types)
        }
    }
    
    var actionString: String {
        switch type {
        case .water:
            return .localized(.water_plants)
        case .plants:
            return .localized(.details)
        case .type:
            return .localized(.details)
        }
    }
    
    
}
