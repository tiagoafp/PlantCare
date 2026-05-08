import SwiftUI

public struct AtlasDefaultCell<Data: AtlasDefaultCellDataProtocol>: View {
    @Environment(\.atlasPalette) private var palette
    var title: Text?
    let data: Data
    let selection: SelectionState
    
    public init(
        title: Text? = nil,
        data: Data,
        selection: SelectionState
    ) {
        self.title = title
        self.data = data
        self.selection = selection
    }
    
    public var body: some View {
        AtlasBaseCell(
            title: title
        ) {
            Button(action: {
                if case .selectable(let onSelect) = selection {
                    onSelect()
                }
            }) {
                ZStack {
                    HStack(alignment: .center, spacing: 16) {
                        if let image = data.image {
                            CachedAsyncImage(url: URL(string: image)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 64, height: 64)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(data.title)
                                .font(.callout).fontWeight(.regular)
                                .foregroundStyle(palette.textPrimary)
                            
                            Text(data.subtitle)
                                .font(.callout).fontWeight(.regular)
                                .foregroundStyle(palette.textSecondary)
                            
                            if let caption = data.caption {
                                Text(caption)
                                    .font(.caption2).fontWeight(.semibold)
                                    .foregroundStyle(palette.textSecondary)
                            }
                        }
                        
                        Spacer()
                        
                        if data.chevron {
                            Image
                                .chevronRight
                                .renderingMode(.template)
                                .foregroundStyle(palette.actionPrimary)
                                .opacity(0.4)
                        }
                    }
                    .padding(16)
                }
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
            .disabled(self.selection.touchDisable)
        }
    }
}

extension AtlasDefaultCell {
    public enum SelectionState {
        case notSelectable
        case selectable(() -> Void)
        
        var touchDisable: Bool {
            switch self {
            case .notSelectable:
                return true
            case .selectable:
                return false
            }
        }
    }
}
