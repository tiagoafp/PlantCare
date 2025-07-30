//
//
// PlantCare
// Created by: tiago.pereira on 25/5/25
//

import SwiftData
import SwiftUI

@MainActor
protocol PlantCareDependencyInjectorProtocol: ObservableObject {
    var db: ModelContainer { get }
    var plantTypeRepo: PlantTypeRepositoryProtocol { get }
    var plantRepo: PlantRepositoryProtocol { get }
}

class PlantCareDependencyInjector: PlantCareDependencyInjectorProtocol {
    var db: ModelContainer
    
    init() throws {
        self.db = try ModelContainer(for: PlantCareModel.self)
    }
    
    var plantTypeRepo: PlantTypeRepositoryProtocol {
        PlantTypeRepository(context: db.mainContext)
    }
    
    var plantRepo: any PlantRepositoryProtocol {
        PlantRepository(context: db.mainContext, waterService: StaticWaterPlantService())
    }
}
