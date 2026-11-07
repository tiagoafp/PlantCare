import SwiftData
import SwiftUI
import AtlasUI

@MainActor
protocol PlantDetailViewModelProtocol: ObservableObject {
    var state: PlantDetailViewModel.State { get }
    
    func load(in context: ModelContext) async
    func onEdit()
    func addActivity()
    func reloadActivities(in context: ModelContext) async
    func onPlantActivity(activity: PlantActivityTimelineAdapter)
    func delete(context: ModelContext)
    func viewAllActivities()
}

class PlantDetailViewModel: PlantDetailViewModelProtocol {
    @Published private(set) var state: State = .loading
    @Published private(set) var plant: PlantRecord?
    @Published var sheet: PlantDetailDestination?
    let input: Input
    
    var plantID: UUID {
        input.plantID
    }

    init(input: Input) {
        self.input = input
    }

    func load(in context: ModelContext) async {
        guard let record = try? input.plantRepository.fetchPlant(id: plantID, in: context),
              let activities = try? input.plantActivityRepository.fetchActivities(
                plantID: plantID,
                in: context
              ) else {
            self.state = .notFound
            return
        }

        
        let activityRecords = activities

        self.plant = record
        
        guard let data = PlantDetailDataAdapter(
            imageManager: input.plantImageStorage,
            plantRecord: record,
            activityRecords: activityRecords.map { activity in
                .init(
                    activity: activity,
                    photo: activity.photo.flatMap { input.activityImageStorage.loadImage(from: $0) }
                )
            }
            
        ) else {
            return
        }
        
        self.state = .data(data)
    }
    
    func reloadActivities(in context: ModelContext) async {
        await load(in: context)
    }
    
    func onEdit() {
        if let plant {
            input.navPath.wrappedValue.append(PlantDetailDestination.edit(plant))
        }
    }
    
    func addActivity() {
        if let plant {
            self.sheet = .logActivity(plant)
        }
    }
    
    func onPlantActivity(activity: PlantActivityTimelineAdapter) {
        if let plant {
            input.navPath.wrappedValue.append(PlantDetailDestination.editActivity(plant, activity.activity))
        }
    }
    
    func delete(context: ModelContext) {
        guard let plant = try? input.plantRepository.fetchPlant(id: plantID, in: context) else {
            self.state = .notFound
            return
        }
        
        do {
            plant.activities.forEach { activity in
                if let photoPath = activity.photo {
                    input.activityImageStorage.deleteImage(at: photoPath)
                }
            }
            
            input.plantImageStorage.deleteImage(at: plant.photo)
            try input.plantRepository.delete(plant, in: context)
            input.navPath.wrappedValue.removeLast()
        } catch {}
    }
    
    func viewAllActivities() {
        
        self.input.navPath.wrappedValue.append(
            PlantDetailDestination.viewAllActivites(plantId: input.plantID)
        )
    }
}

extension PlantDetailViewModel {
    enum State {
        case loading
        case notFound
        case data(PlantDetailDataAdapter)
    }

    struct Input {
        let plantID: UUID
        let plantImageStorage: ImageStorageManagerProtocol
        let activityImageStorage: ImageStorageManagerProtocol
        let plantRepository: PlantRepositoryProtocol
        let plantActivityRepository: PlantActivityRepositoryProtocol
        let navPath: Binding<NavigationPath>
    }
}
