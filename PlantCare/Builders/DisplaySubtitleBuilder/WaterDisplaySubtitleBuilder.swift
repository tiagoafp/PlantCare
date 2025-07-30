//
// Copyright © 2025 Sage.
// All Rights Reserved.


struct WaterDisplaySubtitleBuilder: DisplaySubtitleBuilder {
    func build(plant: PlantStatus) -> DisplayItemSubtitle {
        switch plant.state {
        case .onTime:
            return .positive(.localized(.all_good))
        case .late(let days):
            return .negative(.plural(.missing_water(days)))
        case .early:
            return .warning(.localized(.overwatered))
        }
    }
}
