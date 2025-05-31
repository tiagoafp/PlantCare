//
//
// PlantCare
// Created by: tiago.pereira on 24/5/25
//

import SwiftUI
import PixelKit

struct DashboardView<ViewModel: DashboardViewModelProtocol>: View {
    @EnvironmentObject var config: PlantCareConfigurations
    @State var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            GrouppedSectionView(
                content: .init(
                    title: .init(content: .init(title: "Bla", action: nil)),
                    cells: {
                        VStack {}
                    }))
        }
        .navigationTitle(.translation(.plant_care))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    config.swipeTheme()
                }) {
                    Image(systemName: "gear")
                }
            }
        }
    }
}
