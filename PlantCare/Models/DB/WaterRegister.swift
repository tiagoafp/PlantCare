//
//
// PlantCare
// Created by: tiago.pereira on 13/6/25
//

import SwiftData
import Foundation

@Model
public class WaterRegister {
    var correctDate: Date?
    var wateredAt: Date
    var nextDate: Date?
    
    init(prev: WaterRegister?, waterSchedule: WaterSchedule) {
        let now: Date = .now
        self.wateredAt = now
        self.correctDate = prev?.nextDate
        
        let calculator = WaterScheduleCalculator(waterSchedule: waterSchedule, date: now)
        nextDate = calculator.calculate()
    }
}
