//
//  DashboardListItemAdapter.swift
//  PlantCare
//
//  Created by Tiago Pereira on 9/5/26.
//

import AtlasUI
import SwiftData
import UIKit

struct DashboardListItemAdapter: AtlasDefaultCellDataProtocol {
    var plantRecord: PlantRecord
    var uiImage: UIImage?
    
    init(
        plantRecord: PlantRecord,
        uiImage: UIImage?
    ) {
        self.plantRecord = plantRecord
        self.uiImage = uiImage
    }
}

extension DashboardListItemAdapter {
    var image: AtlasCellImageType? {
        guard let uiImage else { return nil }
        
        return .local(uiImage)
    }
    
    var title: String { plantRecord.nickName }
    var subtitle: String { plantRecord.plantType.scientificName }
    var caption: String? { nil }
    var chevron: Bool { true }
    var id: PersistentIdentifier { plantRecord.id }
}
