//
// Copyright © 2025 Sage.
// All Rights Reserved.

import UIKit

protocol ImagesStorageWritterService {
    var rootURL: URL? { get }
    var fileManager: FileManager { get }
}

extension ImagesStorageWritterService {
    func buildFolder(for plant: Plant) -> URL? {
        guard let plantURL = rootURL?.appending(path: plant.id.uuidString) else { return nil }
        
        if !FileManager.default.fileExists(atPath: plantURL.path) {
            try? FileManager.default.createDirectory(at: plantURL, withIntermediateDirectories: true, attributes: nil)
            return plantURL
        } else {
            return plantURL
        }
    }
    
    func clean(plant: Plant) throws {
        guard let url = buildFolder(for: plant) else { return }
        
        let contents = try fileManager.contentsOfDirectory(
            at: url,
            includingPropertiesForKeys: nil
        )
        
        try contents.forEach { content in
            try fileManager.removeItem(at: content)
        }
    }
    
    func saveCover(image: UIImage?, plant: Plant) -> String? {
        guard
            let image = image,
            let plantURL = buildFolder(for: plant),
            let data = image.pngData()
        else {
            return nil
        }
        
        let coverName = "\(UUID().uuidString).png"
        
        do {
            try saveImage(data: data, plantURL: plantURL, name: coverName)
            try saveCell(image: image, plantURL: plantURL)
            
            return coverName
        } catch {
            return nil
        }
    }
    
    private func saveCell(image: UIImage, plantURL: URL) throws {
        guard let data = Self.resizedToFit(original: image, maxLength: 45)?.pngData() else {
            return
        }
        
        try saveImage(data: data, plantURL: plantURL, name: "cell.png")
    }
    
    private func saveImage(data: Data, plantURL: URL, name: String) throws {
        let imageURL = plantURL.appendingPathComponent(name)
        try data.write(to: imageURL)
    }
}

extension ImagesStorageWritterService {
    static func resizedToFit(original: UIImage, maxLength: CGFloat) -> UIImage? {
        let originalSize = original.size
        let maxOriginalDimension = max(originalSize.width, originalSize.height)
        
        // If the image is already within the desired bounds, return it as is
        guard maxOriginalDimension > maxLength else { return original }
        
        let scale = maxLength / maxOriginalDimension
        let newSize = CGSize(width: originalSize.width * scale,
                             height: originalSize.height * scale)
        
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            original.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
