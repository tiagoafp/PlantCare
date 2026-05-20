import SwiftUI
import SwiftData
import AtlasUI

@main
struct PlantCareApp: App {
    private let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(for: AppDataBase.self, PlantRecord.self, PlantActivityRecord.self)
            try AppDataBaseBootstrap.createRootIfNeeded(in: container.mainContext)
        } catch {
            fatalError("Unable to create plant database: \(error.localizedDescription)")
        }
    }

    var body: some Scene {
        WindowGroup {
            PaletteHostView {
                DashboardRootView()
            }
        }
        .modelContainer(container)
    }
}

private struct PaletteHostView<Content: View>: View {
    @Environment(\.colorScheme) private var colorScheme
    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    private var palette: any AtlasPalette {
        colorScheme == .dark ? DarkTheme() : LightTheme()
    }

    var body: some View {
        content
            .atlasPalette(palette)
    }
}
