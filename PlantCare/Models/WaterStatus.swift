//
// Copyright © 2025 Sage.
// All Rights Reserved.

import Foundation

struct PlantStatus: Hashable {
    let plant: Plant
    var state: WaterState
    
    init(plant: Plant, state: WaterState) {
        self.plant = plant
        self.state = state
    }
}

extension PlantStatus {
    enum WaterState: Hashable {
        case late(Int)
        case early(Int)
        case onTime
    }
}

extension PlantStatus: Comparable {
    static func < (lhs: PlantStatus, rhs: PlantStatus) -> Bool {
        switch (lhs.state, rhs.state) {
        case (.late(let lhsDays), .late(let rhsDays)):
            return lhsDays > rhsDays
        case (.late, .early), (.late, .onTime):
            return true
        case (.early, .early):
            return true
        case (.early, .onTime):
            return true
        case (.onTime, _):
            return false
        case (.early, .late):
            return false
        }
    }
    
    
}
