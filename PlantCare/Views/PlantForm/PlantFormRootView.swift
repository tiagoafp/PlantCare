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
    @State var confirmDelete: Bool = false
    
    init(
        plant: PersistentIdentifier?,
        diInjector: any PlantCareDependencyInjectorProtocol,
        origin: PlantFormOrigin
    ) {
        self.diInjector = diInjector
        
        _viewModel = StateObject(wrappedValue:
                .init(
                    input: .init(
                        plant: plant,
                        repo: diInjector.plantRepo,
                        imagesRepo: diInjector.imagesRepo,
                        origin: origin
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
            .toolbar {
                if viewModel.input.plant != nil {
                    Button(String.localized(.delete)) {
                        confirmDelete.toggle()
                    }
                    .foregroundStyle(PixelKit.shared.theme.negative)
                }
            }
            .alert(
                .localized(.delete_confirmation_title),
                isPresented: $confirmDelete,
                actions: {
                    Button(String.localized(.cancel)) {
                        confirmDelete.toggle()
                    }
                    
                    Button(String.localized(.delete)) {
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
