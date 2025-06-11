//
//  TypeListRootView.swift
//  PlantCare
//
//  Created by tiago.pereira on 8/6/25.
//

import SwiftUI

public struct TypeListRootView: View {
    @ObservedObject var viewModel: TypeListViewModel
    let navigation: TypeListNavigationProtocol
    
    init(
        navigationPath: Binding<NavigationPath>,
        mode: TypeListMode,
        dpInjector: any PlantCareDependencyInjectorProtocol
    ) {
        navigation = TypeListNavigation(navPath: navigationPath)
        viewModel = .init(
            input: .init(
                mode: mode,
                navigation: navigation,
                repo: dpInjector.plantTypeRepo
            )
        )
    }
    
    public var body: some View {
        TypeListView(
            viewModel: viewModel
        )
        .navigationDestination(
            for: TypeListNavigation.Destinations.self,
            destination: navigateTo
        )
    }
}

extension TypeListRootView {
    @ViewBuilder
    func navigateTo(destination: TypeListNavigation.Destinations) -> some View {
        EmptyView()
    }
}
