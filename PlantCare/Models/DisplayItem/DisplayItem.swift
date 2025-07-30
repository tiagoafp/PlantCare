//
//
// PlantCare
// Created by: tiago.pereira on 4/6/25
//

import SwiftUI
import Mockable
import PixelKit

struct DisplayItem: Hashable {
    var image: UIImage?
    var title: String
    var subtitle: DisplayItemSubtitle
    var separator: Bool
    var disclosure: Bool
    var type: ItemType
    
    init(
        image: UIImage? = nil,
        title: String,
        subtitle: DisplayItemSubtitle,
        separator: Bool,
        disclosure: Bool,
        type: ItemType
    ) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.separator = separator
        self.disclosure = disclosure
        self.type = type
    }
}

extension DisplayItem {
    @MainActor
    var cellImage: CellImage? {
        guard let image else { return nil }
        
        return .rounded(Image(uiImage: image))
    }
}

extension DisplayItem {
    enum ItemType: Hashable {
        case plant(Plant)
        case plantType(PlantType)
        case waterRegister(WaterRegister)
    }
}
