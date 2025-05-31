//
//
// PlantCare
// Created by: tiago.pereira on 31/5/25
//

protocol TranslationsProtocol {
    var translation: String { get }
}

enum Translations {
    case plant_care
}

extension Translations {
    var translation: String {
        switch self {
        case .plant_care:
            return "Plant Care"
        }
    }
}
