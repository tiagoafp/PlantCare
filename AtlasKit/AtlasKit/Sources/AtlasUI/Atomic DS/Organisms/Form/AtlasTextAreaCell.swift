import SwiftUI

public struct AtlasTextAreaCell: View {
    @Environment(\.atlasPalette) private var palette
    
    private let title: Text?
    private let placeholder: String
    private let minHeight: CGFloat
    @Binding private var text: String
    @State var writting: Bool = false
    
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
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Rectangle().frame(height: 0)
                    
                    if text.isEmpty {
                        Text(placeholder)
                            .font(.callout.weight(.regular))
                            .foregroundStyle(palette.textSecondary)
                    } else {
                        Text(text)
                            .multilineTextAlignment(.leading)
                            .font(.callout.weight(.regular))
                            .foregroundStyle(palette.textPrimary)
                    }
                    
                    Spacer()
                }
                .frame(minHeight: minHeight)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            }
            .frame(minHeight: minHeight, maxHeight: 400)
            .onTapGesture {
                writting = true
            }
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(palette.bgSurface)
                    .shadow(
                        color: .black.opacity(0.04),
                        radius: 6,
                        x: 0,
                        y: 2
                    )
            }
            .sheet(isPresented: $writting, content: {
                AtlasWritterView(
                    placeholder: placeholder,
                    text: text
                )
            })
        }
    }
}

