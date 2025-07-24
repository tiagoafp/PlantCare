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
    var water: [DisplayItem] { get }
    var plants: [DisplayItem] { get }
    var plantTypes: [DisplayItem] { get }
    
    func onItemPressed(item: DisplayItem)
    func onSectionPress(section: DashboardSection)
    func onAppear()
}

class DashboardViewModel: DashboardViewModelProtocol {
    @Published var sections: [DashboardSection]
    @Published var water: [DisplayItem]
    @Published var plants: [DisplayItem]
    @Published var plantTypes: [DisplayItem]
    
    var input: Input
    weak var router: ViewRouter<DashboardRoute>?
    
    init (input: Input) {
        self.input = input
        self.sections = [.water, .plants, .types]
        water = []
        plants = []
        plantTypes = []
    }
    
    func inject(router: ViewRouter<DashboardRoute>) {
        self.router = router
    }
    
    func onAppear() {
        waterSection()
        plantSection()
        plantTypesSection()
    }
    
    func waterSection() {
        let plants = try? input.plantRepo.fetchOrderedByWater()
        
        self.water = input.plantsBuilder.build(plants: plants ?? [])
    }
    
    func plantSection() {
        let plants = try? input.plantRepo.fetchOrderedByNewAdded()
        
        self.plants = input.waterBuilder.build(plants: plants ?? [])
    }
    
    func plantTypesSection() {
        let types = try? input.plantTypeRepo.fetchTypesByPlantsNumber()
        
        self.plantTypes = input.typesBuilder.build(types: types ?? [])
    }
    
    func onItemPressed(item: DisplayItem) {
        switch item.type {
        case .plant(let plant):
            self.router?.push(.plant(plant.persistentModelID))
        case .plantType(let plantType):
            break
        }
    }
    
    func onSectionPress(section: DashboardSection) {
        switch section {
        case .water:
            self.router?.push(.water)
        case .plants:
            self.router?.push(.plants)
        case .types:
            self.router?.push(.types)
        }
    }
}

extension DashboardViewModel {
    public struct Input {
        let plantRepo: PlantRepositoryProtocol
        let plantTypeRepo: PlantTypeRepositoryProtocol
        let storage: Storage
        let plantsBuilder: PlantItemsBuilder
        let waterBuilder: PlantItemsBuilder
        let typesBuilder: TypeItemsBuilder
    }
}
