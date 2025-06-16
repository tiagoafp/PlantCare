//
//  PlantImagesGalleryRootView.swift
//  PlantCare
//
//  Created by tiago.pereira on 15/6/25.
//

import SwiftUI

public struct PlantImagesGalleryRootView: View {
    @ObservedObject var viewModel: PlantImagesGalleryViewModel
    let depInjector: any PlantCareDependencyInjectorProtocol
    @ObservedObject var navigator: ViewNavigator<PlantImagesGalleryNavigation.Destinations>
    
    init(
        navigationPath: Binding<NavigationPath>,
        depInjector: any PlantCareDependencyInjectorProtocol,
        plant: Binding<Plant>
    ) {
        self.depInjector = depInjector
        self.navigator = .init(navPath: navigationPath)
        
        viewModel = .init(
            input:
                .init(
                    navigation: PlantImagesGalleryNavigation(),
                    plant: plant,
                    imagesRepo: depInjector.imagesRepo
            )
        )
    }
    
    public var body: some View {
        PlantImagesGalleryView(
            viewModel: viewModel
        )
        .task {
            viewModel.input.navigation.updateNavigator(navigator: navigator)
        }
        .sheet(item: $navigator.sheet , content: navigateTo)
        .navigationDestination(for: navigator.type, destination: navigateTo)
    }
}

extension PlantImagesGalleryRootView {
    @ViewBuilder
    func navigateTo(destination: PlantImagesGalleryNavigation.Destinations) -> some View {
        EmptyView()
    }
}
