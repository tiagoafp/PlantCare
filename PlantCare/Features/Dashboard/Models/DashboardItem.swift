//
//
// PlantCare
// Created by: tiago.pereira on 14/7/25
//

import PixelKit

@MainActor
protocol DashboardPlantProtocol: Hashable {
    var title: String { get }
    var subtitle: CellSubtitle { get }
    var image: String? { get }
}

struct WaterItem: DashboardPlantProtocol {
    var title: String
    var subtitle: CellSubtitle
    var image: String?
    
    init(plant: Plant) {
        title = plant.name
        let calculator = PlantWaterCalculator(plant: plant)
        subtitle = .negative(.plural(.missing_water(calculator.numberDaysWatering)))
        image = plant.cover
    }
}
