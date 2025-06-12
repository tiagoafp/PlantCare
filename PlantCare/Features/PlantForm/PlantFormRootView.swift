//
//  PlantFormRootView.swift
//  PlantCare
//
//  Created by tiago.pereira on 7/6/25.
//

import SwiftUI
import SwiftData

public struct PlantFormRootView: View {
    let navigationPath: Binding<NavigationPath>
    let diInjector: any PlantCareDependencyInjectorProtocol
    @ObservedObject var viewModel: PlantFormViewModel
    
    init(
        plant: PersistentIdentifier?,
        navigationPath: Binding<NavigationPath>,
        diInjector: any PlantCareDependencyInjectorProtocol
    ) {
        self.navigationPath = navigationPath
        self.diInjector = diInjector
        
        viewModel = .init(
            input: .init(
                plant: plant,
                navigation: PlantFormNavigation(navPath: navigationPath),
                repo: diInjector.plantRepo,
                imagesRepo: diInjector.imagesRepo
            )
        )
    }
    
    public var body: some View {
        PlantFormView(
            viewModel: viewModel
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
        switch destination {
        case .plantType:
            TypeListRootView(
                navigationPath: navigationPath,
                selected: $viewModel.plant.type,
                dpInjector: diInjector
            )
        case .waterSchedule:
            WaterScheduleSelectorRootView(
                navigationPath: navigationPath,
                depInjector: diInjector,
                plant: $viewModel.plant
            )
        }
    }
}
