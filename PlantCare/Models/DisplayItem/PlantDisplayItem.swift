//
// Copyright © 2025 Sage.
// All Rights Reserved.

import UIKit

struct PlantDisplayItem: DisplayItem {
    let plant: Plant
    var image: UIImage?
    var title: String
    var subtitle: String
    var subtitleVariant: DisplayItemSubtitleVariante
    var separator: Bool
    var disclosure: Bool
}
