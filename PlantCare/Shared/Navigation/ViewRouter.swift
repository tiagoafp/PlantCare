//
//
// PlantCare
// Created by: tiago.pereira on 5/7/25
//

import SwiftUI

public protocol ViewRoute: Hashable, Identifiable {}

@MainActor
public protocol ViewRouterProtocol: ObservableObject {
    associatedtype Route: ViewRoute
    
    func push(_ route: Route)
    func present(_ route: Route)
    func pop()
    func dismiss()
}

public class ViewRouter<Route: ViewRoute>: ViewRouterProtocol {
    @Published var sheet: Route?
    weak var coordinator: StackCoordinator?
    
    func inject(coordinator: StackCoordinator) {
        self.coordinator = coordinator
    }
    
    public func push(_ route: Route) {
        coordinator?.push(route)
    }
    
    public func present(_ route: Route) {
        sheet = route
    }
    
    public func pop() {
        coordinator?.pop()
    }
    
    public func popToRoot() {
        coordinator?.popToRoot()
    }
    
    public func dismiss() {
        coordinator?.dismiss()
    }
}
