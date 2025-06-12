//
//
// PlantCare
// Created by: tiago.pereira on 13/6/25
//

import SwiftUI

protocol DestinationsProtocol: Identifiable, Hashable {}

protocol ViewNavigatorProtocol: ObservableObject {
    func push(view: any Hashable)
    func present(view: any Identifiable)
}

class ViewNavigator<Sheet: DestinationsProtocol>: ViewNavigatorProtocol {
    var navPath: Binding<NavigationPath>
    @Published var sheet: Sheet?
    
    init(navPath: Binding<NavigationPath>) {
        self.navPath = navPath
    }
    
    var type: Sheet.Type { Sheet.self }
    
    func push(view: any Hashable) {
        navPath.wrappedValue.append(view)
    }
    
    func present(view: any Identifiable) {
        sheet = view as? Sheet
    }
}
