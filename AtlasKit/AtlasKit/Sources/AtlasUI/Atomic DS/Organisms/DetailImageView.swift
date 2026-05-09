//
//  DetailImageView.swift
//  AtlasKit
//
//  Created by Tiago Pereira on 9/5/26.
//

import SwiftUI

public struct DetailImageView: View {
    let image: AtlasCellImageType
    
    public init(image: AtlasCellImageType) {
        self.image = image
    }
    
    public var body: some View {
        switch image {
        case .local(let uiImage):
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        case .remote(let path):
            CachedAsyncImage(url: URL(string: path)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
    }
}
