//
//  AtlasSectionView.swift
//  AtlasKit
//
//  Created by Tiago Pereira on 12/5/26.
//

import SwiftUI

public struct AtlasSectionView<Content: View>: View {
    @Environment(\.atlasPalette) var theme
    var title: String?
    var viewAll: AtlasSectionViewViewAll?
    var content: () -> Content
    
    public init(
        title: String? = nil,
        viewAll: AtlasSectionViewViewAll? = nil,
        content: @escaping() -> Content
    ) {
        self.title = title
        self.viewAll = viewAll
        self.content = content
    }
    
    public var body: some View {
        Section(
            content: {
                content()
            },
            header: {
                if let title = title {
                    HStack {
                        Text(title)
                            .font(.headline)
                        
                        Spacer()
                        
                        if let viewAll = viewAll {
                            Button(action: {
                                viewAll.onAction()
                            }) {
                                Text(viewAll.text)
                                    .font(.caption)
                                    .foregroundColor(theme.actionPrimary)
                            }
                        }
                    }
                } else {
                    EmptyView()
                }
            }
        )
    }
}

public struct AtlasSectionViewViewAll {
    let text: String
    let onAction: () -> Void
    
    public init(text: String, onAction: @escaping () -> Void) {
        self.text = text
        self.onAction = onAction
    }
}

#Preview {
    AtlasSectionView(
        title: "Hello",
        viewAll: .init(
            text: "View All",
            onAction: {}),
        content: {
            Text("asdas")
        }
    )
}
