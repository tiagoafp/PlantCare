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
    var coverImage: UIImage? { get }
    
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
    @Published var coverImage: UIImage?
    
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
        plant.cover = input.imagesWritter.saveCover(image: coverImage, plant: plant)
        input.repo.insert(type: plant)
        close()
    }
    
    func onAddImage(image: UIImage) {
        self.coverImage = image
    }
    
    func onChangeImage(image: UIImage) {
        self.coverImage = image
    }
    
    func deletePlant() {
        input.repo.delete(type: plant)
        close()
    }
    
    func onDeleteImage() {
        /*do {
            try input.imagesService.cleanImage(image: coverImage)
            self.coverImage = nil
            self.plant.cover = nil
        } catch {
            
        }*/
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
        let imagesWritter: ImagesStorageWritterService
        let origin: PlantFormOrigin
    }
}
