//
//  PlantFormView.swift
//  PlantCare
//
//  Created by tiago.pereira on 7/6/25.
//

import SwiftUI
import PixelKit

struct PlantFormView<ViewModel: PlantFormViewModelProtocol>: View {
    @StateObject var keyboard = KeyboardResponder()
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
                
                GrouppedSectionView {
                    InputTextCell(
                        title: .localized(.name),
                        text: $viewModel.plant.name,
                        separator: false
                    )
                }
                
                GrouppedSectionView(
                    title: .localized(.optional)
                ) {
                    VStack(spacing: 0) {
                        DisplayCell(
                            title: .localized(.types),
                            subtitle: viewModel.plant.type?.name ?? "",
                            disclosure: true,
                            onPress: {
                                viewModel.onTypePress()
                            }
                        )
                        
                        InputDateCell(
                            .labels(
                                .title(
                                    .localized(.planted_at)
                                )
                            ),
                            date: $viewModel.plant.plantedAt
                        )
                        
                        DisplayCell(
                            title: .localized(.water_register),
                            subtitle: viewModel.plant.waterSchedule.type,
                            disclosure: true,
                            onPress: {
                                viewModel.onWaterSchedule()
                            }
                        )
                        
                        LongTextCell(
                            title: .localized(.notes),
                            text: $viewModel.plant.notes,
                            separator: false
                        )
                    }
                }
                
                if viewModel.allowDelete {
                    MainButton(
                        variant: .delete,
                        title: .localized(.delete),
                        action: viewModel.deletePress
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 40)
                }
            }
        }
        .background(
            Rectangle()
                .foregroundStyle(PixelKit.shared.theme.background)
        )
        .onDisappear(perform: viewModel.cleanNotSave)
        .ignoresSafeArea(.container, edges: .bottom)
    }
    
    func headerImage() -> ImageView {
        guard let mainImage = viewModel.coverImage else {
            return .placeholder(.icon(.imagePlaceholder))
        }
        
        return .image(Image(uiImage: mainImage))
    }
    
    func headerImageOptions() -> [ImageHeaderView.Option] {
        var options: [ImageHeaderView.Option] = []
        

        if viewModel.plant.cover != nil {
            options.append(
                .delete(
                    localization: .localized(.delete),
                    action: viewModel.onDeleteImage
                )
            )
            
            options.append(
                .change(
                    localization: .localized(.change),
                    action: viewModel.onChangeImage
                )
            )
        } else {
            options.append(
                .add(
                    localization: .localized(.add),
                    action: viewModel.onAddImage
                )
            )
        }
        
        return  options
    }
}
