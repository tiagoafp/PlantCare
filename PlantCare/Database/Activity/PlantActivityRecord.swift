import Foundation
import SwiftData

@Model
final class PlantActivityRecord {
    @Attribute(.unique) var id: UUID
    var plantID: String
    var type: PlantActivityType
    var notes: String?
    var photo: String?
    var date: Date

    init(
        id: UUID = UUID(),
        plantID: String,
        type: PlantActivityType,
        notes: String?,
        photo: String?,
        date: Date = .now
    ) {
        self.id = id
        self.plantID = plantID
        self.type = type
        self.notes = notes
        self.photo = photo
        self.date = date
    }
}
