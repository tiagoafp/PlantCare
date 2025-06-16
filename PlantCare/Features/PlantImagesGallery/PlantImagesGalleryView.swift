//
//  PlantImagesGalleryView.swift
//  PlantCare
//
//  Created by tiago.pereira on 15/6/25.
//

import SwiftUI

struct PlantImagesGalleryView<ViewModel: PlantImagesGalleryViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {}
    }
}