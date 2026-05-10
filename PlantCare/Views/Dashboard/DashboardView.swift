import SwiftUI
import AtlasUI

struct DashboardView<ViewModel: DashboardViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        switch viewModel.state {
        case .empty:
            VStack {
                EmptyStateView(
                    image: Image("plant_empty_state"),
                    title: .localized(key: .dashboardEmptyTitle),
                    subtitle: .localized(key: .dashboardEmptySubtitle),
                    action: PrimaryButton(
                        image: .plus,
                        label: .localized(key: .addPlant),
                        type: .button(onPress: viewModel.addPlant)
                    )
                )
            }
        case .data(let plants):
            AtlasListView(
                items: plants,
                fetchingMore: false,
                onSelect: viewModel.selectPlant
            )
                .padding(.vertical, 20)
        }
    }
}
