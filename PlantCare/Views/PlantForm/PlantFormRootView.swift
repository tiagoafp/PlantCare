import SwiftData
import SwiftUI
import AtlasUI

struct PlantFormRootView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel: PlantFormViewModel
    @State var confirmDelete: Bool = false
    
    init(
        formType: PlantFormType,
        navPath: Binding<NavigationPath>
    ) {
        _viewModel = .init(
            wrappedValue: PlantFormViewModel(
                input: .init(
                    navPath: navPath,
                    formType: formType,
                    imageStorage: ImageStorageManager.plant
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
        .navigationTitle(
            Text(title)
        )
        .toolbar {
            switch viewModel.input.formType {
            case .add:
                EmptyView()
            case .edit:
                AtlasToolbarButton(image: .delete, action: {
                    confirmDelete.toggle()
                })
            }
        }
        .alert(
            .localized(key: .deleteConfirmation),
            isPresented: $confirmDelete,
            actions: {
                Button(
                    String.localized(key: .delete),
                    role: .destructive) {
                        viewModel.delete(context: modelContext)
                    }
                
                Button(String.localized(key: .cancel), role: .cancel) {
                    confirmDelete.toggle()
                }
            })
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
