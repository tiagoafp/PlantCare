
// Copyright © 2026 Sage.
// All Rights Reserved.


import SwiftUI

protocol PlantTypeSelectorViewModelProtocol: ObservableObject {
    var search: String { get set }
    var path: NavigationPath { get set }
    var sheet: PlantTypeSelectorDestination? { get set }
    var state: PlantTypeSelectorViewModel.State { get }
}

final class PlantTypeSelectorViewModel: PlantTypeSelectorViewModelProtocol {
    @Published var state: State
    @Published var path: NavigationPath
    @Published var sheet: PlantTypeSelectorDestination?
    @Published var search: String

    init() {
        self.state = .loading
        self.path = .init()
        self.sheet = nil
        self.search = ""
    }
}

extension PlantTypeSelectorViewModel {
    enum State {
        case loading
    }
}
