import SwiftUI

private struct DefaultAtlasPalette: AtlasPalette {
    let actionPrimary: Color = .blue
    let actionPrimaryStrong: Color = .blue
    let actionPrimarySoft: Color = .blue.opacity(0.2)
    let textPrimary: Color = .primary
    let textSecondary: Color = .secondary
    let textTertiary: Color = .secondary.opacity(0.7)
    let textOnActionPrimary: Color = .white
    let bgPrimary: Color = .white
    let bgSecondary: Color = .secondary.opacity(0.05)
    let bgSurface: Color = .white
    let bgSoftAccent: Color = .blue.opacity(0.1)
}

private struct AtlasPaletteKey: EnvironmentKey {
    nonisolated(unsafe) static var defaultValue: any AtlasPalette = DefaultAtlasPalette()
}

public extension EnvironmentValues {
    var atlasPalette: any AtlasPalette {
        get { self[AtlasPaletteKey.self] }
        set { self[AtlasPaletteKey.self] = newValue }
    }
}

public extension View {
    func atlasPalette(_ palette: any AtlasPalette) -> some View {
        environment(\.atlasPalette, palette)
    }
}
