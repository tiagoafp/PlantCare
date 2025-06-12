//
//
// PlantCare
// Created by: tiago.pereira on 24/5/25
//

import SwiftUI

public struct DashboardRootView: View {
    @ObservedObject var viewModel: DashboardViewModel
    let depInjector: any PlantCareDependencyInjectorProtocol
    @ObservedObject var navigation: ViewNavigator<DashboardRouter.Destinations>
    
    init(
        navigationPath: Binding<NavigationPath>,
        depInjector: any PlantCareDependencyInjectorProtocol
    ) {
        self.depInjector = depInjector
        self.navigation = .init(navPath: navigationPath)
        
        viewModel = .init(input:
                .init(
                    router: DashboardRouter(),
                    plantTypeRepo: depInjector.plantTypeRepo,
                    storage: Storage(db: depInjector.db)
                )
        )
    }
    
    public var body: some View {
        DashboardView(
            viewModel: viewModel
        )
        .task {
            viewModel.input.router.updateNavigator(navigator: navigation)
        }
        .sheet(item: $navigation.sheet , content: navigateTo)
        .navigationDestination(for: navigation.type, destination: navigateTo)
    }
}

extension DashboardRootView {
    @ViewBuilder
    func navigateTo(destination: DashboardRouter.Destinations) -> some View {
        switch destination {
        case .water:
            EmptyView()
        case .plants(let plant):
            PlantFormRootView(
                plant: plant,
                navigationPath: navigation.navPath,
                diInjector: depInjector
            )
        case .types:
            TypeListRootView(
                navigationPath: navigation.navPath,
                selected: .constant(nil),
                dpInjector: depInjector
            )
        }
    }
}
