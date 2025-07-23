//
// Copyright © 2025 Sage.
// All Rights Reserved.

import PixelKit

enum DisplayItemSubtitle: Hashable {
    case positive(String)
    case negative(String)
    case warning(String)
    case neutral(String)
    
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
    
    var text: String {
        switch self {
        case .positive(let text):
            return text
        case .negative(let text):
            return text
        case .warning(let text):
            return text
        case .neutral(let text):
            return text
        }
    }

}
