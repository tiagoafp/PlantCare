import SwiftData
import SwiftUI
import AtlasUI

@MainActor
protocol PlantDetailViewModelProtocol: ObservableObject {
    var state: PlantDetailViewModel.State { get }
    
    func load(in context: ModelContext) async
    func onEdit()
}

class PlantDetailViewModel: PlantDetailViewModelProtocol {
    @Published private(set) var state: State = .loading
    @Published private(set) var plant: PlantRecord?
    let input: Input

    init(input: Input) {
        self.input = input
    }

    func load(in context: ModelContext) async {
        guard let record = context.model(for: input.plantID) as? PlantRecord else {
            self.state = .notFound
            return
        }

        self.plant = record
        guard let data = PlantDetailDataAdapter(
            imageManager: input.plantImageStorage,
            plantRecord: record
        ) else {
            return
        }
        
        self.state = .data(data)
    }
    
    func onEdit() {
        if let plant {
            input.navPath.wrappedValue.append(PlantDetailDestination.edit(plant))
        }
    }
}

extension PlantDetailViewModel {
    enum State {
        case loading
        case notFound
        case data(PlantDetailDataAdapter)
    }

    struct Input {
        let plantID: PersistentIdentifier
        let plantImageStorage: ImageStorageManagerProtocol
        let navPath: Binding<NavigationPath>
    }
}
