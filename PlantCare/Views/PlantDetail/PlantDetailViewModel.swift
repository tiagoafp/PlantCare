//
//
// PlantCare
// Created by: tiago.pereira on 9/7/25
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
protocol PlantDetailViewModelProtocol: ObservableObject {
    var plant: Plant? { get }
    
    func image(plant: Plant) -> UIImage?
    func addedAt(plant: Plant) -> String
    func plantedAt(plant: Plant) -> String
    func onAppear()
    func onEdit()
    func onWaterHistory()
}

class PlantDetailViewModel: PlantDetailViewModelProtocol {
    @Published var plant: Plant?
    var input: Input
    let formatter: DateFormatter
    weak var router: ViewRouter<PlantDetailRoute>?
    
    init(input: Input) {
        self.input = input
        self.formatter = DateFormatter()
        self.formatter.dateFormat = "dd/mm/yyyy"
    }
    
    func image(plant: Plant) -> UIImage? {
        input.imageReader.getCover(plant: plant)
    }
    
    func addedAt(plant: Plant) -> String {
        let dateString = formatter.string(from: plant.createdAt)
        
        if let diff = getDifference(from: plant.createdAt, to: .now) {
            return dateString + " " + Translations.add_ago.args(diff)
        } else {
            return dateString
        }
    }
    
    func plantedAt(plant: Plant) -> String {
        let dateString = formatter.string(from: plant.plantedAt)
        
        if let diff = getDifference(from: plant.plantedAt, to: .now) {
            return dateString + " " + Translations.planted_old.args(diff)
        } else {
            return dateString
        }
    }
    
    func getDifference(from start: Date, to end: Date) -> String? {
        let interval = end.timeIntervalSince(start) // TimeInterval in seconds

        let durationFormatter = DateComponentsFormatter()
        durationFormatter.allowedUnits = [.year, .month, .day]
        durationFormatter.unitsStyle = .short // or .full / .abbreviated / .positional
        durationFormatter.zeroFormattingBehavior = .dropAll
        
        return durationFormatter.string(from: interval)
    }
    
    func onAppear() {
        self.plant = input.repo.fetch(id: input.plantId)
    }
    
    func update(router: ViewRouter<PlantDetailRoute>?) {
        self.router = router
    }
    
    func onEdit()  {
        router?.push(.edit)
    }
    
    func onWaterHistory() {
        
    }
}

extension PlantDetailViewModel {
    struct Input {
        let repo: PlantRepositoryProtocol
        let plantId: PersistentIdentifier
        let imageReader: ImagesStorageReaderService
    }
}
