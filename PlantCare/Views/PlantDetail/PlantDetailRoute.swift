//
//
// PlantCare
// Created by: tiago.pereira on 9/7/25
//

import PixelKit

enum PlantDetailRoute: ViewRoute {
    case edit
    case waterRegister
    
    var id: String {
        switch self {
        case .edit:
            return "edit"
        case .waterRegister:
            return "waterRegister"
        }
    }
}
