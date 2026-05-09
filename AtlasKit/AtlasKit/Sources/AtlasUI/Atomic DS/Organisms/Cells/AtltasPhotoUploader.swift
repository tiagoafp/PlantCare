import SwiftUI

public struct AtltasPhotoUploader: View {
    @Environment(\.translations) private var translations
    @Environment(\.atlasPalette) private var palette
    @State var openUploader: Bool = false
    
    var title: Text?
    var image: Binding<UIImage?>
    
    public init(
        title: Text? = nil,
        image: Binding<UIImage?>
    ) {
        self.title = title
        self.image = image
    }
    
    public var body: some View {
        AtlasBaseCell(title: title) {
            contentView()
        }
    }
}

extension AtltasPhotoUploader {
    @ViewBuilder
    func contentView() -> some View {
        if let image = image.wrappedValue {
            imageContainer(image: image)
        } else {
            AtlasImageUploadWrapper(
                onResult: { result in
                    switch result {
                    case .image(let image):
                        self.image.wrappedValue = image
                    }
                },
                content: {
                    buttonContainer()
                }
            )
        }
    }

    @ViewBuilder
    func imageContainer(image: UIImage) -> some View {
        ZStack(alignment: .bottomTrailing) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .clipShape( RoundedRectangle(cornerRadius: 24))
                .padding(1)
            
            AtlasImageUploadWrapper(
                onResult: { result in
                    switch result {
                    case .image(let image):
                        self.image.wrappedValue = image
                    }
                },
                content: {
                    PrimaryButton(
                        image: .pencil,
                        label: Text(translations.change),
                        action: {}
                    )
                }
            )
            .padding(20)
        }
    }
    
    @ViewBuilder
    func buttonContainer() -> some View {
        Button(action: {
            openUploader.toggle()
        }) {
            ZStack(alignment: .center) {
                if let image = image.wrappedValue {
                    ZStack(alignment: .bottomTrailing) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .clipShape( RoundedRectangle(cornerRadius: 24))
                            .padding(1)
                        
                        PrimaryButton(
                            image: .pencil,
                            label: Text(translations.change),
                            action: {
                                openUploader.toggle()
                            }
                        )
                        .padding(20)
                    }
                } else {
                    RoundedRectangle(cornerRadius: 24)
                        .foregroundStyle(palette.bgSurface)
                    VStack(spacing: 6) {
                        Image.photoPlus
                            .foregroundStyle(palette.actionPrimary)
                        
                        Text(translations.tapToUpload)
                            .font(.subheadline.weight(.regular))
                            .foregroundStyle(palette.actionPrimary)
                    }
                }
                
            }
            .frame(height: 250)
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 24)
                    .stroke(
                        palette.actionPrimary.opacity(0.25),
                        style: StrokeStyle(
                            lineWidth: 3,
                            dash: [8, 6]
                        )
                    )
            }
        }
    }
}
