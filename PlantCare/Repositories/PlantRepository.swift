import Foundation
import SwiftData

protocol PlantRepositoryProtocol {
    func fetchPlants(in context: ModelContext) throws -> [PlantRecord]
    func fetchPlant(id: UUID, in context: ModelContext) throws -> PlantRecord?
    func countPlants(nickName: String, in context: ModelContext) throws -> Int
    func insert(_ plant: PlantRecord, in context: ModelContext) throws
    func save(in context: ModelContext) throws
    func delete(_ plant: PlantRecord, in context: ModelContext) throws
}

struct PlantRepository: PlantRepositoryProtocol {
    func fetchPlants(in context: ModelContext) throws -> [PlantRecord] {
        let descriptor = FetchDescriptor<PlantRecord>(
            sortBy: [
                SortDescriptor(\.createdAt, order: .reverse)
            ]
        )

        return try context.fetch(descriptor)
    }

    func fetchPlant(id: UUID, in context: ModelContext) throws -> PlantRecord? {
        let descriptor = FetchDescriptor<PlantRecord>(
            predicate: #Predicate { plant in
                plant.plantID == id
            },
            sortBy: [
                SortDescriptor(\.createdAt, order: .reverse)
            ]
        )

        return try context.fetch(descriptor).first
    }

    func countPlants(nickName: String, in context: ModelContext) throws -> Int {
        let descriptor = FetchDescriptor<PlantRecord>(
            predicate: #Predicate { plant in
                plant.nickName == nickName
            }
        )

        return try context.fetchCount(descriptor)
    }

    func insert(_ plant: PlantRecord, in context: ModelContext) throws {
        context.insert(plant)
        try context.save()
    }

    func save(in context: ModelContext) throws {
        try context.save()
    }

    func delete(_ plant: PlantRecord, in context: ModelContext) throws {
        context.delete(plant)
        try context.save()
    }
}
