//
//
// PlantCare
// Created by: tiago.pereira on 5/7/25
//

import SwiftUI

@MainActor
class StackCoordinator: ObservableObject {
    @Published var path: NavigationPath
    var dismissAction: DismissAction?
    
    init() {
        path = NavigationPath()
    }
    
    func inject(dismissAction: DismissAction?) {
        self.dismissAction = dismissAction
    }
    
    func dismiss() {
        dismissAction?()
    }
    
    func push<V: Hashable>(_ view: V) {
        path.append(view)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
