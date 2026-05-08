import SwiftUI

public struct PrimaryButton: View {
    @Environment(\.atlasPalette) private var palette
    
    var image: Image?
    var label: Text?
    var action: () -> Void
    
    public init(
        image: Image? = nil,
        label: Text? = nil,
        action: @escaping () -> Void
    ) {
        self.image = image
        self.label = label
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            ZStack {
                HStack(spacing: 8) {
                    image?
                        .foregroundStyle(palette.textOnActionPrimary)
    
                    label?
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(palette.textOnActionPrimary)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            .background(
                RoundedRectangle(cornerRadius: 9999)
                    .foregroundStyle(palette.actionPrimary)
            )
        }
    }
}
