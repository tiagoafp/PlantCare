import SwiftData
import SwiftUI
import AtlasUI

@MainActor
protocol PlantActivityDetailViewModelProtocol: ObservableObject {
    var state: PlantActivityDetailViewModel.State { get }
    
    func onAppear(in context: ModelContext)
    func onUpdated(in context: ModelContext)
    func onEdit()
}

final class PlantActivityDetailViewModel: PlantActivityDetailViewModelProtocol {
    @Published var state: State = .loading
    let input: Input

    init(input: Input) {
        self.input = input
        self.state = .loading
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
                plantImageManager: input.plantImageManager
            )
        )
    }
    
    func onEdit() {
        
    }
    
    func onUpdated(in context: ModelContext) {
        loadFromDataBase(in: context)
    }
}

extension PlantActivityDetailViewModel {
    enum State {
        case loading
        case data(PlantActivityDetailViewData)
    }

    struct Input {
        let plantImageManager: ImageStorageManagerProtocol
        let activity: PlantActivityRecord
        let plant: PlantRecord
    }
}
