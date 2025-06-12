//
//
// PlantCare
// Created by: tiago.pereira on 12/6/25
//

import SwiftData

@Model
public class WaterSchedule {
    var type: String
    var numberDay: Int?
    
    public init(schedule: WaterScheduleType) {
        switch schedule {
        case .custom(let days):
            self.numberDay = days
            self.type = schedule.type
        default:
            self.type = schedule.type
        }
    }
    
    var casted: WaterScheduleType {
        if type == WaterScheduleType.weekly.type {
            return .weekly
        }
        
        if type == WaterScheduleType.monthly.type {
            return .monthly
        }
        
        if type == "custom" {
            return .custom(numberDay ?? 0)
        }
        
        return .unknown
    }
}

public enum WaterScheduleType: Hashable {
    case weekly
    case monthly
    case custom(Int)
    case unknown
    
    var type: String {
        switch self {
        case .weekly:
            return "weekly"
        case .monthly:
            return "monthly"
        case .custom:
            return "custom"
        case .unknown:
            return ""
        }
    }
}
