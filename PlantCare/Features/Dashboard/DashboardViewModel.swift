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
    
    let input: Input
    
    init (input: Input) {
        self.input = input
        waterSection = .init(type: .water)
        plantsSection = .init(type: .plants)
        types = .init(type: .type)
    }
    
    func onAppear() {
        do {
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
            input.router.openWater()
        case .plants:
            input.router.openPlants(plant: nil)
        case .type:
            input.router.openTypes()
        }
    }
    
    func onItemPressed(item: any DashboardSectionItemProtocol) {
        if let plantItem = item as? DashboardSectionItemPlant {
            input.router.openPlants(plant: plantItem.plant.persistentModelID)
            return
        }
        
        if let platTypeItem = item as? DashboardSectionItemPlant {
            input.router.openTypes()
            return
        }
    }
}

extension DashboardViewModel {
    public struct Input {
        let router: DashboardRouterProtocol
        let plantTypeRepo: PlantTypeRepositoryProtocol
        let storage: Storage
    }
}
