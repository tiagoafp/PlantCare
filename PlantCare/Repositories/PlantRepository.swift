//
//
// PlantCare
// Created by: tiago.pereira on 11/6/25
//

import SwiftData
import Foundation

protocol PlantRepositoryProtocol {
    func fetchOrderedByWater() throws -> [PlantStatus]
    func fetchOrderedByNewAdded() throws -> [PlantStatus]
    func fetchAll() throws -> [PlantStatus]
    func fetch(id: PersistentIdentifier?) -> Plant?
    func insert(type: Plant)
    func delete(type: Plant)
    func save() throws
}

class PlantRepository: PlantRepositoryProtocol {
    let context: ModelContext
    let waterService: WaterPlantService
    
    init(
        context: ModelContext,
        waterService: WaterPlantService
    ) {
        self.context = context
        self.waterService = waterService
    }
    
    func fetchOrderedByWater() throws -> [PlantStatus] {
        try fetchAll().sorted { $0 < $1}
    }
    
    func fetchOrderedByNewAdded() throws -> [PlantStatus] {
        return Array(
            try fetchAll().prefix(5)
        )
    }
    
    func fetchAll() throws -> [PlantStatus] {
        let descriptor = FetchDescriptor<Plant>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        return try context.fetch(descriptor).map { waterService.waterStatus(plant: $0) }
    }
    
    func fetch(id: PersistentIdentifier?) -> Plant? {
        guard let id else { return nil }
        
        return context.model(for: id) as? Plant
    }
    
    func insert(type: Plant) {
        context.insert(type)
    }
    
    func delete(type: Plant) {
        context.delete(type)
    }
    
    func save() throws {
        try context.save()
    }
}
