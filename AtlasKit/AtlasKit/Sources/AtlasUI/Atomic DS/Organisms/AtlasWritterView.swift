//
//  AtlasWritterView.swift
//  AtlasKit
//
//  Created by Tiago Pereira on 04/06/2026.
//

import SwiftUI

public struct AtlasWritterView: View {
    var placeholder: String
    @State var text: String
    @Environment(\.atlasPalette) private var palette
    @Environment(\.dismiss) var dismiss
    
    public var body: some View {
        NavigationView {
            ZStack {
                TextEditor(text: $text)
                    .font(.callout.weight(.regular))
                    .foregroundStyle(palette.textPrimary)
                    .scrollContentBackground(.hidden)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(palette.bgSurface)
                    }
                    .padding(20)
            }
            .toolbar(content: {
                AtlasToolbarButton(image: .close, action: {
                    dismiss()
                })
            })
        }
    }
}
