//
//  PlantDetailDataAdapter.swift
//  PlantCare
//
//  Created by Tiago Pereira on 9/5/26.
//

import UIKit
import AtlasUI

struct PlantDetailDataAdapter: Hashable {
    private let image: UIImage
    private let plantRecord: PlantRecord
    let activityRecords: [PlantActivityTimelineAdapter]

    init?(imageManager: ImageStorageManagerProtocol, plantRecord: PlantRecord, activityRecords: [PlantActivityTimelineAdapter]) {
        guard let image = imageManager.loadImage(from: plantRecord.photo) else {
            return nil
        }

        self.image = image
        self.plantRecord = plantRecord
        self.activityRecords = activityRecords
    }
}

extension PlantDetailDataAdapter {
    var detailImage: AtlasCellImageType { .local(image) }

    var nickNameField: PlantDetailFieldAdapter {
        .init(
            title: .localized(key: .nickname),
            value: plantRecord.nickName
        )
    }

    var typeField: PlantFormSpeciesAdapter {
        .init(data: plantRecord.plantType)
    }
}
