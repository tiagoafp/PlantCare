import SwiftUI

public struct AtlasTextInputCell: View {
    @Environment(\.atlasPalette) private var palette
    
    private let title: Text?
    private let placeholder: String
    @Binding private var text: String
    
    public init(
        title: Text? = nil,
        placeholder: String = "",
        text: Binding<String>
    ) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
    }
    
    public var body: some View {
        AtlasBaseCell(title: title) {
            TextField(placeholder, text: $text)
                .textInputAutocapitalization(.words)
                .autocorrectionDisabled()
                .font(.callout.weight(.regular))
                .foregroundStyle(palette.textPrimary)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(palette.bgSurface)
                }
        }
    }
}
