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
    
    func deletePlant()
    func onTypePress()
    func onWaterSchedule()
    func onSave()
    func onAddImage(image: UIImage)
    func onChangeImage(image: UIImage)
    func onDeleteImage()
}


class PlantFormViewModel: ViewModelRouter<PlantFormRoute>, PlantFormViewModelProtocol {
    let input: Input
    @Published var plant: Plant
    public var coverImage: String?
    
    init (input: Input) {
        self.input = input
        
        self.plant = input.repo.fetch(id: input.plant) ?? Plant()
    }
    
    func onTypePress() {
        push(.plantType)
    }
    
    func onWaterSchedule() {
        push(.waterSchedule)
    }
    
    func onSave() {
        guard let saved = try? input.imagesRepo.saveToDocs(plant: plant, image: plant.cover) else {
            return
        }
        
        plant.cover = saved
        input.repo.insert(type: plant)
        
        do {
            try input.imagesRepo.cleanCache()
            close()
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
    
    func deletePlant() {
        input.repo.delete(type: plant)
        close()
    }
    
    func onDeleteImage() {
        do {
            try input.imagesRepo.cleanImage(image: coverImage)
            self.coverImage = nil
            self.plant.cover = nil
        } catch {
            
        }
    }
    
    func close() {
        switch input.origin {
        case .list:
            router?.dismiss()
        case .detail:
            router?.popToRoot()
        }
    }
}

extension PlantFormViewModel {
    public struct Input {
        let plant: PersistentIdentifier?
        let repo: PlantRepositoryProtocol
        let imagesRepo: ImagesRepositoryProtocol
        let origin: PlantFormOrigin
    }
}
