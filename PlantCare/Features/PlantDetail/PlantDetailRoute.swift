//
//
// PlantCare
// Created by: tiago.pereira on 9/7/25
//

import PixelKit

enum PlantDetailRoute: ViewRoute {
    case edit
    
    var id: String {
        switch self {
        case .edit:
            return "edit"
        }
    }
}
