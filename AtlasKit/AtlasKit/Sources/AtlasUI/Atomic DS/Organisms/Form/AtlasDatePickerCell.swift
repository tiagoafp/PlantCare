import SwiftUI

public struct AtlasDatePickerCell: View {
    @Environment(\.atlasPalette) private var palette
    
    private let title: Text?
    @Binding private var date: Date
    var displayedComponents: DatePicker.Components
    
    public init(
        title: Text? = nil,
        displayedComponents: DatePicker.Components = [.date, .hourAndMinute],
        date: Binding<Date>
    ) {
        self.title = title
        self._date = date
        self.displayedComponents = displayedComponents
    }
    
    public var body: some View {
        AtlasBaseCell(title: nil) {
            HStack(spacing: 12) {
                title
                    .font(.callout.weight(.regular))
                    .foregroundStyle(palette.textPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                DatePicker("", selection: $date, displayedComponents: displayedComponents)
                    .labelsHidden()
                    .tint(palette.actionPrimary)
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
    }
}

