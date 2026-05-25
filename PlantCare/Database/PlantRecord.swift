import Foundation
import SwiftData

@Model
final class PlantRecord {
    @Attribute(.unique)
    var plantID: UUID
    var photo: String
    var nickName: String
    var plantType: TrefleListResponse.Species
    var createdAt: Date
    @Relationship(deleteRule: .cascade)
    var activities: [PlantActivityRecord] = []

    init(
        photo: String,
        nickName: String,
        plantType: TrefleListResponse.Species,
        createdAt: Date = .now
    ) {
        self.plantID = UUID()
        self.photo = photo
        self.nickName = nickName
        self.plantType = plantType
        self.createdAt = createdAt
    }
}
