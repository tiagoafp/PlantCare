import AtlasUI
import SwiftUI

struct PlantActivitiesListView<ViewModel: PlantActivitiesListViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        switch viewModel.state {
        case .loading, .notFound:
            ProgressView()
        case .data(let activities):
            ZStack {
                if activities.isEmpty {
                    AtlasNoDataSectionView(
                        image: Image(systemName: "calendar"),
                        title: .localized(key: .noActivityYet),
                        description: .localized(key: .activityEmptySubtitle)
                    )
                    .padding(20)
                } else {
                    ScrollView {
                        AtlasTimelineListView(
                            items: activities,
                            fetchingMore: false,
                            onSelect: viewModel.onPlantActivity
                        )
                        .padding(20)
                    }
                }
            }
        }
    }
}
