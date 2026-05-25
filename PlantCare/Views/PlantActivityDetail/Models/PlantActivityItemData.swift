//
//  PlantActivityData.swift
//  PlantCare
//
//  Created by Tiago Pereira on 21/5/26.
//

import AtlasUI

struct PlantActivityItemData: AtlasDefaultCellDataProtocol {
    let image: AtlasCellImageType?
    
    let title: String
    
    let subtitle: String
    
    let caption: String?
    
    let chevron: Bool
    
    let id: ObjectIdentifier
    
    init(image: AtlasCellImageType?, title: String, subtitle: String, caption: String?, chevron: Bool, id: ObjectIdentifier) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.caption = caption
        self.chevron = chevron
        self.id = id
    }
}
