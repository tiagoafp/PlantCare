import Foundation
import SwiftUI

public protocol AtlasPickerCellDataItemProtocol: Identifiable, Hashable {
    var title: String { get }
    var icon: Image? { get }
}

