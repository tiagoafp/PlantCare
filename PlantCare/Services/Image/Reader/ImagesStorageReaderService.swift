//
// Copyright © 2025 Sage.
// All Rights Reserved.

import UIKit

protocol ImagesStorageReaderService {
    var rootURL: URL? { get }
    var fileManager: FileManager { get }
}

extension ImagesStorageReaderService {
    func buildFolder(for plant: Plant) -> URL? {
        guard let plantURL = rootURL?.appending(path: plant.id.uuidString) else { return nil }
        
        if !FileManager.default.fileExists(atPath: plantURL.path) {
            try? FileManager.default.createDirectory(at: plantURL, withIntermediateDirectories: true, attributes: nil)
            return plantURL
        } else {
            return plantURL
        }
    }
    
    private func imageFromURL(url: URL) -> UIImage? {
        guard let data = try? Data(contentsOf: url) else { return nil }
        
        return UIImage(data: data)
    }
    
    func getCover(plant: Plant) -> UIImage? {
        guard let plantURL = buildFolder(for: plant),
              let cover = plant.cover else {
            return nil
        }
        
        let coverUrl = plantURL.appending(component: cover)
        
        return imageFromURL(url: coverUrl)
    }
    
    func getCell(plant: Plant) -> UIImage? {
        guard let plantURL = buildFolder(for: plant)else {
            return nil
        }
        
        let cellUrl = plantURL.appending(component: "cell.png")
        
        return imageFromURL(url: cellUrl)
    }
}
