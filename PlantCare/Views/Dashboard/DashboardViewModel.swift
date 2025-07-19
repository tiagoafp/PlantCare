//
//
// PlantCare
// Created by: tiago.pereira on 24/5/25
//

import SwiftUI
import SwiftData

@MainActor
protocol DashboardViewModelProtocol: ObservableObject {
    var sections: [DashboardSection] { get }
    
    func onSectionPress(section: DashboardSection)
    func onAppear()
}

class DashboardViewModel: DashboardViewModelProtocol {
    @Published var sections: [DashboardSection]
    
    var input: Input
    weak var router: ViewRouter<DashboardRoute>?
    
    init (input: Input) {
        self.input = input
        self.sections = []
    }
    
    func inject(router: ViewRouter<DashboardRoute>) {
        self.router = router
    }
    
    func onAppear() {
        sections.append(contentsOf: [
            waterSection(),
            plantSection(),
            plantTypesSection()
        ])
    }
    
    func waterSection() -> DashboardSection {
        let plants = try? input.plantRepo.fetchOrderedByWater()
        
        return .init(
            type: .water,
            items: input.itemsBuilder.buildWater(plants: plants ?? [])
        )
    }
    
    func plantSection() -> DashboardSection {
        let plants = try? input.plantRepo.fetchOrderedByNewAdded()
        
        return .init(
            type: .plants,
            items: input.itemsBuilder.buildPlants(plants: plants ?? [])
        )
    }
    
    func plantTypesSection() -> DashboardSection {
        let types = try? input.plantTypeRepo.fetchTypesByPlantsNumber()
        
        return .init(
            type: .plants,
            items: input.itemsBuilder.buildTypes(types: types ?? [])
        )
    }
    
    func onSectionPress(section: DashboardSection) {
    }
}

extension DashboardViewModel {
    public struct Input {
        let plantRepo: PlantRepositoryProtocol
        let plantTypeRepo: PlantTypeRepositoryProtocol
        let storage: Storage
        let itemsBuilder: DashboardItemsBuilder
    }
}
