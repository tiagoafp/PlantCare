//
// Copyright © 2025 Sage.
// All Rights Reserved.

import Foundation
import UIKit
import SwiftUI

protocol ImageStorageService {
    func saveDraftImage(plant: Plant, image: UIImage) throws -> String?
    func saveImage(plant: Plant) throws
    func image(plant: Plant, draft: Bool) -> UIImage?
    func cellImage(plant: Plant) -> UIImage?
}

struct PlantImageStorageService: ImageStorageService {
    let fileManager: FileManager
    let resizeService: ImagesResizeService
    init(
        fileManager: FileManager = .default,
        resizeService: ImagesResizeService = DefaultImagesResizeService()
    ) {
        self.fileManager = fileManager
        self.resizeService = resizeService
        
        print("Docs folder \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!)")
    }
    
    private var cacheDirectory: URL? {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    }
    
    private var docsDirectory: URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    private func buildFolder(for plant: Plant, draft: Bool) -> URL? {
        var baseURL = docsDirectory
        if draft {
            baseURL = cacheDirectory
        }
        
        guard let plantURL = baseURL?.appending(path: plant.id.uuidString) else { return nil }
        
        if !FileManager.default.fileExists(atPath: plantURL.path) {
            try? FileManager.default.createDirectory(at: plantURL, withIntermediateDirectories: true, attributes: nil)
            return plantURL
        } else {
            return plantURL
        }
    }
    
    func saveDraftImage(plant: Plant, image: UIImage) throws -> String? {
        guard let url = buildFolder(for: plant, draft: true) else {
            return nil
        }
        
        let coverName = "\(UUID().uuidString).png"
        let imageURL = url.appendingPathComponent(coverName)
        
        
        guard let data = image.pngData() else { return nil }
        
        try data.write(to: imageURL)
        
        return coverName
    }
    
    func saveImage(plant: Plant) throws {
        guard
            let cache = buildFolder(for: plant, draft: true),
            let docs = buildFolder(for: plant, draft: false),
            let cover = plant.cover else {
            return
        }
        
        let cacheImage = cache.appendingPathComponent(cover)
        let docsImage = docs.appendingPathComponent(cover)
        
        try fileManager.moveItem(at: cacheImage, to: docsImage)
    }
    
    func image(plant: Plant, draft: Bool = false) -> UIImage? {
        guard let baseFolder = buildFolder(for: plant, draft: draft),
              let cover = plant.cover else {
            return nil
        }
        
        let path = baseFolder.appending(path: cover)
        
        return UIImage(contentsOfFile: path.path())
    }
    
    func cellImage(plant: Plant) -> UIImage? {
        guard let image = image(plant: plant) else {
            return nil
        }
        
        let renderer = UIGraphicsImageRenderer(size: .init(width: 20, height: 20))
        
        let resized = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: .init(width: 20, height: 20)))
        }
        
        let data = resized.pngData()
        
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: .init(width: 20, height: 20)))
        }
    }
    
    private func resizedToFit(original: UIImage, maxLength: CGFloat) -> UIImage? {
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
