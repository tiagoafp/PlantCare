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
}

class PlantDetailViewModel: PlantDetailViewModelProtocol {
    @Published private(set) var state: State = .loading
    @Published private(set) var plant: PlantRecord?
    @Published var sheet: PlantDetailDestination?
    let input: Input

    init(input: Input) {
        self.input = input
    }

    func load(in context: ModelContext) async {
        guard let record = context.model(for: input.plantID) as? PlantRecord else {
            self.state = .notFound
            return
        }

        
        let activityRecords = record.activities

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
        guard let plant = context.model(for: input.plantID) as? PlantRecord else {
            return
        }
        
        do {
            plant.activities.forEach { activity in
                if let photoPath = activity.photo {
                    input.activityImageStorage.deleteImage(at: photoPath)
                }
            }
            
            input.plantImageStorage.deleteImage(at: plant.photo)
            context.delete(plant)
        } catch {}
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
        let activityImageStorage: ImageStorageManagerProtocol
        let navPath: Binding<NavigationPath>
    }
}
