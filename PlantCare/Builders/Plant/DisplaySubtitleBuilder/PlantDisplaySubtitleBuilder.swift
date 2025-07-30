//
// Copyright © 2025 Sage.
// All Rights Reserved.


struct PlantDisplaySubtitleBuilder: DisplaySubtitleBuilder {
    func build(plant: PlantStatus) -> DisplayItemSubtitle {
        switch plant.state {
        case .onTime:
            return .positive(.localized(.all_good))
        case .late:
            return .negative(.localized(.missing_water))
        case .early:
            return .warning(.localized(.overwatered))
        }
    }
}
