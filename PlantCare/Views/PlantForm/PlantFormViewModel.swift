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
    func delete(context: ModelContext)
}

final class PlantFormViewModel: PlantFormViewModelProtocol {
    @Published var state: State
    var input: Input
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
        
        if case .add(let data, _) = input.formType, let data {
            self.image = UIImage(data: data)
        }
        
        if case .edit(let plant, _) = input.formType {
            self.image = input.imageStorage.loadImage(from: plant.photo)
            self.nickname = plant.nickName
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
            input.navPath.wrappedValue.removeLast()
        } catch {
            handleError(error: error)
        }
    }
    
    func delete(context: ModelContext) {
        if case .edit(let plant, let onDelete) = input.formType {
            context.delete(plant)
            onDelete()
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
    }
}
