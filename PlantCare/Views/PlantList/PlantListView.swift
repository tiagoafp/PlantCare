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
                if viewModel.items.isEmpty {
                    Spacer()
                    Text("No plants")
                    Spacer()
                } else {
                    ScrollView {
                        GrouppedSectionView {
                            VStack(spacing: 0) {
                                ForEach(viewModel.items, id: \.self) { item in
                                    DisplayCell(
                                        title: item.title,
                                        subtitle: item.subtitle,
                                        subtitleVariant: item.subtitleVariant.casted, image: item.cellImage,
                                        disclosure: item.disclosure,
                                        separator: item.separator,
                                        onPress: {  }
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
