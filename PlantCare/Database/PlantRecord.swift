import Foundation
import SwiftData

@Model
final class PlantRecord {
    @Attribute(.unique) var id: UUID
    var photo: String
    var nickName: String
    var plantType: TrefleListResponse.Species
    var createdAt: Date

    init(
        id: UUID = UUID(),
        photo: String,
        nickName: String,
        plantType: TrefleListResponse.Species,
        createdAt: Date = .now
    ) {
        self.id = id
        self.photo = photo
        self.nickName = nickName
        self.plantType = plantType
        self.createdAt = createdAt
    }
}
