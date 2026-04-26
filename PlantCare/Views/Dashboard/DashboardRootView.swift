import SwiftUI
import AtlasUI

struct DashboardRootView: View {
    @StateObject var viewModel: DashboardViewModel
    
    init() {
        _viewModel = .init(
            wrappedValue: DashboardViewModel(
                input: .init()
            )
        )
    }
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            BackgroundView {
                DashboardView(viewModel: viewModel)
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(
                .localized(key: .appTitle)
            )
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    AtlasToolbarButton(
                        image: .init(
                            systemName: viewModel.watering ? "drop.fill" : "drop"),
                        action: {
                            viewModel.watering.toggle()
                        }
                    )
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    AtlasToolbarButton(
                        image: .plus,
                        action: {
                        }
                    )
                }
            }
        }
        .sheet(
            item: $viewModel.sheet,
            content: destination
        )
        .navigationDestination(
            for: DashboardDestination.self,
            destination: destination
        )
    }
    
    @ViewBuilder
    func destination(destination: DashboardDestination) -> some View {
        switch destination {
        case .addPlant:
            EmptyView()
        }
    }
}
