//
//  WaterScheduleSelectorView.swift
//  PlantCare
//
//  Created by tiago.pereira on 14/6/25.
//

import SwiftUI
import PixelKit

struct WaterScheduleSelectorView<ViewModel: WaterScheduleSelectorViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundStyle(PixelKit.shared.theme.background)
            
            ScrollView {
                GrouppedSectionView(nil) {
                    VStack(spacing: 0) {
                        ForEach(viewModel.allSchedules, id: \.self) { schedule in
                            SelectableCell(
                                text: schedule.type,
                                isSelected: viewModel.isSelected(schedule),
                                onSelect: {
                                    viewModel.select(schedule)
                                }
                            )
                        }
                    }
                }
            }
        }
    }
}
