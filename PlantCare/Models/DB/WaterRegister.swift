//
//
// PlantCare
// Created by: tiago.pereira on 13/6/25
//

import SwiftData
import Foundation

@Model
public class WaterRegister {
    var plantedAt: Date
    
    init() {
        self.plantedAt = .now
    }
}
