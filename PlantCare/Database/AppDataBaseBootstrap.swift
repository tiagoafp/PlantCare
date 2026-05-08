import SwiftData

enum AppDataBaseBootstrap {
    static func createRootIfNeeded(in context: ModelContext) throws {
        var descriptor = FetchDescriptor<AppDataBase>()
        descriptor.fetchLimit = 1

        guard try context.fetch(descriptor).isEmpty else {
            return
        }

        context.insert(AppDataBase())
        try context.save()
    }
}
