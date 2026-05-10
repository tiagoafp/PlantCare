import SwiftData
import SwiftUI
import AtlasUI

struct PlantDetailRootView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: PlantDetailViewModel
    var onDelete: () -> Void

    init(
        plantID: PersistentIdentifier,
        navPath: Binding<NavigationPath>,
        onDelete: @escaping () -> Void
    ) {
        self.onDelete = onDelete
        _viewModel = .init(
            wrappedValue: PlantDetailViewModel(
                input: .init(
                    plantID: plantID,
                    plantImageStorage: ImageStorageManager.plant,
                    navPath: navPath
                )
            )
        )
    }

    var body: some View {
        PlantDetailView(viewModel: viewModel)
            .task {
                await viewModel.load(in: modelContext)
            }
            .atlasBackground()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    AtlasToolbarButton(
                        image: .edit,
                        action: viewModel.onEdit
                    )
                }
            }
            .navigationTitle(Text.localized(key: .plantDetails))
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(
                for: PlantDetailDestination.self,
                destination: destination
            )
    }
    
    func destination(destination: PlantDetailDestination) -> some View {
        switch destination {
        case .edit(let plant):
            PlantFormRootView(
                formType: .edit(
                    plant: plant,
                    onDelete: onDelete
                ),
                navPath: viewModel.input.navPath
            )
        }
    }
}
