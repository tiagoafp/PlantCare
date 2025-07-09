//
//
// PlantCare
// Created by: tiago.pereira on 31/5/25
//

import SwiftUI

extension Text {
    static func localized(_ translation: Translations) -> Text {
        return Text(translation.translation)
    }
}

extension String {
    static func localized(_ translation: Translations) -> String {
        return translation.translation
    }
    
    static func plural(_ translation: PluralTranslations) -> String {
        return translation.translation
    }
}
