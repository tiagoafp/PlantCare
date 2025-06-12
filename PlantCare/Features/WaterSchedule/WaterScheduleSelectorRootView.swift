//
//  WaterScheduleSelectorRootView.swift
//  PlantCare
//
//  Created by tiago.pereira on 14/6/25.
//

import SwiftUI

public struct WaterScheduleSelectorRootView: View {
    @ObservedObject var viewModel: WaterScheduleSelectorViewModel
    let depInjector: any PlantCareDependencyInjectorProtocol
    @ObservedObject var navigatior: ViewNavigator<WaterScheduleSelectorNavigation.Destinations>
    
    init(
        navigationPath: Binding<NavigationPath>,
        depInjector: any PlantCareDependencyInjectorProtocol,
        plant: Binding<Plant>
    ) {
        self.depInjector = depInjector
        self.navigatior = .init(navPath: navigationPath)
        
        viewModel = .init(
            input:
                .init(
                    navigation: WaterScheduleSelectorNavigation(),
                    plant: plant
            )
        )
    }
    
    public var body: some View {
        WaterScheduleSelectorView(
            viewModel: viewModel
        )
        .task {
            viewModel.input.navigation.updateNavigator(navigator: navigatior)
        }
        .sheet(item: $navigatior.sheet , content: navigateTo)
        .navigationDestination(for: navigatior.type, destination: navigateTo)
    }
}

extension WaterScheduleSelectorRootView {
    @ViewBuilder
    func navigateTo(destination: WaterScheduleSelectorNavigation.Destinations) -> some View {
        EmptyView()
    }
}
