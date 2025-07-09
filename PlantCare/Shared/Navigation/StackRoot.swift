//
//
// PlantCare
// Created by: tiago.pereira on 5/7/25
//

import SwiftUI

struct StackRoot<Content: View>: View {
    var content: (StackCoordinator) -> Content
    @StateObject var coordinator = StackCoordinator()
    @Environment(\.dismiss) var dismiss
    
    init(content: @escaping (StackCoordinator) -> Content) {
        self.content = content
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            content(coordinator)
                .task {
                    coordinator.inject(dismissAction: dismiss)
                }
        }
        .environmentObject(coordinator)
    }
}
