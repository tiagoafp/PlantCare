import Foundation
import UIKit
import AtlasUI

enum ImageStorageManager: ImageStorageManagerProtocol {
    case plant
    case activities
    
    var subFolder: String {
        switch self {
        case .plant:
            return "plant"
        case .activities:
            return "activities"
        }
    }
    
}
