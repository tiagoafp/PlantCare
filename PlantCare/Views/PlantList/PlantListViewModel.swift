//
//
// PlantCare
// Created by: tiago.pereira on 9/7/25
//

import PixelKit
import SwiftUI

@MainActor
protocol PlantListViewModelProtocol: ObservableObject {
    var items: [DisplayItem] { get }
    
    func fetchPlants()
    func onPress(item: DisplayItem)
    func onAdd()
}

class PlantListViewModel: PlantListViewModelProtocol {
    weak var router: ViewRouter<PlantListRoute>?
    
    @Published var items: [DisplayItem] = []
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
            self.items = input.itemsBuilder.build(plants: plants)
        } catch {}
    }
    
    func onPress(item: DisplayItem) {
        switch item.type {
        case .plant(let plant):
            router?.push(.detail(plant.persistentModelID))
        default:
            break
        }
    }
    
    func onAdd() {
        router?.present(.add)
    }
}

extension PlantListViewModel {
    struct Input {
        let repo: PlantRepositoryProtocol
        let itemsBuilder: PlantItemsBuilder
    }
}

