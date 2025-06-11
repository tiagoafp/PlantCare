//
//
// PlantCare
// Created by: tiago.pereira on 31/5/25
//

import SwiftUI
import SwiftData

protocol DashboardRouterProtocol {
    var navPath: Binding<NavigationPath> { get }
    
    func openWater()
    func openPlants(plant: PersistentIdentifier?)
    func openTypes()
}

class DashboardRouter: DashboardRouterProtocol {
    var navPath: Binding<NavigationPath>
    
    init(navPath: Binding<NavigationPath>) {
        self.navPath = navPath
    }
    
    func openWater() {
        navPath.wrappedValue.append(Destinations.water)
    }
    
    func openPlants(plant: PersistentIdentifier?) {
        navPath.wrappedValue.append(Destinations.plants(plant))
    }
    
    func openTypes() {
        navPath.wrappedValue.append(Destinations.types)
    }
}


extension DashboardRouter {
    enum Destinations: Hashable {
        case water
        case plants(PersistentIdentifier?)
        case types
    }
}
