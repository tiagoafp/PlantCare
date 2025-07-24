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
                            isEmpty: isEmpty(section: section),
                            onAction: {
                                viewModel.onSectionPress(section: section)
                            }
                        ) {
                            sectionList(section: section)
                        }
                    }
                }
                .padding(.bottom, 40)
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
            listView(
                items: viewModel.water,
                emptyConfig: .plant,
                onPress: viewModel.onItemPressed
            )
        case .plants:
            listView(
                items: viewModel.plants,
                emptyConfig: .plant,
                onPress: viewModel.onItemPressed)
        case .types:
            listView(
                items: viewModel.plantTypes,
                emptyConfig: .plantType,
                onPress: viewModel.onItemPressed)
        }
    }
    
    @ViewBuilder
    func listView(
        items: [DisplayItem],
        emptyConfig: ListEmptyView.Configuration,
        onPress: @escaping (DisplayItem) -> Void
    ) -> some View {
        VStack(spacing: 0) {
            if items.isEmpty {
                ListEmptyView(configuration: emptyConfig)
            } else {
                ForEach(items, id: \.self) { item in
                    itemView(item: item, onPress: onPress)
                }
            }
        }
    }
    
    @ViewBuilder
    func itemView(
        item: DisplayItem,
        onPress: @escaping (DisplayItem) -> Void
    ) -> some View {
        DisplayCell(
            title: item.title,
            subtitle: item.subtitle.text,
            subtitleVariant: item.subtitle.casted,
            image: itemImage(item: item),
            disclosure: item.disclosure,
            separator: item.separator,
            onPress: {
                onPress(item)
            }
        )
    }
    
    func itemImage(item: DisplayItem) -> CellImage? {
        if let image = item.image {
            return .rounded(Image(uiImage: image))
        } else {
            return nil
        }
    }
    
    func isEmpty(section: DashboardSection) -> Bool {
        switch section {
        case .water:
            return viewModel.water.isEmpty
        case .plants:
            return viewModel.plants.isEmpty
        case .types:
            return viewModel.plantTypes.isEmpty
        }
    }
}
