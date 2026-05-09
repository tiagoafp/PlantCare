import Foundation
import UIKit
import AtlasUI

enum ImageStorageManager: ImageStorageManagerProtocol {
    case plant
    
    var subFolder: String {
        switch self {
        case .plant:
            return "plant"
        }
    }
    
}
