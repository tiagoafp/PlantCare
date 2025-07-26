//
// Copyright © 2025 Sage.
// All Rights Reserved.

import UIKit

protocol ImagesStorageReaderService {
    var rootURL: URL? { get }
    var fileManager: FileManager { get }
}

extension ImagesStorageReaderService {
    func plantURL(for plant: Plant) -> URL? {
        return rootURL?.appending(path: plant.id.uuidString)
    }
    
    private func imageFromURL(url: URL) -> UIImage? {
        guard let data = try? Data(contentsOf: url) else { return nil }
        
        return UIImage(data: data)
    }
    
    func getCover(plant: Plant) -> UIImage? {
        guard let plantURL = plantURL(for: plant),
              let cover = plant.cover else {
            return nil
        }
        
        let coverUrl = plantURL.appending(component: cover)
        
        return imageFromURL(url: coverUrl)
    }
    
    func getCell(plant: Plant) -> UIImage? {
        guard let plantURL = plantURL(for: plant)else {
            return nil
        }
        
        let cellUrl = plantURL.appending(component: "cell.png")
        
        return imageFromURL(url: cellUrl)
    }
}
