//
//
// PlantCare
// Created by: tiago.pereira on 10/6/25
//

import SwiftUI

struct TypeListItem: Identifiable, Hashable {
    var id: String { type.id.uuidString }
    
    var type: PlantType
    var focused: Bool
    
    init(type: PlantType, editing: PlantType?) {
        self.focused = type == editing
        self.type = type
    }
}
