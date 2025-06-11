//
//
// PlantCare
// Created by: tiago.pereira on 8/6/25
//
import SwiftData
import Foundation

protocol PlantTypeRepositoryProtocol {
    func fetchTypes() throws -> [PlantType]
    func fetchTypesByPlantsNumber() throws -> [PlantType]
    func fetchType(id: PersistentIdentifier) -> PlantType?
    func insert(type: PlantType)
    func delete(type: PlantType)
    func save() throws
}

class PlantTypeRepository: PlantTypeRepositoryProtocol {
    let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchTypes() throws -> [PlantType] {
        let descriptor = FetchDescriptor<PlantType>(
            sortBy: [SortDescriptor(\.createdAt, order: .forward)]
        )
        return try context.fetch(descriptor)
    }
    
    func fetchTypesByPlantsNumber() throws -> [PlantType] {
        let descriptor = FetchDescriptor<PlantType>()
        return try context.fetch(descriptor).sorted(by: { $0.plants.count > $1.plants.count })
    }
    
    func fetchType(id: PersistentIdentifier) -> PlantType? {
        return context.model(for: id) as? PlantType
    }
    
    func insert(type: PlantType) {
        context.insert(type)
    }
    
    func delete(type: PlantType) {
        context.delete(type)
    }
    
    func save() throws {
        try context.save()
    }
    
    
}
