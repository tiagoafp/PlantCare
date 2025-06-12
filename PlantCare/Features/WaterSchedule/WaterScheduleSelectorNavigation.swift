//
//  WaterScheduleSelectorNavigation.swift
//  PlantCare
//
//  Created by tiago.pereira on 14/6/25.
//

import SwiftUI

protocol WaterScheduleSelectorNavigationProtocol {
    func updateNavigator(navigator: any ViewNavigatorProtocol)
}

class WaterScheduleSelectorNavigation: WaterScheduleSelectorNavigationProtocol {
    var navigator: (any ViewNavigatorProtocol)?
    
    init() {}
    
    func updateNavigator(navigator: any ViewNavigatorProtocol) {
        self.navigator = navigator
    }
}


extension WaterScheduleSelectorNavigation {
    enum Destinations: String, DestinationsProtocol {
        case close
        
        var id: String { self.rawValue }
    }
}
