import AtlasCore

extension String {
    static func localized(key: AppLocalization,_ args: any CVarArg...) -> String {
        return String().localized(
            translation: key,
            args
        )
    }
}
