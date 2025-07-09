//
//
// PlantCare
// Created by: tiago.pereira on 16/5/25
//


import SwiftUI
import SwiftData

@main
struct PlantCareApp: App {
    var injector: PlantCareDependencyInjector
    @State var navPath = NavigationPath()
    @StateObject var config = PlantCareConfigurations()
    
    public init() {
        do {
            injector = try PlantCareDependencyInjector()
            try injector.imagesRepo.cleanCache()
        } catch {
            fatalError("Failed to create ModelContainer for Movie.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
                DashboardRootView(navigationPath: $navPath, depInjector: injector)
                    .preferredColorScheme(config.colorScheme)
                    .environmentObject(config)
                    .environmentObject(injector)
            }
    }
}
