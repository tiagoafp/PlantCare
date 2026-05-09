import SwiftData
import SwiftUI
import AtlasUI

struct AddPlantRootView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel: AddPlantViewModel
    
    init(
        image: Data?,
        specie: TrefleListResponse.Species,
        navPath: Binding<NavigationPath>
    ) {
        _viewModel = .init(
            wrappedValue: AddPlantViewModel(
                input: .init(
                    navPath: navPath,
                    image: image,
                    type: specie,
                    imageStorage: ImageStorageManager.plant
                )
            )
        )
    }
    
    var body: some View {
        AddPlantView(viewModel: viewModel)
        .atlasBackground()
        .atlasBottomAction {
            AtlasBottomActionButton(
                title: .localized(key: .addNewPlant),
                action: {
                    viewModel.save(in: modelContext)
                }
            )
        }
        .navigationTitle(
            Text.localized(key: .addNewPlant)
        )
        .toolbar {
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
