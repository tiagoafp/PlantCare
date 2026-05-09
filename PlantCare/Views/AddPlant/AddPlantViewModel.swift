import SwiftData
import SwiftUI
import AtlasUI

protocol AddPlantViewModelProtocol: ObservableObject {
    var type: AddPlantSepciesAdapter { get }
    var image: UIImage? { get set }
    var nickname: String { get set }
    var sheet: AddPlantDestination? { get set }
    var state: AddPlantViewModel.State { get }
    
    func onAppear() async
}

final class AddPlantViewModel: AddPlantViewModelProtocol {
    @Published var state: State
    var input: Input
    @Published var sheet: AddPlantDestination?
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

    var type: AddPlantSepciesAdapter {
        .init(data: input.type)
    }
    
    init(input: Input) {
        self.input = input
        self.state = .data
        self.sheet = nil
        self.nickname = ""
        self.canSubmit = false
        
        if let data = input.image {
            self.image = UIImage(data: data)
        }
    }
    
    func onAppear() async {
        calculateSubmit()
    }
    
    func calculateSubmit() {
        canSubmit = image != nil
    }
    
    @MainActor
    func save(in context: ModelContext) {
        guard canSubmit, let image = image else {
            return
        }
        guard let photoPath = input.imageStorage.saveImage(image) else {
            return
        }

        let record = PlantRecord(
            photo: photoPath,
            nickName: nickname,
            plantType: input.type
        )

        context.insert(record)

        do {
            try context.save()
            input.navPath.wrappedValue.removeLast()
        } catch {
            print("Failed to save plant: \(error)")
        }
    }
}

extension AddPlantViewModel {
    enum State {
        case data
    }
    
    struct Input {
        var navPath: Binding<NavigationPath>
        var image: Data?
        var type: TrefleListResponse.Species
        var imageStorage: ImageStorageManagerProtocol
    }
}
