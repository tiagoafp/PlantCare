import SwiftUI
import AtlasUI

struct AddPlantRootView: View {
    @StateObject var viewModel: AddPlantViewModel

    init() {
        _viewModel = .init(
            wrappedValue: AddPlantViewModel()
        )
    }

    var body: some View {
        NavigationStack(path: $viewModel.path) {
            AddPlantView(viewModel: viewModel)
                .navigationTitle(
                    Text("AddPlant.title")
                )
                .toolbar {
                }
        }
        .sheet(
            item: $viewModel.sheet,
            content: destination
        )
        .navigationDestination(
            for: AddPlantDestination.self,
            destination: destination
        )
    }

    @ViewBuilder
    func destination(destination: AddPlantDestination) -> some View {
        switch destination {
        case .example:
            EmptyView()
        }
    }
}
