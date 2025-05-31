//
//
// PlantCare
// Created by: tiago.pereira on 25/5/25
//

import SwiftData
import Foundation

@Model
public class PlantType {
    @Attribute(.unique) public var id: UUID
    var name: String
    var plants: [Plant]
    
    public init(name: String) {
        self.id = UUID()
        self.name = name
        self.plants = []
    }
    
    public func addPlant(plant: Plant) {
        self.plants.append(plant)
    }
    
    public func removePlant(plant: Plant) {
        self.plants.removeAll { $0.id == plant.id }
    }
}
