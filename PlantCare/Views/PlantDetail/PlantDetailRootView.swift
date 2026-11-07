import SwiftData
import SwiftUI
import AtlasUI

struct PlantDetailRootView: View {
    @Environment(\.atlasPalette) var palette
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: PlantDetailViewModel
    var onDelete: () -> Void
    var depInjector: DependencyInjectorProtocol
    let navPath: Binding<NavigationPath>
    @State var confirmDelete: Bool = false

    init(
        plantID: UUID,
        navPath: Binding<NavigationPath>,
        depInjector: DependencyInjectorProtocol = DependencyInjector(),
        onDelete: @escaping () -> Void
    ) {
        self.onDelete = onDelete
        self.depInjector = depInjector
        self.navPath = navPath
        
        _viewModel = .init(
            wrappedValue: PlantDetailViewModel(
                input: .init(
                    plantID: plantID,
                    plantImageStorage: depInjector.plantImageManager,
                    activityImageStorage: depInjector.activityImageManager,
                    plantRepository: depInjector.plantRepository,
                    plantActivityRepository: depInjector.plantActivityRepository,
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
            .alert(
                .localized(key: .deleteConfirmation),
                isPresented: $confirmDelete,
                actions: {
                    Button(
                        String.localized(key: .delete),
                        role: .destructive) {
                            viewModel.delete(context: modelContext)
                        }
                    
                    Button(String.localized(key: .cancel), role: .cancel) {
                        confirmDelete.toggle()
                    }
                })
            .sheet(item: $viewModel.sheet, content: destination)
    }
    
    @ViewBuilder
    func destination(destination: PlantDetailDestination) -> some View {
        switch destination {
        case .edit(let plant):
            PlantFormRootView(
                depInjector: depInjector,
                formType: .edit(
                    plant: plant,
                    onDelete: onDelete
                ),
                navPath: viewModel.input.navPath,
                onUpdate: {
                    Task{
                        await viewModel.load(in: modelContext)
                    }
                }
            )
        case .logActivity(let plant):
            PlantActivityFormRootView(
                depInjector: depInjector,
                formType: .add(plantId: plant.plantID),
                navPath: nil, onUpdate: {
                    Task {
                        await viewModel.load(in: modelContext)
                    }
                }
            )
        case .editActivity(let plant, let activity):
            PlantActivityDetailRootView(
                depInjector: depInjector,
                activityId: activity.activityID,
                plantId: plant.plantID,
                navPath: navPath,
                onUpdate: {
                    Task {
                        await viewModel.load(in: modelContext)
                    }
                }
            )
        case .viewAllActivites(let plantID):
            PlantActivitiesListRootView(
                plantID: plantID,
                navPath: navPath,
                depInjector: depInjector
            )
        }
    }
}
