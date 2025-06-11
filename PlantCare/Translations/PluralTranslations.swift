//
//
// PlantCare
// Created by: tiago.pereira on 31/5/25
//

import Foundation
import SwiftUI

enum PluralTranslations{
    case number_of_plants(Int)
}

extension PluralTranslations: TranslationsProtocol {
    var key: String.LocalizationValue {
        switch self {
        case .number_of_plants(let count):
            return "\(count) number_of_plants"
        }
    }
    
    var translation: String {
        String(localized: key, table: "Translations")
    }
}
