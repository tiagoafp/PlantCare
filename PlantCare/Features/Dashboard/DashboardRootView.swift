//
//
// PlantCare
// Created by: tiago.pereira on 24/5/25
//

import SwiftUI

protocol DashboardRootViewProtocl {
    
}


public struct DashboardRootView: View, DashboardRootViewProtocl {
    let router: DashboardRouterProtocol
    
    init(navigationPath: Binding<NavigationPath>) {
        router = DashboardRouter(navPath: navigationPath)
    }
    
    public var body: some View {
        DashboardView(
            viewModel: DashboardViewModel(
                input: .init(router: router)
            )
        )
    }
}
