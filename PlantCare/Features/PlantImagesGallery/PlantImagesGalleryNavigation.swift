//
//  PlantImagesGalleryNavigation.swift
//  PlantCare
//
//  Created by tiago.pereira on 15/6/25.
//

import SwiftUI

protocol PlantImagesGalleryNavigationProtocol {
    func updateNavigator(navigator: any ViewNavigatorProtocol)
}

class PlantImagesGalleryNavigation: PlantImagesGalleryNavigationProtocol {
    var navigator: (any ViewNavigatorProtocol)?
    
    init() {}
    
    func updateNavigator(navigator: any ViewNavigatorProtocol) {
        self.navigator = navigator
    }
}


extension PlantImagesGalleryNavigation {
    enum Destinations: DestinationsProtocol {
        var id: String {
            self
        }
    }
}
