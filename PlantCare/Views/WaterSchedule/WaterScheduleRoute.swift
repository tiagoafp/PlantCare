//
//  WaterScheduleSelectorNavigation.swift
//  PlantCare
//
//  Created by tiago.pereira on 14/6/25.
//

import SwiftUI

enum WaterScheduleRoute: String, ViewRoute {
        case close
        
        var id: String { self.rawValue }
}
