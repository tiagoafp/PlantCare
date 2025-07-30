//
//
// PlantCare
// Created by: tiago.pereira on 13/6/25
//

import SwiftData
import Foundation

@Model
public class WaterRegister {
    @Attribute(.unique) public var id: UUID
    @Relationship
    var plant: Plant
    var wateredAt: Date      
    
    init(
        plant: Plant,
        wateredAt: Date = .now
    ) {
        self.id = .init()
        self.plant = plant
        self.wateredAt = wateredAt
    }
}
