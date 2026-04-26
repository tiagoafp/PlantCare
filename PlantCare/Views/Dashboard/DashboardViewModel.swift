import SwiftUI

protocol DashboardViewModelProtocol: ObservableObject {
    var path: NavigationPath { get set }
    var sheet: DashboardDestination? { get set }
    var state: DashboardViewModel.State { get }
    var watering: Bool { get set }
}

class DashboardViewModel: DashboardViewModelProtocol {
    @Published var watering: Bool = false
    var input: Input
    @Published var state: State
    @Published var path: NavigationPath
    @Published var sheet: DashboardDestination?
    
    init(input: Input) {
        self.input = input
        self.state = .empty
        self.path = NavigationPath()
    }
}

extension DashboardViewModel {
    enum State {
        case empty
    }
    
    struct Input {
        
    }
}
