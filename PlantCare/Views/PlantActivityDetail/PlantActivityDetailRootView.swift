import SwiftData
import SwiftUI
import AtlasUI

struct PlantActivityDetailRootView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: PlantActivityDetailViewModel
    var onUpdate: () -> Void

    init(
        activity: PlantActivityRecord,
        plant: PlantRecord,
        onUpdate: @escaping () -> Void
    ) {
        self.onUpdate = onUpdate
        _viewModel = .init(
            wrappedValue: PlantActivityDetailViewModel(
                input: .init(
                    plantImageManager: ImageStorageManager.plant,
                    activity: activity,
                    plant: plant
                )
            )
        )
    }

    var body: some View {
        PlantActivityDetailView(viewModel: viewModel)
            .onAppear(perform: {
                viewModel.onAppear(in: modelContext)
            })
            .atlasBackground()
            .navigationTitle(.localized(key: .activity))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    AtlasToolbarButton(
                        image: .edit,
                        action: viewModel.onEdit
                    )
                }
            }
    }
}
