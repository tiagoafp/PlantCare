//
//  PlantFormViewModel.swift
//  PlantCare
//
//  Created by tiago.pereira on 7/6/25.
//

import SwiftUI
import SwiftData

@MainActor
protocol PlantFormViewModelProtocol: ObservableObject {
    var plant: Plant { get set }
    
    func onAppear()
    func onTypePress()
    func onWaterSchedule()
    func addPlant()
    func onAddImage(image: UIImage)
    func onChangeImage()
    func onDeleteImage()
}


class PlantFormViewModel: PlantFormViewModelProtocol {
    let input: Input
    @Published var plant: Plant
    
    init (input: Input) {
        self.input = input
        
        self.plant = input.repo.fetch(id: input.plant) ?? Plant()
    }
    
    func onAppear() {
        
    }
    
    func onTypePress() {
        input.navigation.plantType()
    }
    
    func onWaterSchedule() {
        input.navigation.waterSchedule()
    }
    
    func addPlant() {
    }
    
    func onAddImage(image: UIImage) {
        guard let path = try? input.imagesRepo.saveImage(plant: plant, image: image) else {
            return
        }
        
        self.plant.images.append(path)
        self.plant.cover = path
    }
    
    func onChangeImage() {}
    func onDeleteImage() {}
}

extension PlantFormViewModel {
    public struct Input {
        let plant: PersistentIdentifier?
        let navigation: PlantFormNavigationProtocol
        let repo: PlantRepositoryProtocol
        let imagesRepo: ImagesRepositoryProtocol
    }
}
