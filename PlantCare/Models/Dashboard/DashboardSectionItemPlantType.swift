//
//
// PlantCare
// Created by: tiago.pereira on 4/6/25
//

import SwiftData
import PixelKit

struct DashboardSectionItemPlantType {
    let plantType: PlantType
    
    init(plantType: PlantType) {
        self.plantType = plantType
    }
}

extension DashboardSectionItemPlantType: DashboardSectionItemProtocol {
    var id: PersistentIdentifier { plantType.persistentModelID }
    
    var image: ImageView.Variant? { nil }
    
    var subtitle: String { .plural(.number_of_plants(1)) }
    
    var subtitleType: CellSubtitle.Variant { .default }
    
    var name: String { plantType.name }
    
    var disclosure: Bool { false }
}
