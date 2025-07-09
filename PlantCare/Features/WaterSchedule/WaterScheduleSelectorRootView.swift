//
//  WaterScheduleSelectorRootView.swift
//  PlantCare
//
//  Created by tiago.pereira on 14/6/25.
//

import SwiftUI

public struct WaterScheduleSelectorRootView: View {
    @StateObject var viewModel: WaterScheduleSelectorViewModel
    let depInjector: any PlantCareDependencyInjectorProtocol
    
    init(
        depInjector: any PlantCareDependencyInjectorProtocol,
        plant: Binding<Plant>
    ) {
        self.depInjector = depInjector
        
        _viewModel = StateObject(wrappedValue:
                .init(
                    input:
                            .init(
                                plant: plant
                            )
                )
        )
    }
    
    public var body: some View {
        StackNavigator(destination: navigateTo) { router in
            WaterScheduleSelectorView(
                viewModel: viewModel
            )
            .task {
                viewModel.inject(router: router)
            }
        }
    }
}

extension WaterScheduleSelectorRootView {
    @ViewBuilder
    func navigateTo(destination: WaterScheduleRoute) -> some View {}
}
