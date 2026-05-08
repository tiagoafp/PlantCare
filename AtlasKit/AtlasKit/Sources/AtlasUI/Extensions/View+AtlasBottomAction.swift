import SwiftUI

private struct AtlasBottomActionModifier<BottomContent: View>: ViewModifier {
    @Environment(\.atlasPalette) private var palette

    let bottomContent: () -> BottomContent

    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom, spacing: 0) {
                bottomContent()
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    .background(palette.bgSurface)
            }
    }
}

public extension View {
    func atlasBottomAction<Content: View>(
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        modifier(
            AtlasBottomActionModifier(
                bottomContent: content
            )
        )
    }
}
