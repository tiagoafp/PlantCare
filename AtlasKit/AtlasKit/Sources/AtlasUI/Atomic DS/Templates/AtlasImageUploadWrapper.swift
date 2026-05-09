import SwiftUI

public struct AtlasImageUploadWrapper<Content: View>: View {
    @Environment(\.translations) private var translations
    @State private var showImagePicker = false
    @State private var showDocumentPicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var content: () -> Content
    @State var showOptions: Bool = false
    let onResult: (PickerResult) -> Void
    
    public init(
        onResult: @escaping (PickerResult) -> Void,
        content: @escaping () -> Content
    ) {
        self.content = content
        self.onResult = onResult
    }
    
    public var body: some View {
        Button(action: {
            showOptions.toggle()
        }){
            content()
        }
        .confirmationDialog(translations.selectSource, isPresented: $showOptions) {
            Button(translations.camera) {
                sourceType = .camera
                showImagePicker = true
            }
            
            Button(translations.photoLibrary) {
                sourceType = .photoLibrary
                showImagePicker = true
            }
            
            Button(translations.files) {
                showDocumentPicker = true
            }
            
            Button(translations.cancel, role: .cancel) { }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(
                sourceType: sourceType,
                onImagePicked: { newImage in
                    self.onResult(.image(newImage))
                }
            )
            .ignoresSafeArea(edges: .bottom)
        }
        .sheet(isPresented: $showDocumentPicker) {
            DocumentPicker(onPick: { newURL in
                if let data = try? Data(contentsOf: newURL),
                   let image = UIImage(data: data) {
                    self.onResult(.image(image))
                }
            })
            .ignoresSafeArea(edges: .bottom)
        }
    }
}


extension AtlasImageUploadWrapper {
    public enum PickerResult {
        case image(UIImage)
    }
}
