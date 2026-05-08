import SwiftUI

public struct EmptyStateView: View {
    @Environment(\.atlasPalette) private var palette
    
    var image: Image?
    var title: Text
    var subtitle: Text
    var action: PrimaryButton?
    
    public init(
        image: Image? = nil,
        title: Text,
        subtitle: Text,
        action: PrimaryButton?
    ) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.action = action
    }
    
    public var body: some View {
        VStack {
            image?
                .renderingMode(.template)
                .padding(.bottom, 32)
                .foregroundStyle(palette.actionPrimary)
            
            title
                .multilineTextAlignment(.center)
                .font(.largeTitle.bold())
                .foregroundStyle(palette.textPrimary)
                .padding(.bottom, 8)
                .padding(.horizontal, 40)
            
            subtitle
                .multilineTextAlignment(.center)
                .font(.body)
                .foregroundStyle(palette.textSecondary)
                .padding(.bottom, 16)
                .padding(.horizontal, 20)
            
            action
        }
        .padding(.horizontal, 20)
    }
}
