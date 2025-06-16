//
//  PlantFormNavigation.swift
//  PlantCare
//
//  Created by tiago.pereira on 7/6/25.
//

import SwiftUI

protocol PlantFormNavigationProtocol {
    var navPath: Binding<NavigationPath> { get set }
    
    func plantType()
    func waterSchedule()
}

class PlantFormNavigation: PlantFormNavigationProtocol {
    var navPath: Binding<NavigationPath>
    
    init(navPath: Binding<NavigationPath>) {
        self.navPath = navPath
    }
    
    func plantType() {
        self.navPath.wrappedValue.append(Destinations.plantType)
    }
    
    func waterSchedule() {
        self.navPath.wrappedValue.append(Destinations.waterSchedule)
    }
    
    func openImagesGallery() {
        self.navPath.wrappedValue.append(Destinations.imagesGallery)
    }
}


extension PlantFormNavigation {
    enum Destinations: Hashable {
        case plantType
        case waterSchedule
        case imagesGallery
    }
}
