import AtlasUI
import SwiftUI

struct PlantTypeSelectorView<ViewModel: PlantTypeSelectorViewModelProtocol>: View {
    @Environment(\.atlasPalette) private var palette
    @ObservedObject var viewModel: ViewModel
    @State var camera: Bool = false

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .data(let items), .searching(let items):
                VStack {
                    takePhotoCard()
                        .padding(.horizontal, 20)
                    
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
        .sheet(isPresented: $camera) {
            ImagePicker(
                sourceType: .camera,
                onImagePicked: { image in
                    Task {
                        await viewModel.onImage(image: image)
                    }
                }
            )
        }
    }
}

extension PlantTypeSelectorView {
    @ViewBuilder
    func takePhotoCard() -> some View {
        Button(action: {
            camera = true
        }) {
            ZStack {
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
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(palette.actionPrimary)
                }
            }
        }
    }
}
