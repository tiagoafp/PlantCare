//
//
// PlantCare
// Created by: tiago.pereira on 25/5/25
//

import SwiftData
import Foundation

@Model
public class PlantCareModel {
    @Attribute(.unique) public var id: UUID
    var plants: [Plant] = []
    var types: [PlantType] = []
    
    public init() {
        id = UUID()
    }
    
    public func addPlant(plant: Plant) {
        self.plants.append(plant)
    }
    
    public func removePlant(plant: Plant) {
        self.plants.removeAll { $0 == plant }
    }
    
    public func addPlantType(type: PlantType) {
        self.types.append(type)
    }
    
    public func removePlantType(type: PlantType) {
        self.types.removeAll { $0 == type }
    }
}
