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
    var water: [DisplayItem<Plant>] { get }
    var plants: [DisplayItem<Plant>] { get }
    var plantTypes: [DisplayItem<PlantType>] { get }
    
    func onPlantPress(item: DisplayItem<Plant>)
    func onPlantTypePress(item: DisplayItem<PlantType>)
    func onSectionPress(section: DashboardSection)
    func onAppear()
}

class DashboardViewModel: DashboardViewModelProtocol {
    @Published var sections: [DashboardSection]
    @Published var water: [DisplayItem<Plant>]
    @Published var plants: [DisplayItem<Plant>]
    @Published var plantTypes: [DisplayItem<PlantType>]
    
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
        
        self.water = input.plantsBuilder.build(plants: plants ?? [], waterDetail: true)
    }
    
    func plantSection() {
        let plants = try? input.plantRepo.fetchOrderedByNewAdded()
        
        self.plants = input.plantsBuilder.build(plants: plants ?? [], waterDetail: false)
    }
    
    func plantTypesSection() {
        let types = try? input.plantTypeRepo.fetchTypesByPlantsNumber()
        
        self.plantTypes = input.itemsBuilder.buildTypes(types: types ?? [])
    }
    
    func onPlantPress(item: DisplayItem<Plant>) {
        
    }
    
    func onPlantTypePress(item: DisplayItem<PlantType>) {
        
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
        let itemsBuilder: DisplayItemsBuilder
        let plantsBuilder: PlantsDisplayItemsBuilder
    }
}
