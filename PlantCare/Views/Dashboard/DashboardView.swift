//
//
// PlantCare
// Created by: tiago.pereira on 24/5/25
//

import SwiftUI
import PixelKit

@MainActor
struct DashboardView<ViewModel: DashboardViewModelProtocol>: View {
    @EnvironmentObject var config: PlantCareConfigurations
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Rectangle().foregroundStyle(PixelKit.shared.theme.background)
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(viewModel.sections, id: \.self) { section in
                        GrouppedSectionView(
                            title: section.title,
                            action: section.actionString,
                            onAction: {
                                viewModel.onSectionPress(section: section)
                            }
                        ) {
                            sectionList(section: section)
                        }
                    }
                }
            }
        }
        .onAppear(perform: viewModel.onAppear)
        .ignoresSafeArea(edges: .bottom)
    }
}

extension DashboardView {
    @ViewBuilder
    func sectionList(
        section: DashboardSection
    ) -> some View {
        switch section {
        case .water:
            listView(items: viewModel.water, onPress: viewModel.onPlantPress)
        case .plants:
            listView(items: viewModel.plants, onPress: viewModel.onPlantPress)
        case .types:
            listView(items: viewModel.plantTypes, onPress: viewModel.onPlantTypePress)
        }
    }
    
    @ViewBuilder
    func listView<Item>(
        items: [DisplayItem<Item>],
        onPress: @escaping (DisplayItem<Item>) -> Void
    ) -> some View {
        VStack(spacing: 0) {
            ForEach(items, id: \.self) { item in
                itemView(item: item, onPress: onPress)
            }
        }
    }
    
    @ViewBuilder
    func itemView<Item>(
        item: DisplayItem<Item>,
        onPress: @escaping (DisplayItem<Item>) -> Void
    ) -> some View {
        DisplayCell(
            title: item.title,
            subtitle: item.subtitle,
            subtitleVariant: item.subtitleVariant.casted,
            image: itemImage(item: item),
            disclosure: item.disclosure,
            separator: item.separator,
            onPress: {
                onPress(item)
            }
        )
    }
    
    func itemImage<Item>(item: DisplayItem<Item>) -> CellImage? {
        if let image = item.image {
            return .rounded(Image(uiImage: image))
        } else {
            return nil
        }
    }
}
