import SwiftData
import SwiftUI
import AtlasUI

@MainActor
protocol PlantActivityDetailViewModelProtocol: ObservableObject {
    var state: PlantActivityDetailViewModel.State { get }
    
    func onAppear(in context: ModelContext)
    func onUpdated(in context: ModelContext)
    func onEdit()
    func onDelete(in context: ModelContext)
}

final class PlantActivityDetailViewModel: PlantActivityDetailViewModelProtocol {
    @Published var state: State = .loading
    let input: Input
    var dismiss: DismissAction?
    
    var activityID: UUID { input.activityId }

    init(input: Input) {
        self.input = input
        self.state = .loading
    }
    
    func inject(dismiss: DismissAction) {
        self.dismiss = dismiss
    }
    
    func onAppear(in context: ModelContext) {
        loadFromDataBase(in: context)
    }
    
    func loadFromDataBase(in context: ModelContext) {
        guard let activity = try? input.plantActivityRepository.fetchActivity(
            id: activityID,
            in: context
        ) else {
            return
        }
        
        self.state = .data(
            .init(
                plant: activity.plant,
                activity: activity,
                plantImageManager: input.plantImageManager,
                activityImageManager: input.activityImageManager
            )
        )
    }
    
    func onEdit() {
        input.navPath.wrappedValue.append(
            PlantActivityDetailDestination.edit(
                plantId: input.plantId,
                activityId: input.activityId
            )
        )
    }
    
    func onUpdated(in context: ModelContext) {
        loadFromDataBase(in: context)
    }
    
    func onDelete(in context: ModelContext) {
        guard let updatedActivity = try? input.plantActivityRepository.fetchActivity(
            id: activityID,
            in: context
        ) else {
            return
        }

        do {
            try input.plantActivityRepository.delete(updatedActivity, in: context)
            input.onUpdate()
            self.dismiss?()
        } catch {}
    }
}

extension PlantActivityDetailViewModel {
    enum State {
        case loading
        case data(PlantActivityDetailViewData)
    }

    struct Input {
        let plantImageManager: ImageStorageManagerProtocol
        let activityImageManager: ImageStorageManagerProtocol
        let plantActivityRepository: PlantActivityRepositoryProtocol
        let activityId: UUID
        var plantId: UUID
        let navPath: Binding<NavigationPath>
        let onUpdate: () -> Void
    }
}
