//
//
// PlantCare
// Created by: tiago.pereira on 24/5/25
//

import SwiftUI
import SwiftData

@MainActor
protocol DashboardViewModelProtocol: ObservableObject {
    var waterSection: DashboardSection<DashboardSectionItemPlant> { get }
    var plantsSection: DashboardSection<DashboardSectionItemPlant> { get }
    var types: DashboardSection<DashboardSectionItemPlantType> { get }
    
    func onSectionPress(section: any DashboardSectionProtocol)
    func onItemPressed(item: any DashboardSectionItemProtocol)
    func onAppear()
}

class DashboardViewModel: DashboardViewModelProtocol {
    @Published var waterSection: DashboardSection<DashboardSectionItemPlant>
    @Published var plantsSection: DashboardSection<DashboardSectionItemPlant>
    @Published var types: DashboardSection<DashboardSectionItemPlantType>
    
    var input: Input
    weak var router: ViewRouter<DashboardRoute>?
    
    init (input: Input) {
        self.input = input
        waterSection = .init(type: .water)
        plantsSection = .init(type: .plants)
        types = .init(type: .type)
    }
    
    func inject(router: ViewRouter<DashboardRoute>) {
        self.router = router
    }
    
    func onAppear() {
        do {
            if let plants: [Plant] = try? input.plantRepo.fetchOrderedByWater() {
                waterSection.update(
                    items: plants.map({ .init(plant: $0)})
                )
            }
            
            types.update(
                items: try input.plantTypeRepo.fetchTypesByPlantsNumber()
                    .map { .init(plantType: $0) }
            )
            
            if let plants: [Plant] = try? input.storage.fetch() {
                plantsSection.update(
                    items: plants.map({ .init(plant: $0)})
                )
            }
        } catch {}
    }
    
    func onSectionPress(section: any DashboardSectionProtocol) {
        switch section.type {
        case .water:
            router?.push(.water)
        case .plants:
            router?.push(.plants)
        case .type:
            router?.push(.types)
        }
    }
    
    func onItemPressed(item: any DashboardSectionItemProtocol) {
        if let plantItem = item as? DashboardSectionItemPlant {
            router?.push(.plant(plantItem.plant.persistentModelID))
            return
        }
    }
}

extension DashboardViewModel {
    public struct Input {
        let plantRepo: PlantRepositoryProtocol
        let plantTypeRepo: PlantTypeRepositoryProtocol
        let storage: Storage
    }
}
