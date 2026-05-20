//
//  ActivityType.swift
//  PlantCare
//
//  Created by Tiago Pereira on 14/5/26.
//

import SwiftData

enum PlantActivityType: String, Codable, Hashable, CaseIterable {
    case watering
    case photo
    case sick
}
