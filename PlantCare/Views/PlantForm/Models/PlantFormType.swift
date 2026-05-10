//
//  PlantFormType.swift
//  PlantCare
//
//  Created by Tiago Pereira on 10/5/26.
//

import Foundation

enum PlantFormType {
    case add(image: Data?, specie: TrefleListResponse.Species)
    case edit(plant: PlantRecord, onDelete: () -> Void)
}
