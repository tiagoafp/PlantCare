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
                }
                .padding(20)
            }
        }
    }
}
