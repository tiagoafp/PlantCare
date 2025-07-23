//
//
// PlantCare
// Created by: tiago.pereira on 11/6/25
//

import SwiftData
import Foundation

protocol PlantRepositoryProtocol {
    func fetchOrderedByWater() throws -> [Plant]
    func fetchOrderedByNewAdded() throws -> [Plant]
    func fetchAll() throws -> [Plant]
    func fetch(id: PersistentIdentifier?) -> Plant?
    func insert(type: Plant)
    func delete(type: Plant)
    func save() throws
}

class PlantRepository: PlantRepositoryProtocol {
    let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchOrderedByWater() throws -> [Plant] {
        return Array(
            try fetchAll().sorted(by: { plantA, plantB -> Bool in
                let scoreA = PlantWaterCalculator(plant: plantA)
                let scoreB = PlantWaterCalculator(plant: plantB)
                return scoreA.numberDaysWatering > scoreB.numberDaysWatering
            }).prefix(5)
        )
    }
    
    func fetchOrderedByNewAdded() throws -> [Plant] {
        return Array(
            try fetchAll().sorted(by: { plantA, plantB -> Bool in
                return plantA.createdAt > plantB.createdAt
            }).prefix(5)
        )
    }
    
    func fetchAll() throws -> [Plant] {
        let descriptor = FetchDescriptor<Plant>(
            sortBy: [SortDescriptor(\.createdAt, order: .forward)]
        )
        return try context.fetch(descriptor)
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
