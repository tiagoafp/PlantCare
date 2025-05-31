//
//
// PlantCare
// Created by: tiago.pereira on 24/5/25
//
import SwiftData
import Foundation

@Model
public class Plant: Identifiable {
    @Attribute(.unique) public var id: UUID
    var name: String
    @Attribute(.externalStorage) var imageData: Data?
    
    var addedDate: Date
    var type: PlantType
    
    public init(name: String, type: PlantType) {
        self.id = UUID()
        self.name = name
        self.addedDate = .now
        self.type = type
    }
}
