import AtlasUI
import Foundation
import SwiftUI

extension Text {
    static func localized(key: AppLocalization,_ args: any CVarArg...) -> Text {
        return Text(
            String().localized(
                translation: key,
                args
            )
        )
    }
}


enum AppLocalization: String, TranslationProtocol {
    case appTitle = "app.title"
    case dashboardEmptyTitle = "dashboard.empty.state.title"
    case dashboardEmptySubtitle = "dashboard.empty.state.subtitle"
    case addPlant = "app.add.plant"
    case addNewPlant = "app.add.new.plant"
    case addPhoto = "app.add.photo"
    case nickname = "app.nickname"
    case insertPlantNickname = "app.insert.plant.nickname"
    
    // Select plant
    case selectPlantTitle = "select.plant.title"
    case selectedPlantType = "selected.plant.type"
    case searchPlants
    case identifyPlant
    case takePhotoIdentify
    case plantDetails = "plant.details"
    case addedOn
    
    var format: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
}
