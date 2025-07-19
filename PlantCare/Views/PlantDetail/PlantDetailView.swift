//
//
// PlantCare
// Created by: tiago.pereira on 9/7/25
//

import SwiftUI
import PixelKit

struct PlantDetailView<ViewModel: PlantDetailViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle().foregroundStyle(PixelKit.shared.theme.background)
            if let plant = viewModel.plant {
                plantContainer(plant: plant)
            }
        }
        .task {
            viewModel.onAppear()
        }
    }
    
    @ViewBuilder
    func plantContainer(plant: Plant) -> some View{
        ScrollView {
            VStack {
                ImageHeaderView(.local(plant.cover ?? ""))
                
                GrouppedSectionView {
                    VStack(spacing: 0) {
                        DisplayCell(
                            .labels(
                                .title(.localized(.name)),
                                .subtitle(plant.name)
                            ),
                            disclosure: false,
                            onPress: {}
                        )
                        
                        DisplayCell(
                            .labels(
                                .title(.localized(.types)),
                                .subtitle(plant.type?.name ?? "")
                            ),
                            disclosure: false,
                            onPress: {}
                        )
                        
                        DisplayCell(
                            .labels(
                                .title(.localized(.added_at)),
                                .subtitle(viewModel.addedAt(plant: plant))
                            ),
                            disclosure: false,
                            onPress: {}
                        )
                        
                        DisplayCell(
                            .labels(
                                .title(.localized(.planted_at)),
                                .subtitle(viewModel.plantedAt(plant: plant))
                            ),
                            disclosure: false,
                            onPress: {}
                        )
                        
                        DisplayCell(
                            .labels(
                                .title(.localized(.water_register)),
                                .subtitle(plant.waterSchedule.type)
                            ),
                            disclosure: false,
                            onPress: {}
                        )
                        
                        DisplayCell(
                            .labels(
                                .title(.localized(.notes)),
                                .subtitle(plant.notes)
                            ),
                            disclosure: false,
                            onPress: {}
                        )
                        
                        DisplayCell(
                            .labels(
                                .title(.localized(.water_register))
                            ),
                            disclosure: true,
                            onPress: viewModel.onWaterHistory
                        )
                    }
                }
            }
        }
    }
}
