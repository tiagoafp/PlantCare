//
//
// PlantCare
// Created by: tiago.pereira on 31/5/25
//

import SwiftUI

protocol DashboardRouterProtocol {
        
}

class DashboardRouter: DashboardRouterProtocol {
    var navPath: Binding<NavigationPath>
    
    init(navPath: Binding<NavigationPath>) {
        self.navPath = navPath
    }
}
