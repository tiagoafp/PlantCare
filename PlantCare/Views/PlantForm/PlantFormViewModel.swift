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
    
    var allowDelete: Bool { get }
    
    func deletePress()
    func deletePlant()
    func onTypePress()
    func onWaterSchedule()
    func onSave()
    func onAddImage(image: UIImage)
    func onChangeImage(image: UIImage)
    func onDeleteImage()
    func cleanNotSave()
}

class PlantFormViewModel: ViewModelRouter<PlantFormRoute>, PlantFormViewModelProtocol {
    let input: Input
    @Published var plant: Plant
    @Published var coverImage: UIImage?
    @Published var confirmDelete: Bool = false
    
    init (input: Input) {
        self.input = input
        
        let plant = input.repo.fetch(id: input.plant) ?? Plant()
        self.coverImage = input.imagesReader.getCover(plant: plant)
        self.plant = plant
        
    }
    
    var allowDelete: Bool { input.plant != nil }
    
    func onTypePress() {
        push(.plantType)
    }
    
    func onWaterSchedule() {
        push(.waterSchedule)
    }
    
    func onSave() {
        plant.cover = input.imagesWritter.saveCover(image: coverImage, plant: plant)
        input.repo.insert(type: plant)
        input.onAdd()
        close()
    }
    
    func onAddImage(image: UIImage) {
        self.coverImage = image
    }
    
    func onChangeImage(image: UIImage) {
        self.coverImage = image
    }
    
    func deletePress() {
        confirmDelete.toggle()
    }
    
    func deletePlant() {
        print("Deleting \(plant.id)")
        do {
            try? input.imagesWritter.clean(plant: plant)
            input.repo.delete(type: plant)
        } catch {
            print("Error \(error.localizedDescription)")
        }
        router?.popToRoot()
    }
    
    func cleanNotSave() {
        if input.repo.fetch(id: plant.id) == nil {
            plant.type = nil
        }
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
            router?.pop()
        }
    }
}

extension PlantFormViewModel {
    public struct Input {
        let plant: PersistentIdentifier?
        let repo: PlantRepositoryProtocol
        let imagesWritter: ImagesStorageWritterService
        let imagesReader: ImagesStorageReaderService
        let origin: PlantFormOrigin
        let onAdd: () -> Void
    }
}
