//
//
// PlantCare
// Created by: tiago.pereira on 4/6/25
//

import PixelKit
import SwiftData

struct DashboardSectionItemPlant {
    let plant: Plant
    
    init(plant: Plant) {
        self.plant = plant
    }
}

extension DashboardSectionItemPlant: DashboardSectionItemProtocol {
    var name: String { plant.name }
    var image: ImageView.Variant? { nil }
    var subtitle: String { plant.type.name }
    var subtitleType: CellSubtitle.Variant { .default }
    var disclosure: Bool { true }
}
