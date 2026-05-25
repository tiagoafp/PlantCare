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
    case editPlant = "app.edit.plant"
    case addPhoto = "app.add.photo"
    case addPhotoOptional = "app.add.photo.optional"
    case photo = "app.photo"
    case sick = "app.sick"
    case nickname = "app.nickname"
    case insertPlantNickname = "app.insert.plant.nickname"
    case save = "app.save"
    case register = "app.register"
    case delete = "app.delete"
    case cancel = "app.cancel"
    case deleteConfirmation = "app.delete.confirmation"
    case logActivity = "app.log.activity"
    case activity = "app.activity"
    case activityHistory = "app.activity.history"
    case noActivityYet = "app.activity.empty.title"
    case activityEmptySubtitle = "app.activity.empty.subtitle"
    case activityType = "app.activity.type"
    case activityDate = "app.activity.date"
    case activityNotes = "app.activity.notes"
    case activityNotesPlaceholder = "app.activity.notes.placeholder"
    case notes = "app.notes"
    case notesOptional = "app.notes.optional"
    case date = "app.date"
    case time = "app.time"
    case dateAndTime = "app.date.and.time"
    case activityDetailsPlaceholder = "app.activity.details.placeholder"
    case activityTypeWater = "activity.type.water"
    case activityWatered = "activity.watered"
    case activityTypeFertilize = "activity.type.fertilize"
    case activityTypeRepot = "activity.type.repot"
    case activityTypePrune = "activity.type.prune"
    case activityTypeOther = "activity.type.other"
    
    // Select plant
    case selectPlantTitle = "select.plant.title"
    case selectedPlant = "app.selected.plant"
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
