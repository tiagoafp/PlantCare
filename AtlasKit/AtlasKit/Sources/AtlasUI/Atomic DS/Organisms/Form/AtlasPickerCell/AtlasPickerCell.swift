import SwiftUI

public struct AtlasPickerCell<Option: AtlasPickerCellDataItemProtocol>: View {
    @Environment(\.atlasPalette) private var palette
    
    private let title: Text?
    private let options: [Option]
    @Binding private var selection: Option
    
    public init(
        title: Text? = nil,
        options: [Option],
        selection: Binding<Option>
    ) {
        self.title = title
        self.options = options
        self._selection = selection
    }
    
    public var body: some View {
        AtlasBaseCell(title: title) {
            Menu {
                ForEach(options, id: \.self) { option in
                    Button {
                        selection = option
                    } label: {
                        HStack {
                            option.icon
                            Text(option.title)
                        }
                    }
                }
            } label: {
                HStack(spacing: 12) {
                    selection.icon
                    
                    Text(selection.title)
                        .font(.callout.weight(.regular))
                        .foregroundStyle(palette.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image.chevronRight
                        .renderingMode(.template)
                        .foregroundStyle(palette.actionPrimary)
                        .opacity(0.4)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
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
            }
            .buttonStyle(.plain)
        }
    }
}

