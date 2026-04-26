import AtlasCore
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
    
    var format: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
}
