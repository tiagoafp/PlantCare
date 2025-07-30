//
//  PlantFormRootView.swift
//  PlantCare
//
//  Created by tiago.pereira on 7/6/25.
//

import SwiftUI
import SwiftData
import PixelKit

public struct PlantFormRootView: View {
    let diInjector: any PlantCareDependencyInjectorProtocol
    @StateObject var viewModel: PlantFormViewModel
    
    init(
        plant: PersistentIdentifier?,
        diInjector: any PlantCareDependencyInjectorProtocol,
        origin: PlantFormOrigin,
        onAdd: @escaping () -> Void
    ) {
        self.diInjector = diInjector
        
        _viewModel = StateObject(wrappedValue:
                .init(
                    input: .init(
                        plant: plant,
                        repo: diInjector.plantRepo,
                        imagesWritter: DocsImagesStorageService(),
                        imagesReader: DocsImagesStorageService(),
                        origin: origin,
                        onAdd: onAdd
                    )
                )
        )
    }
    
    public var body: some View {
        StackNavigator(
            root: viewModel.input.origin == .list ? true : false,
            destination: navigateTo
        ) { route in
            PlantFormView(
                viewModel: viewModel
            )
            .task {
                viewModel.inject(router: route)
            }
            .navigationTitle(.localized(.add_plant))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(String.localized(.save)) {
                    viewModel.onSave()
                }
            }
            .alert(
                .localized(.delete_confirmation_title),
                isPresented: $viewModel.confirmDelete,
                actions: {
                    
                    Button(String.localized(.cancel), role: .cancel) {
                        viewModel.deletePress()
                    }
                    
                    Button(String.localized(.delete), role: .destructive) {
                        viewModel.deletePlant()
                    }
                },
                message: {
                    Text(String.localized(.delete_confirmation_message))
                }
            )
        }
    }
}

extension PlantFormRootView {
    @ViewBuilder
    func navigateTo(destination: PlantFormRoute) -> some View {
        switch destination {
        case .plantType:
            TypeListRootView(
                selected: $viewModel.plant.type,
                dpInjector: diInjector
            )
        case .waterSchedule:
            WaterScheduleSelectorRootView(
                depInjector: diInjector,
                plant: $viewModel.plant
            )
        }
    }
}
