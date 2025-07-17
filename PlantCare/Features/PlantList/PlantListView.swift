//
//
// PlantCare
// Created by: tiago.pereira on 9/7/25
//

import SwiftUI
import PixelKit

struct PlantListView<ViewModel: PlantListViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle().foregroundStyle(PixelKit.shared.theme.background)
            VStack {
                if viewModel.plants.isEmpty {
                    Spacer()
                    Text("No plants")
                    Spacer()
                } else {
                    ScrollView {
                        GrouppedSectionView(nil) {
                            VStack(spacing: 0) {
                                ForEach(viewModel.plants) { plant in
                                    DisplayCell(
                                        .labels(
                                            .title(plant.name),
                                            .subtitle("No tregister")),
                                        disclosure: true,
                                        onPress: {
                                            viewModel.onPlantPress(plant: plant)
                                        }
                                    )
                                }
                            }
                        }
                    }
                }
            }
            
            FooterActionView([
                .init(title: .localized(.add_plant), action: viewModel.onAdd)
            ])
        }
        .task {
            viewModel.fetchPlants()
        }
    }
}
