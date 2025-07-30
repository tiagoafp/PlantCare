//
// Copyright © 2025 Sage.
// All Rights Reserved.

import Foundation

protocol WaterRegisterItemsBuilderProtocol {
    func build(plant: Plant) -> [DisplayItem]
}

struct WaterRegisterItemsBuilder: WaterRegisterItemsBuilderProtocol {
    let dateFormatter: DateFormatter
    let subtitleBuilder: WaterRegisterSubtitleBuilderProtocol
    
    init(
        dateFormatter: DateFormatter = .init(),
        subtitleBuilder: WaterRegisterSubtitleBuilderProtocol
    ) {
        self.dateFormatter = dateFormatter
        self.dateFormatter.dateStyle = .medium
        self.dateFormatter.timeStyle = .none
        self.subtitleBuilder = subtitleBuilder
    }
    
    func build(plant: Plant) -> [DisplayItem] {
        plant.waterRegisters.map { register -> DisplayItem in
            DisplayItem(
                title: dateFormatter.string(from: register.wateredAt),
                subtitle: subtitleBuilder.build(register: register),
                separator: register != plant.waterRegisters.last,
                disclosure: false,
                type: .waterRegister(register)
            )
        }
    }
}
