//
//  PlantDetailFieldAdapter.swift
//  PlantCare
//
//  Created by Tiago Pereira on 9/5/26.
//

import AtlasUI

struct PlantDetailFieldAdapter {
    let title: String
    let value: String
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}


extension PlantDetailFieldAdapter: AtlasDefaultCellDataProtocol {
    var image: AtlasCellImageType? { nil }
    var subtitle: String { value }
    var caption: String? { nil }
    var chevron: Bool { false }
    var id: String { subtitle }
}
