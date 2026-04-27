
// Copyright © 2026 Sage.
// All Rights Reserved.


import SwiftUI

struct PlantTypeSelectorView<ViewModel: PlantTypeSelectorViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack {
                Text(AppSecrets.perenualAPIKey)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
        }
        .searchable(
            text: $viewModel.search,
            prompt: .localized(key: .searchPlants)
        )
    }
}
