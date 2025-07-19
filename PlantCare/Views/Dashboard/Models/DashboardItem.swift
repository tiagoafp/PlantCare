//
//
// PlantCare
// Created by: tiago.pereira on 4/6/25
//

import SwiftUI
import Mockable

struct DashboardItem: Hashable {
    var image: String?
    var title: String
    var subtitle: Subtitle
    var separator: Bool
    var disclosure: Bool
    
    init(
        image: String? = nil,
        title: String,
        subtitle: DashboardItem.Subtitle,
        separator: Bool = true,
        disclosure: Bool = true
    ) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.separator = separator
        self.disclosure = disclosure
    }
}


extension DashboardItem {
    enum Subtitle: Hashable {
        case positive(String)
        case negative(String)
        case warning(String)
        case neutral(String)
    }
}
