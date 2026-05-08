import SwiftUI

public struct AtlasBackgroundView<Content: View>: View {
    @Environment(\.atlasPalette) private var palette
    var content: () -> Content
    
    public init(content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(palette.bgPrimary)
            
            content()
        }
        .toolbarBackground(palette.bgSurface, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .ignoresSafeArea(edges: .bottom)
    }
}
