import SwiftUI

public struct AtlasBottomActionButton: View {
    @Environment(\.atlasPalette) private var palette

    private let title: Text
    private let systemImage: Image?
    private let action: () -> Void

    public init(
        title: Text,
        systemImage: Image? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                systemImage?
                    .foregroundStyle(palette.textOnActionPrimary)

                title
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(palette.textOnActionPrimary)
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 18)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(palette.actionPrimary)
            )
        }
        .buttonStyle(.plain)
    }
}
