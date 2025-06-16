//
//
// PlantCare
// Created by: tiago.pereira on 16/6/25
//

import SwiftData
import Foundation

@Model
public class ImageRegistration: Identifiable {
    var origin: ImageRegistrationOrigin
    var notes: String
    var image: String
    var createdAd: Date
    
    init(image: String, notes: String, origin: ImageRegistrationOrigin) {
        self.notes = notes
        self.image = image
        self.createdAd = .now
        self.origin = origin
    }
}

enum ImageRegistrationOrigin: String, CaseIterable, Codable {
    case feed
    case cover
}
