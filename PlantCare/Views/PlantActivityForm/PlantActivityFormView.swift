import SwiftUI
import AtlasUI

struct PlantActivityFormView<ViewModel: PlantActivityFormViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                AtlasDefaultCell(data: viewModel.selectedPLant, selection: .notSelectable)
                
                if case .add = viewModel.formType {
                    AtlasPickerCell(
                        title: .localized(key: .activityType),
                        options: viewModel.activities,
                        selection: $viewModel.activityType
                    )
                } else {
                    AtlasDatePickerCell(
                        title: .localized(key: .dateAndTime),
                        date: $viewModel.activityDate
                    )
                }
                
                
                if let photoTitle {
                    AtltasPhotoUploader(title: photoTitle, image: $viewModel.activityImage)
                }
                
                if let notesTitle {
                    AtlasTextAreaCell(
                        title: notesTitle,
                        placeholder: .localized(key: .activityDetailsPlaceholder),
                        text: $viewModel.activityNotes
                    )
                }
                
            }
            .padding(20)
            .onChange(of: viewModel.activityType, { _, newValue in
                viewModel.updateConfi(activityType: newValue.activityType)
            })
        }
    }
    
    var photoTitle: Text? {
        guard let photo = viewModel.formConfig.photoType else {
            return nil
        }
        
        switch photo {
        case .mandatory:
            return .localized(key: .addPhoto)
        case .optional:
            return .localized(key: .addPhotoOptional)
        }
    }
    
    var notesTitle: Text? {
        guard let notes = viewModel.formConfig.notes else {
            return nil
        }
        
        switch notes {
        case .optional:
            return .localized(key: .notesOptional)
        }
    }
}
