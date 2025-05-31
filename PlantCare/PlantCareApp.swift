//
//
// PlantCare
// Created by: tiago.pereira on 16/5/25
//


import SwiftUI
import SwiftData

@main
struct PlantCareApp: App {
    @ObservedObject var injector: PlantCareDependencyInjector
    @State var navPath = NavigationPath()
    @StateObject var config = PlantCareConfigurations()
    
    public init() {
        do {
            injector = try PlantCareDependencyInjector()
        } catch {
            fatalError("Failed to create ModelContainer for Movie.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navPath) {
                DashboardRootView(navigationPath: $navPath)
                    .preferredColorScheme(config.colorScheme)
                    .environmentObject(config)
            }
        }
    }
}
