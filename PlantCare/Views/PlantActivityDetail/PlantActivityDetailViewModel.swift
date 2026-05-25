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
        guard let updatedActivity = context.model(for: input.activity.id) as? PlantActivityRecord else {
            return
        }
        
        self.state = .data(
            .init(
                plant: input.plant,
                activity: updatedActivity,
                plantImageManager: input.plantImageManager,
                activityImageManager: input.activityImageManager
            )
        )
    }
    
    func onEdit() {
        input.navPath.wrappedValue.append(PlantActivityDetailDestination.edit(input.plant, input.activity))
    }
    
    func onUpdated(in context: ModelContext) {
        loadFromDataBase(in: context)
    }
    
    func onDelete(in context: ModelContext) {
        guard let updatedActivity = context.model(for: input.activity.id) as? PlantActivityRecord else {
            return
        }
        
        context.delete(updatedActivity)
        
        do {
            try context.save()
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
        let activity: PlantActivityRecord
        let plant: PlantRecord
        let navPath: Binding<NavigationPath>
        let onUpdate: () -> Void
    }
}
