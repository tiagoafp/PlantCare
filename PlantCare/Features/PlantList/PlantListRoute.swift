//
//
// PlantCare
// Created by: tiago.pereira on 9/7/25
//

import PixelKit
import SwiftData

enum PlantListRoute: ViewRoute {
    case add
    case detail(PersistentIdentifier)
    
    var id: String {
        switch self {
        case .add:
            "add"
        case .detail:
            "detail"
        }
    }
}
