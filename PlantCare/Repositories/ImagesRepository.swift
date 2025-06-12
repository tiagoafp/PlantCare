//
//
// PlantCare
// Created by: tiago.pereira on 15/6/25
//
import SwiftUI

protocol ImagesRepositoryProtocol {
    func saveImage(plant: Plant, image: UIImage) throws -> String?
}

struct ImagesRepository: ImagesRepositoryProtocol {
    var docsDirectory: URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    private func folderForPlant(plant: Plant) throws -> URL? {
        guard let folderURL = docsDirectory?.appending(path: "plant-"+plant.id.uuidString) else {
            return nil
        }
        
        if !FileManager.default.fileExists(atPath: folderURL.path) {
            try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            return folderURL
        } else {
            return folderURL
        }
    }
    
    private func folderForImage(plant: Plant, image: UIImage) throws -> URL? {
        let name = UUID().uuidString
        
        return try folderForPlant(plant: plant)?.appendingPathComponent(name, conformingTo: .png)
    }
    
    func saveImage(plant: Plant, image: UIImage) throws -> String? {
        guard let imageURL = try? folderForImage(plant: plant, image: image) else {
            return nil
        }
        
        guard let data = image.pngData() else { return nil }

        
        try data.write(to: imageURL)
        
        return imageURL.absoluteString
    }
    
    
}
