//
//
// PlantCare
// Created by: tiago.pereira on 15/6/25
//
import SwiftUI

protocol ImagesRepositoryProtocol {
    func saveToDocs(plant: Plant, image: String?) throws -> String?
    func saveImage(plant: Plant, image: UIImage, type: ImageStorageType) throws -> String?
    func cleanImage(image: String?) throws
    func cleanCache() throws
}

struct ImagesRepository: ImagesRepositoryProtocol {
    let fileManager: FileManager
    
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    
    var cacheDirectory: URL? {
        createImagesFolder(FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first)
    }
    
    var docsDirectory: URL? {
        createImagesFolder(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)
    }
    
    func createImagesFolder(_ base: URL?) -> URL? {
        guard let imagesURL = base?.appending(path: "Images") else { return nil }
        
        do {
            if !FileManager.default.fileExists(atPath: imagesURL.path) {
                try FileManager.default.createDirectory(at: imagesURL, withIntermediateDirectories: true, attributes: nil)
                return imagesURL
            } else {
                return imagesURL
            }
        } catch {
            return nil
        }
    }
    
    func baseURL(type: ImageStorageType) -> URL? {
        switch type {
        case .docs:
            return docsDirectory
        case .cache:
            return cacheDirectory
        }
    }
    
    func cleanImage(image: String?) throws {
        guard let image else { return }
        
        if fileManager.fileExists(atPath: image) {
            try fileManager.removeItem(at: URL(filePath: image))
        }
    }
    
    func cleanCache() throws {
        guard let cacheDirectory = cacheDirectory else { return }
        
        let images = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil)
        
        try images.forEach { image in
            try fileManager.removeItem(at: image)
        }
    }
    
    private func folderForPlant(plant: Plant, type: ImageStorageType) throws -> URL? {
        guard let folderURL = baseURL(type: type)?.appending(path: "plant-"+plant.id.uuidString) else {
            return nil
        }
        
        if !FileManager.default.fileExists(atPath: folderURL.path) {
            try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            return folderURL
        } else {
            return folderURL
        }
    }
    
    func saveToDocs(plant: Plant, image: String?) throws -> String?  {
        guard let image else { return nil }
        
        guard let cache = URL(string: image) else {
            return nil
        }
        
        guard let docsFolder = try? folderForPlant(plant: plant, type: .docs)?.appendingPathComponent(UUID().uuidString, conformingTo: .png) else {
            return nil
        }
        
        do {
            try fileManager.moveItem(at: cache, to: docsFolder)
        } catch {
            print(error.localizedDescription)
        }
        
        return docsFolder.absoluteString
    }
    
    private func folderForImage(plant: Plant, image: UIImage, type: ImageStorageType) throws -> URL? {
        let name = UUID().uuidString
        
        return try folderForPlant(plant: plant, type: type)?.appendingPathComponent(name, conformingTo: .png)
    }
    
    func saveImage(plant: Plant, image: UIImage, type: ImageStorageType) throws -> String? {
        guard let imageURL = try? folderForImage(plant: plant, image: image, type: type) else {
            return nil
        }
        
        guard let data = image.pngData() else { return nil }
        
        try data.write(to: imageURL)
        
        return imageURL.absoluteString
    }
}

enum ImageStorageType {
    case docs
    case cache
}
