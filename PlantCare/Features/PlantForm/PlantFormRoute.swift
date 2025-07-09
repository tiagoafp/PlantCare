//
//  PlantFormNavigation.swift
//  PlantCare
//
//  Created by tiago.pereira on 7/6/25.
//

import SwiftUI

enum PlantFormRoute: ViewRoute {
    case plantType
    case waterSchedule
    
    var id: String {
        switch self {
        case .plantType:
            return "plantType"
        case .waterSchedule:
            return "waterSchedule"
        }
    }
}
