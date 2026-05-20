import SwiftUI
import AtlasUI

struct PlantActivityDetailView<ViewModel: PlantActivityDetailViewModelProtocol>: View {
    @Environment(\.atlasPalette) private var palette
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .data(let adapter):
            ScrollView {
                VStack(spacing: 20) {
                    AtlasDefaultCell(
                        data: adapter.plant,
                        selection: .notSelectable
                    )
                    
                    VStack(spacing: 16){
                        activityIcon(adapter: adapter)
                        Text(adapter.activity.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(palette.textPrimary)
                    }
                    .padding(.top, 20)
                }.padding(20)
            }
        }
    }
    
    @ViewBuilder
    func activityIcon(adapter: PlantActivityDetailViewData) -> some View {
        ZStack(alignment: .center) {
            Circle()
                .foregroundStyle(adapter.activity.relatedColor ?? palette.actionPrimary)
                .opacity(0.3)
            
            adapter.activity.timelineIcon?
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundStyle(adapter.activity.relatedColor ?? palette.actionPrimary)
        }
        .frame(width: 64, height: 64)
    }
}
