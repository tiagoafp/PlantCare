//
//  PlantActivityFormType.swift
//  PlantCare
//
//  Created by Tiago Pereira on 14/5/26.
//

import Foundation

enum PlantActivityFormType {
    case add(plantId: UUID)
    case edit(plantId: UUID, activityId: UUID)
}
