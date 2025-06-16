//
//  PlantImagesGalleryViewModel.swift
//  PlantCare
//
//  Created by tiago.pereira on 15/6/25.
//

import SwiftUI

protocol PlantImagesGalleryViewModelProtocol: ObservableObject {}

class PlantImagesGalleryViewModel: PlantImagesGalleryViewModelProtocol {
    let input: Input
    
    init (input: Input) {
        self.input = input
    }
}

extension PlantImagesGalleryViewModel {
    public struct Input {
        var navigation: PlantImagesGalleryNavigationProtocol
        var plant: Binding<Plant>
        var imagesRepo: ImagesRepositoryProtocol
    }
}
