//
// Copyright © 2025 Sage.
// All Rights Reserved.

import SwiftUI
import PixelKit

struct WaterRegisterListView<ViewModel: WaterRegisterListViewModelProtocol>: View {
    let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle().foregroundStyle(PixelKit.shared.theme.background)
            
            if viewModel.items.isEmpty {
                ListEmptyView(configuration: .waterRegister)
            }
            
            ScrollView {
                GrouppedSectionView {
                    VStack(spacing: 0) {
                        ForEach(viewModel.items, id: \.self) { item in
                            DisplayCell(
                                title: item.title,
                                subtitle: item.subtitle.text,
                                subtitleVariant: item.subtitle.casted,
                                disclosure: item.disclosure,
                                separator: item.separator,
                                onPress: {}
                            )
                        }
                    }
                }
            }
        }
        .navigationTitle(.localized(.water_history))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: viewModel.onEdit) {
                    Text(String.localized(.edit))
                        .font(.body)
                        .fontWeight(.medium)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
