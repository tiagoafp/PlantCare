import SwiftUI
import AtlasUI

struct AddPlantView<ViewModel: AddPlantViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        switch viewModel.state {
        case .data:
            ScrollView {
                VStack(spacing: 24) {
                    AtltasPhotoUploader(
                        title: .localized(key: .addPhoto),
                        image: $viewModel.image
                    )
                    
                    AtlasDefaultCell(
                        title: .localized(key: .selectedPlantType),
                        data: viewModel.type,
                        selection: .notSelectable
                    )
                    
                    AtlasTextInputCell(
                        title: .localized(key: .nickname),
                        placeholder: String.localized(key: .nickname),
                        text: $viewModel.nickname
                    )
                }
                .padding(20)
            }
        }
    }
}
