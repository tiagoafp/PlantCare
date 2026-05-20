//
//  DashboardListItemAdapter.swift
//  PlantCare
//
//  Created by Tiago Pereira on 9/5/26.
//

import AtlasUI
import SwiftData
import UIKit

struct PlantCellDataAdapter: AtlasDefaultCellDataProtocol {
    var plantRecord: PlantRecord
    var uiImage: UIImage?
    let chevron: Bool
    
    init(
        plantRecord: PlantRecord,
        uiImage: UIImage?,
        chevron: Bool
    ) {
        self.plantRecord = plantRecord
        self.uiImage = uiImage
        self.chevron = chevron
    }
}

extension PlantCellDataAdapter {
    var image: AtlasCellImageType? {
        guard let uiImage else { return nil }
        
        return .local(uiImage)
    }
    
    var title: String { plantRecord.nickName }
    var subtitle: String { plantRecord.plantType.scientificName }
    var caption: String? { nil }
    var id: PersistentIdentifier { plantRecord.id }
}
