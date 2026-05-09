import Foundation
import UIKit

public protocol ImageStorageManagerProtocol {
    var subFolder: String { get }
}

extension ImageStorageManagerProtocol {
    /// Saves an image to the file system and returns the relative path
    public func saveImage(_ image: UIImage, compressionQuality: CGFloat = 0.8) -> String? {
        guard let data = image.jpegData(compressionQuality: compressionQuality) else {
            return nil
        }
        
        let filename = "\(UUID().uuidString).jpg"
        let fileURL = getImageURL(for: filename)
        
        // Create directory if it doesn't exist
        try? FileManager.default.createDirectory(
            at: fileURL.deletingLastPathComponent(),
            withIntermediateDirectories: true
        )
        
        do {
            try data.write(to: fileURL)
            return "\(subFolder)/\(filename)"
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }
    
    /// Loads an image from the file system using the relative path
    public func loadImage(from path: String) -> UIImage? {
        let filename = URL(fileURLWithPath: path).lastPathComponent
        let fileURL = getImageURL(for: filename)
        
        guard let data = try? Data(contentsOf: fileURL) else {
            return nil
        }
        
        return UIImage(data: data)
    }
    
    /// Deletes an image from the file system
    func deleteImage(at path: String) {
        let filename = URL(fileURLWithPath: path).lastPathComponent
        let fileURL = getImageURL(for: filename)
        
        try? FileManager.default.removeItem(at: fileURL)
    }
    
    private func getImageURL(for filename: String) -> URL {
        let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
        
        return documentDirectory
            .appendingPathComponent(subFolder)
            .appendingPathComponent(filename)
    }
}
