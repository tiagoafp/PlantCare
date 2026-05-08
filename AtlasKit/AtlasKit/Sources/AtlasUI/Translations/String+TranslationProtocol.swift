import Foundation

public extension String {
    func localized(translation: TranslationProtocol, _ args: any CVarArg...) -> String {
        String(
            format: translation.format,
            args
        )
    }
}
