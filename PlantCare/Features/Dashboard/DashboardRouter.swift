//
//
// PlantCare
// Created by: tiago.pereira on 31/5/25
//

import SwiftUI
import SwiftData

@MainActor
protocol DashboardRouterProtocol {
    func openWater()
    func openPlants(plant: PersistentIdentifier?)
    func openTypes()
    func updateNavigator(navigator: any ViewNavigatorProtocol)
}

class DashboardRouter: DashboardRouterProtocol{
    var navigator: (any ViewNavigatorProtocol)?
    
    init() {}
    
    func updateNavigator(navigator: any ViewNavigatorProtocol) {
        self.navigator = navigator
    }
    
    func openWater() {
        navigator?.push(view: Destinations.water)
    }
    
    func openPlants(plant: PersistentIdentifier?) {
        navigator?.push(view: Destinations.plants(plant))
    }
    
    func openTypes() {
        navigator?.push(view: Destinations.types)
    }
}


extension DashboardRouter {
    enum Destinations: DestinationsProtocol {
        case water
        case plants(PersistentIdentifier?)
        case types
        
        var id: String {
            switch self {
            case .water:
                return "water"
            case .plants:
                return "plants"
            case .types:
                return "types"
            }
        }
    }
}
