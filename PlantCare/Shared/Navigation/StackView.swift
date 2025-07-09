//
//
// PlantCare
// Created by: tiago.pereira on 5/7/25
//

import SwiftUI

struct StackView<Content: View>: View {
    var content: (StackCoordinator) -> Content
    @EnvironmentObject var coordinator: StackCoordinator
    
    init(content: @escaping (StackCoordinator) -> Content) {
        self.content = content
    }
    
    var body: some View {
        content(coordinator)
    }
}
