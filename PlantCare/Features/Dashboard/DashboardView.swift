//
//
// PlantCare
// Created by: tiago.pereira on 24/5/25
//

import SwiftUI
import PixelKit

struct DashboardView<ViewModel: DashboardViewModelProtocol>: View {
    @EnvironmentObject var config: PlantCareConfigurations
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SectionView(
                    section: viewModel.waterSection,
                    items: viewModel.waterSection.items
                )
                SectionView(
                    section: viewModel.plantsSection,
                    items: viewModel.plantsSection.items
                )
                SectionView(
                    section: viewModel.types,
                    items: viewModel.types.items
                )
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .background(
            Rectangle()
                .foregroundStyle(PixelKit.shared.theme.background)
        )
    }
}

extension DashboardView {
    @ViewBuilder
    func SectionView<Section: DashboardSectionProtocol, Item: DashboardSectionItemProtocol> (
        section: Section, items: [Item]
    ) -> AnyView {
        AnyView(
           GrouppedSectionView(
                .title(
                    section.title,
                    action: .default(
                        section.actionString,
                        action: {
                            viewModel.onSectionPress(section: section)
                        }
                    )
                ),
                cells: {
                    ForEach(items, id: \.self) { item in
                        Cell(item: item, lastItem: items.last)
                    }
                }
            )
        )
    }
    
    @ViewBuilder
    func Cell<Item: DashboardSectionItemProtocol>(item: Item, lastItem: Item?) -> AnyView {
        AnyView(
            DisplayCell(
                .labels(
                    .title(item.name),
                    .subtitle(
                        item.subtitle,
                        variant: item.subtitleType
                    )
                ),
                image: image(item: item),
                disclosure: item is DashboardSectionItemPlant,
                separator: item != lastItem,
                onPress: {
                    viewModel.onItemPressed(item: item)
                }
            )
        )
    }
    
    @ViewBuilder
    func image(item: any DashboardSectionItemProtocol) -> CellImage? {
        if let imageType = item.image {
            CellImage(.rounded(.variant(imageType)))
        }
    }
}
