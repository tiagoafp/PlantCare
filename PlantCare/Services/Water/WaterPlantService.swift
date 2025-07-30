//
// Copyright © 2025 Sage.
// All Rights Reserved.

import Foundation

protocol WaterPlantService {
    func waterStatus(plant: Plant) -> PlantStatus
    func waterStatus(water: WaterRegister) -> PlantStatus
}
 
