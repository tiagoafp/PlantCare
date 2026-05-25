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
                    
                    if let photo = adapter.activity.photo {
                        Image(uiImage: photo)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                    }
                    
                    AtlasDefaultCell(data: adapter.dateCell, selection: .notSelectable)
                    AtlasDefaultCell(data: adapter.timeCell, selection: .notSelectable)
                    
                    if let notesCell = adapter.notesCell {
                        AtlasDefaultCell(data: notesCell, selection: .notSelectable)
                    }
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
