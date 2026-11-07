import AtlasUI
import SwiftData
import SwiftUI

@MainActor
protocol PlantActivitiesListViewModelProtocol: ObservableObject {
    var state: PlantActivitiesListViewModel.State { get }

    func load(in context: ModelContext) async
    func onPlantActivity(activity: PlantActivityTimelineAdapter)
}

final class PlantActivitiesListViewModel: PlantActivitiesListViewModelProtocol {
    @Published private(set) var state: State = .loading
    @Published private(set) var plant: PlantRecord?
    let input: Input

    var plantID: UUID {
        input.plantID
    }

    init(input: Input) {
        self.input = input
    }

    func load(in context: ModelContext) async {
        guard let plant = try? input.plantRepository.fetchPlant(id: plantID, in: context),
              let activities = try? input.plantActivityRepository.fetchActivities(
                plantID: plantID,
                in: context
              ) else {
            state = .notFound
            return
        }

        self.plant = plant
        state = .data(
            activities.map { activity in
                PlantActivityTimelineAdapter(
                    activity: activity,
                    photo: activity.photo.flatMap { input.activityImageStorage.loadImage(from: $0) }
                )
            }
        )
    }

    func onPlantActivity(activity: PlantActivityTimelineAdapter) {
        input.navPath.wrappedValue.append(
            PlantActivitiesListViewDestination.detail(
                recordId: activity.activity.activityID,
                plantId: plantID
            )
        )
    }
}

extension PlantActivitiesListViewModel {
    enum State {
        case loading
        case notFound
        case data([PlantActivityTimelineAdapter])
    }

    struct Input {
        let plantID: UUID
        let activityImageStorage: ImageStorageManagerProtocol
        let plantRepository: PlantRepositoryProtocol
        let plantActivityRepository: PlantActivityRepositoryProtocol
        let navPath: Binding<NavigationPath>
    }
}
