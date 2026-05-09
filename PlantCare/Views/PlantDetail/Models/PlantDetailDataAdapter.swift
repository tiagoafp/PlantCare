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
    private  let plantRecord: PlantRecord
    
    init?(imageManager: ImageStorageManagerProtocol, plantRecord: PlantRecord) {
        guard let image = imageManager.loadImage(from: plantRecord.photo) else {
            return nil
        }
        
        self.image = image
        self.plantRecord = plantRecord
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
    
    var typeField: AddPlantSepciesAdapter {
        .init(data: plantRecord.plantType)
    }
}
