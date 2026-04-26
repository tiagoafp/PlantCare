import SwiftUI
import SwiftData
import AtlasUI

@main
struct PlantCareApp: App {
    var body: some Scene {
        WindowGroup {
            PaletteHostView {
                DashboardRootView()
            }
        }
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
