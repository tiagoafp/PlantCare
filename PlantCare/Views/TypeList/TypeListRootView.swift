//
//  TypeListRootView.swift
//  PlantCare
//
//  Created by tiago.pereira on 8/6/25.
//

import SwiftUI

public struct TypeListRootView: View {
    @StateObject var viewModel: TypeListViewModel
    var selected: Binding<PlantType?>
    
    init(
        selected: Binding<PlantType?>,
        dpInjector: any PlantCareDependencyInjectorProtocol
    ) {
        self.selected = selected
        
        _viewModel = StateObject(
            wrappedValue:
                TypeListViewModel(
                    input: .init(
                        repo: dpInjector.plantTypeRepo,
                        selected: selected
                    )
                )
        )
    }
    
    public var body: some View {
        StackNavigator(destination: navigateTo) { _ in
            TypeListView(
                viewModel: viewModel
            )
            .onChange(of: viewModel.selected, perform: { new in
                if new != selected.wrappedValue {
                    selected.wrappedValue = new
                }
            })
        }
    }
}

extension TypeListRootView {
    @ViewBuilder
    func navigateTo(destination: TypeListRoute) -> some View {
        EmptyView()
    }
}
