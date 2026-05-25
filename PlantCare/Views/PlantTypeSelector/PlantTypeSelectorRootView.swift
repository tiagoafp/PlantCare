import SwiftUI
import AtlasUI

struct PlantTypeSelectorRootView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: PlantTypeSelectorViewModel
    var onUpdate: () -> Void
    
    init(onUpdate: @escaping () -> Void) {
        self.onUpdate = onUpdate
        
        let trefleAPI = TrefleAPI().setKey(key: AppSecrets.trefleAPIKey)
        let planetAPI = PlantnetAPI().setKey(key: AppSecrets.plantnetAPIKey)
        _viewModel = .init(
            wrappedValue: PlantTypeSelectorViewModel(
                input: .init(
                    trefleAPI: trefleAPI,
                    plantnetAPI: planetAPI
                )
            )
        )
    }
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            PlantTypeSelectorView(viewModel: viewModel)
            .atlasBackground()
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
        case .add(let image, let species):
            PlantFormRootView(
                formType: .add(image: image, specie: species),
                navPath: $viewModel.path,
                onUpdate: onUpdate
            )
        }
    }
}
