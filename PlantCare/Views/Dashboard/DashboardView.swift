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
                ForEach(viewModel.sections, id: \.self) { section in
                    GrouppedSectionView(
                        title: section.title,
                        action: .default(section.actionString) {}
                    ) {
                        VStack(spacing: 0) {
                            ForEach(section.items, id: \.self) { item in
                                itemView(item: item)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .background(
            Rectangle()
                .foregroundStyle(PixelKit.shared.theme.background)
        )
        .ignoresSafeArea(edges: .bottom)
    }
}

extension DashboardView {
    @ViewBuilder
    func itemView(item: DashboardItem) -> some View {
        DisplayCell(
            .labels(
                .title(item.title),
                itemSubtitle(item: item)
            ),
            image: itemImage(item: item),
            disclosure: item.disclosure,
            separator: item.separator,
            onPress: {
                
            }
        )
    }
    
    func itemImage(item: DashboardItem) -> CellImage? {
        if let image = item.image {
            return .rounded(image)
        } else {
            return nil
        }
    }
    
    func itemSubtitle(item: DashboardItem) -> CellSubtitle {
        switch item.subtitle {
        case .positive(let value):
            CellSubtitle.positive(value)
        case .negative(let value):
            CellSubtitle.negative(value)
        case .warning(let value):
            CellSubtitle.warning(value)
        case .neutral(let value):
            CellSubtitle.subtitle(value)
        }
    }
}
