import SwiftUI

public struct AtlasTimelineCell<Data: AtlasTimelineCellDataProtocol>: View {
    @Environment(\.atlasPalette) private var palette
    let data: Data
    let selection: SelectionState
    
    public init(
        data: Data,
        selection: SelectionState
    ) {
        self.data = data
        self.selection = selection
    }
    
    public var body: some View {
        Button(action: {
            if case .selectable(let onSelect) = selection {
                onSelect()
            }
        }) {
            HStack(spacing: 16) {
                VStack {
                    icon()
                    Spacer()
                }
                timelineContent()
            }
        }
        .disabled(self.selection.touchDisable)
    }
    
    var relatedColor: Color {
        data.relatedColor ?? palette.actionPrimary
    }
    
    @ViewBuilder
    func icon() -> some View {
        ZStack(alignment: .center) {
            Circle()
                .foregroundStyle(relatedColor.opacity(0.3))
            
            if let timelineIcon = data.timelineIcon {
                timelineIcon
                    .renderingMode(.template)
                    .scaledToFit()
                    .foregroundStyle(relatedColor)
                    .frame(maxWidth: 14, maxHeight: 14)
            } else {
                Image(systemName: "timeline.selection")
                    .renderingMode(.template)
                    .scaledToFit()
                    .foregroundStyle(relatedColor)
                    .frame(maxWidth: 14, maxHeight: 14)
            }
        }
        .frame(width: 32, height: 32)
    }
    
    @ViewBuilder
    func timelineContent() -> some View {
        ZStack(alignment: .leading) {
            Rectangle().frame(height: 0)
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(data.title)
                        .font(.headline)
                        .foregroundStyle(palette.textPrimary)
                    
                    Text(data.date)
                        .font(.caption)
                        .foregroundStyle(palette.textTertiary)
                }
                
                if let image = data.photo {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 128)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                if let descripction = data.descripction, !descripction.isEmpty {
                    Text(descripction)
                        .font(.subheadline)
                        .foregroundStyle(palette.textSecondary)
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
}


extension AtlasTimelineCell {
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
