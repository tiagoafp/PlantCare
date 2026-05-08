import SwiftUI

private struct AtlasBottomActionModifier: ViewModifier {
    @Environment(\.atlasPalette) private var palette
    
    func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .foregroundStyle(palette.bgPrimary)
            content
        }
        .toolbarBackground(palette.bgSurface, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .ignoresSafeArea(edges: .bottom)
    }
}

public extension View {
    func atlasBackground() -> some View {
        modifier(
            AtlasBottomActionModifier()
        )
    }
}
