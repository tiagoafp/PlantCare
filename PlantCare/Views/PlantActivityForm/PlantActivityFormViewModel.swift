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
    
    var selectedPLant: PlantCellDataAdapter { get }
    var activities: [PlantActivityTypePickerAdapter] { get }
    var formConfig: PlantActivityFormConfiguration { get }
    
    func save(in context: ModelContext) -> Bool
    func updateConfi(activityType: PlantActivityType)
}

class PlantActivityFormViewModel: PlantActivityFormViewModelProtocol {
    var formType: PlantActivityFormType { input.formType }
    
    static let defaultActivityType: PlantActivityType = .watering
    
    var plant: PlantRecord {
        switch input.formType {
        case .add(let plant):
            return plant
        case .edit(let plant, _):
            return plant
        }
    }
    @Published var activityType: PlantActivityTypePickerAdapter
    @Published var activityDate: Date
    @Published var activityNotes: String
    @Published var state: State
    @Published var activityImage: UIImage?
    
    @Published var formConfig: PlantActivityFormConfiguration

    var selectedPLant: PlantCellDataAdapter {
        .init(
            plantRecord: plant,
            uiImage: input.imageManager.loadImage(from: plant.photo),
            chevron: false
        )
    }
    
    var activities: [PlantActivityTypePickerAdapter] {
        PlantActivityType.allCases.map { .init(activityType: $0) }
    }
    
    let input: Input

    init(input: Input) {
        self.input = input
        self.state = .data
        
        switch input.formType {
        case .add:
            self.formConfig = .init(plantActivityType: PlantActivityFormViewModel.defaultActivityType)
            
            self.activityType = .init(activityType: PlantActivityFormViewModel.defaultActivityType)
            self.activityImage = nil
            self.activityDate = .now
            self.activityNotes = ""
        case .edit(let plant, let activity):
            self.formConfig = .init(plantActivityType: activity.type)
            
            self.activityType = .init(activityType: activity.type)
            self.activityImage = input.activityImageManager.loadImage(from: activity.photo ?? "")
            self.activityDate = activity.date
            self.activityNotes = activity.notes ?? ""
        }
    }
    
    func updateConfi(activityType: PlantActivityType) {
        formConfig = .init(plantActivityType: activityType)
    }

    func create(in context: ModelContext) -> Bool {
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
        context.insert(recordedActivity)

        do {
            try context.save()
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
            try context.save()
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
        case .edit(_, let activity):
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
        case data
    }

    struct Input {
        let formType: PlantActivityFormType
        let imageManager: ImageStorageManagerProtocol
        let activityImageManager: ImageStorageManagerProtocol
        let onUpdate: () -> Void
    }
}
