import UIKit

@MainActor
public class ImageLoader {
    static let shared = ImageLoader()
    
    private init() {}
    
    public func loadImage(from urlString: String) async throws -> UIImage {
        // 1. Check cache first
        if let cached = ImageCache.shared.get(forKey: urlString) {
            return cached
        }
        
        // 2. Download
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        // 3. Save to cache
        ImageCache.shared.set(image, forKey: urlString)
        
        return image
    }
}
