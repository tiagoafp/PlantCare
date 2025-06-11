//
//  TypeListNavigation.swift
//  PlantCare
//
//  Created by tiago.pereira on 8/6/25.
//

import SwiftUI

protocol TypeListNavigationProtocol {}

class TypeListNavigation: TypeListNavigationProtocol {
    var navPath: Binding<NavigationPath>
    
    init(navPath: Binding<NavigationPath>) {
        self.navPath = navPath
    }
}


extension TypeListNavigation {
    enum Destinations: Hashable {
    }
}
