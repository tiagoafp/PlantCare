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
    case name
    case optional
    case planted_at
    case water_register
    case delete
    case change
    case notes
    case delete_confirmation_title
    case delete_confirmation_message
    case cancel
    case added_at
    case water_history
    case add_plant
    case missing_water
    case irregular_water
    case all_good
    case planted_old
    case add_ago
    case overwatered
}

extension Translations: TranslationsProtocol {
    var localized: String.LocalizationValue {
        String.LocalizationValue(self.rawValue)
    }
    
    var translation: String {
        String(localized: localized, table: "Translations")
    }
    
    func args(_ args: CVarArg...) -> String {
        let tmp = translation
        return withVaList(args) { vaList in
            NSString(format: tmp, arguments: vaList) as String
        }
    }
}
