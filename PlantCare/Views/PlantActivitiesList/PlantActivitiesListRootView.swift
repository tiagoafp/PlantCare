import AtlasUI
import SwiftData
import SwiftUI

struct PlantActivitiesListRootView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: PlantActivitiesListViewModel
    var navPath: Binding<NavigationPath>
    var depInjector: DependencyInjectorProtocol

    init(
        plantID: UUID,
        navPath: Binding<NavigationPath>,
        depInjector: DependencyInjectorProtocol = DependencyInjector()
    ) {
        self.navPath = navPath
        self.depInjector = depInjector
        _viewModel = .init(
            wrappedValue: PlantActivitiesListViewModel(
                input: .init(
                    plantID: plantID,
                    activityImageStorage: depInjector.activityImageManager,
                    plantRepository: depInjector.plantRepository,
                    plantActivityRepository: depInjector.plantActivityRepository,
                    navPath: navPath
                )
            )
        )
    }

    var body: some View {
        PlantActivitiesListView(viewModel: viewModel)
            .onAppear {
                Task {
                    await viewModel.load(in: modelContext)
                }
            }
            .atlasBackground()
            .navigationTitle(Text.localized(key: .activityHistory))
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(
                for: PlantActivitiesListViewDestination.self,
                destination: destination
            )
    }
    
    @ViewBuilder
    func destination(destination: PlantActivitiesListViewDestination) -> some View {
        switch destination {
        case .detail(let recordId, let plantId):
            PlantActivityDetailRootView(
                depInjector: depInjector,
                activityId: recordId,
                plantId: plantId,
                navPath: navPath,
                onUpdate: {
                    Task {
                        await viewModel.load(in: modelContext)
                    }
                }
            )
        }
    }
}
