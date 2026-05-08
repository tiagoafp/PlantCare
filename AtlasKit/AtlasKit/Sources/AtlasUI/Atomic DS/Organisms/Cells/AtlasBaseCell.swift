import SwiftUI

struct AtlasBaseCell<Content: View>: View {
    @Environment(\.atlasPalette) var palette
    var title: Text?
    var content: () -> Content
    
    init(
        title: Text?,
        content: @escaping () -> Content
    ) {
        self.content = content
        self.title = title
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            title?
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundStyle(palette.textSecondary)
            content()
        }
    }
}
