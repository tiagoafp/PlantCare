import SwiftUI

public struct AtlasToolbarButton: View {
    @Environment(\.atlasPalette) private var palette

    let image: Image
    let action: () -> Void
    
    public init(image: Image, action: @escaping () -> Void) {
        self.image = image
        self.action = action
    }

    public var body: some View {
        Button(
            action: action,
            label: {
                image
                    .foregroundStyle(palette.actionPrimary)
            }
        )
    }
}

