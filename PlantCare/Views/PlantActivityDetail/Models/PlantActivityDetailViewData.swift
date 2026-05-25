//
//  PlantActivityDetailViewData.swift
//  PlantCare
//
//  Created by Tiago Pereira on 20/5/26.
//

import AtlasUI

struct PlantActivityDetailViewData: Hashable {
    var plant: PlantCellDataAdapter
    var activity: PlantActivityTimelineAdapter
    
    var dateCell: PlantActivityItemData {
        .init(
            image: nil,
            title: .localized(key: .date),
            subtitle: activity.activity.date.formatted(date: .abbreviated, time: .omitted),
            caption: nil,
            chevron: false,
            id: activity.id
        )
    }
    
    var timeCell: PlantActivityItemData {
        .init(
            image: nil,
            title: .localized(key: .time),
            subtitle: activity.activity.date.formatted(date: .omitted, time: .standard),
            caption: nil,
            chevron: false,
            id: activity.id
        )
    }
    
    var notesCell: PlantActivityItemData? {
        guard let notes = activity.activity.notes else { return nil }
        
        return .init(
            image: nil,
            title: .localized(key: .notes),
            subtitle: notes,
            caption: nil,
            chevron: false,
            id: activity.id
        )
    }
    
    init(
        plant: PlantRecord,
        activity: PlantActivityRecord,
        plantImageManager: ImageStorageManagerProtocol,
        activityImageManager: ImageStorageManagerProtocol
    ) {
        self.plant = .init(
            plantRecord: plant,
            uiImage: plantImageManager.loadImage(from: plant.photo),
            chevron: false
        )
        
        self.activity = .init(activity: activity, photo: activityImageManager.loadImage(from: activity.photo))
    }
}
