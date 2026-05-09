import SwiftData
import SwiftUI
import AtlasUI

struct PlantDetailRootView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: PlantDetailViewModel

    init(plantID: PersistentIdentifier) {
        _viewModel = .init(
            wrappedValue: PlantDetailViewModel(
                input: .init(
                    plantID: plantID,
                    plantImageStorage: ImageStorageManager.plant
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
            .navigationTitle(Text.localized(key: .plantDetails))
            .navigationBarTitleDisplayMode(.inline)        
    }
}
