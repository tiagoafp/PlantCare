//
//
// PlantCare
// Created by: tiago.pereira on 9/7/25
//

import SwiftUI
import SwiftData

struct PlantDetailRootView: View {
    @StateObject var viewModel: PlantDetailViewModel
    var depInjector: any PlantCareDependencyInjectorProtocol
    init(
        plant: PersistentIdentifier,
        depInjector: any PlantCareDependencyInjectorProtocol
    ) {
        self.depInjector = depInjector
        _viewModel = StateObject(
            wrappedValue: .init(
                input: .init(
                    repo: depInjector.plantRepo,
                    plantId: plant,
                    imageReader: DocsImagesStorageService()
                )
            )
        )
    }
    
    var body: some View {
        StackNavigator(destination: destination) { router in
            PlantDetailView(viewModel: viewModel)
                .task {
                    viewModel.update(router: router)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(String.localized(.edit)) {
                            viewModel.onEdit()
                        }
                    }
                }
        }
    }
    
    @ViewBuilder
    func destination(_ route: PlantDetailRoute) -> some View {
        switch route {
        case .edit:
            PlantFormRootView(plant: viewModel.input.plantId, diInjector: depInjector, origin: .detail)
        }
    }
}
