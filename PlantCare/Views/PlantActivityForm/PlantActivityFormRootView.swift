import SwiftData
import SwiftUI
import AtlasUI

struct PlantActivityFormRootView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: PlantActivityFormViewModel
    var depInjector: DependencyInjectorProtocol
    var onUpdate: () -> Void
    var navPath: Binding<NavigationPath>?
    
    init(
        depInjector: DependencyInjectorProtocol = DependencyInjector(),
        formType: PlantActivityFormType,
        navPath: Binding<NavigationPath>?,
        onUpdate: @escaping () -> Void
    ) {
        self.onUpdate = onUpdate
        self.depInjector = depInjector
        self.navPath = navPath
        _viewModel = .init(
            wrappedValue: PlantActivityFormViewModel(
                input: .init(
                    formType: formType,
                    imageManager: depInjector.plantImageManager,
                    activityImageManager: depInjector.activityImageManager,
                    onUpdate: onUpdate
                )
            )
        )
    }
    
    var body: some View {
        if let navPath {
            formview()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(Text.localized(key: .logActivity))
        } else {
            NavigationStack {
                formview()
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle(Text.localized(key: .logActivity))
            }
            
        }
    }
    
    @ViewBuilder
    private func formview() -> some View {
        PlantActivityFormView(viewModel: viewModel)
            .toolbar(content: {
                AtlasToolbarButton(image: .close, action: {
                    dismiss()
                })
            })
            .atlasBackground()
            .atlasBottomAction {
                AtlasBottomActionButton(
                    title: bottomTitle,
                    action: saveActivity
                )
            }
    }

    private func saveActivity() {
        if viewModel.save(in: modelContext) {
            dismiss()
        }
    }
    
    var bottomTitle: Text {
        switch viewModel.input.formType {
        case .add:
            return .localized(key: .register)
        case .edit:
            return .localized(key: .save)
        }
    }
}
