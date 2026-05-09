import SwiftUI
import AtlasUI

struct DashboardRootView: View {
    @StateObject var viewModel: DashboardViewModel
    @Environment(\.modelContext) private var modelContext
   
    init() {
        _viewModel = .init(
            wrappedValue: DashboardViewModel(
                input: .init(
                    imageManager: ImageStorageManager.plant
                )
            )
        )
    }
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            DashboardView(viewModel: viewModel)
                .onAppear(perform: {
                    viewModel.inject(modelContext)
                })
            .atlasBackground()
            .sheet(
                item: $viewModel.sheet,
                content: destination
            )
            .navigationDestination(
                for: DashboardDestination.self,
                destination: destination
            )
            .ignoresSafeArea(edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(
                .localized(key: .appTitle)
            )
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    AtlasToolbarButton(
                        image: .init(
                            systemName: viewModel.watering ? "drop.fill" : "drop"),
                        action: {
                            viewModel.watering.toggle()
                        }
                    )
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    AtlasToolbarButton(
                        image: .plus,
                        action: viewModel.addPlant
                    )
                }
            }
        }
    }
    
    @ViewBuilder
    func destination(destination: DashboardDestination) -> some View {
        switch destination {
        case .addPlant:
            PlantTypeSelectorRootView()
        case .detail(let plantID):
            PlantDetailRootView(plantID: plantID)
        }
    }
}
