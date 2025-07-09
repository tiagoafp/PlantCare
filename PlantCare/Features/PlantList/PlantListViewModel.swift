//
//
// PlantCare
// Created by: tiago.pereira on 9/7/25
//

import PixelKit
import SwiftUI

@MainActor
protocol PlantListViewModelProtocol: ObservableObject {
    var plants: [Plant] { get }
    
    func fetchPlants()
    func onPlantPress(plant: Plant)
    func onAdd()
}

class PlantListViewModel: PlantListViewModelProtocol {
    weak var router: ViewRouter<PlantListRoute>?
    
    @Published var plants: [Plant] = []
    var input: Input
    
    init(input: Input) {
        self.input = input
    }
    
    func inject(router: ViewRouter<PlantListRoute>?) {
        self.router = router
    }
    
    func fetchPlants() {
        do {
            self.plants = try input.repo.fetchAll()
        } catch {}
    }
    
    func onPlantPress(plant: Plant) {
        
    }
    
    func onAdd() {
        router?.present(.add)
    }
}

extension PlantListViewModel {
    struct Input {
        let repo: PlantRepositoryProtocol
    }
}

