import SwiftUI

protocol AddPlantViewModelProtocol: ObservableObject {
    var path: NavigationPath { get set }
    var sheet: AddPlantDestination? { get set }
    var state: AddPlantViewModel.State { get }
}

final class AddPlantViewModel: AddPlantViewModelProtocol {
    @Published var state: State
    @Published var path: NavigationPath
    @Published var sheet: AddPlantDestination?

    init() {
        self.state = .empty
        self.path = .init()
        self.sheet = nil
    }
}

extension AddPlantViewModel {
    enum State {
        case empty
    }
}
