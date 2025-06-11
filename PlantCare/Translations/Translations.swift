//
//
// PlantCare
// Created by: tiago.pereira on 31/5/25
//

import Foundation
import SwiftUI

enum Translations: String {
    case details
    case plant_care
    case plants
    case water
    case water_plants
    case types
    case edit
    case add
    case save
    case number_of_plants
}

extension Translations: TranslationsProtocol {
    var localized: String.LocalizationValue {
        String.LocalizationValue(self.rawValue)
    }
    
    var translation: String {
        String(localized: localized, table: "Translations")
    }
    
    func plural(_ count: Int) -> String {
        return String(localized: LocalizedStringResource("\(count) \(self.rawValue)", table: "Translations"))
    }
}
