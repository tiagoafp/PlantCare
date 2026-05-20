//
//  PlantActivityFormType.swift
//  PlantCare
//
//  Created by Tiago Pereira on 14/5/26.
//

enum PlantActivityFormType {
    case add(plant: PlantRecord)
    case edit(plant: PlantRecord, activity: PlantActivityRecord)
}
