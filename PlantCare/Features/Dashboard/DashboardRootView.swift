//
//
// PlantCare
// Created by: tiago.pereira on 24/5/25
//

import SwiftUI

public struct DashboardRootView: View {
    @StateObject var viewModel: DashboardViewModel
    let depInjector: any PlantCareDependencyInjectorProtocol
    
    init(
        navigationPath: Binding<NavigationPath>,
        depInjector: any PlantCareDependencyInjectorProtocol
    ) {
        self.depInjector = depInjector
        
        _viewModel = StateObject(
            wrappedValue: .init(input:
                    .init(
                        plantTypeRepo: depInjector.plantTypeRepo,
                        storage: Storage(db: depInjector.db)
                    )
            )
        )
    }
    
    public var body: some View {
        StackNavigator(root: true, destination: navigateTo) { router in
            DashboardView(
                viewModel: viewModel
            )
            .task {
                viewModel.inject(router: router)
            }
            .navigationTitle(.localized(.plant_care))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension DashboardRootView {
    @ViewBuilder
    func navigateTo(destination: DashboardRoute) -> some View {
        switch destination {
        case .water:
            EmptyView()
        case .plants:
            PlantListRootView(depInjector: depInjector)
        case .types:
            TypeListRootView(
                selected: .constant(nil),
                dpInjector: depInjector
            )
        case .plant(let plant):
            PlantDetailRootView(
                plant: plant,
                depInjector: depInjector
            )
        }
    }
}
