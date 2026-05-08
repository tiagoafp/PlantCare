import SwiftUI

public struct AtlasBottomActionView<Content: View>: View {
    @Environment(\.atlasPalette) private var palette
    var content: () -> Content
    
    public init(content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            content()
            
        }
        .toolbarBackground(palette.bgSurface, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .ignoresSafeArea(edges: .bottom)
    }
}
