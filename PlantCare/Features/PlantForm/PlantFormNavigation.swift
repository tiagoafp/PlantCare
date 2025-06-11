//
//  PlantFormNavigation.swift
//  PlantCare
//
//  Created by tiago.pereira on 7/6/25.
//

import SwiftUI

protocol PlantFormNavigationProtocol {}

class PlantFormNavigation: PlantFormNavigationProtocol {
    var navPath: Binding<NavigationPath>
    
    init(navPath: Binding<NavigationPath>) {
        self.navPath = navPath
    }
}


extension PlantFormNavigation {
    enum Destinations: Hashable {
    }
}
