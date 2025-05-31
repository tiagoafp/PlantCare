//
//
// PlantCare
// Created by: tiago.pereira on 31/5/25
//

import PixelKit
import SwiftUI

class PlantCareConfigurations: ObservableObject {
    @Published var colorScheme: ColorScheme
    
    init() {
        colorScheme = .light
    }
    
    func swipeTheme() {
        colorScheme = colorScheme == .light ? .dark : .light
    }
}
