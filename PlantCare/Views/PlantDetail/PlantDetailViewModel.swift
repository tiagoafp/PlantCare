//
//
// PlantCare
// Created by: tiago.pereira on 9/7/25
//

import SwiftUI
import SwiftData

@MainActor
protocol PlantDetailViewModelProtocol: ObservableObject {
    var plant: Plant? { get }
    func addedAt(plant: Plant) -> String
    func plantedAt(plant: Plant) -> String
    func onAppear()
    func onEdit()
    func onWaterHistory()
}

class PlantDetailViewModel: PlantDetailViewModelProtocol {
    @Published var plant: Plant?
    var input: Input
    weak var router: ViewRouter<PlantDetailRoute>?
    
    init(input: Input) {
        self.input = input
    }
    
    func addedAt(plant: Plant) -> String {
        "22/12/2020 (5 years ago)"
    }
    
    func plantedAt(plant: Plant) -> String {
        "22/12/2020 (5 years ago)"
    }
    
    func onAppear() {
        self.plant = input.repo.fetch(id: input.plantId)
    }
    
    func update(router: ViewRouter<PlantDetailRoute>?) {
        self.router = router
    }
    
    func onEdit()  {
        router?.push(.edit)
    }
    
    func onWaterHistory() {
        
    }
}

extension PlantDetailViewModel {
    struct Input {
        let repo: PlantRepositoryProtocol
        let plantId: PersistentIdentifier
    }
}
