import AtlasUI
import SwiftUI

struct PlantTypeSelectorView<ViewModel: PlantTypeSelectorViewModelProtocol>: View {
    @Environment(\.atlasPalette) private var palette
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .data(let items), .searching(let items), .recoginizingImage(let items):
                VStack {
                    if case .recoginizingImage = viewModel.state {
                        loadingPhotoCard()
                            .padding(.horizontal, 20)
                    } else {
                        takePhotoCard()
                            .padding(.horizontal, 20)
                    }
                    
                    AtlasListView(
                        items: items,
                        onLast: {
                            Task {
                                await viewModel.fetchMore()
                            }
                        },
                        fetchingMore: viewModel.fetchingMore,
                        onSelect: viewModel.onItemSelector
                    )
                }
                .padding(.top, 16)
            }
        }
        .task {
            await viewModel.onAppear()
        }
        .onChange(of: viewModel.search, { oldValue, newValue in
            if oldValue == newValue {
                return
            }
            
            Task {
                await viewModel.onSearch(search: newValue)
            }
        })
        .searchable(
            text: $viewModel.search,
            prompt: .localized(key: .searchPlants)
        )
    }
}

extension PlantTypeSelectorView {
    @ViewBuilder
    func takePhotoCard() -> some View {
        AtlasImageUploadWrapper(
            onResult: { result in
                Task {
                    await viewModel.onImage(image: result)
                }
            }
        ) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(palette.actionPrimary)
                
                HStack(spacing: 16) {
                    ZStack {
                        Image
                            .camera
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 26, height: 24)
                            .foregroundStyle(palette.textOnActionPrimary)
                    }
                    .frame(width: 48, height: 48)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(palette.textOnActionPrimary.opacity(0.2))
                    }
                    
                    VStack(alignment: .leading) {
                        Text.localized(key: .identifyPlant)
                            .font(.body)
                            .foregroundStyle(palette.textOnActionPrimary)
                        Text.localized(key: .takePhotoIdentify)
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(palette.textOnActionPrimary.opacity(0.85))
                    }
                    
                    Spacer()
                }
                .padding(20)
            }
            .frame(height: 140)
        }
    }
    
    @ViewBuilder
    func loadingPhotoCard() -> some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(palette.actionPrimary)
            
            ProgressView().tint(palette.textOnActionPrimary)
        }
        .frame(height: 140)
    }
}
