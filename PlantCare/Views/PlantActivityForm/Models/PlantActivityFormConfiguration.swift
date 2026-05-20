//
//  PhotoInputType.swift
//  PlantCare
//
//  Created by Tiago Pereira on 14/5/26.
//

class PlantActivityFormConfiguration {
    var photoType: PhotoType?
    var notes: NotesType?
    
    init(plantActivityType: PlantActivityType) {
        switch plantActivityType {
        case .watering:
            photoType = nil
            notes = nil
        case .photo:
            photoType = .mandatory
            notes = .optional
        case .sick:
            photoType = .optional
            notes = .optional
        }
    }
}

extension PlantActivityFormConfiguration {
    enum PhotoType {
        case mandatory
        case optional
    }
    
    enum NotesType {
        case optional
    }
}
