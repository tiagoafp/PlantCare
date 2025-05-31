//
//
// PlantCare
// Created by: tiago.pereira on 25/5/25
//

import SwiftData
import SwiftUI

protocol PlantCareDependencyInjectorProtocol {
    var db: ModelContainer { get } 
}

class PlantCareDependencyInjector: PlantCareDependencyInjectorProtocol, ObservableObject {
    @Published var db: ModelContainer
    
    init() throws {
        self.db = try ModelContainer(for: PlantCareModel.self)
    }
}
