import SwiftUI

struct AddPlantView<ViewModel: AddPlantViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        switch viewModel.state {
        case .empty:
            EmptyView()
        }
    }
}
