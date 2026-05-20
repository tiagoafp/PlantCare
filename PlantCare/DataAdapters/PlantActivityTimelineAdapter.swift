//
//  PlantActivityTimelineAdapter.swift
//  PlantCare
//
//  Created by Tiago Pereira on 14/5/26.
//

import AtlasUI
import SwiftUI

struct PlantActivityTimelineAdapter {
    let activity: PlantActivityRecord
    let photo: UIImage?
    
    init(
        activity: PlantActivityRecord,
        photo: UIImage?
    ) {
        self.activity = activity
        self.photo = photo
    }
}

extension PlantActivityTimelineAdapter: AtlasTimelineCellDataProtocol {
    var id: ObjectIdentifier { activity.id }
    
    var timelineIcon: Image? {
        PlantActivityTypePickerAdapter(activityType: activity.type).icon
    }
    
    var relatedColor: Color? { nil }
    
    var title: String {
        switch activity.type {
        case .watering:
            return .localized(key: .activityWatered)
        case .sick:
            return .localized(key: .sick)
        case .photo:
            return .localized(key: .photo)
        }
    }
    
    var date: String {
        activity.date.formatted(date: .abbreviated, time: .shortened)
    }
    
    var descripction: String? {
        activity.notes
    }
}
