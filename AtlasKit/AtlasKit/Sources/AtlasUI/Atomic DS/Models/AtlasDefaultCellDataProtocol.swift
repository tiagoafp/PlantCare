import SwiftUI

public protocol AtlasDefaultCellDataProtocol: Hashable, Identifiable {
    var image: AtlasCellImageType? { get }
    var title: String { get }
    var subtitle: String { get }
    var caption: String? { get }
    
    var chevron: Bool { get }
}

