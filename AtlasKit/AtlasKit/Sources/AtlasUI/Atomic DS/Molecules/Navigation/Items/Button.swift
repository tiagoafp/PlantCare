import SwiftUI

public struct AtlasToolbarButton: View {
    @Environment(\.atlasPalette) private var palette

    let color: Color?
    let image: Image
    let action: () -> Void
    
    public init(
        image: Image,
        color: Color? = nil,
        action: @escaping () -> Void) {
            self.image = image
            self.action = action
            self.color = color
        }

    public var body: some View {
        Button(
            action: action,
            label: {
                image
                    .foregroundStyle(color ?? palette.actionPrimary)
            }
        )
    }
}

