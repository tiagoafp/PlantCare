import SwiftUI

public struct AtlasListView<Item: AtlasDefaultCellDataProtocol>: View {
    @Environment(\.atlasPalette) private var palette
    
    var items: [Item]
    var onLast: (() -> Void)?
    var fetchingMore: Bool
    var onSelect: ((Item) -> Void)?
    
    public init(
        items: [Item],
        onLast: (() -> Void)? = nil,
        fetchingMore: Bool,
        onSelect: ((Item) -> Void)? = nil
    ) {
        self.items = items
        self.onLast = onLast
        self.fetchingMore = false
        self.onSelect = onSelect
    }
    
    public var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(items) { item in
                    AtlasDefaultCell(
                        data: item,
                        selection: onSelect == nil ? .notSelectable : .selectable({
                            onSelect?(item)
                        })
                    )
                        .onAppear(perform: {
                            if item.id == items.last?.id {
                                onLast?()
                            }
                        })
                }
                
                if fetchingMore {
                    ProgressView()
                }
            }
            .padding(.horizontal, 20)
            
        }
    }
}
