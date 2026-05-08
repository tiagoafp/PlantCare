import Foundation

enum AppSecrets {
    private static let bundle = Bundle.main
    private static let candidates = ["Secrets"]

    static var plantnetAPIKey: String {
        string(forKey: "PLANTNET_KEY")
    }
    
    static var trefleAPIKey: String {
        string(forKey: "TREFLE_TOKEN")
    }

    static func string(forKey key: String) -> String {
        guard let value = dictionary[key] as? String, value.isEmpty == false else {
            fatalError("Missing secrets value for key '\(key)' in Secrets.plist or Secrets.example.plist.")
        }

        return value
    }

    private static var dictionary: [String: Any] {
        guard let url = bundle.url(
            forResource: "Secrets",
            withExtension: "plist"
        ) else {
            fatalError("No secrets plist found in bundle.")
        }
        
        guard let secrets = NSDictionary(contentsOf: url) as? [String: Any] else {
            fatalError("Unable to decode Secrets.plist")
        }
        
        return secrets
    }
}
