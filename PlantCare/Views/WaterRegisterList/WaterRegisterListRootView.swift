//
// Copyright © 2025 Sage.
// All Rights Reserved.

import SwiftUI
import PixelKit

public struct WaterRegisterListRootView: View {
    @StateObject var viewModel: WaterRegisterListViewModel
    var plant: Plant
    
    init(
        plant: Plant,
        dpInjector: any PlantCareDependencyInjectorProtocol
    ) {
        self.plant = plant
        _viewModel = StateObject(
            wrappedValue:
                WaterRegisterListViewModel(
                    input: .init(
                        plant: plant,
                        builder: WaterRegisterItemsBuilder(
                            subtitleBuilder: WaterRegisterSubtitleBuilder(waterService: StaticWaterPlantService())
                        )
                    )
                )
        )
    }
    
    public var body: some View {
        StackNavigator(destination: navigateTo) { router in
            WaterRegisterListView(
                viewModel: viewModel
            )
            .task {
                viewModel.inject(router: router)
            }
        }
    }
}

extension WaterRegisterListRootView {
    @ViewBuilder
    func navigateTo(destination: WaterRegisterListRoute) -> some View {
        EmptyView()
    }
}


