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
    func onSave()
    func onAddImage(image: UIImage)
    func onChangeImage(image: UIImage)
    func onDeleteImage()
}


class PlantFormViewModel: PlantFormViewModelProtocol {
    let input: Input
    @Published var plant: Plant
    public var coverImage: String?
    
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
    
    func onSave() {
        guard let saved = try? input.imagesRepo.saveToDocs(plant: plant, image: plant.cover) else {
            return
        }
        
        plant.cover = saved
        input.repo.insert(type: plant)
        
        do {
            try input.imagesRepo.cleanCache()
        } catch { }
    }
    
    func onAddImage(image: UIImage) {
        guard let path = try? input.imagesRepo.saveImage(plant: plant, image: image, type: .cache) else {
            return
        }
        
        self.coverImage = path
        self.plant.cover = path
    }
    
    func onChangeImage(image: UIImage) {
        do {
            try input.imagesRepo.cleanImage(image: coverImage)
            let path = try input.imagesRepo.saveImage(plant: plant, image: image, type: .cache)
            self.coverImage = path
            self.plant.cover = path
        } catch {}
    }
    
    func onDeleteImage() {
        
    }
}

extension PlantFormViewModel {
    public struct Input {
        let plant: PersistentIdentifier?
        let navigation: PlantFormNavigationProtocol
        let repo: PlantRepositoryProtocol
        let imagesRepo: ImagesRepositoryProtocol
    }
}
