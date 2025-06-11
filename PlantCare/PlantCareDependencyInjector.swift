//
//
// PlantCare
// Created by: tiago.pereira on 25/5/25
//

import SwiftData
import SwiftUI

protocol PlantCareDependencyInjectorProtocol: ObservableObject {
    var db: ModelContainer { get }
    @MainActor
    var plantTypeRepo: PlantTypeRepositoryProtocol { get }
}

class PlantCareDependencyInjector: PlantCareDependencyInjectorProtocol {
    var db: ModelContainer
    
    init() throws {
        self.db = try ModelContainer(for: PlantCareModel.self)
    }
    
    var plantTypeRepo: PlantTypeRepositoryProtocol {
        PlantTypeRepository(context: db.mainContext)
    }
}
