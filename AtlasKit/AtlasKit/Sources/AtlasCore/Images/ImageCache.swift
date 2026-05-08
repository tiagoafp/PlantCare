import UIKit

public class ImageCache {
    @MainActor static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    public func get(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
    
    public func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
