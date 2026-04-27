import SwiftUI
import AtlasUI

struct PlantTypeSelectorRootView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: PlantTypeSelectorViewModel
    
    init() {
        _viewModel = .init(
            wrappedValue: PlantTypeSelectorViewModel()
        )
    }
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            BackgroundView {
                PlantTypeSelectorView(viewModel: viewModel)
            }
            .navigationTitle(.localized(key: .selectPlantTitle))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(
                    placement: .topBarTrailing,
                    content: {
                        AtlasToolbarButton(
                            image: .close,
                            action: {
                                dismiss()
                            }
                        )
                    }
                )
            }
            .sheet(
                item: $viewModel.sheet,
                content: destination
            )
            .navigationDestination(
                for: PlantTypeSelectorDestination.self,
                destination: destination
            )
        }
    }
    
    @ViewBuilder
    func destination(destination: PlantTypeSelectorDestination) -> some View {
        switch destination {
        case .example:
            EmptyView()
        }
    }
}
