import SwiftData
import SwiftUI
import AtlasUI

@MainActor
protocol PlantFormViewModelProtocol: ObservableObject {
    var type: PlantFormSpeciesAdapter { get }
    var image: UIImage? { get set }
    var nickname: String { get set }
    var sheet: PlantFormDestination? { get set }
    var state: PlantFormViewModel.State { get }
    
    func onAppear() async
    
    func onMainAction(context: ModelContext)
}

final class PlantFormViewModel: PlantFormViewModelProtocol {
    @Published var state: State
    var input: Input
    var modelContext: ModelContext?
    @Published var sheet: PlantFormDestination?
    @Published var image: UIImage?  {
        didSet {
            calculateSubmit()
        }
    }
    
    @Published var nickname: String {
        didSet {
            calculateSubmit()
        }
    }
    
    @Published var canSubmit: Bool

    var type: PlantFormSpeciesAdapter {
        switch input.formType {
        case .add(_, let specie):
            return .init(data: specie)
        case .edit(let plant, _):
            return .init(data: plant.plantType)
        }
    }
    
    init(input: Input) {
        self.input = input
        self.state = .data
        self.sheet = nil
        self.nickname = ""
        self.canSubmit = false
        
        if case .add(let data, let type) = input.formType {
            nickname = type.scientificName
            
            if let data {
                self.image = UIImage(data: data)
            }
        }
        
        if case .edit(let plant, _) = input.formType {
            self.image = input.imageStorage.loadImage(from: plant.photo)
            self.nickname = plant.nickName
        }
    }
    
    func inject(modelContext: ModelContext) {
        if self.modelContext != nil {
            return
        }
        
        self.modelContext = modelContext
        
        if case .add(_, let type) = input.formType {
            let descriptor = FetchDescriptor<PlantRecord>(
                predicate: #Predicate { plant in
                    plant.nickName == type.scientificName
                }
            )

            do {
                let count = try modelContext.fetchCount(descriptor)
                if count > 0 {
                    nickname = type.scientificName + " \(count)"
                }
            } catch {
                
            }
        }
    }
    
    func onAppear() async {
        calculateSubmit()
    }
    
    func calculateSubmit() {
        canSubmit = image != nil
    }
    
    
    func onMainAction(context: ModelContext) {
        switch input.formType {
        case .add(_, let specie):
            save(in: context, type: specie)
        case .edit(let plant, _):
            edit(in: context, plant: plant)
        }
    }
    
    func save(in context: ModelContext, type: TrefleListResponse.Species) {
        guard canSubmit, let image = image else {
            return
        }
        guard let photoPath = input.imageStorage.saveImage(image) else {
            return
        }

        let record = PlantRecord(
            photo: photoPath,
            nickName: nickname,
            plantType: type
        )

        context.insert(record)

        do {
            try context.save()
            input.onUpdate()
            input.navPath.wrappedValue.removeLast()
        } catch {
            handleError(error: error)
        }
    }
    
    func edit(in context: ModelContext, plant: PlantRecord) {
        guard canSubmit, let image = image else {
            return
        }
        guard input.imageStorage.replaceImage(image, at: plant.photo) else {
            return
        }
        
        plant.nickName = nickname
        
        do {
            try context.save()
            input.onUpdate()
            input.navPath.wrappedValue.removeLast()
        } catch {
            handleError(error: error)
        }
    }
    
    func handleError(error: Error) {
        #if DEBUG
        print("Failed to edit plant: \(error)")
        #endif
    }
}

extension PlantFormViewModel {
    enum State {
        case data
    }
    
    struct Input {
        var navPath: Binding<NavigationPath>
        let formType: PlantFormType
        var imageStorage: ImageStorageManagerProtocol
        var activityImageStorage: ImageStorageManagerProtocol
        var onUpdate: () -> Void
    }
}
