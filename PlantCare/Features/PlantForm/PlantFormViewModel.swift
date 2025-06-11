//
//  PlantFormViewModel.swift
//  PlantCare
//
//  Created by tiago.pereira on 7/6/25.
//

import SwiftUI
import SwiftData

protocol PlantFormViewModelProtocol: ObservableObject {
    var formaData: PlantFormData { get set }
    @MainActor
    func onAppear()
    
    @MainActor
    func addPlant()
}

class PlantFormViewModel: PlantFormViewModelProtocol {
    let input: Input
    @Published var formaData: PlantFormData
    
    @MainActor
    init (input: Input) {
        self.input = input
        if let plantId = input.plant {
            self.formaData = .init(
                plant: try? input
                    .storage
                    .fetchElement(id: plantId)
            )
        } else {
            self.formaData = .init(plant: nil)
        }
        
    }
    
    @MainActor
    func onAppear() {
        
    }
    
    @MainActor
    func addPlant() {
        let plant = Plant(
            name: formaData.name,
            type: .init(name: "Abc")
        )
        
        do {
            try input.storage.save(model: plant)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension PlantFormViewModel {
    public struct Input {
        let plant: PersistentIdentifier?
        let navigation: PlantFormNavigationProtocol
        let storage: StorageProtocol
    }
}
