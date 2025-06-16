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
                ImageHeaderView(
                    headerImage(),
                    options: headerImageOptions()
                )
                
                GrouppedSectionView(nil) {
                    InputTextCell(
                        .labels(.title(.translation(.name))),
                        text: $viewModel.plant.name,
                        separator: false
                    )
                }
                
                GrouppedSectionView(.title(.translation(.optional))) {
                    VStack(spacing: 0) {
                        DisplayCell(
                            .labels(title: .translation(.types), .subtitle(viewModel.plant.type?.name ?? "")),
                            disclosure: true,
                            onPress: {
                                viewModel.onTypePress()
                            }
                        )
                        
                        InputDateCell(
                            .labels(
                                .title(
                                    .translation(.planted_at)
                                )
                            ),
                            date: $viewModel.plant.plantedAt
                        )
                        
                        DisplayCell(
                            .labels(
                                title: .translation(.water_register), .subtitle(viewModel.plant.waterSchedule.type)
                            ),
                            disclosure: true,
                            onPress: {
                                viewModel.onWaterSchedule()
                            }
                        )
                    }
                }
            }
            
            FooterActionView([
                .init(title: .translation(.save), action: viewModel.onSave)
            ])
        }
        .background(
            Rectangle()
                .foregroundStyle(PixelKit.shared.theme.background)
        )
    }
    
    func headerImage() -> ImageView {
        guard let mainImage = viewModel.plant.cover else {
            return .placeholder(.icon(.imagePlaceholder))
        }
        
        return .url(mainImage)
    }
    
    func headerImageOptions() -> [ImageHeaderView.Option] {
        var options: [ImageHeaderView.Option] = []
        

        if viewModel.plant.cover != nil {
            options.append(
                .delete(
                    localization: .translation(.delete),
                    action: viewModel.onDeleteImage
                )
            )
            
            options.append(
                .change(
                    localization: .translation(.change),
                    action: viewModel.onChangeImage
                )
            )
        } else {
            options.append(
                .add(
                    localization: .translation(.add),
                    action: viewModel.onAddImage
                )
            )
        }
        
        return  options
    }
}
