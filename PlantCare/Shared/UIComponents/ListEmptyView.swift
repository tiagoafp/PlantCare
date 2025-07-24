//
// Copyright © 2025 Sage.
// All Rights Reserved.

import SwiftUI
import PixelKit

struct ListEmptyView: View {
    let configuration: Configuration
    
    init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Rectangle().frame(height: 0)
            Image("plant")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
            
            VStack(spacing: 8) {
                Text(self.configuration.title)
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(PixelKit.shared.theme.textPrimary)
                
                Text(self.configuration.message)
                    .multilineTextAlignment(.center)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(PixelKit.shared.theme.textSecondary)
                    .padding(.horizontal, 32)
            }
        }
    }
}


extension ListEmptyView {
    enum Configuration {
        case plant
        case plantType
        
        var title: String {
            switch self {
            case .plant:
                return "No plants yet"
            case .plantType:
                return "No types yet"
            }
        }
        
        var message: String {
            switch self {
            case .plant:
                return "Start adding your favorite plants to see them here."
            case .plantType:
                return "Create some plant types to organize your garden."
            }
        }
    }
}
