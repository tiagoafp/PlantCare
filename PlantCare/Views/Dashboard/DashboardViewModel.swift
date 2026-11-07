import SwiftUI
import SwiftData
import AtlasUI

protocol DashboardViewModelProtocol: ObservableObject {
    var path: NavigationPath { get set }
    var sheet: DashboardDestination? { get set }
    var state: DashboardViewModel.State { get }
    var watering: Bool { get set }
    
    func addPlant()
    func selectPlant(_ plant: PlantCellDataAdapter)
    func inject(_ modelContext: ModelContext)
    func onDelete()
    
    func onPlatAdded()
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
    
    func selectPlant(_ plant: PlantCellDataAdapter) {
        path.append(DashboardDestination.detail(plant.plantRecord.plantID))
    }
    
    func inject(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        
        loadList()
    }
    
    func loadList() {
        do {
            guard let modelContext else {
                return
            }

            let plants = try input.plantRepository.fetchPlants(in: modelContext)
            
            let list = plants.map { (plant: PlantRecord) -> PlantCellDataAdapter in
                return .init(
                    plantRecord: plant,
                    uiImage: input.imageManager.loadImage(from: plant.photo),
                    chevron: true
                )
            }
            
            if list.isEmpty {
                self.state = .empty
            } else {
                self.state = .data(list)
            }
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
    
    func onPlatAdded() {
        sheet = nil
        loadList()
    }
}

extension DashboardViewModel {
    enum State {
        case empty
        case data([PlantCellDataAdapter])
    }
    
    struct Input {
        let imageManager: ImageStorageManagerProtocol
        let plantRepository: PlantRepositoryProtocol
    }
}
