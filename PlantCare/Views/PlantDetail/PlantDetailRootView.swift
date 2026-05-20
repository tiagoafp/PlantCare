import SwiftData
import SwiftUI
import AtlasUI

struct PlantDetailRootView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: PlantDetailViewModel
    var onDelete: () -> Void
    var depInjector: DependencyInjectorProtocol

    init(
        plantID: PersistentIdentifier,
        navPath: Binding<NavigationPath>,
        depInjector: DependencyInjectorProtocol = DependencyInjector(),
        onDelete: @escaping () -> Void
    ) {
        self.onDelete = onDelete
        self.depInjector = depInjector
        
        _viewModel = .init(
            wrappedValue: PlantDetailViewModel(
                input: .init(
                    plantID: plantID,
                    plantImageStorage: depInjector.plantImageManager,
                    activityImageStorage: depInjector.activityImageManager,
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
            .atlasBottomAction(content: {
                AtlasBottomActionButton(
                    title: .localized(key: .logActivity),
                    systemImage: nil,
                    action: viewModel.addActivity
                )
            })
            .sheet(item: $viewModel.sheet, content: destination)
    }
    
    @ViewBuilder
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
        case .logActivity(let plant):
            PlantActivityFormRootView(
                formType: .add(plant: plant),
                onUpdate: {
                    Task {
                        await viewModel.load(in: modelContext)
                    }
                }
            )
        case .editActivity(let plant, let activity):
            PlantActivityDetailRootView(
                activity: activity,
                plant: plant,
                onUpdate: {
                    Task {
                        await viewModel.load(in: modelContext)
                    }
                }
            )
        }
    }
}
