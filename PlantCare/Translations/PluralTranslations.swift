//
//
// PlantCare
// Created by: tiago.pereira on 31/5/25
//

import Foundation
import SwiftUI

enum PluralTranslations{
    case number_of_plants(Int)
    case missing_water(Int)
}

extension PluralTranslations: TranslationsProtocol {
    var key: String.LocalizationValue {
        switch self {
        case .number_of_plants(let count):
            return "\(count) number_of_plants"
        case .missing_water(let count):
            return "\(count) missing_water"
        }
    }
    
    var translation: String {
        String(localized: key, table: "Translations")
    }
}
