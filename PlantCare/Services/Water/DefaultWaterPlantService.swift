//
// Copyright © 2025 Sage.
// All Rights Reserved.

import Foundation

class DefaultWaterPlantService: WaterPlantService {
    var calendar: Calendar
    
    init(calendar: Calendar = .current) {
        self.calendar = calendar
    }
    
    func waterStatus(plant: Plant) -> PlantStatus { .init(plant: plant, state: .onTime) }
    func waterStatus(water: WaterRegister) -> PlantStatus { .init(plant: water.plant, state: .onTime) }
    
}
    /*func calculateNext(baseOn date: Date? = nil) -> Date {
        let last = date ?? lastWateringDate()
        
        switch plant.waterSchedule.casted {
        case .weekly:
            return calendar.date(byAdding: .weekOfYear, value: 1, to: last) ?? last
        case .monthly:
            return calendar.date(byAdding: .month, value: 1, to: last) ?? last
        case .custom(let days):
            return calendar.date(byAdding: .day, value: days, to: last) ?? last
        case .unknown:
            return last
        }
    }
    
    func nextWateringDate() -> Date {
        guard let next = plant.waterRegisters.last?.nextWaterDate else {
            return calculateNext()
        }
        
        return next
    }
    
    func lastWateringDate() -> Date {
        guard let water = plant.waterRegisters.last?.wateredAt else {
            return plant.createdAt
        }
        
        return water
    }
    
    func registerWater() {
        let now: Date = .now
        
        self.plant.waterRegisters.append(
            .init(
                plant: plant,
                wateredAt: now,
                expectedWaterDate: nextWateringDate(),
                nextWaterDate: calculateNext(baseOn: now)
            )
        )
    }
}

extension DefaultWaterPlantService {
    /// Whether this watering was late
    var isLate: Bool {
        guard let expectedDate = expectedWaterDate else { return false }
        return wateredAt > expectedDate
    }
    
    /// Whether this watering was early (more than 1 day before expected)
    var isEarly: Bool {
        guard let expectedDate = expectedWaterDate else { return false }
        return wateredAt < Calendar.current.date(byAdding: .day, value: -1, to: expectedDate) ?? expectedDate
    }
    
    /// Whether this watering was on time
    var isOnTime: Bool {
        return !isLate && !isEarly
    }
    
    /// Days this watering was late (0 if not late)
    var daysLate: Int {
        guard let expectedDate = expectedWaterDate, isLate else { return 0 }
        return Calendar.current.dateComponents([.day], from: expectedDate, to: wateredAt).day ?? 0
    }
    
    /// Days this watering was early (0 if not early)
    var daysEarly: Int {
        guard let expectedDate = expectedWaterDate, isEarly else { return 0 }
        return Calendar.current.dateComponents([.day], from: wateredAt, to: expectedDate).day ?? 0
    }
    
}*/
