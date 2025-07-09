//
//
// PlantCare
// Created by: tiago.pereira on 5/7/25
//

import SwiftUI

public struct StackNavigator<Content: View, Route: ViewRoute, Destination: View>: View {
    var root: Bool
    var content: (ViewRouter<Route>) -> Content
    var destination: (Route) -> Destination
    @StateObject var viewRouter = ViewRouter<Route>()
    
    init(
        root: Bool = false,
        destination: @escaping (Route) -> Destination,
        content: @escaping (ViewRouter<Route>) -> Content
    ) {
        self.root = root
        self.content = content
        self.destination = destination
    }
    
    public var body: some View {
        if root {
            StackRoot { coordinator in
                content(viewRouter)
                    .task {
                        viewRouter.inject(coordinator: coordinator)
                    }
                    .sheet(item: $viewRouter.sheet, content: destination)
                    .navigationDestination(for: Route.self, destination: destination)
            }
        } else {
            StackView { coordinator in
                content(viewRouter)
                    .task {
                        viewRouter.inject(coordinator: coordinator)
                    }
                    .sheet(item: $viewRouter.sheet, content: destination)
                    .navigationDestination(for: Route.self, destination: destination)
            }
        }
    }
    
}
