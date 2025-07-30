//
// Copyright © 2025 Sage.
// All Rights Reserved.

import SwiftUI

@MainActor
protocol WaterRegisterListViewModelProtocol: ObservableObject {
    var items: [DisplayItem] { get }
    func viewDidAppear()
    func onEdit()
}

class WaterRegisterListViewModel: WaterRegisterListViewModelProtocol {
    let input: Input
    weak var router: ViewRouter<WaterRegisterListRoute>?
    @Published var items: [DisplayItem] = []
    
    init(input: Input) {
        self.input = input
    }
    
    func inject(router: ViewRouter<WaterRegisterListRoute>?) {
        self.router = router
    }
    
    func viewDidAppear() {
        self.items = input.builder.build(plant: input.plant)
    }
    
    func onEdit() {}
}

extension WaterRegisterListViewModel {
    struct Input {
        let plant: Plant
        let builder: WaterRegisterItemsBuilderProtocol
    }
}
