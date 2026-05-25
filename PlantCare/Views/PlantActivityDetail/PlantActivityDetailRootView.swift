import SwiftData
import SwiftUI
import AtlasUI

struct PlantActivityDetailRootView: View {
    @Environment(\.atlasPalette) var palette
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: PlantActivityDetailViewModel
    var onUpdate: () -> Void
    @State private var confirmDelete: Bool = false
    var navPath: Binding<NavigationPath>

    init(
        activity: PlantActivityRecord,
        plant: PlantRecord,
        navPath: Binding<NavigationPath>,
        onUpdate: @escaping () -> Void
    ) {
        self.onUpdate = onUpdate
        self.navPath = navPath
        _viewModel = .init(
            wrappedValue: PlantActivityDetailViewModel(
                input: .init(
                    plantImageManager: ImageStorageManager.plant,
                    activityImageManager: ImageStorageManager.activities,
                    activity: activity,
                    plant: plant,
                    navPath: navPath,
                    onUpdate: onUpdate
                )
            )
        )
    }

    var body: some View {
        PlantActivityDetailView(viewModel: viewModel)
            .onAppear(perform: {
                viewModel.inject(dismiss: dismiss)
                viewModel.onAppear(in: modelContext)
            })
            .atlasBackground()
            .navigationTitle(.localized(key: .activity))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    AtlasToolbarButton(
                        image: .delete,
                        color: palette.actionDestructive,
                        action: {
                            confirmDelete = true
                        }
                    )
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    AtlasToolbarButton(
                        image: .edit,
                        action: viewModel.onEdit
                    )
                }
            }
            .alert(
                .localized(key: .deleteConfirmation),
                isPresented: $confirmDelete,
                actions: {
                    Button(
                        String.localized(key: .delete),
                        role: .destructive) {
                            viewModel.onDelete(in: modelContext)
                        }
                    
                    Button(String.localized(key: .cancel), role: .cancel) {
                        confirmDelete.toggle()
                    }
                }
            )
            .navigationDestination(for: PlantActivityDetailDestination.self, destination: destination)
    }
    
    @ViewBuilder
    func destination(destination: PlantActivityDetailDestination) -> some View {
        switch destination {
        case .edit(let plant, let activity):
            PlantActivityFormRootView(
                formType: .edit(plant: plant, activity: activity),
                navPath: navPath,
                onUpdate: {
                    viewModel.onUpdated(in: modelContext)
                    onUpdate()
                }
            )
        }
    }
}
