import Foundation
import SwiftData

@Model
final class PlantActivityRecord {
    @Attribute(.unique) var activityID: UUID
    @Relationship
    var plant: PlantRecord
    var type: PlantActivityType
    var notes: String?
    var photo: String?
    var date: Date

    init(
        type: PlantActivityType,
        plant: PlantRecord,
        notes: String?,
        photo: String?,
        date: Date = .now
    ) {
        self.activityID = UUID()
        self.type = type
        self.notes = notes
        self.photo = photo
        self.date = date
        self.plant = plant
    }
}
