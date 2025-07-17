//
//
// PlantCare
// Created by: tiago.pereira on 14/7/25
//

import Foundation

struct WaterScheduleCalculator {
    let waterSchedule: WaterSchedule
    let date: Date
    
    init(waterSchedule: WaterSchedule, date: Date) {
        self.waterSchedule = waterSchedule
        self.date = date
    }
    
    func calculate() -> Date? {
        switch waterSchedule.casted {
        case .weekly:
            return Calendar.current.date(byAdding: .weekOfYear, value: 1, to: .now)
        case .monthly:
            return Calendar.current.date(byAdding: .month, value: 1, to: .now)
        case .custom(let days):
            return Calendar.current.date(byAdding: .day, value: days, to: .now)
        case .unknown:
            return nil
        }
    }
}
