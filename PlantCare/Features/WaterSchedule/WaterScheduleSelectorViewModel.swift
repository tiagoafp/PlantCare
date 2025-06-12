//
//  WaterScheduleSelectorViewModel.swift
//  PlantCare
//
//  Created by tiago.pereira on 14/6/25.
//

import SwiftUI
import SwiftData

protocol WaterScheduleSelectorViewModelProtocol: ObservableObject {
    var allSchedules: [WaterScheduleType] { get }
    func isSelected(_ schedule: WaterScheduleType) -> Bool
    func select(_ schedule: WaterScheduleType)
}

class WaterScheduleSelectorViewModel: WaterScheduleSelectorViewModelProtocol {
    var input: Input
    @Published var allSchedules: [WaterScheduleType]
    
    init (input: Input) {
        self.input = input
        
        self.allSchedules = [
            .weekly,
            .monthly,
            .custom(20)
        ]
    }
    
    func isSelected(_ schedule: WaterScheduleType) -> Bool {
        input.plant.waterSchedule.wrappedValue.casted == schedule
    }
    
    func select(_ schedule: WaterScheduleType) {
        input.plant.waterSchedule.wrappedValue = WaterSchedule(schedule: schedule)
    }
}

extension WaterScheduleSelectorViewModel {
    public struct Input {
        var navigation: WaterScheduleSelectorNavigationProtocol
        var plant: Binding<Plant>
    }
}
