//
//
// PlantCare
// Created by: tiago.pereira on 24/5/25
//
import SwiftData
import Foundation

@Model
public class Plant: Identifiable {
    @Attribute(.unique) public var id: UUID
    var name: String
    var createdAt: Date
    var plantedAt: Date
    var type: PlantType?
    var waterSchedule: WaterSchedule
    var notes: String
    var cover: String?
    @Relationship
    var waterRegisters: [WaterRegister]
    
    public init() {
        self.id = UUID()
        self.name = ""
        self.createdAt = .now
        self.plantedAt = .now
        self.waterSchedule = .init(schedule: .weekly)
        self.notes = ""
        self.waterRegisters = []
    }
}
