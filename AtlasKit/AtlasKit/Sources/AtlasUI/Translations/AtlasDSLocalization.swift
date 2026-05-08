import Foundation
import SwiftUI

@MainActor
public class AtlasDSLocalization {
    var selectSource: String { "Select source" }
    var camera: String { "Camera" }
    var photoLibrary: String { "Photo Library" }
    var files: String { "Files" }
    var cancel: String { "Cancel" }
    var tapToUpload: String { "Tap to upload" }
    var change: String { "Change" }
}


private struct AtlasDSLocalizationKey: EnvironmentKey {
    nonisolated(unsafe) static var defaultValue: AtlasDSLocalization = AtlasDSLocalization()
}

public extension EnvironmentValues {
    var translations: AtlasDSLocalization {
        get { self[AtlasDSLocalizationKey.self] }
        set { self[AtlasDSLocalizationKey.self] = newValue }
    }
}

public extension View {
    func atlasTranslatoins(_ translations: AtlasDSLocalization) -> some View {
        environment(\.translations, translations)
    }
}
