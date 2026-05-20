//
//  DependencyInjector.swift
//  PlantCare
//
//  Created by Tiago Pereira on 14/5/26.
//

import AtlasUI

protocol DependencyInjectorProtocol {
    var plantImageManager: ImageStorageManagerProtocol { get }
    var activityImageManager: ImageStorageManagerProtocol { get }
}

struct DependencyInjector: DependencyInjectorProtocol {
    var plantImageManager: ImageStorageManagerProtocol {
        ImageStorageManager.plant
    }
    
    var activityImageManager: ImageStorageManagerProtocol {
        ImageStorageManager.activities
    }
}
