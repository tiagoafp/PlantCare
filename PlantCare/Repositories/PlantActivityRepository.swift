import Foundation
import SwiftData

protocol PlantActivityRepositoryProtocol {
    func fetchActivities(plantID: UUID, in context: ModelContext) throws -> [PlantActivityRecord]
    func fetchActivity(id: UUID, in context: ModelContext) throws -> PlantActivityRecord?
    func insert(_ activity: PlantActivityRecord, in context: ModelContext) throws
    func save(in context: ModelContext) throws
    func delete(_ activity: PlantActivityRecord, in context: ModelContext) throws
}

struct PlantActivityRepository: PlantActivityRepositoryProtocol {
    func fetchActivities(plantID: UUID, in context: ModelContext) throws -> [PlantActivityRecord] {
        let descriptor = FetchDescriptor<PlantActivityRecord>(
            predicate: #Predicate { activity in
                activity.plant.plantID == plantID
            },
            sortBy: [
                SortDescriptor(\.date, order: .reverse)
            ]
        )

        return try context.fetch(descriptor)
    }

    func fetchActivity(id: UUID, in context: ModelContext) throws -> PlantActivityRecord? {
        let descriptor = FetchDescriptor<PlantActivityRecord>(
            predicate: #Predicate { activity in
                activity.activityID == id
            }
        )

        return try context.fetch(descriptor).first
    }

    func insert(_ activity: PlantActivityRecord, in context: ModelContext) throws {
        context.insert(activity)
        try context.save()
    }

    func save(in context: ModelContext) throws {
        try context.save()
    }

    func delete(_ activity: PlantActivityRecord, in context: ModelContext) throws {
        context.delete(activity)
        try context.save()
    }
}
