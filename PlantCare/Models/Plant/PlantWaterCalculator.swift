//
//
// PlantCare
// Created by: tiago.pereira on 14/7/25
//
import Foundation

struct PlantWaterCalculator {
    private var plant: Plant
    
    init(plant: Plant) {
        self.plant = plant
    }
    
    private var wateringDate: Date {
        guard let register = plant.waterRegisters.last else {
            return plant.createdAt
        }
        
        return register.wateredAt
    }
    
    private var expectedWateringDate: Date {
        guard let register = plant.waterRegisters.last else {
            return WaterScheduleCalculator(
                waterSchedule: plant.waterSchedule,
                date: plant.createdAt
            ).calculate() ?? .now
        }
        
        return register.correctDate ?? .now
    }
    
    var numberDaysWatering: Int {
        return Calendar.current.dateComponents(
            [.day],
            from: wateringDate, to: expectedWateringDate
        ).day ?? 0
    }
    
    var castedDaysWatering: Status {
        let result = numberDaysWatering
        
        if result < 0 {
            return .underwatered(abs(result))
        }
        
        if result == 0 {
            return .onTime
        }
        
        return .overwatered(result)
    }
}


extension PlantWaterCalculator {
    enum Status {
        case overwatered(Int)
        case onTime
        case underwatered(Int)
    }
}
