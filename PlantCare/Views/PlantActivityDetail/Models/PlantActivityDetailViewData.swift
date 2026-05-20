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
    
    init(
        plant: PlantRecord,
        activity: PlantActivityRecord,
        plantImageManager: ImageStorageManagerProtocol
    ) {
        self.plant = .init(
            plantRecord: plant,
            uiImage: plantImageManager.loadImage(from: plant.photo),
            chevron: false
        )
        
        self.activity = .init(activity: activity, photo: nil)
    }
}
