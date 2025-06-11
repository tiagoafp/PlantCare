//
//  PlantFormRootView.swift
//  PlantCare
//
//  Created by tiago.pereira on 7/6/25.
//

import SwiftUI
import SwiftData

public struct PlantFormRootView: View {
    let navigation: PlantFormNavigationProtocol
    let plant: PersistentIdentifier?
    let diInjector: any PlantCareDependencyInjectorProtocol
    
    init(
        navigationPath: Binding<NavigationPath>,
        plant: PersistentIdentifier?,
        diInjector: any PlantCareDependencyInjectorProtocol
    ) {
        self.navigation = PlantFormNavigation(navPath: navigationPath)
        self.plant = plant
        self.diInjector = diInjector
    }
    
    public var body: some View {
        PlantFormView(
            viewModel: PlantFormViewModel(
                input: .init(
                    plant: plant,
                    navigation: navigation,
                    storage: Storage(db: diInjector.db)
                )
            )
        )
        .navigationDestination(
            for: PlantFormNavigation.Destinations.self,
            destination: navigateTo
        )
    }
}

extension PlantFormRootView {
    @ViewBuilder
    func navigateTo(destination: PlantFormNavigation.Destinations) -> some View {
        EmptyView()
    }
}
