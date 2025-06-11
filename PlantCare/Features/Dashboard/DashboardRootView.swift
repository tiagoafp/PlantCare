//
//
// PlantCare
// Created by: tiago.pereira on 24/5/25
//

import SwiftUI

public struct DashboardRootView: View {
    @ObservedObject var viewModel: DashboardViewModel
    let router: DashboardRouterProtocol
    let depInjector: any PlantCareDependencyInjectorProtocol
    let navigationPath: Binding<NavigationPath>
    
    init(
        navigationPath: Binding<NavigationPath>,
        depInjector: any PlantCareDependencyInjectorProtocol
    ) {
        self.router = DashboardRouter(navPath: navigationPath)
        self.depInjector = depInjector
        self.navigationPath = navigationPath
        
        viewModel = .init(input:
                .init(
                    router: router,
                    plantTypeRepo: depInjector.plantTypeRepo,
                    storage: Storage(db: depInjector.db)
                )
        )
    }
    
    public var body: some View {
        DashboardView(
            viewModel: viewModel
        )
        .navigationDestination(
            for: DashboardRouter.Destinations.self,
            destination: navigateTo
        )
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
                navigationPath: router.navPath,
                plant: plant,
                diInjector: depInjector
            )
        case .types:
            TypeListRootView(
                navigationPath: navigationPath,
                mode: .normal,
                dpInjector: depInjector
            )
        }
    }
}
