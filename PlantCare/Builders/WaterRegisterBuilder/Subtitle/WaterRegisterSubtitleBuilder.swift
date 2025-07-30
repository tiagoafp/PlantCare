//
// Copyright © 2025 Sage.
// All Rights Reserved.

protocol WaterRegisterSubtitleBuilderProtocol {
    func build(register: WaterRegister) -> DisplayItemSubtitle
}

struct WaterRegisterSubtitleBuilder: WaterRegisterSubtitleBuilderProtocol {
    let waterService: WaterPlantService
    
    init(waterService: WaterPlantService) {
        self.waterService = waterService
    }
    
    func build(register: WaterRegister) -> DisplayItemSubtitle {
        switch waterService.waterState(register: register) {
        case .late(let days):
            return .negative(.plural(.missing_water(days)))
        case .early:
            return .warning(.localized(.overwatered))
        case .onTime:
            return .positive(.localized(.on_time))
        }
    }
}
