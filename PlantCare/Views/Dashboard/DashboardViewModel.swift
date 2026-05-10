import SwiftUI
import SwiftData
import AtlasUI

protocol DashboardViewModelProtocol: ObservableObject {
    var path: NavigationPath { get set }
    var sheet: DashboardDestination? { get set }
    var state: DashboardViewModel.State { get }
    var watering: Bool { get set }
    
    func addPlant()
    func selectPlant(_ plant: DashboardListItemAdapter)
    func inject(_ modelContext: ModelContext)
    func onDelete()
}

class DashboardViewModel: DashboardViewModelProtocol {
    @Published var watering: Bool = false
    var input: Input
    @Published var state: State
    @Published var path: NavigationPath
    @Published var sheet: DashboardDestination?
    var modelContext: ModelContext?
    
    init(input: Input) {
        self.input = input
        self.state = .empty
        self.path = NavigationPath()
    }
    
    func addPlant() {
        sheet = DashboardDestination.addPlant
    }
    
    func selectPlant(_ plant: DashboardListItemAdapter) {
        path.append(DashboardDestination.detail(plant.id))
    }
    
    func inject(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        
        loadList()
    }
    
    func loadList() {
        let descriptor = FetchDescriptor<PlantRecord>()
        
        do {
            guard let plants = try modelContext?.fetch(descriptor) else {
                return
            }
            
            let list = plants.map { (plant: PlantRecord) -> DashboardListItemAdapter in
                return .init(
                    plantRecord: plant,
                    uiImage: input.imageManager.loadImage(from: plant.photo)
                )
            }
            
            self.state = .data(list)
        } catch {
            #if DEBUG
            print(error.localizedDescription)
            #endif
        }
    }
    
    func onDelete() {
        path.removeLast(path.count)
        
        loadList()
    }
}

extension DashboardViewModel {
    enum State {
        case empty
        case data([DashboardListItemAdapter])
    }
    
    struct Input {
        let imageManager: ImageStorageManagerProtocol
    }
}
