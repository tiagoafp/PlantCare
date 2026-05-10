import SwiftUI

public struct PrimaryButton: View {
    @Environment(\.atlasPalette) private var palette
    
    var image: Image?
    var label: Text?
    var type: ButtonType
    
    public init(
        image: Image? = nil,
        label: Text? = nil,
        type: ButtonType
    ) {
        self.image = image
        self.label = label
        self.type = type
    }
    
    public var body: some View {
        switch type {
        case .label:
            container()
        case .button(let onPress):
            Button(action: onPress) {
                container()
            }
        }
    }
    
    @ViewBuilder
    public func container() -> some View {
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


extension PrimaryButton {
    public enum ButtonType {
        case label
        case button(onPress: () -> Void)
    }
}
