import SwiftData
import SwiftUI
import AtlasUI

@MainActor
protocol PlantActivityFormViewModelProtocol: ObservableObject {
    var formType: PlantActivityFormType { get }
    var activityType: PlantActivityTypePickerAdapter { get set }
    var activityImage: UIImage? { get set }
    var activityDate: Date { get set }
    var activityNotes: String { get set }
    var state: PlantActivityFormViewModel.State { get }
    
    var selectedPlant: PlantCellDataAdapter? { get }
    var activities: [PlantActivityTypePickerAdapter] { get }
    var formConfig: PlantActivityFormConfiguration { get }
    
    func onViewAppear(in context: ModelContext) async
    
    func save(in context: ModelContext) -> Bool
    func updateConfi(activityType: PlantActivityType)
}

class PlantActivityFormViewModel: PlantActivityFormViewModelProtocol {
    var plantId: UUID {
        switch input.formType {
        case .add(let plant):
            return plant
        case .edit(let plant, _):
            return plant
        }
    }
    
    var formType: PlantActivityFormType { input.formType }
    
    static let defaultActivityType: PlantActivityType = .watering
    
    
    @Published var activityType: PlantActivityTypePickerAdapter
    @Published var activityDate: Date
    @Published var activityNotes: String
    @Published var state: State
    @Published var activityImage: UIImage?
    @Published var formConfig: PlantActivityFormConfiguration
    var context: ModelContext?

    @Published var selectedPlant: PlantCellDataAdapter?
    
    var activities: [PlantActivityTypePickerAdapter] {
        PlantActivityType.allCases.map { .init(activityType: $0) }
    }
    
    let input: Input

    init(input: Input) {
        self.input = input
        self.activityType = .init(activityType: PlantActivityFormViewModel.defaultActivityType)
        self.activityDate = .now
        self.activityNotes = ""
        self.state = .loading
        self.activityImage = nil
        self.formConfig = .init(plantActivityType: PlantActivityFormViewModel.defaultActivityType)
    }
    
    func onViewAppear(in context: ModelContext) async {
        if self.context != nil { return }
        
        defer { self.context = context }
        
        if let plant = try? input.plantRepository.fetchPlant(id: plantId, in: context) {
            self.selectedPlant = PlantCellDataAdapter(
                plantRecord: plant,
                uiImage: input.imageManager.loadImage(from: plant.photo),
                chevron: false
            )
        }

        switch input.formType {
        case .add:
            self.formConfig = .init(plantActivityType: PlantActivityFormViewModel.defaultActivityType)
            
            self.activityType = .init(activityType: PlantActivityFormViewModel.defaultActivityType)
            self.activityImage = nil
            self.activityDate = .now
            self.activityNotes = ""
        case .edit(_, let activityId):
            guard let activity = try? input.plantActivityRepository.fetchActivity(
                id: activityId,
                in: context
            ) else {
                self.state = .loading
                return
            }

            self.formConfig = .init(plantActivityType: activity.type)
            
            self.activityType = .init(activityType: activity.type)
            self.activityImage = input.activityImageManager.loadImage(from: activity.photo ?? "")
            self.activityDate = activity.date
            self.activityNotes = activity.notes ?? ""
        }

        self.state = .data
    }
    
    func updateConfi(activityType: PlantActivityType) {
        formConfig = .init(plantActivityType: activityType)
    }

    func create(in context: ModelContext) -> Bool {
        guard let plant = try? input.plantRepository.fetchPlant(id: plantId, in: context) else {
            return false
        }

        var photo: String?
        
        if let activityImage {
            photo = input.activityImageManager.saveImage(activityImage)
        }
        
        let recordedActivity = PlantActivityRecord(
            type: activityType.activityType,
            plant: plant,
            notes: activityNotes,
            photo: photo,
            date: activityDate
        )
        
        plant.activities.append(recordedActivity)

        do {
            try input.plantActivityRepository.insert(recordedActivity, in: context)
            input.onUpdate()
            return true
        } catch {
            handleError(error: error)
            return false
        }
    }
    
    func update(activity: PlantActivityRecord, in context: ModelContext) -> Bool {
        var photo: String?
        
        if let activityImage {
            if let oldPhoto = activity.photo {
                if input.activityImageManager.replaceImage(activityImage, at: oldPhoto) {
                    photo = oldPhoto
                }
            } else {
                photo = input.activityImageManager.saveImage(activityImage)
            }
        }
        
        activity.date = activityDate
        activity.notes = activityNotes
        activity.photo = photo
        activity.type = activityType.activityType
        
        do {
            try input.plantActivityRepository.save(in: context)
            input.onUpdate()
            return true
        } catch {
            handleError(error: error)
            return false
        }
    }
    
    func save(in context: ModelContext) -> Bool {
        switch input.formType {
        case .add:
            return create(in: context)
        case .edit(_, let activityId):
            guard let activity = try? input.plantActivityRepository.fetchActivity(
                id: activityId,
                in: context
            ) else {
                return false
            }

            return update(activity: activity, in: context)
        }
    }

    func handleError(error: Error) {
        #if DEBUG
        print("Failed to save activity: \(error)")
        #endif
    }
}

extension PlantActivityFormViewModel {
    enum State {
        case loading
        case data
    }

    struct Input {
        let formType: PlantActivityFormType
        let imageManager: ImageStorageManagerProtocol
        let activityImageManager: ImageStorageManagerProtocol
        let plantRepository: PlantRepositoryProtocol
        let plantActivityRepository: PlantActivityRepositoryProtocol
        let onUpdate: () -> Void
    }
}
