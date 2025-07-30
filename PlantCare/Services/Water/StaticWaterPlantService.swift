//
// Copyright © 2025 Sage.
// All Rights Reserved.

class StaticWaterPlantService: WaterPlantService {
    var values: [PlantStatus.WaterState] = [
        .onTime,
        .late(10),
        .late(9),
        .late(3),
        .early(10),
        .early(5)
    ]
    
    var defaultStatus: PlantStatus.WaterState = .onTime
    
    var randomIndex: Int { Int.random(in: 0..<values.count) }
    
    func waterStatus(plant: Plant) -> PlantStatus {
        let state = values.randomElement() ?? defaultStatus
        
        return .init(plant: plant, state: state)
    }
    func waterStatus(water: WaterRegister) -> PlantStatus {
        let state = values.randomElement() ?? defaultStatus
        
        return .init(plant: water.plant, state: state)
    }
}
