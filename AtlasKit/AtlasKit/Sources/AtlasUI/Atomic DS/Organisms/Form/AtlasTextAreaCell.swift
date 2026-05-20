import SwiftUI

public struct AtlasTextAreaCell: View {
    @Environment(\.atlasPalette) private var palette
    
    private let title: Text?
    private let placeholder: String
    private let minHeight: CGFloat
    @Binding private var text: String
    
    public init(
        title: Text? = nil,
        placeholder: String = "",
        minHeight: CGFloat = 140,
        text: Binding<String>
    ) {
        self.title = title
        self.placeholder = placeholder
        self.minHeight = minHeight
        self._text = text
    }
    
    public var body: some View {
        AtlasBaseCell(title: title) {
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .font(.callout.weight(.regular))
                    .foregroundStyle(palette.textPrimary)
                    .scrollContentBackground(.hidden)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .frame(minHeight: minHeight)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(palette.bgSurface)
                    }
                    .shadow(
                        color: .black.opacity(0.04),
                        radius: 6,
                        x: 0,
                        y: 2
                    )
                
                if text.isEmpty {
                    Text(placeholder)
                        .font(.callout.weight(.regular))
                        .foregroundStyle(palette.textSecondary)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 18)
                        .allowsHitTesting(false)
                }
            }
        }
    }
}

