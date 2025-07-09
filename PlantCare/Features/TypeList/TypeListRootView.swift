//
//  TypeListRootView.swift
//  PlantCare
//
//  Created by tiago.pereira on 8/6/25.
//

import SwiftUI

public struct TypeListRootView: View {
    @ObservedObject var viewModel: TypeListViewModel
    
    init(
        selected: Binding<PlantType?>,
        dpInjector: any PlantCareDependencyInjectorProtocol
    ) {
        viewModel = .init(
            input: .init(
                repo: dpInjector.plantTypeRepo,
                selected: selected
            )
        )
    }
    
    public var body: some View {
        StackNavigator(destination: navigateTo) { _ in
            TypeListView(
                viewModel: viewModel
            )
        }
    }
}

extension TypeListRootView {
    @ViewBuilder
    func navigateTo(destination: TypeListRoute) -> some View {
        EmptyView()
    }
}
