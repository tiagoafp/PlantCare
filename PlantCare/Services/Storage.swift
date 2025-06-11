//
//
// PlantCare
// Created by: tiago.pereira on 7/6/25
//

import SwiftData
import Foundation
import Mockable

@Mockable
protocol StorageProtocol {
    @MainActor
    func fetch<T: PersistentModel>() throws -> [T]
    @MainActor
    func fetchElement<T: PersistentModel>(id: PersistentIdentifier) throws -> T?
    @MainActor
    func save<T: PersistentModel>(model: T) throws
}

struct Storage: StorageProtocol {
    var db: ModelContainer
    
    init(db: ModelContainer) {
        self.db = db
    }
    
    @MainActor
    func fetch<T: PersistentModel>() throws -> [T] {
        let descriptor = FetchDescriptor<T>()
        return try db.mainContext.fetch(descriptor)
    }
    
    @MainActor
    func fetchElement<T: PersistentModel>(id: PersistentIdentifier) throws -> T? {
        return db.mainContext.model(for: id) as? T
    }
    
    @MainActor
    func save<T: PersistentModel>(model: T) throws {
        db.mainContext.insert(model)
        try db.mainContext.save()
    }
}
