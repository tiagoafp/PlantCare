import SwiftData
import SwiftUI
import AtlasUI

struct PlantFormRootView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel: PlantFormViewModel
    
    init(
        depInjector: DependencyInjectorProtocol = DependencyInjector(),
        formType: PlantFormType,
        navPath: Binding<NavigationPath>,
        onUpdate: @escaping () -> Void,
    ) {
        _viewModel = .init(
            wrappedValue: PlantFormViewModel(
                input: .init(
                    navPath: navPath,
                    formType: formType,
                    imageStorage: ImageStorageManager.plant,
                    activityImageStorage: depInjector.activityImageManager,
                    onUpdate: onUpdate
                )
            )
        )
    }
    
    var body: some View {
        PlantFormView(viewModel: viewModel)
        .atlasBackground()
        .atlasBottomAction {
            AtlasBottomActionButton(
                title: mainActionTitle,
                action: {
                    viewModel.onMainAction(context: modelContext)
                }
            )
        }
        .onAppear(perform: {
            viewModel.inject(modelContext: modelContext)
        })
        .navigationTitle(
            Text(title)
        )
        .sheet(
            item: $viewModel.sheet,
            content: destination
        )
        .navigationDestination(
            for: PlantFormDestination.self,
            destination: destination
        )
    }
    
    @ViewBuilder
    func destination(destination: PlantFormDestination) -> some View {
        switch destination {
        case .example:
            EmptyView()
        }
    }
    
    var title: String {
        switch viewModel.input.formType {
        case .add:
            return .localized(key: .addPlant)
        case .edit:
            return .localized(key: .editPlant)
        }
    }
    
    var mainActionTitle: Text {
        switch viewModel.input.formType {
        case .add:
            return .localized(key: .addNewPlant)
        case .edit:
            return .localized(key: .save)
        }
    }
}
