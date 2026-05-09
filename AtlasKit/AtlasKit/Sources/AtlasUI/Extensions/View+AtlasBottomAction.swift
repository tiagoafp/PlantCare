import SwiftUI

private struct AtlasBottomActionModifier<BottomContent: View>: ViewModifier {
    @Environment(\.atlasPalette) private var palette

    let bottomContent: () -> BottomContent

    func body(content: Content) -> some View {
        ZStack(alignment: .bottom){
            content
                .padding(.bottom, 60)
            
            bottomContent()
                .padding(.horizontal, 20)
                .padding(.top, 12)
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
