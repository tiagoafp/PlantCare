//
//
// PlantCare
// Created by: tiago.pereira on 4/6/25
//

import SwiftUI
import Mockable
import PixelKit

protocol DisplayItem: Hashable {
    var image: UIImage? { get }
    var title: String { get }
    var subtitle: String { get }
    var subtitleVariant: DisplayItemSubtitleVariante { get }
    var separator: Bool { get }
    var disclosure: Bool { get }
}

extension DisplayItem {
    @MainActor
    var cellImage: CellImage? {
        guard let image else { return nil }
        
        return .rounded(Image(uiImage: image))
    }
}

enum DisplayItemSubtitleVariante: Hashable {
    case positive
    case negative
    case warning
    case neutral
    
    var casted: CellSubtitle.Variant {
        switch self {
        case .positive:
            return .positive
        case .negative:
            return .negative
        case .warning:
            return .warning
        case .neutral:
            return .default
        }
    }

}
