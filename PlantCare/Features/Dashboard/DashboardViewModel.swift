//
//
// PlantCare
// Created by: tiago.pereira on 24/5/25
//

public protocol DashboardViewModelProtocol {
    
}

public struct DashboardViewModel: DashboardViewModelProtocol {
    let input: Input
    
    init (input: Input) {
        self.input = input
    }
}

extension DashboardViewModel {
    public struct Input {
        let router: DashboardRouterProtocol
    }
}
