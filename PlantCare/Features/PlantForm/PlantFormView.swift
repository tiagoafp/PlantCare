//
//  PlantFormView.swift
//  PlantCare
//
//  Created by tiago.pereira on 7/6/25.
//

import SwiftUI
import PixelKit

struct PlantFormView<ViewModel: PlantFormViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                GrouppedSectionView(nil) {
                    InputTextCell(
                        .labels(.title("Name")),
                        text: $viewModel.formaData.name
                    )
                }
            }
            
            FooterActionView([
                .init(title: "Add", action: viewModel.addPlant)
            ])
        }
    }
}
