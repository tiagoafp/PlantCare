//
//  PlantActivitiesListViewDestination.swift
//  PlantCare
//
//  Created by Tiago Pereira on 28/05/2026.
//
import Foundation

enum PlantActivitiesListViewDestination: Hashable, Identifiable {
    case detail(recordId: UUID, plantId: UUID)
    
    var id: String {
        switch self {
        case .detail(let recordId, _):
            return "detail_\(recordId.uuidString)"
        }
    }
}
