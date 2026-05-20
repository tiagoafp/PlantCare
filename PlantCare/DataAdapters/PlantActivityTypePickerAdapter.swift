//
//  ActivityType+AtlasPickerCellDataItemProtocol.swift
//  PlantCare
//
//  Created by Tiago Pereira on 14/5/26.
//

import AtlasUI
import SwiftUI

struct PlantActivityTypePickerAdapter: AtlasPickerCellDataItemProtocol {
    let activityType: PlantActivityType
    
    init(activityType: PlantActivityType) {
        self.activityType = activityType
    }
    
    var id: String { activityType.rawValue }
    
    var title: String {
        switch activityType {
        case .watering:
                .localized(key: .activityTypeWater)
        case .photo:
                .localized(key: .photo)
        case .sick:
                .localized(key: .sick)
        }
    }
    
    var icon: Image? {
        switch activityType {
        case .watering:
                .init(systemName: "drop.fill")
        case .photo:
                .init(systemName: "camera")
        case .sick:
                .init(systemName: "exclamationmark.circle")
        }
    }
}
