//
//  AtlasNoDataCell.swift
//  AtlasKit
//
//  Created by Tiago Pereira on 11/5/26.
//

import SwiftUI

public struct AtlasNoDataSectionView: View {
    @Environment(\.translations) private var translations
    @Environment(\.atlasPalette) private var palette
    
    var image: Image?
    var title: Text
    var description: Text
    
    public init(image: Image? = nil, title: Text, description: Text) {
        self.image = image
        self.title = title
        self.description = description
    }
    
    public var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 24)
                .foregroundStyle(palette.bgSecondary)
            
            VStack(alignment: .center, spacing: 16) {
                if let image {
                    ZStack(alignment: .center) {
                        Circle()
                            .frame(width: 64, height: 64)
                            .foregroundStyle(palette.actionPrimary.opacity(0.1))
                        
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26)
                            .foregroundStyle(palette.actionPrimary)
                    }
                }
                
                VStack(spacing: 8) {
                    title
                        .font(.headline)
                        .foregroundStyle(palette.textPrimary)
                    description
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .foregroundStyle(palette.textSecondary)
                        .padding(.horizontal, 40)
                }
                
            }
        }
        .frame(height: 246)
    }
}
