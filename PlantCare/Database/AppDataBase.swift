import Foundation
import SwiftData

@Model
final class AppDataBase {
    var plants: [PlantRecord]

    init(
    ) {
        self.plants = []
    }
}
