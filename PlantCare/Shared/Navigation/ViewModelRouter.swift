//
//
// PlantCare
// Created by: tiago.pereira on 5/7/25
//

@MainActor
class ViewModelRouter<Route: ViewRoute> {
    weak var router: ViewRouter<Route>?
    
    func inject(router: ViewRouter<Route>) {
        self.router = router
    }
    
    func push(_ route: Route) {
        router?.push(route)
    }
    
    func pop() {
        router?.pop()
    }
    
    func popToRoot() {
        router?.popToRoot()
    }
    
    func dismiss() {
        router?.dismiss()
    }
}
