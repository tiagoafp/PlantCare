//
//
// PlantCare
// Created by: tiago.pereira on 9/7/25
//

import PixelKit
import SwiftUI

@MainActor
protocol PlantListViewModelProtocol: ObservableObject {
    var items: [DisplayItem<Plant>] { get }
    
    func fetchPlants()
    func onPlantPress(plant: Plant)
    func onAdd()
}

class PlantListViewModel: PlantListViewModelProtocol {
    weak var router: ViewRouter<PlantListRoute>?
    
    @Published var items: [DisplayItem<Plant>] = []
    var input: Input
    
    init(input: Input) {
        self.input = input
    }
    
    func inject(router: ViewRouter<PlantListRoute>?) {
        self.router = router
    }
    
    func fetchPlants() {
        do {
            let plants = try input.repo.fetchAll()
            self.items = input.itemsBuilder.build(plants: plants, waterDetail: false)
        } catch {}
    }
    
    func onPlantPress(plant: Plant) {
        router?.push(.detail(plant.persistentModelID))
    }
    
    func onAdd() {
        router?.present(.add)
    }
}

extension PlantListViewModel {
    struct Input {
        let repo: PlantRepositoryProtocol
        let itemsBuilder: PlantsDisplayItemsBuilder
    }
}

