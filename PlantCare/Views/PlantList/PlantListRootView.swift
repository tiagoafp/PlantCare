//
//
// PlantCare
// Created by: tiago.pereira on 9/7/25
//

import SwiftUI

struct PlantListRootView: View {
    var depInjector: any PlantCareDependencyInjectorProtocol
    @StateObject var viewModel: PlantListViewModel
    
    init(depInjector: any PlantCareDependencyInjectorProtocol) {
        self.depInjector = depInjector
        
        _viewModel = StateObject(
            wrappedValue: PlantListViewModel(
                input: .init(
                    repo: depInjector.plantRepo,
                    itemsBuilder: AppPlantItemsBuilder(
                        subtitleBuilder: PlantDisplaySubtitleBuilder()
                    )
                )
            )
        )
    }
    
    var body: some View {
        StackNavigator(destination: destination) { router in
           PlantListView(viewModel: viewModel)
                .task {
                    viewModel.inject(router: router)
                }
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    @ViewBuilder
    func destination(route: PlantListRoute) -> some View {
        switch route {
        case .add:
            PlantFormRootView(plant: nil, diInjector: depInjector, origin: .list)
        case .detail(let persistentIdentifier):
            PlantDetailRootView(plant: persistentIdentifier, depInjector: depInjector)
        }
    }
}
