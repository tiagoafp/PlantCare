import AtlasUI
import SwiftUI

struct PlantDetailView<ViewModel: PlantDetailViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        switch viewModel.state {
        case .loading, .notFound:
            ProgressView()
        case .data(let adapter):
            ScrollView {
                LazyVStack(spacing: 20) {
                    DetailImageView(image: adapter.detailImage)
                    
                    AtlasDefaultCell(
                        data: adapter.nickNameField,
                        selection: .notSelectable
                    )
                    
                    AtlasDefaultCell(
                        data: adapter.typeField,
                        selection: .notSelectable
                    )
                    
                    AtlasSectionView(title: .localized(key: .activityHistory)) {
                        AtlasNoDataSectionView(
                            image: Image(systemName: "calendar"),
                            title: .localized(key: .noActivityYet),
                            description: .localized(key: .activityEmptySubtitle)
                        )
                    }
                }
                .padding(20)
            }
        }
    }
}
